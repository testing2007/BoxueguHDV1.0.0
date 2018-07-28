//
//  BXGDownloadAPIDelegate.h
//  Demo
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXGDownloadPersistAPIModel.h"

@protocol BXGDownloadAPIDelegate<NSObject>

-(void)downloadProgressForAPIPersisitDownloadItem:(BXGDownloadPersistAPIModel*)apiPersistDownloadItem;
-(void)downloadStateForAPIPersistDownloadItem:(BXGDownloadPersistAPIModel*)apiPersistDownloadItem
                                     andError:(NSError*)error;
-(void)requestDownloadURLFailForAPIPersistDownloadItem:(BXGDownloadPersistAPIModel*)apiPersistDownloadItem
                                        andErrorReason:(NSString*)errorReason;

@end
