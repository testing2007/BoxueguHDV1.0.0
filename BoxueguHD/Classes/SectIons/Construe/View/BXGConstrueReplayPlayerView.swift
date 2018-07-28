//
//  BXGConstrueReplayPlayerView.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/26.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGConstrueReplayPlayerView: UIView {
    
    lazy var mediaView: UIView = {
        return BXGVODPlayerManager.shared.generatePlayerView(type: PlayerViewType.course)
        }()!
    
    lazy var footerView: UIView = {
        return UIView()
    }()
    
    lazy var playBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(#imageLiteral(resourceName: "player_playbtn_play"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(clickPlayBtn), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    lazy var selectRatePopView: BXGVODPlayerSelectRateView = {
        let rateView = BXGVODPlayerSelectRateView()
        rateView.selectRateClosure = { rate in
            BXGVODPlayerManager.shared.rate = rate
            self.hidePopView()
        }
        return rateView
    }()
    
    @objc func clickPlayBtn() {
        if(BXGVODPlayerManager.shared.player?.isPlaying ?? false) {
            BXGVODPlayerManager.shared.pause()
        }else {
            BXGVODPlayerManager.shared.play()
        }
    }
    
//    var clickScreenSizeClosure: (()->())?
    var clickBackBtnClosure: (()->())?
    
//    @objc func clickScreenSizeBtn() {
//        if let clickScreenSizeClosure = clickScreenSizeClosure {
//            clickScreenSizeClosure()
//        }
//    }
    
    func setPlayBtnState(isPlaying: Bool) {
        
        if(isPlaying) {
            playBtn.setImage(#imageLiteral(resourceName: "player_playbtn_pause"), for: UIControlState.normal)
        }else {
            playBtn.setImage(#imageLiteral(resourceName: "player_playbtn_play"), for: UIControlState.normal)
        }
    }
    
    lazy var currentTimeLb: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.pingFangSCRegular(withSize: 14)
        lb.textColor = UIColor.white
        
        return lb
    }()
    
    lazy var durationTimeLb: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.pingFangSCRegular(withSize: 14)
        lb.textColor = UIColor.white
        
        return lb
    }()
    
    func timeFormatter(time: Float) -> String {
        let intergerValue = Int(time)
        return String(format: "%02d:%02zd:%02zd", intergerValue / 3600 % 60, intergerValue / 60 % 60, intergerValue % 60)
    }
    
    func setCurrentTime(time: Float) {
        
        currentTimeLb.text = timeFormatter(time: time)
    }
    
    func setDurrationTime(time: Float) {
        durationTimeLb.text = timeFormatter(time: time)
    }
    
    // MARK: play slider
    lazy var playSlider: RWSlider = {
        let slider = RWSlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        slider.isContinuous = true
        slider.setThumbImage(#imageLiteral(resourceName: "player_slider_thumb"), for: UIControlState.normal)
        slider.minimumTrackTintColor = UIColor.hexColor(hex: 0x466DE2)
        slider.maximumTrackTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        return slider
    }()
    
    var isPlaySliderSeekking: Bool = false
    
    func setPlaySliderValue(value: Float) {
        var value = value
        if value > 1 {
            value = 1
        }
        
        if value < 0 {
            value = 0
        }
        if self.playSlider.isDragging || isPlaySliderSeekking {
            
        }else {
            playSlider.value = value
        }
        playSlider.eventClosure = { event, value in
            switch event {
            case .startDragging:
                BXGVODPlayerManager.shared.pause()
            case .dragging:
                BXGVODPlayerManager.shared.pause()
            case .endDragging:
                BXGVODPlayerManager.shared.player?.seekToTime(sec: (BXGVODPlayerManager.shared.player?.duration)! * value )
            }
        }
    }
    
    lazy var playRateBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 14)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(clickSelectRateBtn), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    @objc func clickSelectRateBtn() {
        popSelectRate()
    }
    
    func setPlayRateBtnState(rate: Float) {
        
        self.playRateBtn.setTitle(String.init(format: "%gX", rate), for: UIControlState.normal)
    }
    
//    lazy var screenSizeBtn: UIButton = {
//        let btn = UIButton()
//        btn.addTarget(self, action: #selector(clickScreenSizeBtn), for: UIControlEvents.touchUpInside)
//        return btn
//    }()
    
