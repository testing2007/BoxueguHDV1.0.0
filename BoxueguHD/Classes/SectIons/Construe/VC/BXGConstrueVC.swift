//
//  BXGConstrueVC.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/24.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation


class BXGConstrueVC: UIViewController {
    
    lazy var viewModel: BXGConstrueViewModel = {
        return BXGConstrueViewModel()
    }()
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var headerView: BXGConstrueHeaderView = {
        let view = BXGConstrueHeaderView(titles: ["直播计划","直播回放"])
        view.clickTabBtnClosure = { (_, index) in
            if index == 0 {
                self.scrollToLiveView()
            }else if index == 1 {
                self.scrollToReplayView()
            }
        }
        view.selectIndex(index: 0)
        return view
    }()
    
    lazy var liveVC: BXGConstrueLiveVC = {
        let vc = BXGConstrueLiveVC(viewModel: viewModel)
        return vc
    }()
    
    lazy var replayVC: BXGConstrueReplayVC = {
        let vc = BXGConstrueReplayVC(viewModel: viewModel)
        return vc
    }()

    override func viewDidLoad() {
        installUI()
        self.navigationItem.titleView = headerView
        viewModel.load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: UI
    
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            
        }
        

        return scrollView
    }()
    
    func installUI() {
        
        addChildViewController(self.liveVC)
        addChildViewController(self.replayVC)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.left.bottom.right.equalToSuperview()
        }
        scrollView.addSubview(self.liveVC.view)
        scrollView.addSubview(self.replayVC.view)
        
        
        self.liveVC.view.snp.makeConstraints { (make) in
            make.left.bottom.top.width.height.equalToSuperview()
        }
        
        self.replayVC.view.snp.makeConstraints { (make) in
            make.right.bottom.top.width.height.equalToSuperview()
            make.left.equalTo(self.liveVC.view.snp.right)
        }
    }
    func scrollToLiveView() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func scrollToReplayView() {
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.size.width, y: 0), animated: true)
    }
}


extension BXGConstrueVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int((scrollView.contentOffset.x + scrollView.bounds.size.width / 2) / scrollView.bounds.size.width)
        headerView.selectIndex(index: currentPage)
    }
}




