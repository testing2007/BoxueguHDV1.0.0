//
//  BXGDownloadedDetailVC.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 itheima. All rights reserved.
//

import UIKit

public protocol  BXGDownloadedDetailVCDelegate : AnyObject {
    func curDetailNoData()-> Void
}

class BXGDownloadedDetailVC: BXGBaseVC {

    var moduleName:String?
    var viewModel:BXGDownloadedDetailViewModel?
    weak var delegate:BXGDownloadedDetailVCDelegate?;
    
    func loadData(courseId: Int32, phaseId: Int32, moduleId: Int32, moduleName: String, bEdit:Bool) {
        self.viewModel = BXGDownloadedDetailViewModel.init(courseId: courseId,
                                                           phaseId: phaseId,
                                                           moduleId: moduleId,
                                                           moduleName: moduleName,
                                                           bEdit:bEdit)
        self.bEdit = bEdit;
        self.moduleName = moduleName
        self.titleLable.text = moduleName
        self.detailTableView.reloadData()
    }
    
    var bEdit:Bool = false {
        didSet {
            self.viewModel?.bEdit = bEdit;
            if(bEdit) {
                self.detailTableView.snp.updateConstraints { (make) in
                    make.bottom.equalTo(-49)
                }
            } else {
                self.detailTableView.snp.updateConstraints { (make) in
                    make.bottom.equalTo(0)
                }
            }
            self.detailTableView.reloadData()
        }
    }
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="split detail vc";
        // Do any additional setup after loading the view.
        self.installUI();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func installUI() -> Void {
        self.view.addSubview(self.titleLable)
        self.view.addSubview(self.detailTableView)
        self.view.addSubview(self.bottomView)
        
        self.titleLable.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.equalTo(25)
            make.right.lessThanOrEqualTo(-15)
            make.height.equalTo(64)
        }
        self.detailTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLable.snp.bottom).offset(0)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        self.bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(self.detailTableView.snp.bottom).offset(0)
            make.left.right.equalTo(0)
            make.height.equalTo(49)
        }
    }
    
    lazy var titleLable:UILabel = {
        let titleLable = UILabel()
        titleLable.textColor = UIColor.hexColor(hex: 0xA3B3BF)
        titleLable.font = UIFont.pingFangSCRegular(withSize: 15)
        return titleLable;
    }()
    
    lazy var detailTableView:UITableView = {
        let tableView:UITableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.hexColor(hex: 0xFFFFFF)
        tableView.separatorColor = UIColor.hexColor(hex: 0xF5F5F5)
        tableView.rowHeight = 44
        tableView.sectionHeaderHeight = 44
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine;
        tableView.register(BXGDownloadedDetailCell.self,
                           forCellReuseIdentifier: BXGDownloadedDetailCell.description())
        tableView.register(BXGDownloadedDetailHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: BXGDownloadedDetailHeaderView.description())
        return tableView;
    }()
    
    lazy var bottomView:BXGDownloadedDetailBottomView = {
        let bottomView:BXGDownloadedDetailBottomView = BXGDownloadedDetailBottomView();
        bottomView.delegate = self
        bottomView.backgroundColor = UIColor.white
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOffset = CGSize(width: 10, height: -8)
        bottomView.layer.shadowOpacity = 0.04
        bottomView.layer.cornerRadius = 4
        bottomView.layer.shadowRadius = 3
        return bottomView;
    }()
    
    @objc func onTest() {
        let vc:UIViewController = UIViewController()
        vc.view.backgroundColor = UIColor.green
        self.navigationController?.pushViewController(vc, animated: true);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BXGDownloadedDetailVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.pointCountInSectionIndex(sectionIndex: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BXGDownloadedDetailCell = tableView.dequeueReusableCell(withIdentifier: BXGDownloadedDetailCell.description(), for: indexPath) as! BXGDownloadedDetailCell
        cell.videoNameLabel.text = self.viewModel?.pointNameInSectionIndex(sectionIndex: indexPath.section, pointIndex: indexPath.row)
        cell.delegate = self
        cell.bEdit = self.viewModel?.bEdit ?? false;
        cell.bSel = self.viewModel?.isSelectedSectionIndex(sectionIndex: indexPath.section, pointIndex: indexPath.row) ?? false;
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel?.sectionCount() ?? 0
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:BXGDownloadedDetailHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: BXGDownloadedDetailHeaderView.description()) as! BXGDownloadedDetailHeaderView;
        if let sectionName = self.viewModel?.sectionName(sectionIndex: section) {
            headerView.sectionLabel.text =  sectionName
            headerView.delegate = self
            headerView.sectionId = section
            headerView.isOpen = self.viewModel?.isOpenHeadSection(sectionId: section) ?? false
        }
        return headerView;
    }
}

