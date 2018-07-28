//
//  BXGDatabaseAPI.m
//  FFDBPrj
//
//  Created by apple on 17/6/12.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "BXGDatabaseAPI.h"
#import "BXGDownloadTable.h"
#import "BXGDownloadResourceManager.h"
#import "BXGFileManager.h"

//////////////////////////////////////////////////////////////////////
#pragma mark 升级数据库版本数据结构
#define kInitialVersion @"1.0"

@interface BXGDatabaseAPIVersion : NSObject
@property (nonatomic, strong) NSString *currentVersion;
@property (nonatomic, strong) NSString *targetVersion;
@property (nonatomic, assign) SEL upgradeSEL;
@end
@implementation BXGDatabaseAPIVersion
-(instancetype)initWithCurrentVersion:(NSString*)currentVersion
                     andTargetVersion:(NSString*)targetVersion
                        andUpgradeSel:(SEL)upgradeSel
{
    self = [super init];
    if(self) {
        _currentVersion = currentVersion;
        _targetVersion = targetVersion;
        _upgradeSEL = upgradeSel;
    }
    return self;
}
@end
//////////////////////////////////////////////////////////////////////

NSString* DB_NAME = @"BXGHD.db";
@interface BXGDatabaseAPI()
@property(nonatomic, strong) FMDatabase* db;
@property (nonatomic, nonnull, strong) NSDictionary *dictVersionUpgrade; //key=versionId, value=@selector(upgradeFunction)
@property (nonatomic, assign) BOOL isOverrideInstall;
@property (nonatomic, strong) NSString *lastestDBVersion;
@end

@implementation BXGDatabaseAPI

+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static BXGDatabaseAPI* instance;
    dispatch_once(&onceToken, ^{
        instance = [[BXGDatabaseAPI alloc] init];
    });
    return instance;
}

-(instancetype)init
{
    self = [super init];
    if(self) {
        _isOverrideInstall = [self isExistDB];
        //        NSAssert([self checkUpgradeCfg], @"数据库升级配置有问题");
    }
    return self;
}

-(FMDatabase*) callDB {
    if(!_db) {
        [self createDatabase];
    }
    return _db;
}

-(NSDictionary*)dictVersionUpgrade {
    if(!_dictVersionUpgrade) {
        NSMutableDictionary *dictVersionUpgrade = [NSMutableDictionary new];
        
        //        BXGDatabaseAPIVersion *upgradeV1toV2 = [[BXGDatabaseAPIVersion alloc] initWithCurrentVersion:kInitialVersion
        //                                                                              andTargetVersion:@"2.0"
        //                                                                                 andUpgradeSel:@selector(upgradeV1toV2:)];
        //        [dictVersionUpgrade setObject:upgradeV1toV2 forKey:upgradeV1toV2.currentVersion];
        //
        //        //如果后续有数据库版本升级, 就从这里添加类似的结构
        //        BXGDatabaseAPIVersion *upgradeV2toV3 = [[BXGDatabaseAPIVersion alloc] initWithCurrentVersion:@"2.0"
        //                                                                              andTargetVersion:@"3.0"
        //                                                                                 andUpgradeSel:@selector(upgradeV2toV3:)];
        //        [dictVersionUpgrade setObject:upgradeV2toV3 forKey:upgradeV2toV3.currentVersion];
        
        _dictVersionUpgrade = [NSDictionary dictionaryWithDictionary:dictVersionUpgrade];
    }
    return _dictVersionUpgrade;
}

-(NSString*)lastestDBVersion {
    if(!_lastestDBVersion) {
        NSArray *allVersionKeys = [self.dictVersionUpgrade allKeys];
        if(allVersionKeys.count==0) {
            _lastestDBVersion = kInitialVersion;
        } else {
            NSArray *sortVersiontKeys = [allVersionKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return [(NSString*)obj1 compare:(NSString*)obj2];
            }];
            NSString *versionKey = sortVersiontKeys[sortVersiontKeys.count-1];
            NSAssert([self.dictVersionUpgrade objectForKey:versionKey], @"upgrade version not match");
            BXGDatabaseAPIVersion *dbVersion = self.dictVersionUpgrade[versionKey];
            _lastestDBVersion = dbVersion.targetVersion;
        }
    }
    return _lastestDBVersion;
}

