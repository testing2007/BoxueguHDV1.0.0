//
//  RWPopView.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/26.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
enum RWPopViewPositionType {
    case center
}
class POP {
    
    func installTransition() {
        viewController.modalPresentationStyle = .custom
    }
 
    init(viewController from: UIViewController) {
        viewController = from
    }
    
    var viewController: UIViewController
    
    func presentViewController(viewController popVC: UIViewController,contentSize: CGSize, position: RWPopViewPositionType, completion: @escaping ()->() ) {
        
        let fromVC = RWPopViewController(contentView: popVC.view, size: contentSize, position: position)
        fromVC.addChildViewController(popVC)
        installTransition()
        viewController.present(fromVC, animated: true, completion: completion)
    }
    
    func dismiss(completion: @escaping ()->()) {
        viewController.dismiss(animated: true, completion: completion)
    }
}

extension UIViewController {
    var rw:POP {
        return POP(viewController: self)
    }
}

class RWPopViewController: UIViewController  {
    
    var transitionType: RWPopViewTransitionType = .present
    var maskView: UIView?
    var contentView: UIView
    var contentViewSize: CGSize
    
    
    init(contentView fromContentView: UIView, size: CGSize, position: RWPopViewPositionType) {
        contentView = fromContentView
        contentViewSize = size
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnimation() {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        installUI()
    }
    
    func installUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(contentViewSize.width)
            make.height.equalTo(contentViewSize.height)
        }
    }
}

enum RWPopViewTransitionType {
    case present
    case dismiss
}

extension RWPopViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let deVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        guard let sourceVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        deVC.view.isUserInteractionEnabled = true
        sourceVC.view.isUserInteractionEnabled = false
        
        if self.transitionType == .present {
            containerView.addSubview(deVC.view)
            
            let maskView = UIVisualEffectView(effect: UIBlurEffect.init(style: UIBlurEffectStyle.extraLight))
            maskView.contentView.backgroundColor = UIColor.black
            maskView.contentView.alpha = 0.4
            maskView.alpha = 0.9
            self.maskView = maskView
            
            
            sourceVC.view.addSubview(maskView)
            maskView.snp.makeConstraints { (make) in
                make.left.bottom.top.right.equalToSuperview()
            }
//            sourceVC.view.alpha = 0
//            maskView.alpha = 0
            
            UIView.animate(withDuration: 0.2, animations: {
//                sourceVC.view.alpha = 1
//                maskView.alpha = 1
            }) { (completed) in
                transitionContext.completeTransition(true)
            }
            
        }else {
//            sourceVC.view.alpha = 1
//            self.maskView?.alpha = 1
            UIView.animate(withDuration: 0.2, animations: {
//                sourceVC.view.alpha = 0
//                self.maskView?.alpha = 0
            }) { (completed) in
                transitionContext.completeTransition(true)
                self.maskView?.removeFromSuperview()
            }
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionType = .present

        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionType = .dismiss
        return self
    }
}
