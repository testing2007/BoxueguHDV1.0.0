//
//  BXGDownloadedIndexCell.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 itheima. All rights reserved.
//

import UIKit

//protocol BXGDownloadedIndexCellDelegate : AnyObject {
//    func onIndex(courseId:Int32, phaseId:Int32, moduleId:Int32, moduleName:String) -> Void
//}
class BXGDownloadedIndexCell: UITableViewCell {

    var courseId:Int32?
    var phaseId:Int32?
    var moduleId:Int32?
    var moduleName:String?
//    weak var delegate:BXGDownloadedIndexCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        if(selected) {
            self.indexView.backgroundColor = UIColor.hexColor(hex: 0xFFFFFF)
            self.indexTitleLabel.textColor = UIColor.hexColor(hex: 0x466DE2)
        } else {
            self.indexView.backgroundColor = UIColor.hexColor(hex: 0xE1E6EB)
            self.indexTitleLabel.textColor = UIColor.hexColor(hex: 0x34495E)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.installUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installUI() {
        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.indexView)
        self.indexView.addSubview(self.indexTitleLabel)
        
        self.indexView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(7)
            make.right.equalTo(-15)
            make.bottom.equalTo(-7)
//            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15))
        }
        self.indexTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
    
    lazy var indexView:UIView = {
        let cellView = UIView()
        cellView.backgroundColor = UIColor.hexColor(hex: 0xE1E6EB)
        cellView.layer.cornerRadius = 6
        cellView.layer.masksToBounds = true
        return cellView;
    }()

    lazy var indexTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.pingFangSCRegular(withSize: 15)
        label.textColor = UIColor.hexColor(hex: 0x34495E)
        return label
    }()
    
//    lazy var indexBtn:UIButton = {
//        let btn:UIButton = UIButton(type: .custom)
//        btn.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 15)
//        btn.setTitleColor(UIColor.hexColor(hex: 0x34495E), for: UIControlState.normal)
//        btn.setTitleColor(UIColor.hexColor(hex: 0x466DE2), for: UIControlState.selected)
//        btn.layer.cornerRadius = 6;
//        btn.layer.masksToBounds = true;
//        btn.addTarget(self, action: #selector(BXGDownloadedIndexCell.onIndex), for: .touchUpInside);
//        return btn
//    }()
    
//    @objc func onIndex() -> Void {
//        delegate?.onIndex(courseId: self.courseId! , phaseId: moduleId!, moduleId: moduleId!, moduleName: moduleName!)
//    }
}
