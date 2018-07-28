//
//  BXGDownloadAPI.h
//  Demo
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXGDownloadAPIDelegate.h"

@interface BXGDownloadAPI : NSObject

+(instancetype)share;

//@property (nonatomic, strong) NSMutableArray<BXGDownloadPersistAPIModel*> *arrDownloadingItems; //下载中的数据暂存在内存中

///注册/反注册观察者
-(void)registerObserver:(id<BXGDownloadAPIDelegate>)observer;
-(void)unregisterObserver:(id<BXGDownloadAPIDelegate>)observer;

///添加新的下载
-(void)addDownloadItem:(BXGDownloadAPIModel*)apiDownloadItem;
-(void)addDownloadItems:(NSArray<BXGDownloadAPIModel*>*)apiDownloadItems;
///启动下载
-(void)start;

///启动之前已添加到下载列表但是还没有下完的资源
-(void)allStartPersisitDownloadItems:(NSArray<BXGDownloadPersistAPIModel*>*)apiPersistDownloadItems;
-(void)startPersisitDownloadItem:(BXGDownloadPersistAPIModel*)apiPersistDownloadItem;

///全部暂停
-(void)allPauseDownload;
///暂停下载指定文件
-(void)pausePersisitDownloadItem:(BXGDownloadPersistAPIModel*)apiPersistDownloadItem;
///重新下载指定文件
-(void)resumePersisitDownloadItem:(BXGDownloadPersistAPIModel*)apiPersistDownloadItem;;

///取消下载指定文件
-(void)cancelPersisitDownloadItem:(BXGDownloadPersistAPIModel*)apiPersistDownloadItem;
-(void)cancelPersisitDownloadItems:(NSArray<BXGDownloadPersistAPIModel*>*)apiPersistDownloadItems;

@end
