//
//  BXGVODPlayerSelectVideoTableView.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/20.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGVODPlayerSelectVideoCell: UITableViewCell {

    
    lazy var cellContentView: UIView = {
        let item = UIView()
        item.backgroundColor = UIColor.hexColor(hex: 0x0D0F12, alpha: 0.32)
        item.layer.cornerRadius = 3
        item.layer.masksToBounds = true
        
        
        return item
    }()
    
    lazy var cellIcone: UIImageView = {
        let item = UIImageView(image: #imageLiteral(resourceName: "course_outline_state_playing"))
        return item
    }()
    
    lazy var cellTitle: UILabel = {
        let item = UILabel()

        item.font = UIFont.pingFangSCRegular(withSize: 12)
        item.textColor = UIColor.hexColor(hex: 0xFFFFFF)
        
//        item.font = UIFont.pingFangSCRegular(withSize: 12)
//        item.textColor = UIColor.hexColor(hex: 0x466DE2)
        
        return item
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func installUI() {
        self.backgroundColor = UIColor.clear
        contentView.addSubview(cellContentView)
        cellContentView.addSubview(cellIcone)
        cellContentView.addSubview(cellTitle)
        cellContentView.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.top.equalTo(0)
            make.bottom.equalTo(-10)
        }
        cellIcone.setContentHuggingPriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
        cellIcone.setContentCompressionResistancePriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
        cellIcone.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        cellTitle.snp.makeConstraints { (make) in
            make.left.equalTo(cellIcone.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    func installData(title: String, isSelected: Bool) {
        cellTitle.text = title
        if isSelected {

            cellIcone.image = #imageLiteral(resourceName: "course_outline_state_playing")
            cellTitle.textColor = UIColor.hexColor(hex: 0x466DE2)

        }else {
            cellIcone.image = #imageLiteral(resourceName: "course_outline_state_playing_white")
            cellTitle.textColor = UIColor.hexColor(hex: 0xFFFFFF)
        }
    }
}

class BXGVODPlayerSelectVideoView: UIVisualEffectView {
    init() {
        super.init(effect: UIBlurEffect(style: UIBlurEffectStyle.extraLight))
        installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var selectVideoPopTableV: UITableView = {
        let item = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        item.delegate = self
        item.dataSource = self
        item.register(BXGVODPlayerSelectVideoCell.self, forCellReuseIdentifier: BXGVODPlayerSelectVideoCell.description())
        item.contentInset = UIEdgeInsetsMake(25, 0, 25, 0)
        item.separatorStyle = .none
        item.rowHeight = 49
        item.backgroundColor = UIColor.hexColor(hex: 0x0D0F12, alpha: 0.75)
        
//        item.backgroundColor = UIColor.clear
        return item
    }()
    func installUI() {
        
        contentView.addSubview(selectVideoPopTableV)
        selectVideoPopTableV.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    public func reloadData() {
        selectVideoPopTableV.reloadData()
    }
    
}

extension BXGVODPlayerSelectVideoView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BXGVODPlayerListManager.shared.videoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BXGVODPlayerSelectVideoCell.description(), for: indexPath)
        if let cell = cell as? BXGVODPlayerSelectVideoCell, let videoList = BXGVODPlayerListManager.shared.videoList {
            
            let videoModel = videoList[indexPath.row]
            let isPlaying = videoModel.resourceId == BXGVODPlayerManager.shared.currentVideoId
            
            cell.installData(title: videoModel.name, isSelected: isPlaying)

        }
        
        return cell
    }
}

extension BXGVODPlayerSelectVideoView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let videoList = BXGVODPlayerListManager.shared.videoList {
            let videoModel = videoList[indexPath.row]
            BXGVODPlayerListManager.shared.play(index: videoModel.tag)
        }
    }
}

