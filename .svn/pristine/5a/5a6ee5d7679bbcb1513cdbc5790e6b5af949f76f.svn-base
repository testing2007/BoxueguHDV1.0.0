//
//  BXGConstrueHeaderView.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/25.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGConstrueHeaderView: UIView {
    
    var titles: [String]
    
    var items: [UIButton]?
    var clickTabBtnClosure: ((_ tabView: UIView,_ index: Int)->())?
    init(titles fromTitles: [String]) {
        titles = fromTitles
        super.init(frame: CGRect.zero)
        installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectIndex(index: Int) {
        if let items = items, items.count > index {
            arrowView.snp.remakeConstraints { (make) in
                make.centerX.equalTo(items[index])
                make.bottom.equalToSuperview()
                make.height.equalTo(1)
                make.width.equalTo(74)
            }
            UIView.animate(withDuration: 0.25) {
                self.layoutIfNeeded()
            }
            setSelectItem(item: items[index])
        }
    }
    
    func setSelectItem(item from: UIButton) {
        if let items = items {
            for item in items {
                if item == from {
                    setItemHighlited(item: item, isHighlited: true)
                }else {
                    setItemHighlited(item: item, isHighlited: false)
                }
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
//        return UILayoutFittingCompressedSize
        return CGSize(width: 346, height: 100);
    }
    
    lazy var arrowView: UIView = {
        let view = UIView()
//        148 - 2
        view.backgroundColor = UIColor.hexColor(hex: 0x34495E)
        return view
    }()
    
    func makeItemBtn() -> UIButton {
        let btn = UIButton()
        setItemHighlited(item: btn, isHighlited: false)
        return btn
    }
    
    func setItemHighlited(item: UIButton, isHighlited: Bool) {
        if(isHighlited){
            item.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 18)
            item .setTitleColor(UIColor.hexColor(hex: 0x34495E), for: UIControlState.normal)
            
        }else {
            
            item.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 18)
            item .setTitleColor(UIColor.hexColor(hex: 0xA2B2BE), for: UIControlState.normal)
        }
    }
    lazy var wrapView: UIView = {
        let view = UIView()
        return view
    }()
    
    func installUI() {
        
        
        addSubview(wrapView)
        wrapView.addSubview(arrowView)
        var lastView: UIView?
        var firstView: UIView?
        var itemsArray = [UIButton]()
        for (index,title) in titles.enumerated() {
            let item = makeItemBtn()
            item.setTitle(title, for: UIControlState.normal)
            item.tag = index
            item.addTarget(self, action: #selector(clickItemBtn(sender:)), for: UIControlEvents.touchUpInside)
            item.titleLabel?.textAlignment = .center
            item.sizeToFit()
            wrapView.addSubview(item)
            item.setContentCompressionResistancePriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
            item.setContentHuggingPriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
            
            if let lastView = lastView {
                item.sizeToFit()
                if(title.count - 1 == index) {
                    
                    item.snp.makeConstraints { (make) in
                        make.left.equalTo(lastView.snp.right)
                        make.top.bottom.right.equalToSuperview()
                        make.width.equalTo(100 + item.bounds.size.width)
                        make.height.equalTo(item.bounds.size.height)
                    }
                    
                    wrapView.snp.makeConstraints { (make) in
                        make.right.equalTo(item)
                    }

                }else {
                    item.snp.makeConstraints { (make) in
                        make.left.equalTo(lastView.snp.right)
                        make.top.bottom.equalToSuperview()
                        make.width.equalTo(100 + item.bounds.size.width)
                        make.height.equalTo(item.bounds.size.height)
                    }
                }

            }else {
                
                item.snp.makeConstraints { (make) in
                    make.left.equalToSuperview()
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(100 + item.bounds.size.width)
                    make.height.equalTo(item.bounds.size.height)
                }
                
                wrapView.snp.makeConstraints { (make) in
                    make.top.bottom.equalToSuperview()
                    make.left.equalTo(item)
//                    make.centerX.equalToSuperview()
                    make.left.right.equalToSuperview()
                }
            }
            
            
            
            lastView = item
            itemsArray.append(item)
        }
        items = itemsArray

    }
    
    
    @objc func clickItemBtn(sender: UIButton) {
        if let closure = clickTabBtnClosure {
            selectIndex(index: sender.tag)
            closure(sender, sender.tag)
            
        }
    }
}
