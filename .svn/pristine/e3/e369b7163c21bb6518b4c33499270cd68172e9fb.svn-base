//
//  BXGDownloadSelectCell.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

protocol BXGDownloadSelectCellDelegate : AnyObject {
    func onSelectOptionItem(bSelected:Bool, cellItem:BXGDownloadSelectCell) -> Void;
}

class BXGDownloadSelectCell: UITableViewCell {

    weak var delegate : BXGDownloadSelectCellDelegate?;
    var sectionId:Int?
    var identifier:Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var bSel:Bool {
        didSet {
            if bSel {
                self.selImageView.image = UIImage.init(named: "download_select")
            } else {
                self.selImageView.image = UIImage.init(named: "download_unselect")
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.bSel = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func installUI() {
        self.addSubview(self.selImageView)
        self.addSubview(self.videoNameLabel)
        self.selImageView.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.centerY.equalTo(self)
            make.width.height.equalTo(18)
        }
        self.videoNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.selImageView.snp.right).offset(10)
            make.centerY.equalTo(self)
            make.right.lessThanOrEqualTo(-25)
        }
    }
    
    lazy var selImageView:UIImageView = {
        let imageView:UIImageView = UIImageView()
        imageView.image = UIImage.init(named: "download_unselect")
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BXGDownloadingCell.onTapImageView(sender:)))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true;
        return imageView;
    }()
    
    lazy var videoNameLabel:UILabel = {
        let label:UILabel = UILabel()
        label.font = UIFont.pingFangSCRegular(withSize: 15)
        label.textColor = UIColor.hexColor(hex: 0x34495E)
        return label;
    }()
    
    @objc func onTapImageView(sender:UITapGestureRecognizer) {
        delegate?.onSelectOptionItem(bSelected: !self.bSel, cellItem: self)
        //        self.selectCell(bHighlighted: !self.bSel)
        self.bSel = !self.bSel;
    }

}
