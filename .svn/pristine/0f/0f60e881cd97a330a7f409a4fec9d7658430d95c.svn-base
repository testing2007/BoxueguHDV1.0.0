//
//  BXGNavUserItem.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/12.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

extension BXGNavUserItemView: UIPopoverPresentationControllerDelegate{
    
}

class BXGNavUserItemView: UIView {
    
    lazy var userIconImgV: UIImageView = {
        let imgV = UIImageView(image: #imageLiteral(resourceName: "user_icon_default"))
        imgV.layer.cornerRadius = 16
        imgV.layer.borderColor = UIColor.hexColor(hex: 0xf5f5f5).cgColor
        imgV.layer.borderWidth = 0.5
        imgV.layer.masksToBounds = true
        return imgV
    }()
    
    lazy var bottomTagImgV: UIImageView = {
        let imgV = UIImageView(image: #imageLiteral(resourceName: "navigationbar_triangle"))
        
        return imgV
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 32 + 10, height: 32))
        installUI()
        
    }
    
    func setHeadImage() {
        if let headImage = BXGUserCenter.shared.userModel?.head_img {
            userIconImgV.sd_setImage(with: URL(string: headImage), placeholderImage: #imageLiteral(resourceName: "user_icon_default"), options: SDWebImageOptions.retryFailed, completed: nil)
        }
    }
    
    override func didMoveToWindow() {
        if let _ = self.window {
            NotificationCenter.default.addObserver(self, selector: #selector(userSignIn), name: NSNotification.Name.BXGUserCenter.SignIn, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(userSignOut), name: NSNotification.Name.BXGUserCenter.SignOut, object: nil)
            setHeadImage()
        }else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    @objc func userSignIn() {
        setHeadImage()
    }
    
    @objc func userSignOut() {
        userIconImgV.image = #imageLiteral(resourceName: "user_icon_default")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installUI() {
        addSubview(userIconImgV)
        addSubview(bottomTagImgV)
        
        userIconImgV.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(32)
            make.left.equalToSuperview()
//            make.centerY.equalToSuperview()
        }
//
        bottomTagImgV.snp.makeConstraints { (make) in
            make.width.equalTo(8)
            make.height.equalTo(5)
            make.centerY.equalToSuperview()
            make.left.equalTo(userIconImgV.snp.right).offset(10)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView(tap:)))
        addGestureRecognizer(tap)
    }
    
    @objc func tapView(tap: UITapGestureRecognizer) {
        //        UIModalPresentationPopover and UIPopoverPresentationController.
        
        let vc = BXGUserItemPopVC()
        vc.clickFeedbackClosure = {
            let feedbackVC = BXGUserFeedbackVC()
            
            if let window = UIApplication.shared.keyWindow, let mainVC = window.rootViewController as? BXGMainVC {
                if let nav = mainVC.selectedViewController as? UINavigationController {
                    nav.pushViewController(feedbackVC, animated: true)
                }
            }
        }
        
        vc.clickSettingClosure = {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: {
                if let window = UIApplication.shared.keyWindow, let mainVC = window.rootViewController as? BXGMainVC {
                    if let nav = mainVC.selectedViewController as? UINavigationController {
                        
                        let popVC = BXGUserSettingPopVC()
                        nav.rw.presentViewController(viewController: popVC,contentSize: CGSize(width: 315 + 50, height: 175 + 50), position: RWPopViewPositionType.center, completion: {
                            
                        })
                        //
                    }
                }
            })
            
            
            
            
        }
        
        vc.clickSignOutClosure = {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: {
                BXGUserCenter.shared.signOut()
            })
            
        }
        
        
        //        vc.view.backgroundColor = UIColor.random()
        //        vc.view.layer.cornerRadius = 2
        //        vc.view.layer.borderWidth = 2
        //        vc.view.layer.borderColor = UIColor.black.cgColor
        vc.preferredContentSize = CGSize(width: 115, height: 44 * 3)
        vc.modalPresentationStyle = .popover
        if let popVC = vc.popoverPresentationController {
            popVC.delegate = self
            popVC.permittedArrowDirections = .down
            popVC.sourceRect = self.bounds
            popVC.sourceView = self
            //            popVC.
            if let viewController = self.viewController {
                viewController.present(vc, animated: true) {
                    
                }
            }
        }
        
