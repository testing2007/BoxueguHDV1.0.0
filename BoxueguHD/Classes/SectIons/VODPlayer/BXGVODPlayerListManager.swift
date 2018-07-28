//
//  BXGVODPlayerListManager.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/18.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

protocol BXGPlayerListManagerDelegate: AnyObject {
    func videoReadyToPlay(manager:BXGVODPlayerListManager, video: BXGVODPlayerVideoModel, index: Int)
    func vidooPlaying(manager:BXGVODPlayerListManager, video: BXGVODPlayerVideoModel, index: Int)
    func videoPlayDone(manager:BXGVODPlayerListManager, video: BXGVODPlayerVideoModel, index: Int)
    func videoDidChange(manager:BXGVODPlayerListManager, video: BXGVODPlayerVideoModel, index: Int)
    func videoWillPlay(manager:BXGVODPlayerListManager, video: BXGVODPlayerVideoModel, index: Int)
    func listPlayDone(manager:BXGVODPlayerListManager, list: [BXGVODPlayerVideoModel])
}

protocol BXGPlayerListManagerDataSource {
    func seekTime(manager:BXGVODPlayerListManager, video: BXGVODPlayerVideoModel) -> Float
    func localPath(manager:BXGVODPlayerListManager, video: BXGVODPlayerVideoModel) -> String
}
public class BXGVODPlayerVideoInfoModel {
    
    let userId: String
    let courseId: Int
    let phaseId: Int
    let moduleId: Int
    let sectionId: Int
    let pointId: Int
    let videoId: Int
    let videoName: String
    
    init(userId fromUserId: String,
         courseId fromCourseId: Int,
         phaseId fromPhaseId: Int,
         moduleId fromModuleId: Int,
         sectionId fromSectionId: Int,
         pointId fromPointId: Int,
         videoId fromVideoId: Int,
         videoName fromVideoName: String) {
        
        userId = fromUserId
        courseId = fromCourseId
        phaseId = fromPhaseId
        moduleId = fromModuleId
        sectionId = fromSectionId
        pointId = fromPointId
        videoId = fromVideoId
        videoName = fromVideoName
        
    }
}

public class BXGVODPlayerVideoModel {
    init(id fromId: Int,
         name fromName: String,
         resourseId fromResourceId: String,
         tag fromTag: Int,
         infoModel fromInfoModel: BXGVODPlayerVideoInfoModel?,
         customId fromCustomId: String?) {
        
        id = fromId
        name = fromName
        resourceId = fromResourceId
        tag = fromTag
        customId = fromCustomId
        infoModel = fromInfoModel
        
    }
    let id: Int
    let name: String
    let resourceId: String
    var tag: Int = 0
    var customId: String?
    
    var infoModel: BXGVODPlayerVideoInfoModel?
}

class BXGVODPlayerListManager {
    
//    func indexPath(videoModel: BXGV)  
    
    static let shared: BXGVODPlayerListManager = {
        let manager = BXGVODPlayerListManager()
        BXGVODPlayerManager.shared.addDelegate(any: manager)
        return manager
    }()
    
    // MARK: 多播代理
    private lazy var delegates: Array<BXGPlayerListManagerDelegate> = Array<BXGPlayerListManagerDelegate>()
    
    public func addDelegate(any: BXGPlayerListManagerDelegate) {
        
        for d in delegates {
            if (d === any) {
                return
            }
        }
        delegates.append(any)
        
    }
    
    func installObserver() {
        
    }
    
    func uninstallObserver() {
//        BXGVODPlayerManager.shared.removeDelegate(any: self)
    }
    
    public func removeDelegate(any: BXGPlayerListManagerDelegate) {
        for (index, d) in delegates.enumerated() {
            if (d === any) {
                delegates.remove(at: index)
            }
        }
            }
    public var dataSource: BXGPlayerListManagerDataSource?
    
    var videoList: [BXGVODPlayerVideoModel]?
    var currentVideo: BXGVODPlayerVideoModel?
    var currentIndex: Int?
    
    var videoListArray: [[BXGVODPlayerVideoModel]]?
    var currentListIndex: Int?
    
    func requestPlay(list: [BXGVODPlayerVideoModel]?, isAutoPlay: Bool) {
        videoList = list
        
        if let list = list, list.count > 0, isAutoPlay {
            self.play(index: 0)
        }
    }
    
    func play(index: Int) {
        
        guard let videoList = videoList, index < videoList.count else {
            return
        }
    
        if let currentVideo = currentVideo, let currentIndex = currentIndex {
            for d in delegates {
                d.videoDidChange(manager: self, video: currentVideo, index: currentIndex)
            }
        }
        currentIndex = index
        let video = videoList[index]
        currentVideo = video
        for d in delegates {
            d.videoReadyToPlay(manager: self, video: video, index: index)
        }
        play(video: video)
    }

    private func play(video: BXGVODPlayerVideoModel) {
        let path = dataSource?.localPath(manager: self, video: video) ?? nil
        let seekTime = dataSource?.seekTime(manager: self, video: video) ?? 0.0
        
        BXGVODPlayerManager.shared.requestPlay(videoId: video.resourceId, path: path, customId: video.customId ?? "", seekTime: seekTime)
    }
    
}

// MARK: Function

extension BXGVODPlayerListManager {
    
