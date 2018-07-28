//
//  BXGDownloadedDetailViewModel.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/24.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGDownloadedDetailSectionModel {
    var sectionName:String?;
    var arrPointModel:[BXGDownloadPersistAPIModel]?;
    
    init() {
        
    }
}

class BXGDownloadedDetailViewModel {
    var courseId:Int32;
    var phaseId:Int32;
    var moduleId:Int32;
    var moduleName:String;
//    var bEdit:Bool = false;//是否处于编辑模式, 默认为非编辑状态
    var openHeadSectionIdSet:Set<Int>;//所有打开Section的头
    
    var arrSectionModel:[BXGDownloadedDetailSectionModel]? //展示的数据模型
    var dictSelModel:[String/*key=sectionIndex_pointIndex*/:BXGDownloadPersistAPIModel] //选中的模型

    init(courseId: Int32, phaseId: Int32, moduleId: Int32, moduleName: String, bEdit:Bool) {
        self.courseId = courseId
        self.phaseId = phaseId
        self.moduleId = moduleId
        self.moduleName = moduleName
        self.dictSelModel = [String:BXGDownloadPersistAPIModel]()
        self.bEdit = bEdit;
        self.openHeadSectionIdSet = Set<Int>()
        self.loadData()
    }
    
    var bEdit:Bool = false {
        didSet {
            self.deselectAll()
        }
    }

    func loadData() -> Void {
        func filteModel(arrDetailModel:[BXGDownloadPersistAPIModel]?) -> [BXGDownloadedDetailSectionModel]? {
            if arrDetailModel == nil {
                self.arrSectionModel = nil;
                return nil;
            }
            var retDownloadedCourseInfo:[BXGDownloadedDetailSectionModel] = [BXGDownloadedDetailSectionModel]()
            var preId:Int32 = -1;
            
            var model:BXGDownloadedDetailSectionModel?;
            if let detailModel = arrDetailModel {
                for dataloadedItem in detailModel {
                    
                    if(preId == -1 || preId != dataloadedItem.apiDownloaderItem.sectionId) {
                        let temp:BXGDownloadedDetailSectionModel = BXGDownloadedDetailSectionModel()
                        temp.sectionName = dataloadedItem.apiDownloaderItem.sectionName;
                        temp.arrPointModel = Array<BXGDownloadPersistAPIModel>()
                        temp.arrPointModel?.append(dataloadedItem)
                        preId = dataloadedItem.apiDownloaderItem.sectionId;
                        
                        model = temp
                        retDownloadedCourseInfo.append(model!);
                    } else {
                        let tempCM = model!;
                        tempCM.arrPointModel?.append(dataloadedItem);
                    }
                }
            }
            
            return (retDownloadedCourseInfo.count>0) ? retDownloadedCourseInfo : nil;
        }

        //查询数据库
        BXGDownloadManager.instance.resetDownloadedCourseDetailModels()
        let arrDetailModel:[BXGDownloadPersistAPIModel]? = BXGDownloadManager.instance.getDownloadedCourseDetailModelsByCourseId(courseId: courseId,
                                                                                                                                 phaseId: phaseId,
                                                                                                                                 moduleId:moduleId)
        //真正需要的模型
        self.arrSectionModel = filteModel(arrDetailModel: arrDetailModel)
    }
    
    func reset() {
        self.loadData()
    }
    
    func sectionCount() -> Int {
        return self.arrSectionModel?.count ?? 0
    }
    
    func pointCountInSectionIndex(sectionIndex:Int) -> Int {
        if(self.isOpenHeadSection(sectionId: sectionIndex)) {
            return self.arrSectionModel?[sectionIndex].arrPointModel?.count ?? 0
        } else {
            return 0
        }
    }
    
    func sectionName(sectionIndex:Int) -> String {
        return self.arrSectionModel?[sectionIndex].sectionName ?? "";
    }
    
    func pointNameInSectionIndex(sectionIndex:Int, pointIndex:Int) -> String {
        return self.arrSectionModel?[sectionIndex].arrPointModel?[pointIndex].apiDownloaderItem.pointName ?? "";
    }
    
    func selectAll() -> Void {
        var sectionIndex:Int = 0
        var pointIndex:Int = 0
        if let sectionDatas = self.arrSectionModel {
            for sectionItem in sectionDatas {
                pointIndex = 0
                if let pointDatas = sectionItem.arrPointModel {
                    for _ in pointDatas {
                        self.selectSectionIndex(sectionIndex: sectionIndex, pointIndex: pointIndex)
                        pointIndex += 1
                    }
                }//end pointDatas
                sectionIndex += 1
            }
        }//end sectionDatas
        return
    }
    
    func deselectAll() -> Void {
        self.dictSelModel.removeAll()
    }
    
    func selectSectionIndex(sectionIndex:Int, pointIndex:Int) -> Void {
        var bSel:Bool = false;
        if let sectionModels=self.arrSectionModel, sectionModels.count>sectionIndex {
            if let sectionModel:BXGDownloadedDetailSectionModel = sectionModels[sectionIndex] {
                if let pointModels:[BXGDownloadPersistAPIModel] = sectionModel.arrPointModel, pointIndex<pointModels.count {
                    if let pointModel:BXGDownloadPersistAPIModel = pointModels[pointIndex] {
                        let key = self.selKey(sectionIndex: sectionIndex, pointIndex: pointIndex)
                        self.dictSelModel[key] = pointModel
                        bSel = true
                    }
                }
            }
        }
        if(!bSel) {
            print("fail to set value, sectionIndex=\(sectionIndex), pintIndex=\(pointIndex)")
        }
        
        //        pointModels
    }
    
    func deselectSectionIndex(sectionIndex:Int, pointIndex:Int) -> Void {
        let key = self.selKey(sectionIndex: sectionIndex, pointIndex: pointIndex)
        if (self.dictSelModel.keys.contains(key)) {
            self.dictSelModel[key] = nil
        }
    }
    
    func isSelectedSectionIndex(sectionIndex:Int, pointIndex:Int) -> Bool {
        let key = self.selKey(sectionIndex: sectionIndex, pointIndex: pointIndex)
        return self.dictSelModel.keys.contains(key)
    }
    
    func removeSelected() -> Void {
        var bDelete = false
        for selModel in self.dictSelModel.values {
            BXGDownloadManager.instance.deleteDownloadedItem(apiPersistDownloadItem: selModel)
            bDelete = true
        }
        self.dictSelModel.removeAll()
        if bDelete {
            self.reset()
        }
    }
    
    func isHaveData() -> Bool {
        return ( (self.arrSectionModel?.count ?? 0) > 0)
    }
    
    //select section
    func isOpenHeadSection(sectionId:Int) -> Bool {
        return openHeadSectionIdSet.contains(sectionId);
    }
    func addOpenHeadSectionId(sectionId:Int) -> Void {
        openHeadSectionIdSet.insert(sectionId);
    }
    func removeOpenHeadSectionId(sectionId:Int) -> Void {
        if(openHeadSectionIdSet.contains(sectionId)) {
            openHeadSectionIdSet.remove(sectionId);
        }
    }
    
    
    private func selKey(sectionIndex:Int, pointIndex:Int) -> String {
        return String(format: "%d_%d", sectionIndex, pointIndex)
    }
}
