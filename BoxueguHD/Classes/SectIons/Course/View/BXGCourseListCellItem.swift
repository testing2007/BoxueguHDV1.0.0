//
//  BXGCourseListView.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/12.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class BXGCourseListCellItem: UIView {
    
    public var model: BXGStudyCourseModel? {
        didSet {
            if let model = model {
                
                // TODO: 缺少place holder
                self.courseImageV.kf.setImage(with: URL(string: model.smallImgPath ?? ""))
                if(model.type == .employmentCourse) {
                    self.employmentTagLb.text = "  就业课  "
                }else {
                    self.employmentTagLb.text = ""
                }
                employmentTagLb.sizeToFit()
                let paraStyle = NSMutableParagraphStyle()
                paraStyle.firstLineHeadIndent = employmentTagLb.bounds.size.width + 5
                let attString = NSMutableAttributedString(string: model.courseName ?? "")
                attString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paraStyle, range: NSMakeRange(0, attString.length))
                courseTitleLb.attributedText = attString
                
                // 上次学习时间
                let str: String = model.stuLastStudyTime ?? "无"
                
                self.courseLastStudyTimeLb.text = "上次学习时间:\(str)"
                
                if(model.status == "-1" && model.terminateCause == "1") {
                    self.courseLastStudyTimeLb.text = "休学中"
                }
                
                
                let progressText = model.learningPercentPross ?? "0"
                self.courseProgressLb.text = "已学\(progressText)%"
    
                self.courseProgressBar.percent = (Double(progressText) ?? 0) / 100
                
                
//                model.stuLastStudyTime ?? ""
//                if(courseModel.status == "-1")
                
//                NSString *stuLastStudyTime = courseModel.stuLastStudyTime.length > 0 ? courseModel.stuLastStudyTime : @"无";
//                cell.view.subLabel.text = [NSString stringWithFormat:@"上次学习时间:%@",stuLastStudyTime];
//                [cell.view.imageView sd_setImageWithURL:[NSURL URLWithString:courseModel.smallImgPath] placeholderImage:[UIImage imageNamed:@"默认加载图"]];
//                if([courseModel.status isEqualToString:@"-1"] && [courseModel.terminateCause isEqualToString:@"1"]) {
//                    // 是否是休学中
//                    cell.view.stateLabel.text = [NSString stringWithFormat:@"%@",@"休学中"];
//                    cell.view.progressView.alpha = 0.5;
//                }else {
//                    cell.view.stateLabel.text = [NSString stringWithFormat:@"已学%@%%",courseModel.learningPercentPross];
//                    cell.view.progressView.alpha = 1;
//                }
                
                
                
                
                
                
                
//                self.courseLastStudyTimeLb.text
//                model.stuLastStudyTime
                
                
            }else {
                
            }
            
            
            
        }
    }
    
    class BXGCourseListCellProgressBar: UIView {
        
        var percent = 0.0 {
            didSet {
                
                if percent < 0 {
                    percent = 0
                }
                
                if percent > 1 {
                    percent = 1
                }
                
                updateFrame()
            }
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            updateFrame()
        }
        func updateFrame() {
            
            frontView.frame = CGRect(x: 0, y: 0, width: self.bounds.width * CGFloat(percent), height: self.bounds.height)
            
            frontView.layer.cornerRadius = frontView.bounds.height / 2
            bgView.layer.cornerRadius = frontView.bounds.height / 2
        }
        
        lazy var frontView: UIView = {
           let view = UIView()
            view.backgroundColor = UIColor.hexColor(hex: 0x466DE2)
            return view
        }()
        
        lazy var bgView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.hexColor(hex: 0xf5f5f5)
            return view
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            
            self.addSubview(bgView)
            self.addSubview(frontView)
            
            bgView.snp.makeConstraints { (make) in
                make.left.right.top.bottom.equalToSuperview()
            }
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    lazy var courseImageV: UIImageView = {
       let imgV = UIImageView()
        imgV.layer.cornerRadius = 3
        imgV.layer.borderColor = UIColor.hexColor(hex: 0xf5f5f5).cgColor
        imgV.layer.borderWidth = 1
        
        imgV.layer.shadowColor = UIColor.black.cgColor
        imgV.layer.shadowOffset = CGSize(width: 0, height: 0)
        imgV.layer.shadowOpacity = 0.04
        imgV.layer.shadowRadius = 3
        
        
        imgV.layer.masksToBounds = true
        
        
        
        

        return imgV
    }()
    
    lazy var courseContentV: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 4
//        view.layer.masksToBounds = true
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        
        return view
    }()

    lazy var employmentTagLb: UILabel = {
        let lb = UILabel()
        lb.text = ""
        
        lb.font = UIFont.pingFangSCRegular(withSize: 12)
        lb.textColor = UIColor.themeColor
        lb.backgroundColor = UIColor.hexColor(hex: 0xEDF2F8)
        
//        lb.backgroundColor = UIColor.randomColor()
        return lb
    }()
    
    lazy var courseTitleLb: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 2
        lb.font = UIFont.pingFangSCRegular(withSize: 15)
        lb.textColor = UIColor.hexColor(hex: 0x34495E)