    func hasNext() -> Bool {
        
        guard let currentIndex = self.currentIndex, let videoList = self.videoList else {
            return false
        }
        
        if currentIndex + 1 >= videoList.count{
            return false
        }else {
            return true
        }
    }
    
    func hasNextList() -> Bool {
        
        guard let currentListIndex = currentListIndex, let videoListArray = videoListArray else {
            return false
        }
        
        if currentListIndex + 1 >= videoListArray.count{
            return false
        }else {
            return true
        }
    }
    
    var nextIndex: Int? {
        
        guard let currentIndex = self.currentIndex else {
            return nil
        }
        
        if hasNext() {
            return currentIndex + 1
        }else {
            return nil
        }
    }
    
    var nextListIndex: Int? {
        guard let currentListIndex = currentListIndex else {
            return nil
        }
        
        if hasNext() {
            return currentListIndex + 1
        }else {
            return nil
        }
    }
    
    var nextList: [BXGVODPlayerVideoModel]? {
        
        guard let currentListIndex = currentListIndex, let videoListArray = videoListArray else {
            return nil
        }
        
        if hasNextList() {
            return videoListArray[currentListIndex + 1]
        }else {
            return nil
        }
    }
    
    var nextVideoModel: BXGVODPlayerVideoModel? {
        
        guard let currentIndex = self.currentIndex, let videoList = self.videoList else {
            return nil
        }
        
        if hasNext() {
            return videoList[currentIndex + 1]
        }else {
            return nil
        }
    }
    
    func playNext() {
        guard let nextVideoModel = nextVideoModel else {
            return
        }
        play(video: nextVideoModel)
    }
    
    func playNextList() {
        guard let nextList = nextList else {
            return
        }
        requestPlay(list: nextList, isAutoPlay: true)
    }

    func setDefault() {
        self.videoListArray = nil
        self.videoList = nil
        self.currentIndex = 0
        self.currentListIndex = 0
//        BXGVODPlayerManager.shared.reset()
    }

    func playDone() {
        
        for d in delegates {
            
            if let currentVideo = self.currentVideo, let currentIndex = self.currentIndex {
                d.videoPlayDone(manager: self, video: currentVideo, index: currentIndex)
            }
        }
        self.currentVideo = nil
        
        if hasNext() {
            for d in delegates {
                if let nextVideoModel = nextVideoModel, let nextIndex = nextIndex {
                    d.videoWillPlay(manager: self, video: nextVideoModel, index: nextIndex)
                }
            }
        }else {
            for d in delegates {
                if let videoList = self.videoList {
                    d.listPlayDone(manager: self, list: videoList)
                }
            }
        }
    }
}

extension BXGVODPlayerListManager {
    
    public func installPlayListArray(listArray: [[BXGVODPlayerVideoModel]]) {
        
        setDefault()
        
        self.videoListArray = listArray
    }
    
    public func play(listIndex: Int, videoIndex:Int) {
        guard let videoListArray = videoListArray,
            listIndex < videoListArray.count,
            videoIndex < videoListArray[listIndex].count else  {
                return
        }
        
        requestPlay(list: videoListArray[listIndex], isAutoPlay: false)
        play(index: videoIndex)
    }
}

extension BXGVODPlayerListManager: BXGPlayerManagerDelegate {
    
    
    func playStateDidChange(playerManager: BXGVODPlayerManager, isPlaying: Bool) {
        
    }
    
    func didReachEnd(playerManager: BXGVODPlayerManager) {
        playDone()
    }
    
    func requestFailed(playerManager: BXGVODPlayerManager, error: Error?) {
        
    }
    
    func didFailed(playerManager: BXGVODPlayerManager, error: Error?) {
        
    }
    
    func readyToPlay(playerManager: BXGVODPlayerManager) {
        if let currentVideoModel = currentVideo, let currentIndex = currentIndex {
            let seekTime = dataSource?.seekTime(manager: self, video:currentVideoModel) ?? 0.0
            playerManager.seekToTime(time: seekTime)
            
            
            for d in delegates {
                d.vidooPlaying(manager: self, video: currentVideoModel, index: currentIndex)
            }
        }
        
    }
    
    func playTimeDidChage(playerManager: BXGVODPlayerManager, currentTime: Float, durationTime: Float) {
        
    }
    
    func loadedTimeDidChage(playerManager: BXGVODPlayerManager, durationTime: Float) {
        
    }
    
    func bufflingStateDidChange(playerManager: BXGVODPlayerManager, isBuffling: Bool) {
        
    }
    
    func startSeek(playerManager: BXGVODPlayerManager, startSeekTime: Float, currentTime: Float, durationTime: Float) {
        
    }
    
    func Seeking(playerManager: BXGVODPlayerManager, SeekingTime: Float, currentTime: Float, durationTime: Float) {
        
    }
    
    func endSeek(playerManager: BXGVODPlayerManager, endSeekTime: Float, currentTime: Float, durationTime: Float) {
        
    }
    
    func startRequest(playerManager: BXGVODPlayerManager) {
        
    }
    
    func rateDidChange(playerManager: BXGVODPlayerManager, rate: Float) {
        
    }
    
    func videoDidStop(playerManager: BXGVODPlayerManager, lastPlayedTime: Float, durantionTime: Float) {
        
    }
}





