//
//  BXGSectionExamResultAnalyseCell.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/23.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGSectionExamResultAnalyseCell: UITableViewCell {
    lazy var cellTagLb: UILabel = {
        let view = UILabel()
        view.font = UIFont.pingFangSCRegular(withSize: 16)
        view.textColor = UIColor.hexColor(hex: 0xB1BEC8)
        view.text = "答案解析："
        //        font-family: PingFangSC-Regular;
        //        font-size: 32px;
        //        color: #B1BEC8;
        //        letter-spacing: 0;
        //        line-height: 48px;
        
        return view
    }()
    
    lazy var cellTitleLb: UILabel = {
        let view = UILabel()
        view.font = UIFont.pingFangSCRegular(withSize: 16)
        view.textColor = UIColor.hexColor(hex: 0x161F00)
        view.numberOfLines = 0
        
        return view
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installUI() {
        contentView.addSubview(cellTagLb)
        contentView.addSubview(cellTitleLb)
        cellTagLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
        }
        
        cellTitleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview()
        }
    }
    
    func installModel(analyse: String?) {
        
        cellTagLb.sizeToFit()
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.firstLineHeadIndent = cellTagLb.bounds.size.width + 5
        
        if let title = analyse, let data = title.data(using: String.Encoding.utf8) {
            do {
                let att = try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
                
                let newLine = att.string.trimmingCharacters(in: CharacterSet.newlines)
                
                let att2 = NSMutableAttributedString(string: newLine, attributes: [NSAttributedStringKey.paragraphStyle : paraStyle])
                cellTitleLb.attributedText = att2
            }catch {
                cellTitleLb.text = " "
            }
            
        }else {
            cellTitleLb.text = " "
        }
    }
}
