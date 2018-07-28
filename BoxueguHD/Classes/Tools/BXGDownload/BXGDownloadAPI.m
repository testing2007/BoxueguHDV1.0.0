//
//  BXGDownloadAPI.m
//  Demo
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import "BXGDownloadAPI.h"
#import "BXGDownloadCC.h"
#import "BXGDatabaseAPI.h"

#import "BoxueguHD-Swift.h"

@interface BXGDownloadAPI()<BXGDownloadCCDelegate>
@property (nonatomic, strong) NSMutableArray *arrDownloadObserver;
@property (nonatomic, strong) BXGDownloadCC *ccDownloader;
@property (nonatomic, strong) NSMutableDictionary<NSString* /*customId*/, BXGDownloadPersistAPIModel *> *dictAPIDownloadItems;
@end
@implementation BXGDownloadAPI

+(instancetype)share {
    static BXGDownloadAPI *downloader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloader = [BXGDownloadAPI new];
        
        //从数据库获取信息并暂存到内存中, 因为下载中列表进度更新,不能持续读取数据库
//        downloader.arrDownloadingItems = [[NSMutableArray alloc]initWithArray:[BXGDatabaseAPI.shareInstance searchAllDownloading]];
    });
    return downloader;
}

-(BXGDownloadCC*)ccDownloader {
    if(_ccDownloader == nil) {
        _ccDownloader= [[BXGDownloadCC alloc] initWithDownloadDelegate:self];
    }
    return _ccDownloader;
}

-(NSMutableArray*)arrDownloadObserver {
    if(_arrDownloadObserver == nil) {
        _arrDownloadObserver = [NSMutableArray new];
    }
    return _arrDownloadObserver;
}

-(NSMutableDictionary*)dictAPIDownloadItems {
    if(_dictAPIDownloadItems == nil) {
        _dictAPIDownloadItems = [NSMutableDictionary new];
    }
    return _dictAPIDownloadItems;
}

///注册/反注册观察者
-(void)registerObserver:(id<BXGDownloadAPIDelegate>)observer {
    if([self.arrDownloadObserver indexOfObject:observer] == NSNotFound) {
        [self.arrDownloadObserver addObject:observer];
    }
}

-(void)unregisterObserver:(id<BXGDownloadAPIDelegate>)observer {
    [self.arrDownloadObserver removeObject:observer];
}

///添加新的下载
-(void)addDownloadItem:(BXGDownloadAPIModel*)apiDownloadItem {
    NSString *customId = apiDownloadItem.generateCustomId;
    //预存储待下载的对象, 方便回调时对数据进行持久化
    if(![self.dictAPIDownloadItems objectForKey:customId]) {
        BXGDownloadCCModel *downloadItem = [[BXGDownloadCCModel alloc] initWithCustomId:customId andCCVideoId:apiDownloadItem.ccVideoId];
        __weak typeof(self) weakSelf = self;
        [self.ccDownloader addDownloadItem:downloadItem];
        NSLog(@"####downloadItem url=%@", downloadItem.downloadURL);
        BXGDownloadPersistAPIModel *persistDownloadItem = [[BXGDownloadPersistAPIModel alloc] initWithDownloadItem:apiDownloadItem andDownloadURL:downloadItem.downloadURL   andToken:downloadItem.token andVideoPath:downloadItem.videoPath andQualityDesp:downloadItem.desp];
        [weakSelf.dictAPIDownloadItems setObject:persistDownloadItem forKey:customId];
        
        //资源一旦被添加到下载中,就将信息先在数据库中进行登记
        [[BXGDownloadTableManager shareInstance] addDownloadItem:persistDownloadItem];
    }
}

-(void)addDownloadItems:(NSArray<BXGDownloadAPIModel*>*)apiDownloadItems {
    for(BXGDownloadAPIModel *item in apiDownloadItems) {
        [self addDownloadItem:item];
    }
}

-(void)start {
//    [self.ccDownloader start];
}

