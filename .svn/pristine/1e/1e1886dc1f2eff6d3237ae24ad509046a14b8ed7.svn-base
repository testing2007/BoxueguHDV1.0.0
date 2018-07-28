//
//  BXGDownloadCC.m
//  Demo
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import "BXGDownloadCC.h"
#import "BXGDownloadCCModel.h"
#import "BXGDownloadCCDelegate.h"
#import "DWSDK.h"
#import "BoxueguHD-Swift.h"
#import "NSURLSession+DWCorrectedResumeData.h"

@interface BXGCCDownloadingItem : NSObject
@property (nonatomic, strong) BXGDownloadCCModel *downloadItem;
@property (nonatomic, strong) DWDownloadModel *ccDownloadModel;
@end
@implementation BXGCCDownloadingItem
@end

@interface BXGDownloadCC()
//CC的APIKey、userID.
@property (nonatomic, strong) NSString *ccApiKey;
@property (nonatomic, strong) NSString *ccUserId;

@property (nonatomic, strong) NSMutableArray<BXGDownloadCCModel*> *arrWaitingDownload; //待下载队列
@property (nonatomic, strong) NSMutableDictionary<NSString*/*customId*/, BXGCCDownloadingItem*> *dictDownloading; //正在下载

@property (nonatomic, strong) NSThread *downloadMonitorThread; //下载线程
@property (nonatomic, strong) NSCondition *condition;  //下载条件变量

@end

@implementation BXGDownloadCC

+(instancetype)instance {
    static BXGDownloadCC *downloadCC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadCC = [[BXGDownloadCC alloc] initWithDownloadDelegate:nil];
    });
    return downloadCC;
}

-(instancetype)initWithDownloadDelegate:(id<BXGDownloadCCDelegate>)delegate{
    self = [super init];
    if(self) {
        //后台下载设置
        [[DWDownloadSessionManager manager] configureBackroundSession];
        
        self.ccUserId = [BXGDownloadEnvSource.instance ccUserId] ;
        self.ccApiKey = [BXGDownloadEnvSource.instance ccAPIKey];
        _maxConcurrentDownloadNums = 2;
        _arrWaitingDownload = [NSMutableArray new];
        _dictDownloading = [NSMutableDictionary new];
        _delegate = delegate;
        _condition = [[NSCondition alloc] init];
        _downloadMonitorThread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadRun:) object:nil];
        [_downloadMonitorThread start];
    }
    return self;
}

-(void)addDownloadItem:(BXGDownloadCCModel*)downloadItem {
    [self addDownloadItem:downloadItem  isAppend:YES];
}

//-(void)addDownloadItems:(NSArray<BXGDownloadCCModel*>*)downloadItems {
//    for(BXGDownloadCCModel *item in downloadItems) {
//        [self addDownloadItem:item];
//    }
//}
//
-(void)addHeadDownloadItem:(BXGDownloadCCModel*)downloadItem  {
    [self addDownloadItem:downloadItem isAppend:NO];
}

-(void)addDownloadItem:(BXGDownloadCCModel*)downloadItem isAppend:(BOOL)bAppend {
    
    NSAssert(self.ccUserId, @"ccUserId is nil");
    NSAssert(self.ccApiKey, @"ccApiKey is nil");
    [self->_condition lock];
    
    if([self isExistDownloadingList:downloadItem]) {
        //正在下载列表中
        [self->_condition unlock];
        return ;
    }
    
    int downloadItemIndex = [self downloadItemIndex:downloadItem];
    if(bAppend) {
        if(downloadItemIndex<0) {
            //如果要追加, 只有当等待下载列表中不存在的时候才添加
            [self.arrWaitingDownload addObject:downloadItem];
        }
    } else {
        if(downloadItemIndex>0) {
            //存在于 非第一个位置 的时候, 才需要将原来的删除
            [self.arrWaitingDownload removeObjectAtIndex:downloadItemIndex];
            [self.arrWaitingDownload insertObject:downloadItem atIndex:0];
        } else if (downloadItemIndex<0) {
            //不存在
            [self.arrWaitingDownload insertObject:downloadItem atIndex:0];
        } else {
            //已存在且在第一个位置
            //do nothing;
        }
    }
//    [self doDownload];
    [self.condition signal];
    [self->_condition unlock];
}

