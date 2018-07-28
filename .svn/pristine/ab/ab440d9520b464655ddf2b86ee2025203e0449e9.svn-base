//
//  QZTabView.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018年 itheima. All rights reserved.
//

import UIKit

typealias OnClickTabBtnBlockType = (_ view:UIView, _ index:Int) -> Void

class QZTabView: UIView {

    var preTabIndexSel:Int = 0; //0/2/4/6 双数序列
    var onClickTabBtnBlock:OnClickTabBtnBlockType?
    
    
    init(items:NSArray) {
        super.init(frame:CGRect.zero)
        
        preTabIndexSel = 1
        
        var index:Int = preTabIndexSel
        var preView:UIView?;
        for item in items {
            let itemView = UIView();
            self.addSubview(itemView);
            //item view
//            let strSize:CGSize = (item as! String).stringSize(font: UIFont(name: "PingFangSC-Regular", size: 18)!, w: 100, h: 44)
            let subBtn:UIButton = UIButton(type:.custom)
            subBtn.tag = index;
            subBtn.addTarget(self, action: #selector(QZTabView.onClickIndex(obj:)), for: .touchUpInside)
            subBtn.setTitle(item as? String, for: .normal)
            subBtn.setTitleColor(UIColor.blue, for: .selected)
            subBtn.setTitleColor(UIColor.white, for: .normal)
            
            itemView.addSubview(subBtn)
            
            //item 选中标签
            let markView:UIView = UIView()
            
            markView.backgroundColor = UIColor.blue
            markView.tag = index+1; //标签是单数序列 1/3/5/7
            if(preTabIndexSel+1 == markView.tag) {
                markView.isHidden = false
                subBtn.isSelected = true;
            } else {
                markView.isHidden = true
                subBtn.isSelected = false;
            }
            itemView.addSubview(markView)
         
            itemView.snp.makeConstraints { (make) in
                make.left.equalTo(index==1 ? 0 : (preView?.snp.right)!)
                make.width.equalTo(self.snp.width).dividedBy(items.count)
                make.top.bottom.equalTo(0)
            }
            subBtn.snp.makeConstraints { (make) in
                make.center.equalTo(itemView)
            }
            markView.snp.makeConstraints { (make) in
                make.left.right.bottom.equalTo(0)
                make.height.equalTo(0);
            }
            
            preView = itemView;
            index = index+2
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //修复iOS11.4 titleView 设置后重叠现象
    override var intrinsicContentSize: CGSize {
        return CGSize(width: BXGDevice.ScreenWidth - 200, height: 40.0)
    }

    @objc func onClickIndex(obj:UIButton) {
        if(obj.tag == preTabIndexSel) {
            return ;
        }
        //重置markview的显示
        let oldMarkIndex:Int = preTabIndexSel+1
        self.viewWithTag(oldMarkIndex)?.isHidden = true
        let newMarkIndex:Int = obj.tag+1
        self.viewWithTag(newMarkIndex)?.isHidden = false

        //重置button view的显示
        if let btnOld = self.viewWithTag(preTabIndexSel) as? UIButton {
            btnOld.isSelected = false
        }
        if let btnNew = self.viewWithTag(obj.tag) as? UIButton {
            btnNew.isSelected = true
        }
        //保存新的buttonTabIndex
        preTabIndexSel = obj.tag
        
        if(onClickTabBtnBlock != nil) {
            onClickTabBtnBlock?(obj, obj.tag/2)
        }
     }
    
    func setCurrentIndex(newIndex:Int) {
        let interNewIndex:Int = newIndex*2+1
        if(interNewIndex ==  preTabIndexSel) {
            return ;
        }
        
        //重置markview的显示
        let oldMarkIndex:Int = preTabIndexSel+1
        self.viewWithTag(oldMarkIndex)?.isHidden = true
        let newMarkIndex:Int = interNewIndex+1
        self.viewWithTag(newMarkIndex)?.isHidden = false
        
        //重置button view的显示
        if let btnOld = self.viewWithTag(preTabIndexSel) as? UIButton {
            btnOld.isSelected = false
        }
        if let btnNew = self.viewWithTag(interNewIndex) as? UIButton {
            btnNew.isSelected = true
        }
        
        //保存新的buttonTabIndex
        preTabIndexSel = interNewIndex
    }
    
    
}