///启动之前已添加到下载列表但是还没有下完的资源
-(void)allStartPersisitDownloadItems:(NSArray<BXGDownloadPersistAPIModel*>*)apiPersistDownloadItems {
    for(BXGDownloadPersistAPIModel *item in apiPersistDownloadItems) {
        [self startPersisitDownloadItem:item];
    }
}

-(void)startPersisitDownloadItem:(BXGDownloadPersistAPIModel*)apiPersistDownloadItem {
    NSString *customId = [apiPersistDownloadItem.apiDownloaderItem generateCustomId];
    BXGDownloadCCModel *downloadItem = [[BXGDownloadCCModel alloc] initWithCustomId:customId
                                                                       andCCVideoId:apiPersistDownloadItem.apiDownloaderItem.ccVideoId
                                                                     andDownloadURL:apiPersistDownloadItem.downloadURL
                                                                andDownloadFilePath:apiPersistDownloadItem.videoPath
                                                                   andDownloadToken:apiPersistDownloadItem.token
                                                             andDownloadQualityDesp:apiPersistDownloadItem.qualityDesp];
    [self.ccDownloader startDownloadItem:downloadItem];
    
    //预存储待下载的对象, 方便回调时对数据进行持久化
    [self.dictAPIDownloadItems setObject:apiPersistDownloadItem forKey:customId];
}

///全部暂停
-(void)allPauseDownload {
    
    for (BXGDownloadPersistAPIModel *apiPersistDownloadItem in self.dictAPIDownloadItems.allValues) {
        BXGDownloadCCModel *downloadItem = [[BXGDownloadCCModel alloc] initWithCustomId:[apiPersistDownloadItem.apiDownloaderItem generateCustomId]
                                                                           andCCVideoId:apiPersistDownloadItem.apiDownloaderItem.ccVideoId
                                                                         andDownloadURL:apiPersistDownloadItem.downloadURL
                                                                    andDownloadFilePath:apiPersistDownloadItem.videoPath
                                                                       andDownloadToken:apiPersistDownloadItem.token
                                                                 andDownloadQualityDesp:apiPersistDownloadItem.qualityDesp];
        [self.ccDownloader pauseDownloadItem:downloadItem];
    }
    [self.dictAPIDownloadItems removeAllObjects];
//    [self.ccDownloader allPauseDownload];
}

///暂停下载指定文件
-(void)pausePersisitDownloadItem:(BXGDownloadPersistAPIModel*)apiPersistDownloadItem {
    BXGDownloadCCModel *downloadItem = [[BXGDownloadCCModel alloc] initWithCustomId:[apiPersistDownloadItem.apiDownloaderItem generateCustomId]
                                                                     andCCVideoId:apiPersistDownloadItem.apiDownloaderItem.ccVideoId
                                                                   andDownloadURL:apiPersistDownloadItem.downloadURL
                                                              andDownloadFilePath:apiPersistDownloadItem.videoPath
                                                                 andDownloadToken:apiPersistDownloadItem.token
                                                           andDownloadQualityDesp:apiPersistDownloadItem.qualityDesp];
    [self.ccDownloader pauseDownloadItem:downloadItem];
    [self.dictAPIDownloadItems removeObjectForKey:apiPersistDownloadItem.apiDownloaderItem.generateCustomId];
}
///重新下载指定文件
-(void)resumePersisitDownloadItem:(BXGDownloadPersistAPIModel*)apiPersistDownloadItem {
    BXGDownloadCCModel *downloadItem = [[BXGDownloadCCModel alloc] initWithCustomId:[apiPersistDownloadItem.apiDownloaderItem generateCustomId]
                                                                     andCCVideoId:apiPersistDownloadItem.apiDownloaderItem.ccVideoId
                                                                   andDownloadURL:apiPersistDownloadItem.downloadURL
                                                              andDownloadFilePath:apiPersistDownloadItem.videoPath
                                                                 andDownloadToken:apiPersistDownloadItem.token
                                                           andDownloadQualityDesp:apiPersistDownloadItem.qualityDesp];
    [self.ccDownloader resumeDownloadItem:downloadItem];
    [self.dictAPIDownloadItems setObject:apiPersistDownloadItem forKey:apiPersistDownloadItem.apiDownloaderItem.generateCustomId];
}

