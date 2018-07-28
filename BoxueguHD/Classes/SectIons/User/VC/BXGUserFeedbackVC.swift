//
//  BXGUserFeedbackVC.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/26.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGUserFeedbackVC: UIViewController {
    // MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        installUI()
    }
    // MARK: MODEL
    lazy var viewModel: BXGUserFeedbackViewModel = {
        let item = BXGUserFeedbackViewModel()
        return item
    }()
    // MARK: UI
    
    lazy var textView: UITextView = {
        let view = RWTextView()
        view.counterLabel.font = UIFont.pingFangSCRegular(withSize: 12)
        view.counterLabel.textColor = UIColor.hexColor(hex: 0x3A4E63)
        view.countNumber = 200
        view.placeHolderLabel.font = UIFont.pingFangSCRegular(withSize: 15)
        view.placeHolderLabel.textColor = UIColor.hexColor(hex: 0x3A4E63)
        view.font = UIFont.pingFangSCRegular(withSize: 15)
        view.textColor = UIColor.hexColor(hex: 0x34495E)
        view.placeHolder = "感谢您为我们提出宝贵意见和建议～"
        view.textContainerInset = UIEdgeInsetsMake(25, 25, 25, 25)
        view.placeHolderInsets = UIEdgeInsetsMake(25, 25 + 4, 25, 25)
        view.layer.cornerRadius = 3;
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    lazy var mobileTF: UITextField = {
        let view = UITextField()
        view.font = UIFont.pingFangSCRegular(withSize: 15)
        view.textColor = UIColor.hexColor(hex: 0x3A4E63)
        view.attributedPlaceholder = NSAttributedString(string: "请输入您的手机号码，方便答疑解惑！", attributes: [NSAttributedStringKey.foregroundColor: UIColor.hexColor(hex: 0x3A4E63), NSAttributedStringKey.font: UIFont.pingFangSCRegular(withSize: 15)])
        
        return view
    }()
    
    lazy var spView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexColor(hex: 0xBFC5C8)
        return view
    }()
    
    lazy var submitBtn: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.layer.cornerRadius = 20
        view.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 16)
        view.setTitle("登录", for: UIControlState.normal)
        view.setTitleColor(UIColor.hexColor(hex: 0xFFFFFF), for: UIControlState.normal)
        view.backgroundColor = UIColor.themeColor
        view.addTarget(self, action: #selector(clickSubmitBtn), for: UIControlEvents.touchUpInside)
        return view
    }()
    
    func installUI() {
        view.backgroundColor = UIColor.hexColor(hex: 0xeff3f5)
        view.addSubview(textView)
        view.addSubview(mobileTF)
        view.addSubview(spView)
        view.addSubview(textView)
        view.addSubview(submitBtn)
        
        textView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.left.equalToSuperview().offset(25)
            make.height.equalTo(170)
        }
        mobileTF.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(30)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
        }
        spView.snp.makeConstraints { (make) in
            make.top.equalTo(mobileTF.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(1)
        }
        
        submitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(spView).offset(130)
            make.width.equalTo(600)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
//        setSubmitEnable(isEnable: false)
    }
    
    // MARK: SETTER
    
    func setSubmitEnable(isEnable: Bool) {
        if isEnable {
            submitBtn.setTitleColor(UIColor.hexColor(hex: 0xFFFFFF), for: UIControlState.normal)
            submitBtn.backgroundColor = UIColor.themeColor
            submitBtn.isEnabled = true
        }else {
            submitBtn.setTitleColor(UIColor.hexColor(hex: 0xFFFFFF), for: UIControlState.normal)
            submitBtn.backgroundColor = UIColor.hexColor(hex: 0xcccccc)
            submitBtn.isEnabled = false
        }
    }
    
    // MARK: FUNCTION
    
    @objc func clickSubmitBtn() {
        // 判断是否空
        guard var text = textView.text else {
            return
        }
        text = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (text as NSString).hasEmoji() {
            BXGHUDTool.showHUD(string: "暂不支持输入表情")
        }
        
        if text.count < 5 {
            BXGHUDTool.showHUD(string: "请输入不少于5个字")
            textView.becomeFirstResponder()
            return
        }
        
        if text.count > 120 {
            BXGHUDTool.showHUD(string: "请输入少于120个字")
            textView.becomeFirstResponder()
            return
        }
        
        // mobile
        
        if let mobile = mobileTF.text {
            if BXGVerifyTool.verifyPhoneNumber(mobile) {
                BXGHUDTool.showHUD(string: "请输入正确的手机号")
                mobileTF.becomeFirstResponder()
                return
            }
        }
        BXGHUDTool.showLoadingHUD(string: "")
        viewModel.postFeedback(text: text, mobile: mobileTF.text) { (succeed, message) in
            BXGHUDTool.closeHUD()
            if succeed {
                BXGHUDTool.showHUD(string: "提交成功")
            }else {
                BXGHUDTool.showHUD(string: message ?? "")
            }
        }
    }
}