//    func setScreenSizeBtnState(isFull: Bool) {
//        if isFull {
//            screenSizeBtn.setImage(#imageLiteral(resourceName: "player_screen_smallsize"), for: UIControlState.normal)
//        }else {
//            screenSizeBtn.setImage(#imageLiteral(resourceName: "player_screen_fullsize"), for: UIControlState.normal)
//        }
//    }
    
    lazy var headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var headerLeftBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "navigationbar_leftbtn_white"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(clickBackBtn), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    @objc func clickBackBtn() {
        if let closure = clickBackBtnClosure {
            closure()
        }
    }
    
    lazy var headerTitleBtn: UIButton = {
        let btn = UIButton()
        btn.contentHorizontalAlignment = .left
        btn.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 16)
        btn.titleLabel?.textAlignment = .left
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        return btn
    }()
    
//    lazy var learnedBtn: UIButton = {
//        let btn = UIButton()
//        btn.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 16)
//        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
//        btn.setTitle("已学习", for: UIControlState.normal)
//        return btn
//    }()
    
    lazy var teacherLb: UILabel = {
        let view = UILabel()
        view.font = UIFont.pingFangSCRegular(withSize: 16)
        view.textColor = UIColor.white
        return view
    }()
    
    func setTeacher(_ teacher: String) {
        teacherLb.text = "讲师：\(teacher)"
    }
    
    lazy var menuBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("目录", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 14)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(clickMenuBtn), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    @objc func clickMenuBtn() {
        popSelectVideo()
    }
    
    func setHeaderTitle(title: String?) {
        self.headerTitleBtn.setTitle(title, for: UIControlState.normal)
    }
    
    
    func installUI() {
        self.addSubview(mediaView)
        self.addSubview(footerView)
        mediaView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        footerView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        footerView.addSubview(playBtn)
        playBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        footerView.addSubview(currentTimeLb)
        currentTimeLb.snp.makeConstraints { (make) in
            make.left.equalTo(playBtn.snp.right).offset(20)
            make.centerY.equalTo(playBtn)
            make.height.equalTo(12)
            make.width.equalTo(60)
        }
        
        footerView.addSubview(durationTimeLb)
        
        currentTimeLb.setContentHuggingPriority(.required, for: .horizontal)
        currentTimeLb.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        durationTimeLb.setContentHuggingPriority(.required, for: .horizontal)
        durationTimeLb.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        setCurrentTime(time: 0)
        setDurrationTime(time: 0)
        setPlayRateBtnState(rate: 1)
        
        footerView.addSubview(playSlider)
        playSlider.snp.makeConstraints { (make) in
            make.left.equalTo(currentTimeLb.snp.right).offset(20)
            make.centerY.equalTo(playBtn)
        }
        
        durationTimeLb.snp.makeConstraints { (make) in
            make.left.equalTo(playSlider.snp.right).offset(20)
            make.centerY.equalTo(playBtn)
            make.height.equalTo(12)
            make.width.equalTo(60)
        }
        
        footerView.addSubview(playRateBtn)
        
        playRateBtn.snp.makeConstraints { (make) in
            make.left.equalTo(durationTimeLb.snp.right).offset(5)
            make.centerY.equalTo(playBtn)
            make.width.equalTo(50)
        }
        
//        footerView.addSubview(screenSizeBtn)
        footerView.addSubview(menuBtn)
        
        
        menuBtn.snp.makeConstraints { (make) in
            make.left.equalTo(playRateBtn.snp.right).offset(5)
            make.centerY.equalTo(playBtn)
            make.width.equalTo(50)
            make.right.equalToSuperview().offset(-25)
        }
        
//        screenSizeBtn.snp.makeConstraints { (make) in
//            make.left.equalTo(menuBtn.snp.right).offset(5)
//            make.centerY.equalTo(playBtn)
//            make.right.equalToSuperview().offset(-25)
//
//        }
//
//        screenSizeBtn.setContentHuggingPriority(.required, for: .horizontal)
//        screenSizeBtn.setContentCompressionResistancePriority(.required, for: .horizontal)
//
//        setScreenSizeBtnState(isFull: false)
        
        
        // header
        addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(175)
        }
        
        headerView.addSubview(headerLeftBtn)
        headerView.addSubview(headerTitleBtn)
        headerView.addSubview(teacherLb)
        
        headerLeftBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(32)
        }
        
        headerTitleBtn.snp.makeConstraints { (make) in
            make.left.equalTo(headerLeftBtn.snp.right).offset(5)
            make.centerY.equalTo(headerLeftBtn)
            make.width.equalTo(270)
        }
        
        teacherLb.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25)
            make.centerY.equalTo(headerLeftBtn)
        }
        
        setHeaderTitle(title: "")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        installUI()
        
        
        
        
        
        
        
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCurrentRate(rate: Float) {
        let rateDesList = ["1.0X","1.25X","1.5X","2.0X"]
        let rateValueList: [Float] = [1.0, 1.25, 1.5, 2.0]
        
        var rateIndex: Int?
        for (index, value) in rateValueList.enumerated() {
            if value == rate {
                rateIndex = index
                break;
            }
        }
        if let index = rateIndex {
            playRateBtn.setTitle(rateDesList[index], for: UIControlState.normal)
        }
        
    }
    
    override func didMoveToWindow() {
        if let _ = self.window {
            // 添加 ob
            BXGVODPlayerManager.shared.addDelegate(any: self)
            BXGVODPlayerListManager.shared.addDelegate(any: self)
        }else {
            // 删除 ob
            BXGVODPlayerManager.shared.removeDelegate(any: self)
            BXGVODPlayerListManager.shared.removeDelegate(any: self)
        }
    }
    
    // MARK: 选集弹出
    lazy var selectVideoPopView: BXGVODPlayerSelectVideoView = {
        let item = BXGVODPlayerSelectVideoView()
        return item
    }()
    
    lazy var popMaskView: UIView = {
        let item = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapPopMaskView))
        item.addGestureRecognizer(tap)
        return item
    }()
    @objc func tapPopMaskView() {
        hidePopView()
    }
    
    func popSelectVideo() {
        
        addSubview(popMaskView)
        
        popMaskView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        
        addSubview(selectVideoPopView)
        selectVideoPopView.snp.makeConstraints { (make) in
            make.bottom.top.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(340)
        }
        
    }
    
    func popSelectRate() {
        
        addSubview(popMaskView)
        
        popMaskView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        addSubview(selectRatePopView)
        selectRatePopView.snp.makeConstraints { (make) in
            make.width.equalTo(53)
            make.height.equalTo(120)
            make.centerX.equalTo(playRateBtn)
            make.bottom.equalTo(playRateBtn.snp.top).offset(-10)
        }
    }
    
    func hidePopView() {
        
        
        popMaskView.removeFromSuperview()
        selectVideoPopView.removeFromSuperview()
        selectRatePopView.removeFromSuperview()
    }
}

