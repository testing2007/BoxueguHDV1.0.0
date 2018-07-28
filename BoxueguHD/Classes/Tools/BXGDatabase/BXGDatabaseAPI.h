//
//  BXGDatabaseAPI.h
//  FFDBPrj
//
//  Created by apple on 17/6/12.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
//#import "BXGDownloadPersistAPIModel.h"
//#import "BXGDownloadTableProtocol.h"

extern NSString* DB_NAME;

@class BXGDownloadTable;
@interface BXGDatabaseAPI : NSObject

+(instancetype)shareInstance;
-(FMDatabase*) callDB;

-(BOOL)open;
-(BOOL)close;

@end

#define BXGDATABASE [[BXGDatabaseAPI shareInstance] callDB]

