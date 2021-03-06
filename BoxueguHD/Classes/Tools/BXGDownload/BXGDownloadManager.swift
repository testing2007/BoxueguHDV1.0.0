//
//  BXGDownloadManager.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/19.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGDownloadedCourseModel {
    var courseId:Int32?
    var courseName:String?
    var courseImageURLPath:String?
    var fileNums:Int
    var fileSize:Double
    var fileInfo:Array<BXGDownloadPersistAPIModel>?
    
    init() {
        fileNums = 0
        fileSize = 0
    }
}

class BXGDownloadedCourseDetailModel {
    var moduleId:Int32?
    var moduleName:String?
    var arrPersistModel:Array<BXGDownloadPersistAPIModel>?
}

class BXGDownloadManager {
    static let instance = BXGDownloadManager()
    
    ///注册/反注册观察者
    func registerObserver(observer:BXGDownloadAPIDelegate) -> Void {
        BXGDownloadAPI.share().registerObserver(observer)
    }
    func unregisterObserver(observer:BXGDownloadAPIDelegate) -> Void {
        BXGDownloadAPI.share().unregisterObserver(observer)
    }
    
    //添加下载
    func addDownloadItem(courseOutlineModuleModel:BXGCourseOutlineModuleModel,
                         courseName:String,
                         courseType:Int,
                         courseImageUrl:String,
                         phaseName:String) -> Void {
//        return ;
        
        if let sectionItems = courseOutlineModuleModel.sectionItems {
            for sectionItem in sectionItems {
                if let pointItems = sectionItem.pointItems {
                    for pointItem in pointItems {
                        let downloadModel:BXGDownloadAPIModel = BXGDownloadAPIModel.init(courseId: (Int32(courseOutlineModuleModel.studentCourseId ?? 0)),
                                                                                         andCourseName: courseName,
                                                                                         andCourseType: Int32(courseType),
                                                                                         andCourseImageUrl: courseImageUrl,
                                                                                         andPhaseId: Int32(courseOutlineModuleModel.phaseId ?? 0),
                                                                                         andPhaseName: phaseName,
                                                                                         andPhaseSort: Int32(courseOutlineModuleModel.phaseSort ?? 0),
                                                                                         andModuleId: Int32(courseOutlineModuleModel.moduleId ?? 0),
                                                                                         andModuleName: courseOutlineModuleModel.moduleName ?? "",
                                                                                         andModuleSort: Int32(courseOutlineModuleModel.sort ?? 0),
                                                                                         andSectionId: Int32(sectionItem.sectionId ?? 0),
                                                                                         andSectionName:sectionItem.sectionName ?? "",
                                                                                         andSectionSort: Int32(sectionItem.sort ?? 0),
                                                                                         andSectionIsPass: Int32(sectionItem.isPass ?? 0),
                                                                                         andSectionIsTry: 0,
                                                                                         andPointId: Int32(pointItem.pointId ?? 0),
                                                                                         andPointName: pointItem.pointName ?? "",
                                                                                         andPointSort: Int32(pointItem.sort ?? 0),
                                                                                         andVideoId: Int32(pointItem.videoId ?? 0),
                                                                                         andCCVideoId: String(pointItem.ccVideoId ?? "0"),
                                                                                         andIsWatched: false)!
                        
                        if(!BXGDownloadTableManager.shareInstance().isExistDatabase(downloadModel)) {
                            BXGDownloadAPI.share().addDownloadItem(downloadModel)
                        } else {
                            let model:BXGDownloadPersistAPIModel? = BXGDownloadTableManager.shareInstance().searchDownloadItem(downloadModel);
                            if let model=model {
                                BXGDownloadAPI.share().startPersisitDownloadItem(model);
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }

    func start() {
        BXGDownloadAPI.share().start()
    }
    
   ///启动之前已添加到下载列表但是还没有下完的资源
    func allStartUndownloadedItems() {
        let allUndownloadedItems:[BXGDownloadPersistAPIModel]? = self.searchAllDownloadingCourseInfo()
        if let allItems=allUndownloadedItems {
            BXGDownloadAPI.share().allStartPersisitDownloadItems(allItems)
        }
    }
    
    func startUndownloadedItem(apiPersistDownloadItem:BXGDownloadPersistAPIModel) {
        BXGDownloadAPI.share().startPersisitDownloadItem(apiPersistDownloadItem)
    }
//    -(void)allStartPersisitDownloadItems:(NSArray<BXGDownloadPersistAPIModel*>*)apiPersistDownloadItems;
//    -(void)startPersisitDownloadItem:(BXGDownloadPersistAPIModel*)apiPersistDownloadItem;
//
    ///全部暂停
    func allPauseDownload() {
        BXGDownloadAPI.share().allPauseDownload()
    }
    ///暂停下载指定文件
    func pausePersisitDownloadItem(apiPersistDownloadItem:BXGDownloadPersistAPIModel) {
        BXGDownloadAPI.share().pausePersisitDownloadItem(apiPersistDownloadItem);
    }
    ///重新下载指定文件
    func resumePersisitDownloadItem(apiPersistDownloadItem:BXGDownloadPersistAPIModel) {
        BXGDownloadAPI.share().resumePersisitDownloadItem(apiPersistDownloadItem);
    }

    ///取消下载指定文件
    func cancelPersisitDownloadItem(apiPersistDownloadItem:BXGDownloadPersistAPIModel) {
        BXGDownloadAPI.share().cancelPersisitDownloadItem(apiPersistDownloadItem);
        BXGDownloadTableManager.shareInstance().deleteWaitingDownloadItem(apiPersistDownloadItem);
    }
    func cancelPersisitDownloadItems(apiPersistDownloadItems:[BXGDownloadPersistAPIModel]) {
        BXGDownloadAPI.share().cancelPersisitDownloadItems(apiPersistDownloadItems);
    }
    
    func deleteDownloadedItem(apiPersistDownloadItem:BXGDownloadPersistAPIModel) {
        BXGDownloadTableManager.shareInstance().deleteDownloadedItem(apiPersistDownloadItem);
    }
    
    func deleteDownloadedItems(apiPersistDownloadItems:[BXGDownloadPersistAPIModel]) {
        BXGDownloadTableManager.shareInstance().deleteDownloadedItems(apiPersistDownloadItems);
    }
    
    private var downloadingModels:[BXGDownloadPersistAPIModel]?;
    
    private var downloadedModels:[BXGDownloadedCourseModel]?;
    private var bGetDownloadingModel:Bool = false;
    private var bGetDownloadedModel:Bool = false;
    
    private var downloadedCourseIndexModels:[BXGDownloadPersistAPIModel]?;
    private var bGetDownloadedCourseIndexModel:Bool = false;
    private var downloadedCourseDetailModels:[BXGDownloadPersistAPIModel]?;
    private var bGetDownloadedCourseDetailModel:Bool = false;
}


extension BXGDownloadManager {
    func getDownloadingModel() -> [BXGDownloadPersistAPIModel]? {
        if(!bGetDownloadingModel) {
            downloadingModels =  BXGDownloadManager.instance.searchAllDownloadingCourseInfo();
            bGetDownloadingModel = true;
        }
        return downloadingModels;
    }
    
    func resetDownloadingModel() -> Void {
        bGetDownloadingModel = false;
        downloadingModels?.removeAll();
    }
    
    func getDownloadedModel() -> [BXGDownloadedCourseModel]? {
        if(!bGetDownloadedModel) {
            downloadedModels = BXGDownloadManager.instance.searchAllDownloadedCourseInfo();
            bGetDownloadedModel = true;
        }
        return downloadedModels;
    }
    
    func resetDownloadedModel() -> Void {
        bGetDownloadedModel = false
        downloadedModels?.removeAll()
    }
    
    func getDownloadedCourseIndexModelsByCourseId(courseId:Int32) -> [BXGDownloadPersistAPIModel]? {
        if(!bGetDownloadedCourseIndexModel) {
            if let models = BXGDownloadTableManager.shareInstance().searchDownloadedCourseIndex(byCourseId: courseId) {
                downloadedCourseIndexModels = models as? [BXGDownloadPersistAPIModel]
            }
            bGetDownloadedCourseIndexModel = true
        }
        return downloadedCourseIndexModels
    }
    
    func resetDownloadedCourseIndexModels() -> Void {
        bGetDownloadedCourseIndexModel = false
        downloadedCourseIndexModels?.removeAll()
    }
    
    func getDownloadedCourseDetailModelsByCourseId(courseId:Int32, phaseId:Int32, moduleId:Int32) -> [BXGDownloadPersistAPIModel]? {
        if(!bGetDownloadedCourseDetailModel) {
            if let models = BXGDownloadTableManager.shareInstance().searchDownloadedCourseDetail(byCourseId: courseId, andPhaseId: phaseId, andModuleId: moduleId) {
                downloadedCourseDetailModels = models as? [BXGDownloadPersistAPIModel]
            }
            bGetDownloadedCourseDetailModel = true
        }
        return downloadedCourseDetailModels
    }
    
    func resetDownloadedCourseDetailModels() -> Void {
        bGetDownloadedCourseDetailModel = false;
        downloadedCourseDetailModels?.removeAll()
    }
    
    func isExistDownloadingItem() -> Bool {
        return self.getDownloadingModel() != nil;
    }
    
//    func getDownloadedCourseDetailInfoModel(courseId:Int32)->[BXGDownloadedCourseDetailModel]? {
//        if(!bGetDownloadedCourseDetailModel) {
//            downloadedCourseDetailModels = BXGDownloadManager.instance.searchDownloadedCourseDetailByCourseId(courseId: courseId)
//            bGetDownloadedCourseDetailModel = true
//        }
//        return downloadedCourseDetailModels;
//    }
//
//    func resetDownloadedCourseDetailInfoModel() -> Void {
//        bGetDownloadedCourseDetailModel = false;
//    }

    ////////////////////
//    private func searchDownloadedCourseDetailByCourseId(courseId:Int32)-> [BXGDownloadPersistAPIModel]? {
    
//        var retDownloadedCourseDetailInfo:[BXGDownloadedCourseDetailModel] = Array<BXGDownloadedCourseDetailModel>()
//
//        let downloadedCourseDetailDataByOrderId:[BXGDownloadPersistAPIModel]? = BXGDownloadTableManager.shareInstance().searchDownloadedCourseDetail(byCourseId: courseId) as? [BXGDownloadPersistAPIModel]
//
//        var preModuleId:Int32 = -1;
//        var courseDetailModel:BXGDownloadedCourseDetailModel?;
//        if let dataloadedDatas = downloadedCourseDetailDataByOrderId {
//            for dataloadedItem in dataloadedDatas {
//
//                if(preModuleId == -1 || preModuleId != dataloadedItem.apiDownloaderItem.phaseId) {
//                    let tempCDM:BXGDownloadedCourseDetailModel = BXGDownloadedCourseDetailModel()
//                    tempCDM.moduleId = dataloadedItem.apiDownloaderItem.moduleId;
//                    tempCDM.moduleName = dataloadedItem.apiDownloaderItem.moduleName;
//                    tempCDM.arrPersistModel = Array<BXGDownloadPersistAPIModel>()
//
//                    preModuleId = tempCDM.moduleId!;
//                    courseDetailModel = tempCDM
//
//                    retDownloadedCourseDetailInfo.append(courseDetailModel!);
//                } else {
//                    let tempCDM = courseDetailModel!;
//                    tempCDM.arrPersistModel?.append(dataloadedItem);
//                }
//            }
//        }
//
//        return (retDownloadedCourseDetailInfo.count>0) ? retDownloadedCourseDetailInfo : nil;
//    }
    
//    phaseId1
//        model1
//            -->video1
//            -->video2
//        model2
//            -->video1
//    phaseId2
//        model1
//            -->video1
//        model2
//            -->video1

    private func searchAllDownloadedCourseInfo() -> [BXGDownloadedCourseModel]? {
        var retDownloadedCourseInfo:[BXGDownloadedCourseModel] = Array<BXGDownloadedCourseModel>()
        
        let downloadedDataByOrderById:[BXGDownloadPersistAPIModel]? = BXGDownloadTableManager.shareInstance().searchAllDownloaded() as? [BXGDownloadPersistAPIModel]
        var preCourseId:Int32 = -1;
        
        var courseModel:BXGDownloadedCourseModel?;
        if let dataloadedDatas = downloadedDataByOrderById {
            for dataloadedItem in dataloadedDatas {
                
                if(preCourseId == -1 || preCourseId != dataloadedItem.apiDownloaderItem.courseId) {
                    let tempCM:BXGDownloadedCourseModel = BXGDownloadedCourseModel()
                    tempCM.courseId = dataloadedItem.apiDownloaderItem.courseId;
                    tempCM.courseName = dataloadedItem.apiDownloaderItem.courseName;
                    tempCM.courseImageURLPath = dataloadedItem.apiDownloaderItem.courseImageUrl;
                    tempCM.fileInfo = Array<BXGDownloadPersistAPIModel>()
                    tempCM.fileInfo?.append(dataloadedItem)
                    tempCM.fileNums += 1
                    let filePath:String = dataloadedItem.videoPath
                    tempCM.fileSize += Double(BXGFileManager.getFileSize(withPath: filePath))
                    
                    preCourseId = tempCM.courseId!;
                    courseModel = tempCM
                    
                    retDownloadedCourseInfo.append(courseModel!);
                } else {
                    let tempCM = courseModel!;
                    tempCM.fileNums += 1
                    let filePath:String = dataloadedItem.videoPath
                    tempCM.fileSize += Double(BXGFileManager.getFileSize(withPath: filePath))
                    tempCM.fileInfo?.append(dataloadedItem);
                }
            }
        }
        
        return (retDownloadedCourseInfo.count>0) ? retDownloadedCourseInfo : nil;
        /*
         let persistDownloadedCourseDatasGroupByCourseId:[BXGDownloadPersistAPIModel]? = BXGDownloadTableManager.shareInstance().searchAllDownloadedCourseInfo() as? [BXGDownloadPersistAPIModel];
         if let persistCourseDatasGroupByCourseId = persistDownloadedCourseDatasGroupByCourseId,
         let datasOrderByCourseId=persistDownloadedDatasOrderByCourseId {
         for persistCourseDataItemGroupByCourseId in persistCourseDatasGroupByCourseId {
         let downloadedCoureInfo:BXGDownloadedCourseModel = BXGDownloadedCourseModel()
         
         downloadedCoureInfo.courseId = Int(persistCourseDataItemGroupByCourseId.apiDownloaderItem.courseId);
         downloadedCoureInfo.courseName = persistCourseDataItemGroupByCourseId.apiDownloaderItem.courseName;
         //                downloadedCoureInfo.courseImageURLPath
         downloadedCoureInfo.fileInfo = Array<BXGDownloadPersistAPIModel>()
         for dataItemOrderByCourseId in datasOrderByCourseId {
         downloadedCoureInfo.fileInfo?.append(dataItemOrderByCourseId)
         downloadedCoureInfo.fileNums += 1;
         downloadedCoureInfo.fileSize += Double(BXGFileManager.getFileSize(withPath:dataItemOrderByCourseId.videoPath))
         }
         
         retDownloadedCourseInfo.append(downloadedCoureInfo);
         }
         }
         
         courseId ->
         return (retDownloadedCourseInfo.count>0) ? retDownloadedCourseInfo : nil;
         */
        
    }
    
    func searchAllDownloadingCourseInfo() -> [BXGDownloadPersistAPIModel]? {
        let downloadingCourses:[BXGDownloadPersistAPIModel]? = BXGDownloadTableManager.shareInstance().searchAllDownloading() as? [BXGDownloadPersistAPIModel]
        return downloadingCourses;
//        return BXGDownloadAPI.share().arrDownloadingItems.count==0 ? nil : BXGDownloadAPI.share().arrDownloadingItems as? [BXGDownloadPersistAPIModel];
    }
    /*
    private func searchAllDownloadingCourseInfo() -> [BXGDownloadPersistAPIModel]? {
        return BXGDownloadAPI.share().arrDownloadingItems.count==0 ? nil : BXGDownloadAPI.share().arrDownloadingItems as? [BXGDownloadPersistAPIModel];
    }
    */
}