-(BOOL)isExistDownloadingList:(BXGDownloadCCModel*)downloadItem {
    BXGCCDownloadingItem *downloadingItem = [self.dictDownloading objectForKey:downloadItem.customId];
    if(downloadingItem) {
        return true;//表明已存在, 且在第一个位置,不用插入数据
    }
    return false;
}

///查询到了就返回对应的索引值(索引值从0开始), 没有找到就返回-1;
-(NSInteger)downloadItemIndex:(BXGDownloadCCModel*)downloadItem {
    NSInteger index = -1;
    NSInteger i=0;
    for (BXGDownloadCCModel *item in self.arrWaitingDownload) {
        if([item.customId isEqualToString:downloadItem.customId]) {
            index = i;
            break;
        }
        i++;
    }
    return index;
}

-(void)start {
}

///全部下载
-(void)allStartDownload:(NSArray<BXGDownloadCCModel*>*)arrDownloadItem {
    for(BXGDownloadCCModel *downloadItem in arrDownloadItem) {
        [self addDownloadItem:downloadItem];
    }
    [self start];
}
///开始下载指定文件
-(void)startDownloadItem:(BXGDownloadCCModel*)downloadItem {
    [self addHeadDownloadItem:downloadItem];
    [self start];
}

///全部暂停
-(void)allPauseDownload {
    [self.condition lock];
    
    [self.arrWaitingDownload removeAllObjects];
    
    if(self.dictDownloading) {
        NSMutableArray *removeKeys = [NSMutableArray new];
        for(BXGCCDownloadingItem *item in _dictDownloading.allValues) {
            if(item.ccDownloadModel.state == DWDownloadStateRunning) {
                [[DWDownloadSessionManager manager] suspendWithDownloadModel:item.ccDownloadModel];
                //todo 是否需要将暂停的数据 item.ccDownloadModel 赋值给item.downloadItem
//                [self.arrWaitingDownload addObject:item.downloadItem];
                [removeKeys addObject:item.downloadItem.customId];
                
            }
        }
        if(removeKeys.count>0) {
            [self.dictDownloading removeObjectsForKeys:removeKeys];
            [self.condition signal];
//            [self doDownload];
        }
    }
    [self.condition unlock];
}
///暂停下载指定文件
-(void)pauseDownloadItem:(BXGDownloadCCModel*)downloadItem {
    [self.condition lock];
    
    NSInteger index = [self downloadItemIndex:downloadItem];
    if(index>=0) {
        [self.arrWaitingDownload removeObjectAtIndex:index];
    }

    if(self.dictDownloading){
        //只要是暂停, 不管其运行状态, 都需要将其从下载等待列表中删除掉
        NSMutableArray *removeKeys = [NSMutableArray new];
        BXGCCDownloadingItem *item = [self.dictDownloading objectForKey:downloadItem.customId];
        if(item && item.ccDownloadModel.state == DWDownloadStateRunning) {
            [[DWDownloadSessionManager manager] suspendWithDownloadModel:item.ccDownloadModel];
            //todo 是否需要将暂停的数据 item.ccDownloadModel 赋值给item.downloadItem
//            [self.arrWaitingDownload addObject:item.downloadItem];
            [removeKeys addObject:item.downloadItem.customId];
        }
        if(removeKeys.count>0) {
            [self.dictDownloading removeObjectsForKeys:removeKeys];
            [self.condition signal];
//            [self doDownload];
        }
    }
    [self.condition unlock];
}

///重新下载指定文件
-(void)resumeDownloadItem:(BXGDownloadCCModel*)downloadItem {
    [self startDownloadItem:downloadItem];
}

///取消下载指定文件
-(void)cancelDownloadItem:(BXGDownloadCCModel*)downloadItem {
    DWDownloadModel *loadModel =[[DWDownloadModel alloc]initWithURLString:downloadItem.downloadURL
                                                                 filePath:downloadItem.videoPath
                                                            responseToken:downloadItem.token
                                                                   userId:self->_ccUserId
                                                                  videoId:downloadItem.ccVideoId];
    
    [self.condition lock];
    //只要是暂停, 不管其运行状态, 都需要将其从下载等待列表中删除掉
    NSInteger index = [self downloadItemIndex:downloadItem];
    if(index>=0) {
        [self.arrWaitingDownload removeObjectAtIndex:index];
    }
    [self.dictDownloading removeObjectForKey:downloadItem.customId];
    [self.condition unlock];
    
    [[DWDownloadSessionManager manager] cancleWithDownloadModel:loadModel isClear:YES];
}

