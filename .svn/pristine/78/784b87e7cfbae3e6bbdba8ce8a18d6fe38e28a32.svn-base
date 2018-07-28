//
//  BXGCourseSectionExamVC.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/20.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGSectionExamVC: UIViewController {
    
    let viewModel: BXGSectionExamViewModel
    init(viewModel fromViewModel: BXGSectionExamViewModel) {
        viewModel = fromViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var questionVC: BXGSectionExamQuestionVC = {
        
        let vc = BXGSectionExamQuestionVC(viewModel: viewModel)
        vc.clickSubmitClosure = {
            self.scrollToResultView()
            self.resultVC.loadData()
        }
        return vc
    }()
    
    lazy var resultVC: BXGSectionExamResultVC = {
        let vc = BXGSectionExamResultVC(viewModel: viewModel)
        vc.clickReTryClosure = {
            self.scrollToQuestionView()
            self.questionVC.retry()
        }
        
        vc.clickContinueClosure = {
            self.navigationController?.popViewController(animated: true)
        }
        return vc
    }()
    
    
    
    override func viewDidLoad() {
        installUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: UI
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false
        return scrollView
    }()

    func installUI() {
        
        addChildViewController(self.questionVC)
        addChildViewController(self.resultVC)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64)
            make.left.bottom.right.equalToSuperview()
        }
        scrollView.addSubview(self.questionVC.view)
        scrollView.addSubview(self.resultVC.view)
        
        
        self.questionVC.view.snp.makeConstraints { (make) in
            make.left.bottom.top.width.height.equalToSuperview()
        }
        
        self.resultVC.view.snp.makeConstraints { (make) in
            make.right.bottom.top.width.height.equalToSuperview()
            make.left.equalTo(self.questionVC.view.snp.right)
        }
        
    }
    func scrollToQuestionView() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//        setViewControllers([questionVC], direction: UIPageViewControllerNavigationDirection.forward, animated: true) { (completion) in
        
    }
    
    func scrollToResultView() {
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.size.width, y: 0), animated: true)
        
    }
    
}

//extension BXGSectionExamVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        return nil
//        if viewController === resultVC {
//            return questionVC
//        }
//        return nil
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        return nil
//        if viewController === questionVC {
//            return resultVC
//        }
//        return nil
//    }
//
//
//}




