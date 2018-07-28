//
//  BXGDownloadingVC.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

class BXGDownloadingVC: UIViewController {

    var bEdit:Bool = false;
    var selectDict:Dictionary<String, BXGDownloadingCell>?; //存放所有被选中的
//    var viewModel:BXGDownloadingViewModel;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "下载管理"
        selectDict = Dictionary<String, BXGDownloadingCell>()//创建空的Set集合
        self.installUI();
    }
    
//    init(persistDataModels:[BXGDownloadPersistAPIModel]?) {
//        self.viewModel = BXGDownloadingViewModel(persistDataModels:persistDataModels);
//        super.init(nibName: nil, bundle: nil);
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    func loadData() {
        BXGDownloadManager.instance.resetDownloadingModel()
//        BXGDownloadManager.instance.resetDownloadedCourseInfoModel()
        self.downloadTableView.reloadData()
    }
    
    
    lazy var downloadTableView:UITableView = {
        let tableView : UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.hexColor(hex: 0xFFFFFF)
        tableView.separatorColor = UIColor.hexColor(hex: 0xF5F5F5)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 44

        //分割线
        tableView.separatorStyle = .singleLine;
        
        tableView.register(BXGDownloadingCell.self, forCellReuseIdentifier: BXGDownloadingCell.description())
        return tableView;
    }()
    
    lazy var downloadNonEditBottomView:BXGDownloadingBottomView = {
        var bottomView:BXGDownloadingBottomView = BXGDownloadingBottomView.init(frame: CGRect.zero, bEdit: false)
        bottomView.nonEditDelegate = self;
        bottomView.backgroundColor = UIColor.hexColor(hex: 0xFFFFFF)
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOffset = CGSize(width: 10, height: -8)
        bottomView.layer.shadowOpacity = 0.04
        return bottomView;
    }()
    
    lazy var downloadEditBottomView:BXGDownloadingBottomView = {
        var bottomView:BXGDownloadingBottomView = BXGDownloadingBottomView.init(frame: CGRect.zero, bEdit: true)
        bottomView.editDelegate = self;
        bottomView.backgroundColor = UIColor.hexColor(hex: 0xFFFFFF)
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOffset = CGSize(width: 10, height: -8)
        bottomView.layer.shadowOpacity = 0.04
        return bottomView;
    }()
    
    func installUI() {
        self.view.addSubview(self.downloadTableView)
        self.downloadTableView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.bottom.equalTo(-49)
        }
        
        self.view.addSubview(self.downloadNonEditBottomView)
        self.view.addSubview(self.downloadEditBottomView)
        self.downloadNonEditBottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(49);
        }
        self.downloadEditBottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(49);
        }

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightBarButton)
        self.adjustBottomViewShow();
    }
    
    lazy var rightBarButton : UIButton = {
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.setTitle("编辑", for: UIControlState.normal)
        btn.setTitleColor(UIColor.hexColor(hex: 0x34495E), for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.pingFangSCMedium(withSize: 15)
        btn.addTarget(self, action: #selector(BXGDownloadingVC.onClickRightEditBtn), for: UIControlEvents.touchUpInside)
        return btn;
    }()
    
    @objc func onClickRightEditBtn() {
        self.bEdit = !self.bEdit
        self.adjustBottomViewShow()
        self.downloadTableView.reloadData();
        NSLog("onClickRightEditBtn")
    }
    
    func adjustBottomViewShow() {
        if(self.bEdit) {
            self.rightBarButton.setTitle("取消", for: UIControlState.normal);
            self.downloadNonEditBottomView.isHidden = true
            self.downloadEditBottomView.isHidden = false
            self.selectDict?.removeAll();
            self.downloadTableView.reloadData();
        } else {
            self.rightBarButton.setTitle("编辑", for: UIControlState.normal);
            self.downloadNonEditBottomView.isHidden = false
            self.downloadEditBottomView.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSelImageByEditMode(cell:BXGDownloadingCell) {
        if(bEdit) {
            if let dataModel = cell.dataModel,
                let iden = dataModel.apiDownloaderItem.generateCustomId() {
                if (selectDict?.keys.contains(iden))! {
                    cell.bSel = true;
                } else {
                    cell.bSel = false;
                }
            }
        }
    }
}

extension BXGDownloadingVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(bEdit) {
            let  cell:BXGDownloadingCell = tableView.cellForRow(at: indexPath) as! BXGDownloadingCell;
            if let iden = cell.dataModel?.apiDownloaderItem.generateCustomId() {
                if (selectDict?.keys.contains(iden))! {
                    selectDict?.removeValue(forKey: iden)
                    cell.bSel = false;
                } else {
                    selectDict?.updateValue(cell, forKey: iden)
                    cell.bSel = true
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
            BXGDownloadManager.instance.registerObserver(observer: cell as! BXGDownloadingCell)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            BXGDownloadManager.instance.unregisterObserver(observer: cell as! BXGDownloadingCell)
    }
}

extension BXGDownloadingVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let models = BXGDownloadManager.instance.getDownloadingModel();
        if let models=models {
            return models.count;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        func downloadSpeedString(bytes:float_t) -> String {
            var strBytes:String = String("");
            if(bytes>1024*1024*1024)
            {
                //GByte
                strBytes.removeAll();
                strBytes = strBytes.appendingFormat("%.1fGB/s", bytes/1024.0/1024.0/1024);
            }
            else if(bytes>1024*1024)
            {
                //MBytes
                strBytes = strBytes.appendingFormat("%.1fMB/s", bytes/1024.0/1024.0);
            }
            else if(bytes>1024)
            {
                //KBytes
                strBytes = strBytes.appendingFormat("%.1fKB/s", bytes/1024.0);
            }
            else
            {
                strBytes = strBytes.appendingFormat("%.1fB/s", bytes*1.0);
            }
            return strBytes;
        }
        
        let  cell:BXGDownloadingCell = tableView.dequeueReusableCell(withIdentifier: BXGDownloadingCell.description(), for: indexPath) as! BXGDownloadingCell
        
        cell.updateContraintForEditMode(bEdit: self.bEdit)
        if let models = BXGDownloadManager.instance.getDownloadingModel() {
            
            if indexPath.row<models.count {
                let cellModel:BXGDownloadPersistAPIModel = models[indexPath.row]
                cell.delegate = self;
                cell.dataModel = cellModel
                cell.pointNameLabel.text = cellModel.apiDownloaderItem.pointName
                cell.downloadProgressView.progress = cellModel.progress;
                cell.downloadSpeedLabel.text = downloadSpeedString(bytes:cellModel.speed);
                cell.downloadStaus = cellModel.downloadState;

                self.setSelImageByEditMode(cell: cell);
            }
        }
        
        return cell
    }
}

extension BXGDownloadingVC : BXGDownloadingNonEditDelegate {
    func onDownloadingAllStart() -> Void {
        print("BXGDownloadingVC::onDownloadingAllStart")
        //切换显示状态
        if let models = BXGDownloadManager.instance.getDownloadingModel() {
            var i:Int = 0
            while(i < models.count) {
                let indexPath:IndexPath = IndexPath(row: i, section: 0);
                let cell:BXGDownloadingCell? = self.downloadTableView.cellForRow(at: indexPath) as? BXGDownloadingCell
                if (cell != nil) {
                    cell?.downloadStaus = .readying;
                }
                i+=1
            }
        }
        
        BXGDownloadManager.instance.allStartUndownloadedItems()
    }
    
    func onDownloadingAllPause() -> Void {
        print("BXGDownloadingVC::onDownloadingAllPause")
        //切换显示状态
        if let models = BXGDownloadManager.instance.getDownloadingModel() {
            var i:Int = 0
            while(i < models.count) {
                let indexPath:IndexPath = IndexPath(row: i, section: 0);
                let cell:BXGDownloadingCell? = self.downloadTableView.cellForRow(at: indexPath) as? BXGDownloadingCell
                if (cell != nil) {
                    cell?.downloadStaus = .suspended;
                }
                i+=1
            }
        }

        BXGDownloadManager.instance.allPauseDownload()
    }
}

extension BXGDownloadingVC : BXGDownloadingEditDelgate {
    func onSelectAll() -> Void {
        NSLog("BXGDownloadingVC::onSelectAll")
        
        if let items:[BXGDownloadPersistAPIModel] = BXGDownloadManager.instance.getDownloadingModel() {
            var i:Int = 0
            for item in items {
                let indexPath:IndexPath = IndexPath(row: i, section: 0)
                let cell:BXGDownloadingCell? = self.downloadTableView.cellForRow(at: indexPath) as? BXGDownloadingCell
                if let cell=cell {
                    selectDict?.updateValue(cell, forKey: item.apiDownloaderItem.generateCustomId()!)
                    cell.bSel = true;
                }
                i+=1
            }
        }
        
    }
    
    func onConfirmDelete() -> Void {
        NSLog("BXGDownloadingVC::onConfirmDelete")
        if let dict = self.selectDict {
            for keyItem in dict.keys {
                let cell:BXGDownloadingCell = dict[keyItem]!
                BXGDownloadManager.instance.cancelPersisitDownloadItem(apiPersistDownloadItem: cell.dataModel!)
            }
        }
        //状态重置
        selectDict?.removeAll();
        
        self.loadData();
    }
}

extension BXGDownloadingVC : BXGDownloadingCellDelegate {
    func onDownloadComplete() {
        self.loadData();
    }
    
    func onSelectOptionItem(bSelected:Bool, cellItem:BXGDownloadingCell) -> Void { //bSelected:Bool, cellItem: BXGDownloadingCell
        NSLog("onSelectOptionItem")
        if(bSelected) {
            selectDict?.updateValue(cellItem, forKey: (cellItem.dataModel?.apiDownloaderItem.generateCustomId())!)
        } else {
            selectDict?.removeValue(forKey: (cellItem.dataModel?.apiDownloaderItem.generateCustomId())!)
        }
    }
}

//extension BXGDownloadingVC : BXGDow

