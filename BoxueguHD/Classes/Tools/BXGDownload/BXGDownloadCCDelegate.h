//
//  BXGDownloadCCDelegate.h
//  Demo
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXGDownloadCCModel.h"

@protocol BXGDownloadCCDelegate <NSObject>

-(NSString*)generateDownloadPathByFileName:(NSString*)fileName;
-(void)downloadProgressForDownloadItem:(BXGDownloadCCModel*)downloadItem;
-(void)downloadStateForDownloadItem:(BXGDownloadCCModel*)downloadItem andError:(NSError*)error;
-(void)requestDownloadURLFailForCustomId:(NSString*)customId andErrorReason:(NSString*)errorReason;

@end
