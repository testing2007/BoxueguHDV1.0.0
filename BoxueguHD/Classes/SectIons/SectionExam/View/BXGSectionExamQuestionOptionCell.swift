//
//  BXGSectionExamOptionCell.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/21.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGSectionExamQuestionOptionCell: UITableViewCell {
    
    var cellSelected: Bool = false {
        didSet {
            if cellSelected {
                tagImgV.image = #imageLiteral(resourceName: "section_exam_option_selected")
                
            }else {
                tagImgV.image = #imageLiteral(resourceName: "section_exam_option")
            }
        }
    }
    
    lazy var tagImgV: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "section_exam_option"))
        return view
    }()
    
    lazy var indexLb: UILabel = {
        let view = UILabel()
        return view
    }()
    
    lazy var optionLb: UILabel = {
        let view = UILabel()
        return view
    }()
    
    lazy var optionImgV: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFit
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
        
        self.selectionStyle = .none
        contentView.addSubview(tagImgV)
        contentView.addSubview(indexLb)
        contentView.addSubview(optionLb)
        contentView.addSubview(optionImgV)
        
        tagImgV.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(25)
            make.height.width.equalTo(16)
        }
        
        indexLb.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgV.snp.right).offset(25)
            make.top.equalTo(23)
        }
        
        optionLb.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgV.snp.right).offset(25)
            make.top.equalTo(23)
            make.right.equalTo(-25)
            make.height.greaterThanOrEqualTo(50)
        }
        
        optionImgV.snp.makeConstraints { (make) in
            make.top.equalTo(optionLb.snp.bottom).offset(25)
            make.left.equalTo(indexLb.snp.right)
            make.height.equalTo(150)
            make.right.equalTo(-50)
            make.bottom.equalTo(0)
        }
    }
    
    func installData(indexString: String?, option: String?, optionPicture: String?) {
        indexLb.text = indexString
        indexLb.sizeToFit()
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.firstLineHeadIndent = indexLb.bounds.size.width + 5
        let attString = NSMutableAttributedString(string: option ?? "")
        attString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paraStyle, range: NSMakeRange(0, attString.length))

        optionLb.attributedText = attString
        if let urlString = optionPicture, let url = URL(string: urlString) {
            optionImgV.kf.setImage(with: url)
        }else {
            optionImgV.image = nil
        }
        
        if let option = option, option.count > 0, let optionPicture = optionPicture, optionPicture.count > 0 {
            
            optionLb.snp.remakeConstraints { (make) in
                make.top.equalTo(23)
                make.right.equalTo(-25)
                make.left.equalTo(tagImgV.snp.right).offset(25)
            }
            
            optionImgV.snp.remakeConstraints { (make) in
                make.top.equalTo(optionLb.snp.bottom).offset(25)
                make.left.equalTo(65)
                make.right.equalTo(-65)
                make.height.equalTo(250)
                make.bottom.equalTo(-25)
            }
        } else if let optionPicture = optionPicture, optionPicture.count > 0 {
            
            optionLb.snp.remakeConstraints { (make) in
                make.left.equalTo(tagImgV.snp.right).offset(25)
                make.top.equalTo(12)
                make.right.equalTo(-25)
                make.height.equalTo(0)
            }
            
            optionImgV.snp.remakeConstraints { (make) in
//                make.top.equalTo(optionLb.snp.bottom).offset(25)
                make.top.equalTo(12)
                make.left.equalTo(65)
                make.right.equalTo(-65)
                make.height.equalTo(150)
                make.bottom.equalTo(-25)
            }
        } else if let option = option, option.count > 0 {
            optionLb.snp.remakeConstraints { (make) in
                make.left.equalTo(tagImgV.snp.right).offset(25)
                make.top.equalTo(12)
                make.right.equalTo(-25)
                make.bottom.equalTo(-25)
            }
            
            optionImgV.snp.remakeConstraints { (make) in
                make.top.equalTo(optionLb.snp.bottom).offset(25)
                make.left.equalTo(65)
                make.right.equalTo(-65)
                make.height.equalTo(0)
            }
        }else {
            optionLb.snp.remakeConstraints { (make) in
                make.left.equalTo(tagImgV.snp.right).offset(25)
                make.top.equalTo(12)
                make.right.equalTo(-25)
                make.bottom.equalTo(tagImgV.snp.bottom).offset(25)
                make.bottom.equalTo(0)
            }
            
            optionImgV.snp.remakeConstraints { (make) in
                make.top.equalTo(optionLb.snp.bottom).offset(25)
                make.left.equalTo(65)
                make.right.equalTo(-65)
                make.height.equalTo(150)
                make.height.equalTo(0)
            }
        }
    }
    
}