-(void)cancelDownloadItems:(NSArray<BXGDownloadCCModel*>*)arrDownloadItem {
    for(BXGDownloadCCModel *item in arrDownloadItem) {
        [self cancelDownloadItem:item];
    }
}

#pragma mark private function

//-(void)doDownload {
////    if( self.arrWaitingDownload.count<=0 || self.dictDownloading.count>=self.maxConcurrentDownloadNums) {
////        return ;
////    }
//    
//    if(self.arrWaitingDownload.count<=0) {
//        return ;
//    }
//    
//    BXGDownloadCCModel *downloadItem = self.arrWaitingDownload[0];
//    [self.arrWaitingDownload removeObjectAtIndex:0];
//    [self requestDownloadInfo:downloadItem andFinishBlock:^(bool bSuccess, NSString* errorString) {
//        if(bSuccess) {
//            NSLog(@"consume finish: \n\t\t\t downloadItem:Url=%@\n,  \n\t\t\t path=%@, \n\t\t\t token=%@, \n\t\t\t desp=%@", downloadItem.downloadURL, downloadItem.videoPath, downloadItem.token, downloadItem.desp);
//            
//            [self executeDownload:downloadItem];
//        }
//    }];
//    
//}

-(void)downloadRun:(id)obj {
    while(true) {
        [self.condition lock];
        if( self.arrWaitingDownload.count<=0) {
            NSLog(@"consume before waiting");
            [self.condition wait];
            NSLog(@"consume end: waiting");
        }

        if(self.arrWaitingDownload.count<=0 || self.dictDownloading.count>self.maxConcurrentDownloadNums) {
            [self.condition unlock];
            continue;
        }
        NSAssert(self.dictDownloading.count<self.maxConcurrentDownloadNums, @"get out");

        BXGDownloadCCModel *downloadItem = self.arrWaitingDownload[0];
        [self.arrWaitingDownload removeObjectAtIndex:0];
        [self requestDownloadInfo:downloadItem andFinishBlock:^(bool bSuccess, NSString* errorString) {
            if(bSuccess) {
                NSLog(@"consume finish: \n\t\t\t downloadItem:Url=%@\n,  \n\t\t\t path=%@, \n\t\t\t token=%@, \n\t\t\t desp=%@", downloadItem.downloadURL, downloadItem.videoPath, downloadItem.token, downloadItem.desp);
                    [self executeDownload:downloadItem];
            }
        }];


        //        //
        //        NSNumber *taskId = self.arrWaitingTask[0];
        //        NSLog(@"downloadthread:get the taskId=%ld", taskId.integerValue);
        //        [self.arrWaitingTask removeObjectAtIndex:0];
        //
        //        dispatch_async(_executeTaskQueue, ^{
        //            NSLog(@"consume the taskId=%ld", taskId.integerValue);
        //            NSLog(@"consume the thread is executing the task, taskId=%ld", taskId.integerValue);
        //            sleep(10);
        //            NSLog(@"consume the thread finish execute the task, taskId=%ld", taskId.integerValue);
        //        });
        [self.condition unlock];
        NSLog(@"----------------consume a task----------------------------");
    }
}

