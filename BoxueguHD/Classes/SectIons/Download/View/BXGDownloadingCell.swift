//
//  BXGDownloadingCell.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/9.
//  Copyright © 2018年 itheima. All rights reserved.
//

import UIKit

protocol BXGDownloadingCellDelegate : AnyObject {
    func onSelectOptionItem(bSelected:Bool, cellItem:BXGDownloadingCell) -> Void;
    func onDownloadComplete() -> Void;
}

class BXGDownloadingCell: UITableViewCell {

    weak var delegate : BXGDownloadingCellDelegate?;
//    var model:BXGDownloadPersistAPIModel?;
    var dataModel:BXGDownloadPersistAPIModel?
//    var bSel:Bool = false;
    
    var bSel:Bool {
        didSet {
            if bSel {
                self.selImageView.image = UIImage.init(named: "download_select")
            } else {
                self.selImageView.image = UIImage.init(named: "download_unselect")
            }
        }
    }
    
//    var model:BXGDownloadPersistAPIModel? {
//        didSet {
//            if let m=model {
//                m.addObserver(self, forKeyPath: "progress", options: NSKeyValueObservingOptions.new, context: nil);
//            }
//        }
//    }
    
    var downloadStaus: BXGDownloadState {
        didSet {
////            BXGDownloadStateNone,        // 未下载 或 下载删除了
////            BXGDownloadStateReadying,    // 等待下载
////            BXGDownloadStateRunning,     // 正在下载
////            BXGDownloadStateSuspended,   // 下载暂停
////            BXGDownloadStateCompleted,   // 下载完成
////            BXGDownloadStateFailed       // 下载失败
            switch downloadStaus {
            case .none:
                self.downloadStatusBtn.setImage(UIImage(named: "download_pause"), for: UIControlState.normal)
                break;
            case .readying:
                self.downloadStatusBtn.setImage(UIImage(named: "download_waiting"), for: UIControlState.normal)
                break;
            case .running:
                self.downloadStatusBtn.setImage(UIImage(named: "download_downloading"), for: UIControlState.normal)
                break;
            case .suspended:
                self.downloadStatusBtn.setImage(UIImage(named: "download_pause"), for: UIControlState.normal)
                break;
            case .completed:
                //do nothing
                break;
            case .failed:
                self.downloadStatusBtn.setImage(UIImage(named: "download_failure"), for: UIControlState.normal)
                break;
            }
        }
    }
    @objc func onClickDownloadStatus() {
        NSLog("onClickDownloadStatus")
        switch self.downloadStaus {
        case .none:
            if(self.dataModel != nil) {
                BXGDownloadManager.instance.startUndownloadedItem(apiPersistDownloadItem:self.dataModel!);
                self.downloadStaus = .readying
            }
        case .readying:
            if(self.dataModel != nil) {
                BXGDownloadManager.instance.startUndownloadedItem(apiPersistDownloadItem:self.dataModel!);
                self.downloadStaus = .running
            }
        case .running:
            if(self.dataModel != nil) {
                BXGDownloadManager.instance.pausePersisitDownloadItem(apiPersistDownloadItem: self.dataModel!)
                self.downloadStaus = .suspended
            }
        case .suspended:
            if(self.dataModel != nil) {
                BXGDownloadManager.instance.resumePersisitDownloadItem(apiPersistDownloadItem: self.dataModel!)
                self.downloadStaus = .running
            }
        case .failed:
            if(self.dataModel != nil) {
                BXGDownloadManager.instance.resumePersisitDownloadItem(apiPersistDownloadItem: self.dataModel!)
                self.downloadStaus = .readying
            }
        case .completed:
            let _:Int=1; //do nothing, just only for compiling
        }
    }
    //    @objc func onClickDownloadStatus() {
    //        NSLog("onClickDownloadStatus")
    //        switch self.dataModel?.downloadState {
    //        case .some(.none):
    //            self.downloadStaus = .running;
    //            if(self.dataModel != nil) {
    //                self.dataModel?.downloadState = .running;
    //                BXGDownloadManager.instance.startUndownloadedItem(apiPersistDownloadItem:self.dataModel!);
    //            }
    //            break
    //        case .readying?:
    //            self.downloadStaus = .running;
    //            if(self.dataModel != nil) {
    //                self.dataModel?.downloadState = .running;
    //                BXGDownloadManager.instance.startUndownloadedItem(apiPersistDownloadItem:self.dataModel!);
    //            }
    //            break;
    //        case .running?:
    //            self.downloadStaus = .suspended
    //            if(self.dataModel != nil) {
    //                self.dataModel?.downloadState = .suspended;
    //                BXGDownloadManager.instance.pausePersisitDownloadItem(apiPersistDownloadItem: self.dataModel!)
    //            }
    //            break;
    //        case .failed?:
    //            self.downloadStaus = .running
    //            if(self.dataModel != nil) {
    //                self.dataModel?.downloadState = .running;
    //                BXGDownloadManager.instance.startUndownloadedItem(apiPersistDownloadItem: self.dataModel!)
    //            }
    //            break;
    //        case .completed?:
    //            //do nothing
    //            break;
    //        case .suspended?:
    //            self.downloadStaus = .running
    //            if(self.dataModel != nil) {
    //                self.dataModel?.downloadState = .running;
    //                BXGDownloadManager.instance.resumePersisitDownloadItem(apiPersistDownloadItem: self.dataModel!)
    //            }
    //            break;
    //        case .none:
    //            break;
    //        }
    //    }
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.bSel = false
        self.downloadStaus = .none
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installUI() {
        self.contentView.addSubview(self.selImageView)
        self.contentView.addSubview(self.pointNameLabel)
        self.contentView.addSubview(self.downloadProgressView)
        self.contentView.addSubview(self.downloadSpeedLabel)
        self.contentView.addSubview(self.downloadStatusBtn)
        
        self.selImageView.snp.makeConstraints { (make) in
            make.left.equalTo(25.5)
            make.centerY.equalTo(self)
            make.width.height.equalTo(0);
        }
        self.pointNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.selImageView.snp.right).offset(0)
            make.centerY.equalTo(self)
        }
        
        self.downloadStatusBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-25.5)
            make.centerY.equalTo(self)
            make.width.equalTo(21)
            make.height.equalTo(21)
        }
        
        self.downloadSpeedLabel.snp.makeConstraints { (make) in
            //make.right.equalTo(self.downloadStatusBtn.snp.left).offset(-15)
            make.right.equalTo(-63)
            make.centerY.equalTo(self)
            make.width.equalTo(50)
        }
        
        self.downloadProgressView.snp.makeConstraints { (make) in
            make.right.equalTo(self.downloadSpeedLabel.snp.left).offset(-14.5)
            make.centerY.equalTo(self)
            make.width.equalTo(300)
            make.height.equalTo(7);
        }
        
        self.downloadProgressView.setContentHuggingPriority(.required, for: UILayoutConstraintAxis.horizontal)
        self.downloadProgressView.setContentCompressionResistancePriority(.required, for: UILayoutConstraintAxis.horizontal)
    }
    
    func updateContraintForEditMode(bEdit:Bool) {
        if(bEdit) {
            self.selImageView.snp.updateConstraints { (make) in
                make.width.height.equalTo(18)
            }
            self.pointNameLabel.snp.updateConstraints { (make) in
                make.left.equalTo(self.selImageView.snp.right).offset(10)
            }
            
            self.downloadStatusBtn.isHidden = true;
            self.downloadSpeedLabel.snp.updateConstraints { (make) in
                make.right.equalTo(-25.5)
            }
        } else {
            self.selImageView.snp.updateConstraints { (make) in
                make.width.height.equalTo(0)
            }
            self.pointNameLabel.snp.updateConstraints { (make) in
               make.left.equalTo(self.selImageView.snp.right).offset(0)
            }
            
            self.downloadStatusBtn.isHidden = false;
            self.downloadSpeedLabel.snp.updateConstraints { (make) in
                make.right.equalTo(-63)
            }
        }
    }
    
    @objc func onTapImageView(sender:UITapGestureRecognizer) {
        delegate?.onSelectOptionItem(bSelected: !self.bSel, cellItem: self)
//        self.selectCell(bHighlighted: !self.bSel)
        self.bSel = !self.bSel;
    }
    
    lazy var selImageView:UIImageView = {
        let imageView:UIImageView = UIImageView()
        imageView.image = UIImage.init(named: "download_unselect")
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BXGDownloadingCell.onTapImageView(sender:)))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true;
        return imageView;
    }()
    
    lazy var pointNameLabel:UILabel = {
        let label:UILabel = UILabel()
        label.textColor = UIColor.hexColor(hex: 0x34495E)
        label.font = UIFont.pingFangSCRegular(withSize: 15)
        return label;
    }()
    
    lazy var downloadProgressView:UIProgressView = {
        let progressView:UIProgressView = UIProgressView()
        progressView.trackTintColor = UIColor.hexColor(hex: 0xE5EBEF)
        progressView.progressTintColor = UIColor.hexColor(hex: 0x375FD8)
        progressView.layer.cornerRadius = 4;
        progressView.layer.masksToBounds = true;
        return progressView;
    }()
    
    lazy var downloadSpeedLabel:UILabel = {
        let label:UILabel = UILabel()
        label.textColor = UIColor.hexColor(hex: 0x000000)
        label.font = UIFont.pingFangSCRegular(withSize: 12)
        label.textAlignment = .left;
        return label;
    }()
    
    private lazy var downloadStatusBtn : UIButton = {
        let btn:UIButton =  UIButton(type: UIButtonType.custom)
        btn.addTarget(self, action: #selector(BXGDownloadingCell.onClickDownloadStatus), for: UIControlEvents.touchUpInside)
        return btn;
    }()
}