///取消下载指定文件
-(void)cancelPersisitDownloadItem:(BXGDownloadPersistAPIModel*)apiPersistDownloadItem {
    if(apiPersistDownloadItem.downloadState == BXGDownloadStateCompleted) {
        [BXGFileManager removeFileOfPath:apiPersistDownloadItem.videoPath];
    } else {
        NSString *customId = [apiPersistDownloadItem.apiDownloaderItem generateCustomId];
        BXGDownloadCCModel *downloadItem = [[BXGDownloadCCModel alloc] initWithCustomId:customId
                                                                           andCCVideoId:apiPersistDownloadItem.apiDownloaderItem.ccVideoId
                                                                         andDownloadURL:apiPersistDownloadItem.downloadURL
                                                                    andDownloadFilePath:apiPersistDownloadItem.videoPath
                                                                       andDownloadToken:apiPersistDownloadItem.token
                                                                 andDownloadQualityDesp:apiPersistDownloadItem.qualityDesp];
        [self.ccDownloader cancelDownloadItem:downloadItem];
        
        //删除下载中的对象
        if([self.dictAPIDownloadItems objectForKey:customId]) {
            [self.dictAPIDownloadItems removeObjectForKey:customId];
        }
    }
    
}

-(void)cancelPersisitDownloadItems:(NSArray<BXGDownloadPersistAPIModel*>*)apiPersistDownloadItems {
    for(BXGDownloadPersistAPIModel *item in apiPersistDownloadItems) {
        [self cancelPersisitDownloadItem:item];
    }
}

#pragma mark -- BXGDownloadCCDelegate
-(NSString*)generateDownloadPathByFileName:(NSString*)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    return filePath;
}

-(void)downloadProgressForDownloadItem:(BXGDownloadCCModel*)ccDownloadItem {
    
    NSLog(@"api progress=%lf, downloadState=%ld", ccDownloadItem.progress, ccDownloadItem.downloadState);
    //调用存储对象 todo
    
//    BXGDownloadPersistAPIModel *persistDownloadItem = [self.dictAPIDownloadItems objectForKey:ccDownloadItem.customId];
//    persistDownloadItem.downloadURL = ccDownloadItem.downloadURL;
//    persistDownloadItem.token = ccDownloadItem.token;
//    persistDownloadItem.videoPath = ccDownloadItem.videoPath;
//    persistDownloadItem.qualityDesp = ccDownloadItem.desp;
//    persistDownloadItem.downloadState = ccDownloadItem.downloadState;
//    persistDownloadItem.totalBytesWritten = ccDownloadItem.totalBytesWritten;
//    persistDownloadItem.totalBytesExpectedToWrite = ccDownloadItem.totalBytesExpectedToWrite;
//    persistDownloadItem.progress = ccDownloadItem.progress;
//    persistDownloadItem.speed = ccDownloadItem.speed;
    BXGDownloadPersistAPIModel *persistDownloadItem =  [self updateDownloadInfoByCCDownloadItem:ccDownloadItem];
    for(id<BXGDownloadAPIDelegate> observer in self.arrDownloadObserver) {
        if(persistDownloadItem &&
           ([observer respondsToSelector:@selector(downloadProgressForAPIPersisitDownloadItem:)])) {
            //通知观察者
            [observer downloadProgressForAPIPersisitDownloadItem:persistDownloadItem];
        }
    }

    if(persistDownloadItem) {
        //每下载1M写入一次数据库
        static int64_t sumTotalBytesWritten=0;
        if(sumTotalBytesWritten+1024*1024<=persistDownloadItem.totalBytesWritten)
        {
            sumTotalBytesWritten = persistDownloadItem.totalBytesWritten;
            [[BXGDownloadTableManager shareInstance] addDownloadItem:persistDownloadItem];
        }
    }
}

