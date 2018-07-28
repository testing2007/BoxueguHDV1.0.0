//
//  BXGDownloadedIndexVC.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 itheima. All rights reserved.
//

import UIKit

public protocol  BXGDownloadIndexVCDelegate : AnyObject {
    func changeIndexToDetail(courseId: Int32, phaseId: Int32, moduleId: Int32, moduleName: String) -> Void
}

class BXGDownloadedIndexVC: UIViewController {

//    weak open var menuDelegate: BXGDownloadIndexVCDelegate?

    weak var delegate:BXGDownloadIndexVCDelegate?
    
//    var courseSelIndex:Int = -1;
    var arrIndexData:[BXGDownloadPersistAPIModel]?
    
    func loadData(indexDatas:[BXGDownloadPersistAPIModel]?) -> Void {
        arrIndexData = indexDatas;
        if let _ = arrIndexData {
            courseSelIndex = 0
        } else {
            courseSelIndex = -1
        }
        self.indexTableView.reloadData();
    }
    
    var courseSelIndex:Int = -1 {
        didSet {
                if(courseSelIndex != -1 && courseSelIndex < arrIndexData?.count ?? 0) {
                    if let indexData = arrIndexData?[courseSelIndex].apiDownloaderItem {
                    delegate?.changeIndexToDetail(courseId: indexData.courseId,
                                                  phaseId: indexData.phaseId,
                                                  moduleId: indexData.moduleId,
                                                  moduleName: indexData.moduleName ?? "")
                    }
                }
        }
    }
    
    func indexOfData() -> BXGDownloadPersistAPIModel? {
        if let datas=arrIndexData {
            if(courseSelIndex>=0 && courseSelIndex<datas.count) {
                return datas[courseSelIndex];
            }
        }
        return nil;
    }
    
    lazy var indexTableView:UITableView = {
        let tableView:UITableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.hexColor(hex: 0xEBF0F3)
        tableView.rowHeight = 54
        tableView.separatorStyle = .none;
        tableView.register(BXGDownloadedIndexCell.self,
                           forCellReuseIdentifier: BXGDownloadedIndexCell.description())
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOffset = CGSize(width: 12, height: 10)
        tableView.layer.shadowOpacity = 0.04

        return tableView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.installUI()
    }
    
    func installUI() -> Void {
        self.view.addSubview(self.indexTableView);
        indexTableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BXGDownloadedIndexVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(courseSelIndex == indexPath.row) {
            return ;
        }
        self.courseSelIndex = indexPath.row;
    }
}

extension BXGDownloadedIndexVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrIndexData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BXGDownloadedIndexCell = tableView.dequeueReusableCell(withIdentifier: BXGDownloadedIndexCell.description(), for: indexPath) as! BXGDownloadedIndexCell;
        if let data = arrIndexData?[indexPath.row].apiDownloaderItem, (indexPath.row < arrIndexData?.count ?? 0) {
            cell.indexTitleLabel.text = data.moduleName ?? "";
            cell.courseId = data.courseId
            cell.phaseId = data.phaseId
            cell.moduleId = data.moduleId
            cell.moduleName = data.moduleName ?? ""
        }
        
        return cell
    }
}

//extension BXGDownloadedIndexVC : BXGDownloadedIndexCellDelegate {
//    func onIndex(courseId: Int32, phaseId: Int32, moduleId: Int32, moduleName: String) {
//        print("onIndex courseId:\(courseId) phaseId:\(phaseId) moduleId:\(moduleId) moduleName:\(moduleName)")
//    }
//}


