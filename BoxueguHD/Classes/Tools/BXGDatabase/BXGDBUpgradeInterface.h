//
//  BXGDBUpgradeInterface.h
//  DBMirgratePRJ
//
//  Created by apple on 2018/3/9.
//  Copyright © 2018年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BXGDBUpgradeInterface <NSObject>

@optional
-(void)upgradeV1toV2;
-(void)upgradeV2toV3;

@end
