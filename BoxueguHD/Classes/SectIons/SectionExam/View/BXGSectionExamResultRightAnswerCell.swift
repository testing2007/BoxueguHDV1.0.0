//
//  BXGSectionExamResultRightAnswerCell.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/23.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGSectionExamResultRightAnswerCell: UITableViewCell {
    
    lazy var cellLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.pingFangSCRegular(withSize: 16)
        view.textColor = UIColor.hexColor(hex: 0x34495E)
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
        contentView.addSubview(cellLabel)
        cellLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview()
        }
    }
    
    func installModel(string: [String]?) {
        var text = ""
        if let string = string {
            
            for (index, answer) in string.enumerated() {
                
                if index != 0 {
                    text.append("，")
                }
                
                if let intValue = Int(answer) {
                    text.append(alphabet[intValue])
                }
            }
            
        }
        
        //        for (NSInteger i = 0; i < examModel.appStandardAnswers.count; i++) {
        //
        //            if(i == 0) {
        //                answer = [NSString stringWithFormat:@"%@", K_ALPHABET_ARRAY[[examModel.appStandardAnswers[i] integerValue]]];
        //            }else {
        //                answer = [NSString stringWithFormat:@"%@、%@", answer, K_ALPHABET_ARRAY[[examModel.appStandardAnswers[i] integerValue]]];
        //            }
        //
        //        }
        
        
        cellLabel.text = "正确答案：\(text)"
    }
    
}
