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
        let imgV = UIImageView(image: #imageLiteral(resourceName: "login_logo"))
        return imgV
    }()
    
    lazy var usernameTF: UITextField = {
        let tf = UITextField()
        tf.clearButtonMode = .whileEditing
        tf.tintColor = UIColor.white
        tf.textColor = UIColor.white
        tf.font = UIFont.pingFangSCRegular(withSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: "请输入手机号或邮箱", attributes: [NSAttributedStringKey.font : UIFont.pingFangSCRegular(withSize: 16), NSAttributedStringKey.foregroundColor: UIColor.hexColor(hex: 0xA9B4E8)])
        return tf
    }()
    
    lazy var firstSpView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.alpha = 0.7
        return view
    }()
    
    lazy var secondSpView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.alpha = 0.7
        return view
    }()
    
    lazy var passwordTF: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.tintColor = UIColor.white
        tf.clearButtonMode = .whileEditing
        tf.textColor = UIColor.white
        tf.font = UIFont.pingFangSCRegular(withSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: "请输入6～18位密码", attributes: [NSAttributedStringKey.font : UIFont.pingFangSCRegular(withSize: 16), NSAttributedStringKey.foregroundColor: UIColor.hexColor(hex: 0xA9B4E8)])
        return tf
    }()
    
    lazy var companyLb: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var copyrightLb: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0;
        view.text = "传智播客旗下高端IT在线教育品牌 博学谷\nCopyright@2016～2017博学谷AII Rights Reserved"
        view.textAlignment = .center
        view.font = UIFont.pingFangSCRegular(withSize: 13)
        view.textColor = UIColor.white
        view.alpha = 0.7
        return view
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.addTarget(self,  action: #selector(clickLogin), for: .touchUpInside)
        btn.setTitle("登录", for: .normal)
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 25
        btn.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 18)
        btn.setTitleColor(UIColor.hexColor(hex: 0x466DE2), for: UIControlState.normal)

        return btn
    }()
    
    lazy var backgroundView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "login_background"))
        return view
    }()
    
    lazy var offsetView: UIView = {
        let view = UIView()
        return view
    }()
    
    func installUI() {
        self.view.addSubview(backgroundView)
        
        self.view.addSubview(usernameTF)
        self.view.addSubview(passwordTF)
        self.view.addSubview(logoImgV)
        self.view.addSubview(loginBtn)
        self.view.addSubview(firstSpView)
        self.view.addSubview(secondSpView)
        self.view.addSubview(copyrightLb)
        self.view.addSubview(offsetView)
        
        
        backgroundView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalToSuperview()
        }
        
        logoImgV.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(150)
            make.top.lessThanOrEqualToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        
        usernameTF.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImgV.snp.bottom).offset(50)
            make.height.equalTo(30)
            make.width.equalTo(350)
        }
        
        firstSpView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameTF.snp.bottom).offset(5)
            make.width.equalTo(350)
            make.height.equalTo(0.5)
        }
        
        passwordTF.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstSpView.snp.bottom).offset(30)
            make.height.equalTo(30)
            make.width.equalTo(350)
        }
        
        secondSpView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTF.snp.bottom).offset(5)
            make.width.equalTo(350)
            make.height.equalTo(0.5)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTF.snp.bottom).offset(60)
            make.height.equalTo(50)
            make.width.equalTo(350)
        }
        
        copyrightLb.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.width.equalTo(350)
        }
        
        offsetView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0)
            make.top.greaterThanOrEqualTo(loginBtn.snp.bottom)
        }

        logoImgV.setContentCompressionResistancePriority(UILayoutPriority.required, for: UILayoutConstraintAxis.vertical)
        logoImgV.setContentHuggingPriority(UILayoutPriority.required, for: UILayoutConstraintAxis.vertical)
        
        offsetView.setContentCompressionResistancePriority(UILayoutPriority.required, for: UILayoutConstraintAxis.vertical)
        offsetView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.vertical)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapView() {
        view.endEditing(true)
    }
}


extension BXGUserLoginVC {
    func installObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillSHow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillSHow(_ notification: Notification) {
        
        
        if let userInfo = notification.userInfo, let rect = userInfo["UIKeyboardBoundsUserInfoKey"] as? CGRect {
            offsetView.snp.updateConstraints { (make) in
                make.height.equalTo(rect.size.height)
            }
        }
        //        self.keyboardView.alpha = 0
        UIView.animate(withDuration: 0.25) {
            //            self.keyboardView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        
        offsetView.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
            //            self.keyboardView.alpha = 0
        }) { (succeed) in
            
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        installObserver()
    }
}

// MARK: Response

extension BXGUserLoginVC {
    @objc func clickLogin() {
        view.endEditing(true)
        // 验证
        guard let username = usernameTF.text, let password = passwordTF.text else {
            return
        }
        if username.count <= 0 {
            // 用户名为空
            
            BXGHUDTool.showHUD(string: "请输入用户名")
            return
        }
        if !BXGVerifyTool.verifyEmail(username) && !BXGVerifyTool.verifyPhoneNumber(username) {
            
            // 用户名格式错误
            BXGHUDTool.showHUD(string: "账号格式错误,请重新输入")
            return
        }
        
        
        if password.count <= 0 {
            // 密码为空
            BXGHUDTool.showHUD(string: "请输入密码")
            return
        }
        
        if !BXGVerifyTool.verifyPswFormat(password) {
            // 密码格式错误
            BXGHUDTool.showHUD(string: "密码格式错误,请重新输入")
            return
        }
        BXGHUDTool.showLoadingHUD(string: "")
        BXGUserCenter.shared.requestSignIn(username: username, password: password) { (userModel, message) in
            BXGHUDTool.closeHUD()
            if(userModel != nil) {
                self.dismiss(animated: true, completion: {
                    BXGHUDTool.showHUD(string: "登录成功")
                });
            }else {
                BXGHUDTool.showHUD(string: message)
            }
        }
    }
}


