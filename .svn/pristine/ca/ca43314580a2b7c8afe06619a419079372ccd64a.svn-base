//
//  BXGUserSettingPopVC.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/26.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGUserSettingPopImageCacheCell: UITableViewCell {
    
    lazy var cellTitleLb: UILabel = {
        let view = UILabel()
        view.font = UIFont.pingFangSCRegular(withSize: 15)
        view.textColor = UIColor.hexColor(hex: 0x34495e)
        view.text = "清除缓存图片"
        return view
    }()
    
    lazy var cacheSizeLb: UILabel = {
        let view = UILabel()
        view.font = UIFont.pingFangSCRegular(withSize: 12)
        view.textColor = UIColor.hexColor(hex: 0xB1BEC8)

        return view
    }()
    
    lazy var arrowImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "user_setting_right_arrow"))
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        installUI()
    }
    
    // mb
    func setImageCacheSize(size: Float) {
        cacheSizeLb.text = String.init(format: "%0.2fM", size)
    }
    
    func installUI() {
        contentView.addSubview(cellTitleLb)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(cacheSizeLb)

        cellTitleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(10)
        }
        arrowImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25)
            make.centerY.equalTo(cellTitleLb)
            make.left.equalTo(cacheSizeLb.snp.right).offset(5)
        }
        cacheSizeLb.snp.makeConstraints { (make) in
            make.centerY.equalTo(cellTitleLb)
            make.left.equalTo(cellTitleLb.snp.right).offset(5)
        }
        cacheSizeLb.setContentCompressionResistancePriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
        cacheSizeLb.setContentHuggingPriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
        arrowImageView.setContentCompressionResistancePriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
        arrowImageView.setContentHuggingPriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BXGUserSettingPopVersionCell: UITableViewCell {
    
    lazy var cellTitleLb: UILabel = {
        let view = UILabel()
        view.font = UIFont.pingFangSCRegular(withSize: 15)
        view.textColor = UIColor.hexColor(hex: 0x34495e)
        view.text = "版本信息"
        return view
    }()
    
    lazy var versionLb: UILabel = {
        let view = UILabel()
        view.font = UIFont.pingFangSCRegular(withSize: 12)
        view.textColor = UIColor.hexColor(hex: 0xB1BEC8)
        
        return view
    }()
    
    func installUI() {
        contentView.addSubview(cellTitleLb)
        contentView.addSubview(versionLb)
        cellTitleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(10)
        }
        versionLb.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25)
            make.centerY.equalTo(cellTitleLb)
            make.left.equalTo(cellTitleLb.snp.right)
        }
        versionLb.setContentCompressionResistancePriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
        versionLb.setContentHuggingPriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCurrentVersion(version: String) {
        versionLb.text = "v\(version)"
    }
}

enum BXGUserSettingPopDataSourceType {
    case imageCahce
    case version
}

class BXGUserSettingPopVC: UIViewController {

    // 获取 sd web img cache
    
    // 执行清理
    
    // version
    
    
    // mb
    lazy var bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    lazy var closeBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "user_setting_close").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: UIControlState.normal)
        view.addTarget(self, action: #selector(clickCloseBtn), for: UIControlEvents.touchDown)
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bubbleView.layer.cornerRadius = 11
        bubbleView.layer.masksToBounds = true
    }
    
    func loadCacheSize(finished: @escaping (_ size: Float)->()) {
        SDImageCache.shared().calculateSize { (fileCount, totalSize) in
            finished(Float(totalSize) / (1024 * 1024))
        }
    }
    
    func appShortVersion() -> String {
        if let infoDict = Bundle.main.infoDictionary {
            if let version = infoDict["CFBundleShortVersionString"] as? String {
                return version
            }
        }
        return ""
    }
    
    func clearImageCache(finished: @escaping ()->()) {
        SDImageCache.shared().clearDisk {
            finished()
        }
    }

    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.register(BXGUserSettingPopVersionCell.self, forCellReuseIdentifier: BXGUserSettingPopVersionCell.description())
        view.register(BXGUserSettingPopImageCacheCell.self, forCellReuseIdentifier: BXGUserSettingPopImageCacheCell.description())
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 40
        view.separatorColor = UIColor.hexColor(hex: 0xf5f5f5)
        view.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        view.isScrollEnabled = false
        return view
    }()
    
    let dataSource: [BXGUserSettingPopDataSourceType] = [.imageCahce, .version]
    
    lazy var topTitleLb: UILabel = {
        let view = UILabel()
        view.font = UIFont.pingFangSCRegular(withSize: 18)
        view.text = "设置"
        view.textColor = UIColor.black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installUI()
    }
    
    func installUI() {
        self.view.backgroundColor = UIColor.clear
        bubbleView.addSubview(topTitleLb)
        bubbleView.addSubview(tableView)
        
        view.addSubview(bubbleView)
        view.addSubview(closeBtn)
        
        topTitleLb.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(18)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topTitleLb.snp.bottom).offset(25)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(18)
        }
        closeBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(bubbleView.snp.right)
            make.centerY.equalTo(bubbleView.snp.top)
            make.width.height.equalTo(28)
        }
        
        bubbleView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-25)
            make.top.equalToSuperview().offset(25)
        }
        
    }
    @objc func clickCloseBtn() {
        dismiss(animated: true, completion: nil)
    }
}

extension BXGUserSettingPopVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BXGUserSettingPopImageCacheCell.description(), for: indexPath)
        
        if dataSource.count > indexPath.row {
            switch dataSource[indexPath.row] {
                
            case .imageCahce:
                let cell = tableView.dequeueReusableCell(withIdentifier: BXGUserSettingPopImageCacheCell.description(), for: indexPath)
                if let cell = cell as? BXGUserSettingPopImageCacheCell {
                    loadCacheSize { (size) in
                        cell.setImageCacheSize(size: size)
                    }
                }
                return cell
            case .version:
                let cell = tableView.dequeueReusableCell(withIdentifier: BXGUserSettingPopVersionCell.description(), for: indexPath)
                if let cell = cell as? BXGUserSettingPopVersionCell {
                    cell.setCurrentVersion(version: appShortVersion())
                }
                return cell
            }

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if dataSource.count > indexPath.row {
            switch dataSource[indexPath.row] {
                
            case .imageCahce:
                BXGHUDTool.showLoadingHUD(string: "正在清理")
                clearImageCache {
                    BXGHUDTool.closeHUD()
                    BXGHUDTool.showHUD(string: "清理成功")
                }
                tableView.reloadData()
            case .version:break;
                
            }
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
