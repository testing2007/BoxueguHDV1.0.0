//
//  BXGCourseOutlineSectionExamCell.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/20.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

class BXGCourseOutlineSectionExamCell: UITableViewCell {
    
    lazy var cellIconImgV: UIImageView = {
        
        let item = UIImageView(image: #imageLiteral(resourceName: "course_outline_section_exam"))
        return item
    }()
    
    lazy var cellTitleLb: UILabel = {
        let item = UILabel()
        item.text = "小节测试"
        item.font = UIFont.pingFangSCRegular(withSize: 15)
        item.textColor = UIColor.hexColor(hex: 0x34495E)
        return item
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installUI() {
        addSubview(cellIconImgV)
        addSubview(cellTitleLb)
        
        cellIconImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
        }
        cellTitleLb.snp.makeConstraints { (make) in
            make.left.equalTo(cellIconImgV.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
        }
        
        cellIconImgV.setContentHuggingPriority(.required, for: UILayoutConstraintAxis.horizontal)
        cellIconImgV.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
