//
//  BXGCourseOutlineViewModel.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/17.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
import ObjectMapper

//- (void)updateVideoStatusWithVideoModel:(BXGVODPlayerVideoModel *)vodVideoModel studyUpdateStatus:(BXGStudyUpdateStatus)status;

//- (void)requestUpdateOfflineStudyStatusWithFinished:(void(^ _Nullable)(BOOL success))finishedBlock {
//
//    BXGStudyCenterProgressStatusTable *table = [BXGStudyCenterProgressStatusTable new];
//    NSArray <BXGStudyCenterProgressStatusModel *> *modelArray = [table searchNoneSyncRecordWithUserId:[BXGUserCenter share].userModel.user_id ];
//    if(modelArray.count > 0) {
//        NSMutableArray *serializerArray = [NSMutableArray new];
//        for(NSInteger i = 0; i < modelArray.count; i++) {
//
//            NSString *addtime = [modelArray[i].addtime converDateStringFromFormat:@"yyyy-MM-dd HH:mm:ss.SSS" toFormat:@"yyyy-MM-dd HH:mm:ss"];
//
//            if(modelArray[i].courseId
//                && modelArray[i].sectionId
//                && modelArray[i].videoId
//                && @(modelArray[i].status).stringValue
//                && addtime) {
//                NSDictionary *item = @{@"courseId":modelArray[i].courseId,
//                    @"sectionId":modelArray[i].sectionId,
//                    @"videoId":modelArray[i].videoId,
//                    @"studyStatus":@(modelArray[i].status).stringValue,
//                    @"lastLearnTime":addtime,
//                };
//                [serializerArray addObject:item];
//            }
//        }
//
//        NSString *videoData = [serializerArray yy_modelToJSONString];
//        if(videoData.length > 0) {
//            [self.networkTool appRequestUpdateOfflineVideoStatusWithVideoData:videoData Finished:^(NSInteger status, NSString * _Nullable message, id  _Nullable result) {
//                if(status / 100 == 2) {
//                [table updateSyncForAllNoneSyncRecordWithUserId:[BXGUserCenter share].userModel.user_id ];
//                }else {
//                // pass
//                }
//                }];
//        }
//    }
//}









public enum BXGStudyUpdateStatusType {
    case begin // 内存 网络
    case finished // 内存 数据库(seekTime 清理) 网络
    case changed // 内存 数据库 网络
}

class BXGCourseOutlineViewModel {
    
    let courseModel: BXGStudyCourseModel
    let phaseModel: BXGCoursePhaseModel
    let moduleModel: BXGCourseModuleModel
    
    var outlineModuleModel: BXGCourseOutlineModuleModel?
    
    public func updateVideoStatus(videoModel: BXGVODPlayerVideoModel, status: BXGStudyUpdateStatusType) {
        guard let info = videoModel.infoModel else {
            return
        }
        var currentTime = BXGVODPlayerManager.shared.player?.currentTime ?? 0
        let duration = BXGVODPlayerManager.shared.player?.duration ?? 0
        var studyStatus = 0
        switch status {
        case .begin:
            studyStatus = 1
            
        case .finished:
            studyStatus = 2
        case .changed:
            let percent = currentTime / duration
            if percent >= 2.0 / 3.0 {
                studyStatus = 2
            }else {
                studyStatus = 1
            }
        }
        // 更新内存
        
        // 寻找当前模型进行更新
        
        //    if(pointModel.studyStatus.integerValue != 2) {
        //        pointModel.studyStatus = @(studyStatus).stringValue;
        //    }else {
        //        studyStatus = 2; // 根据本地模型数据 状态为准 已学完 不可逆
        //    }
        
        // 数据库
        let manager = BXGStudyStatusTableManager()
//        BXGStudyStatusModel *newModel = nil;
        
        
        if status == .finished {
            currentTime = 0
        }
        let date = Date()

        guard let statusModel = BXGStudyStatusModel(userId: info.userId, courseId: "\(info.courseId)", phaseId: "\(info.phaseId)", moduleId: "\(info.moduleId)", sectionId: "\(info.sectionId)", pointId: "\(info.pointId)", videoId: "\(info.videoId)", videoName: info.videoName, isSync: 0, status: studyStatus, seekTime: Double(currentTime), durationTime: Double(duration), addTime: date.convertToString(toFormat: "yyyy-MM-dd HH:mm:ss.SSS")) else {
            return
        }
        
        if status != .begin {
            // != .begin 时才会保存到数据库
            
            let modelArray =  manager.searchRecord(withUserId: info.userId, courseId: "\(info.courseId)", phaseId: "\(info.phaseId)", moduleId: "\(info.moduleId)", sectionId: "\(info.sectionId)", videoId: "\(info.videoId)")
            if let first = modelArray?.first{
                // 存在
                statusModel.status = statusModel.status > first.status ? statusModel.status : first.status
                manager.updateOneRecord(statusModel)
                
            }else {
                // 不存在
                manager.addOneRecord(statusModel)
            }
        }
        
        let updateStatus = status
        
        BXGNetworkManager.request(api: BXGNetworkApp1API.updateVideoStatus(courseId: info.courseId, sectionId: info.sectionId, videoId: info.videoId, studyStatus: studyStatus)) { (response) in
            switch response {
            case .success(let status, let message, let result):
                if status == 200 {
                    
                    // updateStatus != .begin 才会更新数据库
                    if updateStatus != .begin {
                        statusModel.isSync = 1
                        manager.updateOneRecord(statusModel)
                    }
                    
                }
                return;
            case .failure(let error):
                print()
            }
        }
    }
    
    
    //    // 网络 + 数据库
    //    [self.networkTool appRequestUpdateVideoStatusWithCourseId:self.courseModel.idx SectionId:sectionModel.sectionId VideoId:pointModel.videoId StudyStatus:@(studyStatus).stringValue Finished:^(NSInteger status, NSString * _Nullable message, id  _Nullable result) {
    //        if(status / 100 == 2) {
    //        // 同步成功 保存到本地数据库 保存为已同步
    //        if(newModel && status != BXGStudyUpdateStatusBegin) {
    //        newModel.isSync = true;
    //        [table updateOneRecord:newModel];
    //        }
    //        }
    //        }];
    //}
    
