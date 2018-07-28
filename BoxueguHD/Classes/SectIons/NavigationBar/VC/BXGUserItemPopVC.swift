//
//  BXGUserItemPopVC.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/26.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGUserItemPopCell: UITableViewCell {
    
    // MARK: INIT
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SETTER
    
    func setTitleName(_ title: String) {
        cellTitleLb.text = title
    }
    
    // MARK: UI
    
    lazy var cellTitleLb: UILabel = {
        let view = UILabel()
        view.font = UIFont.pingFangSCRegular(withSize: 15)
        view.textColor = UIColor.hexColor(hex: 0x34495E)
        return view
    }()
    
    func installUI() {
        addSubview(cellTitleLb)
        cellTitleLb.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}


enum BXGUserItemPopCellType {
    case feedback
    case setting
    case signOut
    
    var title: String {
        switch self {

        case .feedback:
            return "反馈"
        case .setting:
            return "设置"
        case .signOut:
            return "退出"
        }
    }
}

class BXGUserItemPopVC: UIViewController {
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instalUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: MODEL
    
    
    let dataSource = [BXGUserItemPopCellType.feedback, BXGUserItemPopCellType.setting, BXGUserItemPopCellType.signOut]
    
    // MARK: UI
    
    func instalUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.bottom.top.right.equalToSuperview()
        }
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self
        view.dataSource = self
        view.register(BXGUserItemPopCell.self, forCellReuseIdentifier: BXGUserItemPopCell.description())
        view.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
        view.separatorColor = UIColor.hexColor(hex: 0xDCE3E8)
        view.rowHeight = 44
        view.isScrollEnabled = false
        return view
    }()
    
    // MARK: FUNCTION
    
    var clickSettingClosure: (()->())?
    var clickSignOutClosure: (()->())?
    var clickFeedbackClosure: (()->())?
    
    
    func clickSetting(){
        if let closure = clickSettingClosure {
            closure()
        }
    }
    
    func clickFeedback(){
        if let closure = clickFeedbackClosure {
            closure()
        }
    }
    
    func clickSignOut(){
        if let closure = clickSignOutClosure {
            closure()
        }
    }
    
}

extension BXGUserItemPopVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BXGUserItemPopCell.description(), for: indexPath)
        if let cell = cell as? BXGUserItemPopCell, dataSource.count > indexPath.row {
            let type = dataSource[indexPath.row]
            cell.setTitleName(type.title)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if dataSource.count > indexPath.row {
            let type = dataSource[indexPath.row]
            switch type {
                
            case .feedback:
                clickFeedback()
            case .setting:
                clickSetting()
            case .signOut:
                clickSignOut()
            }
        }
    
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true) {
            
        }
    }
    
    
}
