//
//  BXGDownloadedDetailCell.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/23.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

protocol BXGDownloadedDetailCellDelegate : AnyObject {
    func onSelectOptionItem(bSelected:Bool, cellItem:BXGDownloadedDetailCell) -> Void;
}

class BXGDownloadedDetailCell: UITableViewCell {

    //显示数据的模型
//    var model:BXGDownloadPersistAPIModel?
    weak var delegate : BXGDownloadedDetailCellDelegate?;

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        self.installUI();
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.bSel = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setModel(model:BXGDownloadPersistAPIModel, delegate:BXGDownloadedDetailCellDelegate, bEdit:Bool, bSel:Bool) {
//        self.model = model;
//        self.delegate = delegate;
//        self.bEdit = bEdit;
//        
//        if(self.bEdit) {
//            self.bSel = bSel
//        } else {
//            if(model.apiDownloaderItem.watched) {
//                //TODO: 已观看图
//            } else {
//                //TODO: 未观看图
//            }
//            self.videoNameLabel.text = model.apiDownloaderItem.pointName
//        }
//    }
    
    var bEdit:Bool = false {
        didSet {
            if(!bEdit) {
                //TODO: 查询是否是已观看状态, 然后贴相关的图片
                self.markImageView.image = UIImage.init(named: "downloaded_unwatched")
//                self.markImageView.image = UIImage.init(named: "downloaded_watched")
            } else {
                self.markImageView.image = UIImage.init(named: "downloaded_unselect")
            }
        }
    };
    
    var bSel:Bool {
        didSet {
            if(!bEdit) {
                return ;
            }
            if bSel {
                self.markImageView.image = UIImage.init(named: "downloaded_select")
            } else {
                self.markImageView.image = UIImage.init(named: "downloaded_unselect")
            }
        }
    }
    
    func installUI() -> Void {
        self.addSubview(self.markImageView)
        self.addSubview(self.videoNameLabel)
        self.markImageView.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.centerY.equalTo(self)
            make.width.height.equalTo(18)
        }
        self.videoNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.markImageView.snp.right).offset(10)
            make.centerY.equalTo(self)
            make.right.lessThanOrEqualTo(-25)
        }
    }
    
    lazy var markImageView:UIImageView = {
        let imageView:UIImageView = UIImageView()
        imageView.image = UIImage.init(named: "downloaded_unselect")
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BXGDownloadedDetailCell.onTapImageView(sender:)))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true;
        return imageView;
    }()
    
    @objc func onTapImageView(sender:UITapGestureRecognizer) {
        if (bEdit) {
            delegate?.onSelectOptionItem(bSelected: !self.bSel, cellItem: self)
            self.bSel = !self.bSel;
        }
    }
    
    lazy var videoNameLabel:UILabel = {
        let label:UILabel = UILabel()
        label.font = UIFont.pingFangSCRegular(withSize: 15)
        label.textColor = UIColor.hexColor(hex: 0x34495E)
        return label;
    }()
}
