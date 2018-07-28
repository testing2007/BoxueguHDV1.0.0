//
//  QZTabDetailView.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018年 itheima. All rights reserved.
//

import UIKit

typealias IndexChangeBlockType = (_ view:UIView, _ index: Int) -> Void

class QZTabDetailView: UIScrollView {

    var detailViews:[UIView]?
    var currentIndex:Int?
    var indexChangedBlock:IndexChangeBlockType?
    
    //数组指定具体的类型
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isPagingEnabled = true;
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        self.delegate = self;
        self.currentIndex = 0;
        self.indexChangedBlock = nil;
    }
    
    func setDetailViews(views:[UIView]?) {
        if((self.detailViews) != nil) {
            for view in self.detailViews! {
                view.removeFromSuperview();
            }
        }
        
        self.detailViews = nil;
        self.detailViews = views;
        
        var index:Int = 1
        var preView:UIView?;
        for view in views! {
            
            self.addSubview(view)
            view.tag = index;
            
            view.snp.makeConstraints { (make) in
                make.left.equalTo(index==1 ? 0 : (preView?.snp.right)!)
                make.top.bottom.equalTo(0)
                make.width.equalToSuperview()
                make.height.equalToSuperview()
            }
            
            //这个必须要写上, 否则contentSize就会不对, 即便你写了width也不行.
            if(index == (views?.count)!) {
                view.snp.makeConstraints { (make) in
                    make.right.equalTo(0);
                }
            }
            
            index = index+1;
            preView = view;
            
            currentIndex = 0
        }
    
        currentIndex = -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCurrentIndex(newValue:Int) -> Void {
        if (self.detailViews != nil) {
            if(newValue == currentIndex) {
                return
            }
            if((self.detailViews?.count)! <= 0 ) {
                return
            }
            if((self.detailViews?.count)! <= 0 || newValue <= 0) {
                currentIndex = 0
            } else if(newValue >= (self.detailViews?.count)!) {
                currentIndex =  (self.detailViews?.count)!-1;
            }

            
            currentIndex = newValue
            self.scrollToIndex(index: newValue)
        }
    }
    
    func scrollToIndex(index:Int) -> Void {
        if(self.detailViews != nil) {
            if(index >= 0 && (self.detailViews?.count)! > 0) {
                self.setContentOffset(self.detailViews![index].frame.origin, animated: true)
            }
        }
    }
}

extension QZTabDetailView : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index:Int = (Int((scrollView.contentOffset.x + (scrollView.bounds.size.width / 2)) / scrollView.bounds.size.width));
        if(currentIndex != index) {
            self.setCurrentIndex(newValue: index)
            if((indexChangedBlock != nil) && (detailViews?.count)! > 0) {
                indexChangedBlock?(detailViews![index], index)
            }
        }
    }
}
