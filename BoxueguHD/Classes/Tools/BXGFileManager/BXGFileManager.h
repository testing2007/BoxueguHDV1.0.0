//
//  RWFileManager.h
//  testFileManager
//
//  Created by Renying Wu on 2018/5/4.
//  Copyright © 2018年 RenyingWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BXGFileManager : NSObject
//获取Document路径
+ (NSString *)getDocumentPath;

//获取Library路径
+ (NSString *)getLibraryPath;

//获取应用程序路径
+ (NSString *)getApplicationPath;

//获取Cache路径
+ (NSString *)getCachePath;

//获取Temp路径
+ (NSString *)getTempPath;

//判断文件是否存在于某个路径中
+ (BOOL)fileIsExistOfPath:(NSString *)filePath;

//从某个路径中移除文件
+ (BOOL)removeFileOfPath:(NSString *)filePath;

//从URL路径中移除文件
- (BOOL)removeFileOfURL:(NSURL *)fileURL;

//创建文件路径
+(BOOL)creatDirectoryWithPath:(NSString *)dirPath;

//创建文件
+ (BOOL)creatFileWithPath:(NSString *)filePath;

//保存文件
+ (BOOL)saveFile:(NSString *)filePath withData:(NSData *)data;

//追加写文件
+ (BOOL)appendData:(NSData *)data withPath:(NSString *)path;

//获取文件
+ (NSData *)getFileData:(NSString *)filePath;

//读取文件
+ (NSData *)getFileData:(NSString *)filePath startIndex:(long long)startIndex length:(NSInteger)length;

//移动文件
+ (BOOL)moveFileFromPath:(NSString *)fromPath toPath:(NSString *)toPath;

//拷贝文件
+(BOOL)copyFileFromPath:(NSString *)fromPath toPath:(NSString *)toPath;

//获取文件夹下文件列表
+ (NSArray *)getFileListInFolderWithPath:(NSString *)path;

//获取文件大小
+ (long long)getFileSizeWithPath:(NSString *)path;

//获取文件创建时间
+ (NSString *)getFileCreatDateWithPath:(NSString *)path;

//获取文件所有者
+ (NSString *)getFileOwnerWithPath:(NSString *)path;

//获取文件更改日期
+ (NSString *)getFileChangeDateWithPath:(NSString *)path;
@end