extension BXGConstrueReplayPlayerView: BXGPlayerManagerDelegate {
    
    func playStateDidChange(playerManager: BXGVODPlayerManager, isPlaying: Bool) {
        setPlayBtnState(isPlaying: isPlaying)
    }
    
    func didReachEnd(playerManager: BXGVODPlayerManager) {
        
    }
    
    func requestFailed(playerManager: BXGVODPlayerManager, error: Error?) {
        
    }
    
    func didFailed(playerManager: BXGVODPlayerManager, error: Error?) {
        
    }
    
    func readyToPlay(playerManager: BXGVODPlayerManager) {
        
    }
    
    func playTimeDidChage(playerManager: BXGVODPlayerManager, currentTime: Float, durationTime: Float) {
        setCurrentTime(time: currentTime)
        setDurrationTime(time: durationTime)
        setPlaySliderValue(value: currentTime / durationTime)
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
        selectRatePopView.setCurrentRate(rate: rate)
        setCurrentRate(rate: rate)
    }
    
    func videoDidStop(playerManager: BXGVODPlayerManager, lastPlayedTime: Float, durantionTime: Float) {
        
    }
}

extension BXGConstrueReplayPlayerView: BXGPlayerListManagerDelegate {
    func videoReadyToPlay(manager: BXGVODPlayerListManager, video: BXGVODPlayerVideoModel, index: Int) {
        selectVideoPopView.reloadData()
        setHeaderTitle(title: video.name)
    }
    
    func vidooPlaying(manager: BXGVODPlayerListManager, video: BXGVODPlayerVideoModel, index: Int) {
        
    }
    
    func videoPlayDone(manager: BXGVODPlayerListManager, video: BXGVODPlayerVideoModel, index: Int) {
        
    }
    
    func videoDidChange(manager: BXGVODPlayerListManager, video: BXGVODPlayerVideoModel, index: Int) {
        
    }
    
    func videoWillPlay(manager: BXGVODPlayerListManager, video: BXGVODPlayerVideoModel, index: Int) {
        
    }
    
    func listPlayDone(manager: BXGVODPlayerListManager, list: [BXGVODPlayerVideoModel]) {
        
    }
}