-(void)requestDownloadInfo:(BXGDownloadCCModel*)downloadItem andFinishBlock:( void (^)(bool bSuccess, NSString* errorString) )finishBlock {
    if(![self isValidate:downloadItem.downloadURL]) {
        //获取下载地址 hlsSupport传@"0"
        DWPlayInfo *playinfo = [[DWPlayInfo alloc] initWithUserId:self.ccUserId andVideoId:downloadItem.ccVideoId key:self.ccApiKey hlsSupport:@"0"];
        //                playinfo.mediatype = DWAPPDELEGATE.mediatype; //todo
        playinfo.timeoutSeconds =20;//网络请求超时时间
        playinfo.errorBlock = ^(NSError* error) {
            NSLog(@"资源请求失败, error=%@", error.debugDescription);
            if(self->_delegate && [self->_delegate respondsToSelector:@selector(requestDownloadURLFailForCustomId:andErrorReason:)]) {
                [self->_delegate requestDownloadURLFailForCustomId:downloadItem.customId andErrorReason:error.debugDescription];
            }
            if(finishBlock) {
                finishBlock(false, error.description);
            }
        };
        
        playinfo.finishBlock = ^(NSDictionary *response) {
            NSDictionary *playUrls =[DWUtils parsePlayInfoResponse:response];
            if (!playUrls) {
                //说明 网络资源暂时不可用
                if(self->_delegate && [self->_delegate respondsToSelector:@selector(requestDownloadURLFailForCustomId:andErrorReason:)]) {
#ifdef DEBUG
                    [self->_delegate requestDownloadURLFailForCustomId:downloadItem.customId andErrorReason:[NSString stringWithFormat:@"request response cann't be resolve playUrls, the response = %@", response.debugDescription]];
#else
                    [self->_delegate requestDownloadURLFailForCustomId:downloadItem.customId andErrorReason:@"request response cann't be resolve playUrls"]
#endif
                }
                if(finishBlock) {
                    finishBlock(false, @"网络资源暂不可用");
                }
                return ;
            }
            NSLog(@"---%@",playUrls);
            NSArray *videos = [playUrls valueForKey:@"definitions"];
            if (videos) {
                NSDictionary *videoInfo = videos[videos.count-1];
                //字典转模型
                NSString *definition =[videoInfo objectForKey:@"definition"];
                NSString *newDesp = [videoInfo objectForKey:@"desp"];
                NSString *newDownloadURL = [videoInfo objectForKey:@"playurl"];
                NSString *newToken = [playUrls objectForKey:@"token"];
                
                float systemVersion =[[[UIDevice currentDevice] systemVersion] floatValue];
                if(downloadItem.downloadURL && systemVersion < 11.3 && [newDesp isEqualToString:downloadItem.desp]) {
                    //旧的URL
                    NSData *resumeData =[[DWDownloadSessionManager manager] resumeDataFromFileWithFilePath:downloadItem.downloadURL];
                    //新的URL
                    NSData *newResumeData =[[DWDownloadSessionManager manager] newResumeDataFromOldResumeData:resumeData withURLString:newDownloadURL];
                    downloadItem.resumeData = newResumeData;
                }
                downloadItem.downloadURL = newDownloadURL;
                downloadItem.token = newToken;
                downloadItem.desp = newDesp;
                /* 注意：
                 若你所下载的 videoId 未启用视频加密功能，则保存的文件扩展名[必须]是 mp4，否则无法播放。
                 若你所下载的 videoId 启用了视频加密功能，则保存的文件扩展名[必须]是 pcm，否则无法播放。
                 */
                NSString *type;
                if ([downloadItem.downloadURL containsString:@"mp4?"]) {
                    
                    type =@"mp4";
                }else if([downloadItem.downloadURL containsString:@"pcm?"]){
                    
                    type =@"pcm";
                }else if ([downloadItem.downloadURL containsString:@"m4a?"]){
                    
                    type =@"m4a";
                }else if ([downloadItem.downloadURL containsString:@"mp3?"]){
                    
                    type =@"mp3";
                }else if ([downloadItem.downloadURL containsString:@"aac?"]){
                    
                    type =@"aac";
                }
                
                NSString *videoFileName = [NSString stringWithFormat:@"%@.%@", downloadItem.customId, type];
//                NSString *videoFileName;
//                if(definition) {
//                    videoFileName  = [NSString stringWithFormat:@"%@-%@.%@", downloadItem.ccVideoId, definition, type];
//                } else {
//                    videoFileName  = [NSString stringWithFormat:@"%@.%@", downloadItem.ccVideoId, type];
//                }
                if(self->_delegate && [self->_delegate respondsToSelector:@selector(generateDownloadPathByFileName:)]) {
                    NSString *videoPath = [self->_delegate generateDownloadPathByFileName:videoFileName];
                    downloadItem.videoPath = videoPath;
                }
                if(finishBlock) {
                    finishBlock(true, nil);
                }
            } else {
                if(finishBlock) {
                    finishBlock(false, @"fail to parse [definitions]");
                }
            }//definition
        };
        [playinfo start];
    } else  {
        if (finishBlock) {
            finishBlock(true, nil);
        }
    }
}

