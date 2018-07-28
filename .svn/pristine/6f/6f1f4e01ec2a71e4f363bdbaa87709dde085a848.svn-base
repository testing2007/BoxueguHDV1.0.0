//
//  BXGBaseVC.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 itheima. All rights reserved.
//

//主要职责比如可以统一添加统计, 获取UIWindow的主VC等;

import UIKit

class BXGBaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.view.backgroundColor = UIColor.white;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mainViewController() -> BXGMainVC {
        return UIApplication.shared.keyWindow?.rootViewController as! BXGMainVC;
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