-(BOOL)createDatabase
{
    NSString* dbPath = [[BXGDownloadResourceManager shareInstance] downloadDBPath];
    _db = [FMDatabase databaseWithPath:dbPath];
    BOOL bResult = [_db open];
    if(!bResult)
    {
        NSLog(@"fail to open database");
        return bResult;
    }
    
    bResult = [BXGDownloadTable createTable];
    if(!bResult)
    {
        NSLog(@"fail to create download table");
        return bResult;
    }
    
    [self upgradeDB];//升级DB
    return bResult;
}

-(BOOL)open
{
    BOOL bResult = [self createDatabase];
    //    BOOL bResult = [_db open];
    if(bResult)
    {
        NSLog(@"success to open the db");
        //[self upgradeDB];//升级DB
    }
    else
    {
        NSLog(@"fail to open the db, the code=%d, the reason=%@", [_db lastErrorCode], [_db lastErrorMessage]);
    }
    return bResult;
}

-(BOOL)close
{
    BOOL bResult = [_db close];
    if(bResult)
    {
        NSLog(@"success to close the db");
    }
    else
    {
        NSLog(@"fail to close the db, the code=%d, the reason=%@", [_db lastErrorCode], [_db lastErrorMessage]);
    }
    _db = nil;
    return bResult;
}

#pragma upgradeDB
- (void)upgradeDB {
    if(_isOverrideInstall) {
        [self migrateToLatestDB];
    } else {
        [self setDatabaseVersion:self.lastestDBVersion];
    }
}

- (BOOL)isExistDB {
    return [BXGFileManager fileIsExistOfPath:[BXGDownloadResourceManager shareInstance].downloadDBPath];
}

- (BOOL)isNeedUpgrade {
    if(![self isExistDB]) {
        return NO;
    }
    
    NSString *dbVersion = [self databaseVersion];
    if(!dbVersion) {
        dbVersion = kInitialVersion;
    }
    if([self.lastestDBVersion compare:dbVersion]>0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)migrateToLatestDB {
    NSString* currentDB = [self databaseVersion];
    BXGDatabaseAPIVersion *dbVersion = nil;
    if(!currentDB) {
        currentDB = kInitialVersion;
    }
    dbVersion = self.dictVersionUpgrade[currentDB];
    if(dbVersion && [self respondsToSelector:dbVersion.upgradeSEL]) {
        [self performSelectorOnMainThread:dbVersion.upgradeSEL withObject:dbVersion waitUntilDone:YES];
    }
    if([self isNeedUpgrade]) {
        [self migrateToLatestDB];
    }
}

#pragma mark DatabaseVersion todo
#define kDatabaseVersion @"DATABASE_VERSION"
-(NSString*)databaseVersion {
    return [[NSUserDefaults standardUserDefaults] valueForKey:kDatabaseVersion];
}

-(void)setDatabaseVersion:(NSString*)version {
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:kDatabaseVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)removeDatabaseVersion {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDatabaseVersion];
}


//-(BOOL)checkUpgradeCfg {
//    NSArray *allVersionKeys = [self.dictVersionUpgrade allKeys];
//    if(allVersionKeys.count==0) {
//        return YES;
//    }
//
//    NSArray *sortVersiontKeys = [allVersionKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        return [(NSString*)obj1 compare:(NSString*)obj2];
//    }];
//    if([sortVersiontKeys[sortVersiontKeys.count-1] isEqualToString:latest_db_Version] &&
//       [sortVersiontKeys[0] isEqualToString:kInitialVersion] &&
//       [latest_db_Version compare:kInitialVersion]>=0) {
//        return YES;
//    }
//    return NO;
//}




@end


