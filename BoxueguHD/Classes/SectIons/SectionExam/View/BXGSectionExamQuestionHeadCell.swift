//
//  BXGSectionExamQuestionHeadCell.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/21.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGSectionExamQuestionHeadCell: UITableViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    
    func installData(type: BXGStudySectionExamQuestionType, title: String) {
        
        let text: String?
        switch type {
            
        case .single:
            text = " 单选题 "
        case .multiple:
            text = " 多选题 "
        case .trueFalse:
            text = " 判断题 "
        case .blank:
            text = " 填空题 "
        case .shortAnswer:
            text = " 简答题 "
        case .code:
            text = " 代码题 "
        case .apply:
            text = " 应用题 "
        }

        
        cellTagLb.text = text
        
        cellTagLb.sizeToFit()
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.firstLineHeadIndent = cellTagLb.bounds.size.width + 5
        
        if let data = title.data(using: String.Encoding.utf8) {
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
        
        
        //        let attString = NSMutableAttributedString(string: title)
        //        attString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paraStyle, range: NSMakeRange(0, attString.length))
        
        
        
        
        //        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        //        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        //        paraStyle.alignment = NSTextAlignmentLeft;
        //        paraStyle.lineSpacing = 0; //设置行间距
        //        paraStyle.hyphenationFactor = 1.0;
        //        paraStyle.firstLineHeadIndent = 50;
        //        paraStyle.paragraphSpacingBefore = 0.0;
        //        paraStyle.headIndent = 0;
        //        paraStyle.tailIndent = 0;
        //
        //        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[headContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        //
        //
        //        NSString *newLine  = [attrStr.string stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        //        NSMutableAttributedString *matt = [[NSMutableAttributedString alloc]initWithString:newLine];
        //        [matt addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, matt.length)];
        //        self.contentLabel.attributedText = matt.copy;
        //        self.contentLabel.font = [UIFont bxg_fontRegularWithSize:16];
        //        self.contentLabel.textColor = [UIColor colorWithHex:0x333333];
        
        
    }
    
    lazy var cellTitleLb: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont.pingFangSCRegular(withSize: 16)
        view.textColor = UIColor.hexColor(hex: 0x34495E)
        view.numberOfLines = 0
        
        //        font-family: PingFangSC-Regular;
        //        font-size: 32px;
        //        color: #34495E;
        //        letter-spacing: 0;
        //        line-height: 48px;
        return view
    }()
    
    lazy var cellTagLb: UILabel = {
        let view = UILabel()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.themeColor.cgColor
        view.font = UIFont.pingFangSCRegular(withSize: 12)
        view.textColor = UIColor.hexColor(hex: 0x34495E)
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        installUI()
        self.selectionStyle = .none
//        self.isUserInteractionEnabled = false
        
    }
    
    func installUI() {
        contentView.addSubview(cellTagLb)
        contentView.addSubview(cellTitleLb)
        
        cellTagLb.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(20)
        }
        
        cellTitleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-16)
            make.height.greaterThanOrEqualTo(24)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