extension BXGDownloadedDetailVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:BXGDownloadedDetailCell? = tableView.cellForRow(at: indexPath) as? BXGDownloadedDetailCell
        
        if( self.viewModel?.isSelectedSectionIndex(sectionIndex: indexPath.section,
                                                   pointIndex: indexPath.row) ?? false ) {
            self.viewModel?.deselectSectionIndex(sectionIndex: indexPath.section,
                                                 pointIndex: indexPath.row)
            cell?.bSel = false
        } else {
            self.viewModel?.selectSectionIndex(sectionIndex: indexPath.section,
                                               pointIndex: indexPath.row)
            cell?.bSel = true
        }
    }
}

extension BXGDownloadedDetailVC : BXGDownloadedDetailBottomViewDelegate {
    func onSelectAll() {
//        let sections:Int = self.viewModel?.sectionCount() ?? 0
//
//        var sectionIndex:Int = 0
//        var points:Int = 0
//        var pointIndex:Int = 0
//
//        if let vm = self.viewModel {
//            while  sectionIndex < sections {
//                points = vm.pointCountInSectionIndex(sectionIndex: sectionIndex)
//                //pointCountInSectionIndex(sectionIndex: sectionIndex)
//                pointIndex=0
//                while pointIndex < points {
//                    vm.selectSectionIndex(sectionIndex: sectionIndex, pointIndex: pointIndex)
//                    pointIndex += 1
//                }
//                sectionIndex += 1
//            }
//        }
        self.viewModel?.selectAll()
        self.detailTableView.reloadData()
        //
        //        print("onSelectAll")
    }
    
    func onDeselectAll() {
        self.viewModel?.deselectAll()
        self.detailTableView.reloadData()
        print("onDeselectAll")
    }
    
    func onDelete() {
        self.viewModel?.removeSelected()
        if let vm = self.viewModel {
            if !vm.isHaveData() {
                //如果没有数据
                self.delegate?.curDetailNoData()
            }
        }
        print("onDelete")
        self.detailTableView.reloadData()
    }
}

extension BXGDownloadedDetailVC : BXGDownloadedDetailHeaderViewDelegate {
    func openSection(sectionId: Int) {
        print("openSection")
        self.viewModel?.addOpenHeadSectionId(sectionId: sectionId)
        self.detailTableView.reloadSections(IndexSet.init(integer: sectionId), with: UITableViewRowAnimation.automatic)
    }
    
    func closeSection(sectionId: Int) {
        print("closeSection")
        self.viewModel?.removeOpenHeadSectionId(sectionId: sectionId)
        self.detailTableView.reloadSections(IndexSet.init(integer: sectionId), with: UITableViewRowAnimation.automatic)
    }
}

extension BXGDownloadedDetailVC : BXGDownloadedDetailCellDelegate {
    func onSelectOptionItem(bSelected: Bool, cellItem: BXGDownloadedDetailCell) {
        print("onSelectOptionItem")
    }
}


