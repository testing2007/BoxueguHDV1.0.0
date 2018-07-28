//
//  BXGCourseOutlineVideoCell.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/19.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGCourseOutlineVideoCell: UITableViewCell {
    
    var ccVideoId:String?
    
    lazy var cellIconImgV: UIImageView = {
        
        let item = UIImageView(image: #imageLiteral(resourceName: "course_outline_state_none"))
        return item
    }()
    
    lazy var cellTitleLb: UILabel = {
        let item = UILabel()
        item.font = UIFont.pingFangSCRegular(withSize: 15)
        item.textColor = UIColor.hexColor(hex: 0x34495E)
        return item
    }()
    
    lazy var downloadStateLb: UILabel = {
        
        //        font-family: PingFangSC-Regular;
        //        font-size: 24px;
        //        color: #34495E;
        //        line-height: 30px;
        
        let item = UILabel()
        item.font = UIFont.pingFangSCRegular(withSize: 12)
        item.textColor = UIColor.hexColor(hex: 0x34495E)
//        item.text = "已下载"
        item.text = ""
        return item
    }()
    
    public func installData(pointModel: BXGCourseOutlinePointModel, title: String, isPlaying: Bool) {
        
        
        if isPlaying {
            cellIconImgV.image = #imageLiteral(resourceName: "course_outline_state_playing")
            cellTitleLb.textColor = UIColor.themeColor
        }else {
            
            cellIconImgV.image = #imageLiteral(resourceName: "course_outline_state_none")
            cellTitleLb.textColor = UIColor.hexColor(hex: 0x34495E)
            if let status = pointModel.studyStatus {
                if(status == 1) {
                    cellIconImgV.image = #imageLiteral(resourceName: "course_outline_state_ing")
                }else if (status == 2) {
                    cellIconImgV.image = #imageLiteral(resourceName: "course_outline_state_done")
                    cellTitleLb.textColor = UIColor.hexColor(hex: 0xABB8C2)
                }
            }
            
        }
        cellTitleLb.text = title
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installUI() {
        self.backgroundColor = UIColor.white
        addSubview(cellIconImgV)
        addSubview(cellTitleLb)
        addSubview(downloadStateLb)
        
        cellIconImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
        }
        cellTitleLb.snp.makeConstraints { (make) in
            make.left.equalTo(cellIconImgV.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        downloadStateLb.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25)
            make.left.equalTo(cellTitleLb.snp.right)
            make.centerY.equalToSuperview()
        }
        cellIconImgV.setContentHuggingPriority(.required, for: UILayoutConstraintAxis.horizontal)
        cellIconImgV.setContentCompressionResistancePriority(.required, for: .horizontal)
        downloadStateLb.setContentHuggingPriority(.required, for: UILayoutConstraintAxis.horizontal)
        downloadStateLb.setContentCompressionResistancePriority(.required, for: .horizontal)
        
    }
}

extension BXGCourseOutlineVideoCell : BXGDownloadAPIDelegate {
    func downloadProgress(forAPIPersisitDownloadItem apiPersistDownloadItem: BXGDownloadPersistAPIModel!) {
        if(self.ccVideoId?.compare(apiPersistDownloadItem.apiDownloaderItem.ccVideoId!) == ComparisonResult.orderedSame) {
            if(apiPersistDownloadItem.downloadState != .completed) {
                self.downloadStateLb.text = String(format: "%3.0f%%", apiPersistDownloadItem.progress*100)
            } else {
                self.downloadStateLb.text = "已下载"
            }
        }
    }
    
    func downloadState(forAPIPersistDownloadItem apiPersistDownloadItem: BXGDownloadPersistAPIModel!, andError error: Error!) {
        NSLog("downloadState");
    }
    
    func requestDownloadURLFail(forAPIPersistDownloadItem apiPersistDownloadItem: BXGDownloadPersistAPIModel!, andErrorReason errorReason: String!) {
        NSLog("downloadfailure");
    }
}