        //        BXGUserCenter.shared.signOut()
        
    }

    
}

//class BXGNavUserItem: UIBarButtonItem {
//
//    var view = UIView()
//
//    lazy var userIconImgV: UIImageView = {
//        let imgV = UIImageView()
//        imgV.backgroundColor = UIColor.brown
//        return imgV
//    }()
//
//    lazy var bottomTagImgV: UIImageView = {
//        let imgV = UIImageView()
//        imgV.backgroundColor = UIColor.brown
//        return imgV
//    }()
//
//    func installUI() {
//        view.addSubview(userIconImgV)
//        view.addSubview(bottomTagImgV)
//
//        userIconImgV.snp.makeConstraints { (make) in
//            make.width.height.equalTo(32)
//            make.left.equalTo(10)
//            make.centerY.equalToSuperview()
//        }
//
//        bottomTagImgV.snp.makeConstraints { (make) in
//            make.width.equalTo(8)
//            make.height.equalTo(5)
//            make.centerY.equalToSuperview()
//            make.left.equalTo(userIconImgV.snp.right).offset(10)
//        }
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView(tap:)))
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func tapView(tap: UITapGestureRecognizer) {
////        UIModalPresentationPopover and UIPopoverPresentationController.
//
//        let vc = BXGUserItemPopVC()
//        vc.clickFeedbackClosure = {
//            let feedbackVC = BXGUserFeedbackVC()
//
//            if let window = UIApplication.shared.keyWindow, let mainVC = window.rootViewController as? BXGMainVC {
//                if let nav = mainVC.selectedViewController as? UINavigationController {
//                    nav.pushViewController(feedbackVC, animated: true)
//                }
//            }
//        }
//
//        vc.clickSettingClosure = {
//
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: {
//                if let window = UIApplication.shared.keyWindow, let mainVC = window.rootViewController as? BXGMainVC {
//                    if let nav = mainVC.selectedViewController as? UINavigationController {
//
//                        let popVC = BXGUserSettingPopVC()
//                        nav.rw.presentViewController(viewController: popVC,contentSize: CGSize(width: 315 + 50, height: 175 + 50), position: RWPopViewPositionType.center, completion: {
//
//                        })
////
//                    }
//                }
//            })
//
//
//
//
//        }
//
//        vc.clickSignOutClosure = {
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: {
//                BXGUserCenter.shared.signOut()
//            })
//
//        }
//
//
////        vc.view.backgroundColor = UIColor.random()
////        vc.view.layer.cornerRadius = 2
////        vc.view.layer.borderWidth = 2
////        vc.view.layer.borderColor = UIColor.black.cgColor
//        vc.preferredContentSize = CGSize(width: 115, height: 44 * 3)
//        vc.modalPresentationStyle = .popover
//        if let popVC = vc.popoverPresentationController {
//            popVC.delegate = self
//            popVC.permittedArrowDirections = .down
//            popVC.sourceRect = (self.customView?.bounds)!
//            popVC.sourceView = self.customView!
////            popVC.
//            if let viewController = self.customView!.viewController {
//                viewController.present(vc, animated: true) {
//
//                }
//            }
//        }
//
////        BXGUserCenter.shared.signOut()
//
//    }
//
//    override init() {
//
//        super.init()
//        self.customView = view
//        view.snp.makeConstraints { (make) in
//            make.width.equalTo(100)
//            make.height.equalTo(44) // 这里不能大于 44
//        }
//        installUI()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


