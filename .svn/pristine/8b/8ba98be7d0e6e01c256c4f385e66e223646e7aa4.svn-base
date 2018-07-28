//
//  BXGDownloadedDetailHeaderView.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/24.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

protocol BXGDownloadedDetailHeaderViewDelegate : AnyObject {
    func openSection(sectionId:Int) -> Void;
    func closeSection(sectionId:Int) -> Void;
}

class BXGDownloadedDetailHeaderView: UITableViewHeaderFooterView {
        var sectionId:Int //section索引值
        weak var delegate:BXGDownloadedDetailHeaderViewDelegate?
        
        override init(reuseIdentifier: String?) {
            sectionId = -1
            isOpen = false
            super.init(reuseIdentifier: reuseIdentifier)
            self.backgroundColor = UIColor.hexColor(hex: 0xF6F9FC)
            
            self.installUI()
            
            self.isUserInteractionEnabled = true;
            let tap:UITapGestureRecognizer = UITapGestureRecognizer()
            tap.addTarget(self, action: #selector(BXGDownloadSelectHeaderView.onClickHeaderSection))
            self.addGestureRecognizer(tap)
        }
        
        var isOpen:Bool {
            didSet {
                if(isOpen) {
                    self.switchImageView.image = UIImage.init(named: "download_arrow_down_open")
                } else {
                    self.switchImageView.image = UIImage.init(named: "download_arrow_left_close")
                }
            }
        }
        
        @objc func onClickHeaderSection() {
            self.isOpen = !self.isOpen
            if(self.isOpen) {
                self.delegate?.openSection(sectionId: sectionId)
            } else {
                self.delegate?.closeSection(sectionId: sectionId)
            }
        }
        
        func installUI() {
            self.backgroundColor = UIColor.hexColor(hex: 0xF6F9FC)
            self.contentView.addSubview(self.sectionLabel)
            self.contentView.addSubview(self.switchImageView)
            self.sectionLabel.snp.makeConstraints { (make) in
                make.left.equalTo(25.5)
                make.centerY.equalToSuperview()
            }
            self.switchImageView.snp.makeConstraints { (make) in
                make.right.equalTo(-25)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(14)
            }
        }
        
        lazy var sectionLabel:UILabel = {
            let label:UILabel = UILabel()
            label.font = UIFont.pingFangSCRegular(withSize: 16)
            label.textColor = UIColor.hexColor(hex: 0x34495E)
            return label;
        }()
        
        lazy var switchImageView:UIImageView = {
            let imageView:UIImageView = UIImageView()
            return imageView;
        }()
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
