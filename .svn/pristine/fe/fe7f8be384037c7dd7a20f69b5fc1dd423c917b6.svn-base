//
//  BXGConstrueLiveCell.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/24.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGConstrueLiveCell2: UITableViewCell {
    
    // MARK: UI
    lazy var nameLabel: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var descLabel: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var onAirTag: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var studyBtn: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var teacherLabel: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var dateLabel: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var timeLabel: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var durantionLabel: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var recommandImgV: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var watchedTagView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var tagListView: UIView = {
        let view = UIView()
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(recommandImgV)
        contentView.addSubview(watchedTagView)
        contentView.addSubview(studyBtn)
        contentView.addSubview(onAirTag)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
        }
        
        recommandImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.equalToSuperview().offset(23)
            make.height.equalToSuperview().offset(15)
            make.centerY.equalTo(nameLabel)
        }
        
        watchedTagView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalTo(nameLabel)
        }
        
        studyBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.width.equalToSuperview().offset(47)
            make.height.equalToSuperview().offset(18)
            make.centerY.equalTo(nameLabel)
        }
        
        studyBtn.setContentCompressionResistancePriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)

        onAirTag.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(15)
            make.centerY.equalTo(nameLabel)
            make.right.lessThanOrEqualTo(studyBtn.snp.left).offset(-15)
            
        }
        
        nameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        nameLabel.setContentHuggingPriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
        
        onAirTag.setContentCompressionResistancePriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
        
    }
    
    func installModel() {
        
    }
}
