//
//  BXGHTMLParser.h
//  Boxuegu
//
//  Created by RenyingWu on 2017/12/15.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BXGHTMLParser : NSObject
+ (NSArray *)parserToArrayWithXML:(NSString *)xml;
+ (NSString*)parserToLiveIdWithXML:(NSString *)xml;

+ (NSArray *)parserToSectionExamCodeStringWithHTML:(NSString *)html;

// 取纯文本
+ (NSString *)parserToSectionExamContentStringWithHTML:(NSString *)html;

+ (NSArray *)parserToSectionExamImageURLWithHTML:(NSString *)html;
+ (NSString *)parserToHtmlContent:(NSString *)html;




@end