-(BXGDownloadPersistAPIModel*)updateDownloadInfoByCCDownloadItem:(BXGDownloadCCModel*)ccDownloadItem {
    BXGDownloadPersistAPIModel *persistDownloadItem = [self.dictAPIDownloadItems objectForKey:ccDownloadItem.customId];
    if(persistDownloadItem) {
        persistDownloadItem.downloadURL = ccDownloadItem.downloadURL;
        persistDownloadItem.token = ccDownloadItem.token;
        persistDownloadItem.videoPath = ccDownloadItem.videoPath;
        persistDownloadItem.qualityDesp = ccDownloadItem.desp;
        persistDownloadItem.downloadState = ccDownloadItem.downloadState;
        persistDownloadItem.totalBytesWritten = ccDownloadItem.totalBytesWritten;
        persistDownloadItem.totalBytesExpectedToWrite = ccDownloadItem.totalBytesExpectedToWrite;
        persistDownloadItem.progress = ccDownloadItem.progress;
        persistDownloadItem.speed = ccDownloadItem.speed;
    }
    return persistDownloadItem;
}

-(void)downloadStateForDownloadItem:(BXGDownloadCCModel*)ccDownloadItem andError:(NSError*)error {
    
    BXGDownloadPersistAPIModel *persistDownloadItem =  [self updateDownloadInfoByCCDownloadItem:ccDownloadItem];
    
    NSLog(@"api progress=%lf, state=%ld", ccDownloadItem.progress, ccDownloadItem.downloadState);
    //下载完成以后， 先更新数据库， 再通知观察对象刷新界面
    if(ccDownloadItem.downloadState==BXGDownloadStateCompleted) {
        NSLog(@"api progress=%lf, state=complete, persistDownloadItem.progress=%lf, pState=%ld", ccDownloadItem.progress, persistDownloadItem.progress, persistDownloadItem.downloadState);
        [[BXGDownloadTableManager shareInstance] addDownloadItem:persistDownloadItem];
        [self.dictAPIDownloadItems removeObjectForKey:ccDownloadItem.customId];
    }

    NSArray *arrtemp = [NSArray arrayWithArray:self.arrDownloadObserver];
    if(arrtemp.count>0) {
        for(id<BXGDownloadAPIDelegate> item in arrtemp) {
            if(persistDownloadItem &&
               ([item respondsToSelector:@selector(downloadStateForAPIPersistDownloadItem:andError:)]) ) {
                //调用这个函数的时候如果出现等于完成的情况, 会重新加载tableView;然后再添加新的cell注册到self.arrDownloadObserver,这样就会导致这个数组在循环,
                //但是外面又修改了. 破坏了原有的循环结构, 导致程序最后崩溃;所以这里使用一个临时的数组
                [item downloadStateForAPIPersistDownloadItem:persistDownloadItem andError:error];
            }
        }
    }
}

-(void)requestDownloadURLFailForCustomId:(NSString*)customId andErrorReason:(NSString*)errorReason {
    
    BXGDownloadPersistAPIModel *persistDownloadItem = [self.dictAPIDownloadItems objectForKey:customId];
    NSArray *arrtemp = [NSArray arrayWithArray:self.arrDownloadObserver];
    if(arrtemp.count>0) {
        for(id<BXGDownloadAPIDelegate> item in arrtemp) {
            if(persistDownloadItem && [item respondsToSelector:@selector(requestDownloadURLFailForAPIPersistDownloadItem:andErrorReason:)]) {
                [item requestDownloadURLFailForAPIPersistDownloadItem:persistDownloadItem andErrorReason:errorReason];
            }
        }
    }
    
    //从数据库中将对象删除todo
    
    //对象取消持久化处理
    if([self.dictAPIDownloadItems objectForKey:customId]) {
        [self.dictAPIDownloadItems removeObjectForKey:customId];
    }
}

@end
