//
//  BXGConstrueReplayPlayerVC.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/26.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGConstrueReplayPlayerVC: UIViewController {
    
    // INIT
    let planModel: BXGConstrueLiveModel
    let playerModels: [BXGConstrueReplayPlayerModel]
    
    init(planModel fromPlanModel: BXGConstrueLiveModel, playerModels fromPlayerModels: [BXGConstrueReplayPlayerModel]) {
        planModel = fromPlanModel
        playerModels = fromPlayerModels
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        installUI()
        start()

        playerView.setTeacher(planModel.teacher ?? "")
    }
    
    // FUNCTION
    
    func start() {
        
        let vodModels = generateVODModels(playerModels: playerModels)
        BXGVODPlayerListManager.shared.requestPlay(list: vodModels, isAutoPlay: true)

    }
    
    func generateVODModels(playerModels: [BXGConstrueReplayPlayerModel]) -> [BXGVODPlayerVideoModel] {
        var vodModels = [BXGVODPlayerVideoModel]()
        for (index, playerModel) in playerModels.enumerated() {
            if let model = generateVODModel(playerModel: playerModel, tag: index, customId: "") {
                vodModels.append(model)
            }
        }
        return vodModels
    }
    
    func generateVODModel(playerModel: BXGConstrueReplayPlayerModel, tag: Int, customId: String?) -> BXGVODPlayerVideoModel?{
        
        guard let recordVideoId = playerModel.recordVideoId else {
            return nil
        }

        var name = playerModel.name ?? ""
        name = String.init(format: "%02zd_%@",tag + 1, name)
        return BXGVODPlayerVideoModel(id: 0, name: name, resourseId: recordVideoId, tag: tag,infoModel: nil, customId: customId)
    }
    
    // UI
    
    lazy var playerView: BXGConstrueReplayPlayerView = {
        let view = BXGConstrueReplayPlayerView()
        return view
    }()
    
    func installUI() {
        view.backgroundColor = UIColor.black
        view.addSubview(playerView)
        playerView.snp.makeConstraints { (make) in
            make.left.bottom.top.right.equalToSuperview()
        }
    }
    
}
