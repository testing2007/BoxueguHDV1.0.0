//
//  BXGConstrueViewModel.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/24.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
import ObjectMapper
class BXGConstrueViewModel {
    
    var liveModels: [BXGConstrueLiveModel]?
    var replayModels: [BXGConstrueLiveModel]?
    
    var replayModelsMap: [String:[BXGConstrueLiveModel]]?
    var replayModelsKeyList: [String]?
    
    func loadLiveList(finished: @escaping (_ succeed: Bool,_ message: String?)->()) {
        
        self.liveModels = nil
        
        let date = Date()
        BXGNetworkManager.request(api: BXGNetworkApp1API.construeLivePlanList(day: date.convertToString(toFormat: "yyyy-MM-dd"))) { (response) in
            switch response {
            case .success(let status, let message, let result):
                
                if status == 200 {
                    if let models = Mapper<BXGConstrueLiveModel>().mapArray(JSONObject: result) {
                        self.liveModels = models
                        finished(true, "")
                        return
                    }
                }

            case .failure(let error):
                print()
            }
            finished(false, "")
        }
    }
    
    func loadReplayList(finished: @escaping (_ succeed: Bool,_ message: String?)->()) {
        BXGNetworkManager.request(api: BXGNetworkApp2API.construeReplay(pageNo: nil, pageSize: nil, day: nil)) { (response) in
            switch response {
            case .success(let status, let message, let result):
                if status == 200 {
                    if let result = result as? Dictionary<String, Any>, let items = result["items"], let models = Mapper<BXGConstrueLiveModel>().mapArray(JSONObject: items) {
                        self.replayModels = models
                        
                        var map = [String: [BXGConstrueLiveModel]]()
                        var keyList = [String]()
                        for model in models {
                            if let key = model.startTime?.convertToString(fromFormat: "yyyy-MM-dd HH:mm", toFormat: "yyyy-MM-dd") {
                                if map[key] == nil {
//                                    let index = map.count
                                    map[key] = [BXGConstrueLiveModel]()
                                    keyList.append(key)
                                }
                                if var array = map[key] {
                                    array.append(model)
                                    map[key] = array
                                }
                            }
                        }
                        self.replayModelsMap = map
                        self.replayModelsKeyList = keyList
                        
                        finished(true, "")
                        return
                    }
                }
            case .failure(let error):
                print()
            }
            finished(false, "")
        }
        
    }
    
    // date order
    
    
    
//    NSMutableDictionary *keyForIndex = [NSMutableDictionary new];
//    NSMutableDictionary *indexDict = [NSMutableDictionary new];
//    NSMutableArray *subArray = [NSMutableArray new];
//    NSMutableDictionary *mudict = [NSMutableDictionary new];
//
//    for (NSInteger i = 0; i < modelArray.count; i++) {
//    BXGConstruePlanDayModel *model = modelArray[i];
//    NSString *key = [model.startTime converDateStringFromFormat:@"yyyy-MM-dd HH:mm" toFormat:@"yyyy-MM-dd"];
//
//    if(key.length > 0) {
//
//    if(!mudict[key]) {
//    NSInteger index = mudict.count;
//    mudict[key] = [NSMutableArray new];
//    indexDict[@(index).description] = key;
//    keyForIndex[key] = @(index);
//    }
//    NSMutableArray *m = mudict[key];
//    [m addObject:model];
//
//    //            indexDict[@(i).description] = key;
//    //            keyForIndex[key] = @(i);
//    }
//
//    }
//
//    self.keyForIndex = keyForIndex;
//    self.indexDict = indexDict;
//    self.valueDict = mudict;
    
    
    
    
    func requestReplayDetail(planId: Int, finished: @escaping (_ succeed: Bool,
        _ message: String?,
        _ replayModels: [BXGConstrueReplayPlayerModel]?)->()) {
        
        BXGNetworkManager.request(api: BXGNetworkApp1API.construeReplayDetail(planId: planId)) { (response) in
            switch response {
            case .success(let status, _, let result):
                
                if status == 200, let models = Mapper<BXGConstrueReplayPlayerModel>().mapArray(JSONObject: result) {
                    
                    finished(true, nil, models)
                    return
                }
            case .failure( _): break
            }
            finished(true, nil, nil)
        }
    }
    
    func requestLivePlanDetail(planId: Int, finished: @escaping (_ succeed: Bool,
        _ message: String?,
        _ detailModel: BXGConstrueLiveModel?,
        _ liveRoomId: String?)->()) {
        
        BXGNetworkManager.request(api: BXGNetworkApp1API.construeLivePlanDetail(planId: planId)) { (response) in
            switch response {
            case .success(let status, _, let result):
                
                if status == 200, let model = Mapper<BXGConstrueLiveModel>().map(JSONObject: result), let liveRoom = model.liveRoom {
                    
                    finished(true, nil, model, liveRoom)
                    return
                }
            case .failure( _): break
            }
            finished(true, nil, nil, nil)
        }
    }
    
    
    func load() {
        // 日历
//        BXGNetworkManager.request(api: BXGNetworkApp1API.construePlanByMonth) { (response) in
//            switch response {
//            case .success(let status, let message, let result):
//                print()
//            case .failure(let error):
//                print()
//            }
//        }
//        // 回放
//        BXGNetworkManager.request(api: BXGNetworkApp1API.construeReplay(pageNo: nil, pageSize: nil, day: nil)) { (response) in
//            switch response {
//            case .success(let status, let message, let result):
//                print()
//            case .failure(let error):
//                print()
//            }
//        }
        
        

    }
}
