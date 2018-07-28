//
//  BXGVODPlayer.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/17.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGVODPlayerDRMServer {
    
    static let shared: BXGVODPlayerDRMServer = {
        return BXGVODPlayerDRMServer()
    }()
    
    let drmServer = DWDrmServer(listenPort: 20140)

    public func start() {
        drmServer?.start()
    }
    
    public func stop() {
        drmServer?.stop()
    }
}

protocol BXGVODPlayerDelegate {
    func playStateDidChange(player: BXGVODPlayer, isPlaying: Bool)
    func didReachEnd(player: BXGVODPlayer)
    func requestFailed(player: BXGVODPlayer, error: Error?)
    func didFailed(player: BXGVODPlayer, error: Error?)
    func readyToPlay(player: BXGVODPlayer)
    func playTimeDidChage(player: BXGVODPlayer, currentTime: Float, durationTime: Float)
    func loadedTimeDidChage(player: BXGVODPlayer, durationTime: Float)
    func bufflingStateDidChange(player: BXGVODPlayer, isBuffling: Bool)
    func rateDidChange(player: BXGVODPlayer, rate: Float)
}

class BXGVODPlayer: NSObject {
    
    var delegate: BXGVODPlayerDelegate?
    
    var playerItem: AVPlayerItem? {
        return self.playerView?.item
    }
    
    var playerLayer: AVPlayerLayer? {
        return playerView?.playerLayer
    }
    
    var looping: Bool {
        get {
            if let looping = self.playerView?.looping  {
                return looping
            }else {
                return false
            }
        }
        set {
            self.playerView?.looping = newValue;
        }
    }
    
    var muted: Bool {
        get {
            if let muted = self.playerView?.muted  {
                return muted
            }else {
                return false
            }
        }
        set {
            self.playerView?.muted = newValue;
        }
    }

    public func generatePlayerView(ccUserId: String, ccAPIKey: String) -> DWPlayerView? {
        self.playerView = nil
        if let playerView = DWPlayerView(userId: ccUserId, key: ccAPIKey) {
            playerView.contentMode = .scaleAspectFit
            playerView.timeoutSeconds = 10
            playerView.delegate = self
            if let listenPort = BXGVODPlayerDRMServer.shared.drmServer?.listenPort {
                playerView.drmServerPort = listenPort
            }
            self.playerView = playerView
            self.installObserver()
            return playerView
        }
        
        return nil
    }
    
    public func play() {
        
        if(self.currentTime == self.duration && self.currentTime > 0) {
            playerView?.repeatPlay()
        }else {
            playerView?.play()
        }
    }
    
    public func pause() {
        self.playerView?.pause()
    }
    
    public func seekToTime(sec: Float) {
        self.playerView?.scrub(sec)
        self.playerView?.play()
    }
    
    public var currentTime: Float {
        
        var currentTime: Float = 0.0
        if let item = self.playerView?.item {
            let cmtime = item.currentTime()
            currentTime = Float(CMTimeGetSeconds(cmtime))
        }
        
        if(currentTime.isNaN) {
            currentTime = 0
        }
        return currentTime
        
    }
    
    public var duration: Float {
        
        var durationTime: Float = 0.0
        if let playerView = self.playerView, let item = playerView.item{
            let cmtime = item.duration
            durationTime = Float(CMTimeGetSeconds(cmtime))
        }
        
        if(durationTime.isNaN) {
            durationTime = 0
        }
        return durationTime
    }
    
    public var isPlaying:Bool {
        if let playerView = self.playerView {
            return playerView.playing;
        }else {
            return false
        }
    }
    
    var playerView: DWPlayerView?
    
    var playerTimer: Timer?
    
