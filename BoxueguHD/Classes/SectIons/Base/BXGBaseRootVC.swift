//
//  BXGBaseRootVC.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 itheima. All rights reserved.
//

import UIKit

//主要职责就是给导航栏位置添加了一个自定义的view, 状态栏显示亮白色

class BXGBaseRootVC: BXGBaseVC {

    var navibackgroundView:UIView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override var prefersStatusBarHidden: Bool {
        //是否隐藏状态栏, 返回false, 不隐藏; 否则,隐藏
        return false;
    }
    
    func customNavigationBar() {
        
        //导航栏上面贴了一个自定义view
        if((self.navibackgroundView) != nil) {
            let navibackgroundView:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: BXGDevice.ScreenWidth, height: BXGDevice.NaviBarOffset))
            self.navibackgroundView = navibackgroundView;
        }
    }

    func addCustomActionForBackItemWithTarget(target:AnyObject, action:Selector) -> Void {
        let item:UIBarButtonItem = self.navigationItem.leftBarButtonItem!;
        item.action = action;
        item.target = target;
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