-(void)executeDownload:(BXGDownloadCCModel*)downloadItem{
    DWDownloadModel *loadModel =[[DWDownloadModel alloc]initWithURLString:downloadItem.downloadURL
                                                                 filePath:downloadItem.videoPath
                                                            responseToken:downloadItem.token
                                                                   userId:self->_ccUserId
                                                                  videoId:downloadItem.ccVideoId];
    if(downloadItem.resumeData) {
        loadModel.resumeData = downloadItem.resumeData;
    }
    
    //添加到正在下载列表中
    BXGCCDownloadingItem *downloadingItem = [BXGCCDownloadingItem new];
    downloadingItem.downloadItem = downloadItem;
    downloadingItem.ccDownloadModel = loadModel;//存放下载模型, 方便取消
    [self.dictDownloading setObject:downloadingItem forKey:downloadItem.customId];
    
    //从待下载列表中删除
//    [self.arrWaitingDownload removeObject:downloadItem];
    
    DWDownloadSessionManager *manager =[DWDownloadSessionManager manager];
    [manager startWithDownloadModel:loadModel progress:^(DWDownloadProgress *progress, DWDownloadModel *downloadModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"progress ccdownload progress=%lf", progress.progress);
            if(self->_delegate && [self->_delegate respondsToSelector:@selector(downloadProgressForDownloadItem:)]) {
                downloadItem.downloadState = [downloadItem convertBXGDownloadState:downloadModel.state];
                downloadItem.totalBytesWritten = downloadModel.progress.totalBytesWritten;
                downloadItem.totalBytesExpectedToWrite = downloadModel.progress.totalBytesExpectedToWrite;
                downloadItem.progress = downloadModel.progress.progress;
                downloadItem.speed = downloadModel.progress.speed;
                [self->_delegate downloadProgressForDownloadItem:downloadItem];
            }
        });
    } state:^(DWDownloadModel *downloadModel, DWDownloadState state, NSString *filePath, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self->_delegate && [self->_delegate respondsToSelector:@selector(downloadStateForDownloadItem:andError:)]) {
                downloadItem.downloadState = [downloadItem convertBXGDownloadState:state];
                [self->_delegate downloadStateForDownloadItem:downloadItem andError:error];
            }
            if(state==DWDownloadStateCompleted) {
                //NSLog(@"state ccdownload progress=%lf", downloadModel.progress.progress);
                [self->_condition lock];
                [self downloadNextItem:downloadItem];
                [self->_condition unlock];
            }
            else if(state==DWDownloadStateFailed) {
                [self->_condition lock];
                [self.dictDownloading removeObjectForKey:downloadItem.customId];
                [self->_condition unlock];
            }
        });
    }];
}

-(BOOL)isAddDownloadList:(NSString*)customId {
    BOOL bExist = NO;
    NSObject *obj = [_dictDownloading objectForKey:customId];
    if(obj) {
        bExist = YES;
        return bExist;
    }
    for(BXGDownloadCCModel *downloadItem in _arrWaitingDownload) {
        if([downloadItem.customId isEqualToString:customId]) {
            bExist = YES;
            break;
        }
    }
    return bExist;
}

-(void)downloadNextItem:(BXGDownloadCCModel*)downloadItem {
    [self.dictDownloading removeObjectForKey:downloadItem.customId];
    [self start];
}

/**
 判断URL是否有效
 *取得时间戳与失效时间戳做比对
 *http://d1-33.play.bokecc.com/flvs/cb/QxhEr/hKboX7hTIY-20.pcm?t=1496894440&key=F458F79EF07944EAAF38AC01A4F49CC9&upid=2625321496887240251
 *t=1496894440为失效时间点
 */
-(BOOL)isValidate:(NSString *)downloadURL{
    
    if(!downloadURL || [downloadURL isEqualToString:@""] || downloadURL.length==0) {
        NSLog(@"url不可用");
        return NO;
    }
    
    NSRange range =[downloadURL rangeOfString:@"t="];
    NSRange timeRang =NSMakeRange(range.location+2, 10);
    NSString *oldStr =[downloadURL substringWithRange:timeRang];
    NSLog(@"时间%@",oldStr);
    
    NSDate *date =[NSDate date];
    NSString *timeString =[NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    NSString *nowString =[timeString substringWithRange:NSMakeRange(0, 10)];
    NSLog(@"__%@___%@",oldStr,nowString);
    
    if ([nowString integerValue] >= [oldStr integerValue]) {
        NSLog(@"url不可用");
        return NO;
    }else{
        
        NSLog(@"url可用");
        return YES;
    }
}

@end