    private func installObserver() {
        self.playerView?.addObserver(self, forKeyPath: "playing", options: NSKeyValueObservingOptions.new, context: nil)
        
        
        playerTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(playerTimerAction), userInfo: nil, repeats: true)
    }
    
    var lastCurrentTime: Float = 0
    
    @objc func playerTimerAction() {
        let buffling = self.currentTime != self.lastCurrentTime
        
        if(buffling && self.isPlaying) {
            isBuffling = true
        }else {
            isBuffling = false
        }
    }
    
    var isBuffling: Bool = false {
        willSet {
            delegate?.bufflingStateDidChange(player: self, isBuffling: newValue)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let keyPath = keyPath, keyPath == "playing",let change = change, let isPlaying = change[NSKeyValueChangeKey.newKey] as? Bool {
            delegate?.playStateDidChange(player: self, isPlaying: isPlaying)
        }
    }
    
    private func uninstallObserver() {
        self.playerTimer?.invalidate()
        self.playerTimer = nil
    }
    
    public func releasePlayer() {
        
        uninstallObserver()
        self.playerView?.removeTimer()
        self.playerView?.resetPlayer()
        self.playerView?.playerLayer = nil;
        self.playerView?.item = nil;
        self.playerView?.player = nil;
        self.playerView?.urlAsset = nil;
        self.playerView = nil;
    }
    
    public func stop() {
//        self.playerView?.scrub(0)
        self.playerView?.removeTimer()
        self.playerView?.pause()
    }
    
    public var playerRate:Float {
        get {
            return self.playerView?.player.rate ?? 1.0
        }
        set {
            self.playerView?.setPlayerRate(newValue)
        }
    }
    
    public var playableDuration:TimeInterval {
        get {
            if let playableDuration = self.playerView?.playableDuration() {
                if(playableDuration.isNaN) {
                    return 0
                }else {
                    return playableDuration
                }
            }else {
                return 0
            }
        }
    }
    
    public func requestPlay(videoId: String, customId: String) {
        
        playerView?.videoId = videoId
        playerView?.failBlock = { error in
            if let d = self.delegate {
                d.requestFailed(player: self, error: error)
            }
        }
        playerView?.getPlayUrlsBlock = { playUrls in
            
            guard let playUrls = playUrls else {
                return
            }
            
            guard let status = playUrls["status"] as? Int,
                status == 0 else {
                    return
            }
            
            guard let vrmode = playUrls["vrmode"] as? String,
                vrmode == "0" else {
                    return
            }
            
            guard let qualityArray = playUrls["qualities"] as? Array<Dictionary<String, Any>> else {
                return
            }
            
            guard let quality = qualityArray.last,
                let urlString = quality["playurl"] as? String,
                let url = URL(string: urlString) else {
                    return
            }
            
            self.playerView?.removeTimer()
            self.playerView?.resetPlayer()
            self.playerView?.setURL(url, withCustomId: customId)
            self.playerView?.play()
            
        }
        playerView?.startRequestPlayInfo()
    }
    
    public func requestPlay(videoId: String,path: String, customId: String, seekTime: Float) {
        playerView?.videoId = videoId
        self.playerView?.removeTimer()
        self.playerView?.resetPlayer()
        self.playerView?.setURL(URL(fileURLWithPath: path), withCustomId: customId)
        self.playerView?.play()
    }
}


extension BXGVODPlayer: DWVideoPlayerDelegate {
    
    public func videoPlayer(_ playerView: DWPlayerView!, loadedTimeRangeDidChange duration: Float) {
        if(self.isPlaying && self.isBuffling) {
            self.playerView?.play()
        }
        delegate?.loadedTimeDidChage(player: self, durationTime: duration)
    }
    
    func videoPlayerPlaybackBufferEmpty(_ playerView: DWPlayerView!) {
        
    }
    
    func videoPlayerPlaybackLikely(toKeepUp playerView: DWPlayerView!) {
        
    }
    
    func videoPlayer(_ playerView: DWPlayerView!, didFailWithError error: Error!) {
        
        delegate?.didFailed(player: self, error: error)
    }
    
    public func videoPlayerDidReachEnd(_ playerView: DWPlayerView!) {
        self.stop()
        self.delegate?.didReachEnd(player: self)
        
    }
    
    func videoPlayerIsReady(toPlayVideo playerView: DWPlayerView!) {
        self.delegate?.readyToPlay(player: self)
    }
    
    func videoPlayer(_ playerView: DWPlayerView!, timeDidChange time: Float) {
        self.delegate?.playTimeDidChage(player: self, currentTime: self.currentTime, durationTime: self.duration)
    }
}
