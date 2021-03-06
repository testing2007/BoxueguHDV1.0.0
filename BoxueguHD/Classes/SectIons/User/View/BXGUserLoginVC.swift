//
//  BXGUserLoginVC.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/12.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit
import SnapKit

class BXGUserLoginVC: UIViewController {
    
    lazy var logoImgV: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    lazy var usernameTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "请输入手机号或邮箱"
        return tf
    }()
    
    lazy var passwordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "请输入6～18位密码"
        return tf
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self,  action: #selector(clickLogin), for: .touchUpInside)
        btn.setTitle("Login", for: .normal)
        return btn
    }()
    
    lazy var backgroundView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "login_background"))
        return view
    }()
    func installUI() {
        self.view.addSubview(backgroundView)
        
        self.view.addSubview(usernameTF)
        self.view.addSubview(passwordTF)
        self.view.addSubview(loginBtn)
        
        backgroundView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalToSuperview()
        }
        
        usernameTF.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(100)
            make.width.equalTo(200)
        }
        
        passwordTF.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameTF.snp.bottom).offset(10)
            make.height.equalTo(100)
            make.width.equalTo(200)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTF.snp.bottom).offset(10)
            make.height.equalTo(100)
            make.width.equalTo(200)
        }
        
    }
}

// MARK: Life Cycle

extension BXGUserLoginVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.hexColor(hex: 0x436be0)
        self.installUI()
    }
}

// MARK: Response

extension BXGUserLoginVC {
    @objc func clickLogin() {
        if let username = usernameTF.text, let password = passwordTF.text {
            BXGUserCenter.shared.requestSignIn(username: username, password: password) { (userModel, message) in
                if(userModel != nil) {
                    self.dismiss(animated: true, completion: {
                        
                    });
                }else {
                    
                }
            }
        }else {
            // 缺少参数
        }
    }
}


