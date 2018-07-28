//
//  BXGLiveRootVC.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 itheima. All rights reserved.
//

import UIKit

class BXGLiveRootVC: BXGBaseRootVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.navigationItem.leftBarButtonItem =
        self.installUI();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var liveHeaderView:QZTabView = {
        let headerView:QZTabView = QZTabView.init(items : ["直播计划", "直播回放"]);
        headerView.frame = CGRect(x: 0, y: 0, width: BXGDevice.ScreenWidth, height: BXGDevice.NaviBarOffset)
        return headerView;
    }()
    
    lazy var tabDetailView:QZTabDetailView = {
        let tabDetailView:QZTabDetailView = QZTabDetailView()
        return tabDetailView
    }()
    
    lazy var livePlanVC:BXGLivePlanVC = {
        let planVC:BXGLivePlanVC = BXGLivePlanVC()
        return planVC
    }()
    
    lazy  var livePlaybackVC:BXGLivePlaybackVC = {
        let playbackVC:BXGLivePlaybackVC = BXGLivePlaybackVC()
        return playbackVC
    }()
    
    func installUI() {
        //安装UI
        self.navigationItem.titleView = self.liveHeaderView;
        self.tabDetailView.setDetailViews(views: [self.livePlanVC.view, self.livePlaybackVC.view])
        self.view.addSubview(self.tabDetailView)
        self.tabDetailView.snp.makeConstraints { (make) in
//            make.top.equalTo(BXGDevice.NaviBarOffset)
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        
        //绑定联动关系
        self.tabDetailView.indexChangedBlock =  { (view:UIView, index:Int) -> Void in
            self.liveHeaderView.setCurrentIndex(newIndex: index);
        }
        self.liveHeaderView.onClickTabBtnBlock =  { (view:UIView, index:Int) -> Void in
            self.tabDetailView.setCurrentIndex(newValue: index);
        }
    }
}