    init(courseModel fromCourseModel: BXGStudyCourseModel, phaseModel fromPhaseModel: BXGCoursePhaseModel, moduleModel fromModuleModel: BXGCourseModuleModel) {
        courseModel = fromCourseModel
        phaseModel = fromPhaseModel
        moduleModel = fromModuleModel
    }
    
    
    
    func request(courseId: Int, moduleId: Int, finished: @escaping (_ succeed: Bool)->()) {
        
        BXGNetworkManager.request(api: BXGNetworkApp2API.coursePlayCouseKnowledgeTree(courseId: courseId, moduleId: moduleId, isTry: false)) { (response) in
            switch response {
            case .success(let status, let message, let result):
                if let model = Mapper<BXGCourseOutlineModuleModel>().map(JSONObject: result) {
                    print(model)
                    self.outlineModuleModel = model
                    finished(false)
                    return
                }
            case .failure(let error):
                print()
            }
            finished(false)
        }
    }
    
    func makeVODInfoModel(courseModel: BXGStudyCourseModel, phaseModel: BXGCoursePhaseModel, moduleModel: BXGCourseModuleModel, sectionModel: BXGCourseOutlineSectionModel, pointModel: BXGCourseOutlinePointModel) -> BXGVODPlayerVideoInfoModel? {
        if let userId = BXGUserCenter.shared.userModel?.user_id,
            let courseId = courseModel.id,
            let phaseId = phaseModel.phaseId,
            let moduleId = moduleModel.id,
            let sectionId = sectionModel.sectionId,
            let pointId = pointModel.pointId,
            let videoId = pointModel.videoId,
            let videoName = pointModel.pointName {
            let infoModel = BXGVODPlayerVideoInfoModel(userId: userId, courseId: courseId, phaseId: phaseId, moduleId: moduleId, sectionId: sectionId, pointId: pointId, videoId: videoId, videoName: videoName)
            return infoModel
        }else {
            return nil
        }
        
    }
    
    func makeVODVideoModel(sectionModel: BXGCourseOutlineSectionModel) -> [BXGVODPlayerVideoModel]? {
        guard let pointItems = sectionModel.pointItems, let studentCourseId = outlineModuleModel?.studentCourseId else {
            return nil
        }
        var array = Array<BXGVODPlayerVideoModel>()
        for (index, pointModel) in pointItems.enumerated() {
            
            if let id = pointModel.videoId, let name = pointModel.pointName, let resourseId = pointModel.ccVideoId {
                
                
                if let infoModel = makeVODInfoModel(courseModel: courseModel, phaseModel: phaseModel, moduleModel: moduleModel, sectionModel: sectionModel, pointModel: pointModel) {
                    let videoModel = BXGVODPlayerVideoModel(id: id, name: name, resourseId: resourseId, tag: index, infoModel: infoModel, customId: "D_\(studentCourseId)_\(id)")
                    
                    array.append(videoModel)
                }
            }
        }
        return array
    }
    
    func makeVODVideoModels(moduleModel: BXGCourseOutlineModuleModel) -> [[BXGVODPlayerVideoModel]]? {
        if let sectionModels = moduleModel.sectionItems {
            
            var array = [[BXGVODPlayerVideoModel]]()
            
            for s in sectionModels {
                if let list = makeVODVideoModel(sectionModel: s) {
                    array.append(list)
                }
            }
            return array
        }else {
            return nil
        }
    }
    
    func generateVODModels() -> [[BXGVODPlayerVideoModel]]? {
        if let moduleModel = outlineModuleModel {
            return makeVODVideoModels(moduleModel: moduleModel)
        }else {
            return nil
        }
    }
}
