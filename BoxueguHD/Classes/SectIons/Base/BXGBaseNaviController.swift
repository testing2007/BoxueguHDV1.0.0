//
//  BXGBaseNaviController.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 itheima. All rights reserved.
//

import UIKit

class BXGBaseNaviController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.interactivePopGestureRecognizer?.delegate = self;
        
        self.hideSystemNavigationBar();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        //状态栏显示为白亮色(默认是黑色), 不能放在UIViewController上面执行, 
        return .lightContent;
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(self.childViewControllers.count >= 1) {
            let backItem:UIBarButtonItem = self.createBackItemTarget(target: self, backAction:#selector(BXGBaseNaviController.onBack))
            viewController.navigationItem.leftBarButtonItem = backItem
            viewController.hidesBottomBarWhenPushed = true;
            self.isNavigationBarHidden = false;
        }
        super.pushViewController(viewController, animated: animated);
    }

    @objc func onBack() {
        self.popViewController(animated: true)
    }

    func createBackItemTarget(target:AnyObject, backAction:Selector) -> UIBarButtonItem {

        let imageIcon:UIImage = UIImage(named: "返回-白")!
//        UIImage *imageIcon = [[UIImage imageNamed:@"返回-白"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        let backItem:UIBarButtonItem = UIBarButtonItem(image: imageIcon,
                                                       style: .plain,
                                                       target: target,
                                                       action: backAction)
        // 设置返回按钮位置
        backItem.imageInsets = UIEdgeInsetsMake(0, -5, 0, 0)
        return backItem;
    }

    func hideSystemNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        self.navigationBar.isTranslucent = true;
    }
}

extension BXGBaseNaviController {
    func pushViewController(_ viewController: UIViewController, animated: Bool, needLogin:Bool) {
        self.pushViewController(viewController, animated: animated, needLogin: needLogin, needNetwork: false)
    }

    func pushViewController(_ viewController: UIViewController, animated: Bool, needLogin:Bool, needNetwork:Bool) {
//        if(![BXGUserDefaults share].userModel && needLogin) {
//            UIViewController * toViewController = [[BXGBaseNaviController alloc]initWithRootViewController:[BXGUserLoginVC new]];
//            [[self topViewController] presentViewController:toViewController animated:true completion:nil];
//            return;
//        }
//
//        BXGReachabilityStatus status = [[BXGNetWorkTool sharedTool] getReachState];
//        if(needNetwork && status == BXGReachabilityStatusReachabilityStatusNotReachable) {
//
//            [[BXGHUDTool share] showHUDWithString:kBXGToastNoNetworkError];
//            return;
//        }
        self.pushViewController(viewController, animated: animated);
    }
}
