//
//  BXGSectionExamResultSeparatorCell.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/23.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGSectionExamResultSeparatorCell: UITableViewCell {
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexColor(hex: 0xf5f5f5)
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(1)
            make.top.equalToSuperview().offset(21)
            make.bottom.equalToSuperview().offset(-21)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