extension BXGDownloadingCell : BXGDownloadAPIDelegate {
    func downloadProgress(forAPIPersisitDownloadItem apiPersistDownloadItem: BXGDownloadPersistAPIModel!) {
        print("BXGDownloadingCell::downloadProgress=%f", apiPersistDownloadItem.progress);
        let origValue:String = (self.dataModel?.apiDownloaderItem.generateCustomId())!
        let newValue:String = apiPersistDownloadItem.apiDownloaderItem.generateCustomId()!;
        if( origValue.compare(newValue) == ComparisonResult.orderedSame) {
            if(apiPersistDownloadItem.downloadState == .running) {
                self.downloadProgressView.progress = apiPersistDownloadItem.progress;
                self.downloadSpeedLabel.text = String(format:"%.1fKB/s", apiPersistDownloadItem.speed)
                self.downloadStaus = apiPersistDownloadItem.downloadState
            }
        }

    }
    
    func downloadState(forAPIPersistDownloadItem apiPersistDownloadItem: BXGDownloadPersistAPIModel!, andError error: Error!) {
        print("BXGDownloadingCell::downloadState")
        let origValue:String = (self.dataModel?.apiDownloaderItem.generateCustomId())!
        let newValue:String = apiPersistDownloadItem.apiDownloaderItem.generateCustomId()!;
        if( origValue.compare(newValue) == ComparisonResult.orderedSame) {
            if(apiPersistDownloadItem.downloadState == .completed) {
                self.downloadStaus = apiPersistDownloadItem.downloadState;
                self.delegate?.onDownloadComplete();
            }
        }
    }
    
    func requestDownloadURLFail(forAPIPersistDownloadItem apiPersistDownloadItem: BXGDownloadPersistAPIModel!, andErrorReason errorReason: String!) {
        let origValue:String = (self.dataModel?.apiDownloaderItem.generateCustomId())!
        let newValue:String = apiPersistDownloadItem.apiDownloaderItem.generateCustomId()!;
        if( origValue.compare(newValue) == ComparisonResult.orderedSame ) {
            print("BXGDownloadingCell::requestDownloadURLFail, the error reason=\(errorReason).")
            self.downloadStaus = .failed;
        }
    }
    
    
}