////////////////
//extension BXGDownloadSelectVC : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell:BXGDownloadSelectCell = tableView.cellForRow(at: indexPath) as! BXGDownloadSelectCell;
//
//        if (self.viewModel.isSelItemCellInSection(cellId: cell.identifier!, sectionId: cell.sectionId!)) {
//            self.viewModel.removeSelItemCellInSection(cellId: cell.identifier!, sectionId: cell.sectionId!)
//            cell.bSel = false
//        } else {
//            self.viewModel.addSelItemCellInSection(cellId:cell.identifier!, sectionId:cell.sectionId!)
//            cell.bSel = true
//        }
//    }
//}
//
//extension BXGDownloadSelectVC : BXGDownloadSelectHeaderViewDelegate {
//    func openSection(sectionId:Int) -> Void {
//        self.viewModel.addOpenHeadSectionId(sectionId: sectionId)
//        self.tableView.reloadSections(IndexSet.init(integer: sectionId), with: UITableViewRowAnimation.automatic)
//    }
//
//    func closeSection(sectionId:Int) -> Void {
//        self.viewModel.removeOpenHeadSectionId(sectionId: sectionId)
//        self.tableView.reloadSections(IndexSet.init(integer: sectionId), with: UITableViewRowAnimation.automatic)
//    }
//}
//
//extension BXGDownloadSelectVC : BXGDownloadSelectCellDelegate {
//    func onSelectOptionItem(bSelected: Bool, cellItem: BXGDownloadSelectCell) {
//        if(bSelected) {
//            self.viewModel.addSelItemCellInSection(cellId: cellItem.identifier!, sectionId: cellItem.sectionId!)
//        } else {
//            self.viewModel.removeSelItemCellInSection(cellId: cellItem.identifier!, sectionId: cellItem.sectionId!)
//        }
//    }
//
//}
//
//extension BXGDownloadSelectVC : BXGDownloadSelectBottomViewDelegate {
//    func onConfirmDownload() -> Void {
//        NSLog("onConfirmDownload")
//        if(self.viewModel.selItemsDictInSection.count > 0) {
//            //            var allKeys:Dictionary<Int, Set<Int>>.Keys = self.viewModel.selItemsDictInSection.keys
//            //            for sectionId in allKeys {
//            //                var keyValues:Set<Int> = self.viewModel.selItemsDictInSection[sectionId]!
//            //                //                var sectionModel:BXGCourseOutlineSectionModel = self.viewModel.moduleModel.sectionItems![sectionId];
//            //                for pointId in keyValues {
//            //                    self.viewModel.moduleModel.sectionItems![sectionId].pointItems?.remove(at: pointId)
//            //                }
//            //                if((self.viewModel.moduleModel.sectionItems![sectionId].pointItems?.count)!<=0) {
//            //                    self.viewModel.moduleModel.sectionItems?.remove(at: sectionId)
//            //                }
//            //            }
//            let newCourseOutlineModuleModel:BXGCourseOutlineModuleModel = BXGCourseOutlineModuleModel();
//            newCourseOutlineModuleModel.moduleId = self.viewModel.moduleModel.moduleId;
//            newCourseOutlineModuleModel.nextType = self.viewModel.moduleModel.nextType;
//            newCourseOutlineModuleModel.nextModuleId = self.viewModel.moduleModel.nextModuleId;
//            newCourseOutlineModuleModel.phaseHomeworkId = self.viewModel.moduleModel.phaseHomeworkId;
//            newCourseOutlineModuleModel.phaseHomeworkStatus = self.viewModel.moduleModel.phaseHomeworkStatus;
//            newCourseOutlineModuleModel.phaseId = self.viewModel.moduleModel.phaseId;
//            newCourseOutlineModuleModel.moduleName = self.viewModel.moduleModel.moduleName;
//            newCourseOutlineModuleModel.sort = self.viewModel.moduleModel.sort;
//            newCourseOutlineModuleModel.phaseSort = self.viewModel.moduleModel.phaseSort;
//            newCourseOutlineModuleModel.mentId = self.viewModel.moduleModel.mentId;
//            newCourseOutlineModuleModel.mentName = self.viewModel.moduleModel.mentName;
//            newCourseOutlineModuleModel.duration = self.viewModel.moduleModel.duration;
//            newCourseOutlineModuleModel.sectionItems = Array<BXGCourseOutlineSectionModel>()
//
//            let allKeys:Dictionary<Int, Set<Int>>.Keys = self.viewModel.selItemsDictInSection.keys
//            for sectionId in allKeys {
//
//                let sectionModel:BXGCourseOutlineSectionModel = self.viewModel.moduleModel.sectionItems![sectionId];
//                let itemSection:BXGCourseOutlineSectionModel = BXGCourseOutlineSectionModel()
//                itemSection.sectionId = sectionModel.sectionId
//                itemSection.sectionName = sectionModel.sectionName
//                itemSection.parentId = sectionModel.parentId
//                itemSection.isPass = sectionModel.isPass
//                itemSection.sort = sectionModel.sort
//                itemSection.isSectionTest = sectionModel.isSectionTest
//                itemSection.isHomework = sectionModel.isHomework
//                itemSection.sectionTestStatus = sectionModel.sectionTestStatus
//                itemSection.pointItems = Array<BXGCourseOutlinePointModel>()
//
//                newCourseOutlineModuleModel.sectionItems?.append(itemSection)
//
//                let keyValues:Set<Int> = self.viewModel.selItemsDictInSection[sectionId]!
//                for pointId in keyValues {
//                    let pointModel:BXGCourseOutlinePointModel = sectionModel.pointItems![pointId]
//                    let itemPoint:BXGCourseOutlinePointModel = BXGCourseOutlinePointModel()
//                    itemPoint.pointId = pointModel.pointId;
//                    itemPoint.pointName = pointModel.pointName;
//                    itemPoint.parentId = pointModel.parentId;
//                    itemPoint.sort = pointModel.sort;
//                    itemPoint.videoId = pointModel.videoId
//                    itemPoint.ccVideoId = pointModel.ccVideoId;
//                    itemPoint.studyStatus = pointModel.studyStatus;
//                    itemPoint.videoH5Url = pointModel.videoH5Url;
//
//                    itemSection.pointItems?.append(itemPoint)
//                }
//            }
//
//            self.selectVCDelegate?.onConfirmDownload(model: newCourseOutlineModuleModel)
//
//        } else {
//            self.selectVCDelegate?.onConfirmDownload(model: nil)
//        }
//    }
//}
