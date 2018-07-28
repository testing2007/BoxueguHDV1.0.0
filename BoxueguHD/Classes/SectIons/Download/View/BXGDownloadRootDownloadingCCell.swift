//
//  BXGDownloadRootDownloadingCCell.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

class BXGDownloadRootDownloadingCCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var shadowFrameView:UIView = {
        let shadowFrameView:UIView = UIView()
        shadowFrameView.backgroundColor = UIColor.white
        shadowFrameView.layer.cornerRadius = 4
        shadowFrameView.layer.shadowColor = UIColor.black.cgColor
        shadowFrameView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowFrameView.layer.shadowOpacity = 0.2
        shadowFrameView.layer.shadowRadius = 3
        return shadowFrameView;
    }()
    
    var courseImageView:UIImageView = {
        let courseImageView:UIImageView = UIImageView()
        courseImageView.backgroundColor = UIColor.random()
        courseImageView.kf.setImage(with: nil, placeholder: #imageLiteral(resourceName: "download_downloading_root"))
        return courseImageView;
    }()
    
    var downloadingLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.hexColor(hex: 0x34495E)
        label.text = "正在下载"
        return label
    }()
    
    var leaveDownloadNumsLabel:UILabel =  {
        let label:UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hexColor(hex: 0x9AABB8)
        return label;
    }()
    
    func installUI() {
        self.contentView.addSubview(self.shadowFrameView)
        self.contentView.addSubview(self.courseImageView)
        self.contentView.addSubview(self.downloadingLabel)
        self.contentView.addSubview(self.leaveDownloadNumsLabel)
        
        self.shadowFrameView.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.top.equalTo(15);
            make.right.equalTo(-10)
            make.width.equalTo(self.frame.size.width-25-10)
            make.bottom.equalTo(0)
        }
        self.courseImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.shadowFrameView.snp.left).offset(15)
            make.top.equalTo(0)
            make.height.equalTo(self.shadowFrameView)
            make.width.equalTo(self.shadowFrameView.snp.height).multipliedBy(170.0/103.0)
        }
        self.downloadingLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.courseImageView.snp.right).offset(5.5)
            make.top.equalTo(self.shadowFrameView.snp.top).offset(11.5)
            make.right.lessThanOrEqualTo(self.shadowFrameView.snp.right)
        }
        self.leaveDownloadNumsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.courseImageView.snp.right).offset(15)
            make.top.equalTo(self.downloadingLabel.snp.bottom).offset(4.5)
            make.right.lessThanOrEqualTo(self.shadowFrameView.snp.right)
        }
    }
    
    func updateContainerConstraint(nIndex:Int) {
        //都必须写, 否则上下拖动的时候, 有可能因为重用造成不对齐的现象;
        if(nIndex%2==0) {
            self.shadowFrameView.snp.updateConstraints { (make) in
                make.left.equalTo(25);
                make.right.equalTo(-10);
            }
        } else {
            self.shadowFrameView.snp.updateConstraints { (make) in
                make.left.equalTo(10);
                make.right.equalTo(-25);
            }
        }
    }
}