//        lb.backgroundColor = UIColor.randomColor()
//        lb.text = "【Java】微服务架构技术基础（持续更新 "
        return lb
    }()
    
    lazy var courseLastStudyTimeLb: UILabel = {
        let lb = UILabel()
        lb.text = "上次学习时间：2018.6.14 12:00"
        lb.textColor = UIColor.hexColor(hex: 0x9AABB8)
        lb.font = UIFont.pingFangSCRegular(withSize: 12)
    
        return lb
    }()
    
    lazy var courseProgressBar: BXGCourseListCellProgressBar = {
        let view = BXGCourseListCellProgressBar()
        return view
    }()
    
    lazy var courseProgressLb: UILabel = {
        let lb = UILabel()
        lb.text = "已学99%"
        lb.textColor = UIColor.hexColor(hex: 0x9AABB8)
        lb.font = UIFont.pingFangSCRegular(withSize: 12)
        lb.textAlignment = .center
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.randomColor()
        
        self.addSubview(courseContentV)
        self.addSubview(courseImageV)
        self.addSubview(courseProgressBar)
        self.addSubview(courseTitleLb)
        self.addSubview(employmentTagLb)
        self.addSubview(courseLastStudyTimeLb)
        self.addSubview(courseProgressLb)
        
        courseContentV.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(30)
            make.bottom.equalTo(-15)
            make.right.equalTo(-15)
        }
        courseImageV.snp.makeConstraints { (make) in
            make.top.equalTo(courseContentV.snp.top).offset(-15)
            make.left.equalTo(courseContentV.snp.left).offset(15)
            make.bottom.equalTo(courseContentV.snp.bottom).offset(-30 - 7)
            make.width.equalTo(courseImageV.snp.height).multipliedBy(340 / 207.0)
        }
        
        courseProgressBar.snp.makeConstraints { (make) in
            make.left.equalTo(courseImageV.snp.left)
            make.bottom.equalTo(courseContentV.snp.bottom).offset(-15)
            make.height.equalTo(7)
            make.right.equalTo(courseContentV.snp.right).offset(-83)
        }
        
        courseTitleLb.snp.makeConstraints { (make) in
            make.left.equalTo(courseImageV.snp.right).offset(15)
            make.right.equalTo(courseContentV.snp.right).offset(-15)
            make.top.equalTo(courseContentV.snp.top).offset(10)
        }
        
        employmentTagLb.snp.makeConstraints { (make) in
            make.left.equalTo(courseImageV.snp.right).offset(15)
            make.right.lessThanOrEqualTo(courseContentV.snp.right).offset(-15)
            make.top.equalTo(courseContentV.snp.top).offset(12)
//            make.centerY.equalTo(courseTitleLb) 不能使用这个 会变成两行时候 位置会错乱
        }
        employmentTagLb.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        
        courseLastStudyTimeLb.snp.makeConstraints { (make) in
            make.left.equalTo(courseImageV.snp.right).offset(15)
            make.right.equalTo(courseContentV.snp.right).offset(-15)
            make.top.equalTo(courseTitleLb.snp.bottom).offset(7)
        }
        
        courseProgressLb.snp.makeConstraints { (make) in
            make.left.equalTo(courseProgressBar.snp.right).offset(5)
            make.right.equalTo(courseContentV.snp.right).offset(-5)
            make.centerY.equalTo(courseProgressBar)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        employmentTagLb.layer.cornerRadius = employmentTagLb.bounds.size.height / 2
        employmentTagLb.layer.masksToBounds = true
//        self.courseContentV.layer.cornerRadius = 3
//        self.courseContentV.layer.masksToBounds = true

    }
}

class BXGCourseListCell: UITableViewCell {
    
    public var view = BXGCourseListCellItem(frame: CGRect.zero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(view)
        self.view.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BXGCourseListCCell: UICollectionViewCell {
    
    public var view = BXGCourseListCellItem(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(view)
        self.view.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

