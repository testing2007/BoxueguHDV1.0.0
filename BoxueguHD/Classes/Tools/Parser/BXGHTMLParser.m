//
//  BXGHTMLParser.m
//  Boxuegu
//
//  Created by RenyingWu on 2017/12/15.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "BXGHTMLParser.h"
#import "TFHpple.h"

@implementation BXGHTMLParser

+ (NSArray *)parserToSectionExamCodeStringWithHTML:(NSString *)html {
    
    if(html == nil) {
        return nil;
    }
    
    
    NSData  * data      = [html dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray * elements  = [doc searchWithXPathQuery:@"//code"];
    
    NSMutableArray *codeArray = [NSMutableArray new];
    
    for (NSInteger i = 0; i < elements.count; i++) {
        TFHppleElement *element = elements[i];
        NSString *content = element.text;
        if(content.length > 0) {
            [codeArray addObject:content];
        }
    }
    return codeArray.copy;
    
    
    
//
//
//    NSRegularExpression *regularExpretion1 = [NSRegularExpression regularExpressionWithPattern:@"<pre>" options:0 error:nil];
//    NSRegularExpression *regularExpretion2 = [NSRegularExpression regularExpressionWithPattern:@"</pre>" options:0 error:nil];
//    id result1 = [regularExpretion1 matchesInString:html options:0 range:NSMakeRange(0, html.length)];
//    id result2 = [regularExpretion2 matchesInString:html options:0 range:NSMakeRange(0, html.length)];
//
//    NSMutableArray *codeList = [NSMutableArray new];
//    for (NSInteger i = 0; i < [result1 count]; i++) {
//        if(i >= [result2 count]) {
//            break;
//        }
//
//        NSRange range1 = [result1[i] range];
//        NSRange range2 = [result2[i] range];
//
//        NSRange contentRange = NSMakeRange(range1.location + range1.length, range2.location - (range1.location + range1.length));
//        NSString *content = [html substringWithRange:contentRange];
//        if(content.length > 0) {
//            [codeList addObject:content];
//        }
//    }
//
//    NSMutableArray<NSString *> *resultArray = [NSMutableArray new];
//
//    // step 2
//    for (NSInteger i = 0; i < codeList.count; i++) {
//        NSString *content = [BXGHTMLParser parserToHtmlContent:codeList[i]];
//        if(content.length > 0) {
//            [resultArray addObject:content];
//        }
//    }
//    return resultArray.copy;
}

// 取纯文本
//+ (NSString *)parserToSectionExamContentStringWithHTML:(NSString *)html {
//
//    html = [html stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    html = [html stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    if(html == nil) {
//        return nil;
//    }
//    return html;
//
//    NSData  * data      = [html dataUsingEncoding:NSUTF8StringEncoding];
//    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
//    NSArray * elements  = [doc searchWithXPathQuery:@"//p"];
//    NSString *content = @"";
//    for (NSInteger i = 0; i < elements.count; i++) {
//        TFHppleElement *element = elements[i];
//        NSString *fitString = [element.text trimWhitespaceAndNewLineCharacterSet];
//
//        if(element.text.length > 0 && fitString.length > 0) {
//            if(content.length > 0 && element.text.length) {
//                content = [NSString stringWithFormat:@"%@\n%@",content,element.text];
//            }else {
//                content = element.text;
//            }
//        }
//    }
//    return content;
//
//
//    html = [html stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//
//    NSString *resultString = @"";
//    NSRegularExpression *regularExpretion = [NSRegularExpression regularExpressionWithPattern:@"<p>([\\s]*.*)</p>" options:0 error:nil];
//
//    id result = [regularExpretion matchesInString:html options:0 range:NSMakeRange(0, html.length)];
//
//    // step 1
//    NSMutableArray *codeList = [NSMutableArray new];
//    for (NSInteger i = 0; i < [result count]; i++) {
//
//        NSString *str = [html substringWithRange:[result[i] range]];
//        [codeList addObject:str];
//    }
//
//    // step 2
//    for (NSInteger i = 0; i < codeList.count; i++) {
//        NSString *content = [BXGHTMLParser parserToHtmlContent:codeList[i]];
//        if(content.length > 0) {
//            resultString = [resultString stringByAppendingFormat:@"%@%@",resultString, content];
//        }
//    }
//    return resultString;


// 取内容

+ (NSString *)parserToHtmlContent:(NSString *)html {
    
    if(html == nil) {
        return nil;
    }
    html = [html stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSString *resultString = @"";
    NSRegularExpression *regularExpretion = [NSRegularExpression regularExpressionWithPattern:@"(>[^>^<]*<)" options:0 error:nil];
    id result = [regularExpretion matchesInString:html options:0 range:NSMakeRange(0, html.length)];
    NSMutableArray *codeList = [NSMutableArray new];
    for (NSInteger i = 0; i < [result count]; i++) {
        
        NSString *str = [html substringWithRange:[result[i] range]];
        if(str.length > 2) {
            str = [str substringWithRange:NSMakeRange(1,str.length - 2)];

            resultString = [NSString stringWithFormat:@"%@%@",resultString, str];;
        }
    }
    return resultString.copy;
}

+ (NSString *)parserToSectionExamContentStringWithHTML:(NSString *)html {
    
    if(html == nil) {
        return nil;
    }
    NSMutableArray *imageArray = [NSMutableArray new];
    NSRegularExpression *regularExpretion = [NSRegularExpression regularExpressionWithPattern:@"<img[^<]*/?>" options:0 error:nil];
    id result = [regularExpretion matchesInString:html options:0 range:NSMakeRange(0, html.length)];
    for (NSInteger i = 0; i < [result count]; i++) {
        
        NSString *str = [html substringWithRange:[result[i] range]];
        [imageArray addObject:str];
    }
    
    for (NSInteger i = 0; i < imageArray.count; i++) {
        html = [html stringByReplacingOccurrencesOfString:imageArray[i] withString:@""];
    }
    
    return html;
}
+ (NSArray *)parserToSectionExamImageURLWithHTML:(NSString *)html {

    if(html == nil) {
        return nil;
    }

    NSData  * data      = [html dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray * elements  = [doc searchWithXPathQuery:@"//img"];
    NSMutableArray *imageList = [NSMutableArray new];
    for (NSInteger i = 0; i < elements.count; i++) {
        TFHppleElement *element = elements[i];
        NSString *urlString = [elements[i] objectForKey:@"src"];
        if(urlString) {
            [imageList addObject:urlString];
        }
    }
    return imageList.copy;
}
//    html = [html stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//
//    NSRegularExpression *regularExpretion = [NSRegularExpression regularExpressionWithPattern:@"(<img[^>^<]*>)" options:0 error:nil];
//    id result = [regularExpretion matchesInString:html options:0 range:NSMakeRange(0, html.length)];
//
//    // step 1
//    NSMutableArray *resultList = [NSMutableArray new];
//    for (NSInteger i = 0; i < [result count]; i++) {
//
//        NSString *str = [html substringWithRange:[result[i] range]];
//        [resultList addObject:str];
//    }
//
//    // step 2
//    NSMutableArray *secondResultList = [NSMutableArray new];
//    for (NSInteger i = 0; i < resultList.count; i++) {
//
//        NSRegularExpression *regularExpretion = [NSRegularExpression regularExpressionWithPattern:@"(src[\\s]*=[\\s]*[\"\'][^\'^\"]*[\"\']{1})" options:0 error:nil];
//        id result = [regularExpretion matchesInString:resultList[i] options:0 range:NSMakeRange(0, [resultList[i] length])];
//
//        for (NSInteger j = 0; j < [result count]; j++) {
//            NSString *str = [resultList[i] substringWithRange:[result[j] range]];
//            [secondResultList addObject:str];
//        }
//    }
//
//    // step 3
//    NSMutableArray *thirdResultList = [NSMutableArray new];
//    for (NSInteger i = 0; i < secondResultList.count; i++) {
//
//        NSRegularExpression *regularExpretion = [NSRegularExpression regularExpressionWithPattern:@"([\'\"][^\'^\"]*[\'\"])" options:0 error:nil];
//        id result = [regularExpretion matchesInString:secondResultList[i] options:0 range:NSMakeRange(0, [secondResultList[i] length])];
//
//        for (NSInteger j = 0; j < [result count]; j++) {
//
//            NSString *str = [secondResultList[i] substringWithRange:[result[j] range]];
//            if(str.length > 2) {
//                str = [str substringWithRange:NSMakeRange(1,str.length - 2)];
//                [thirdResultList addObject:str];
//            }
//        }
//
//    }
//    return thirdResultList.copy;


//首先 代码题目
//(<pre>[^>^<]*<code[^>^<]*>.*</code>[^>^<]*</pre>)
//
//(>[^>^<]*<)
//
//是否是 code
//
//(<p>[^>^<]*</p>)
//
//(>[^>^<]*<) 去头去尾部 获得内容
//
//(<img[^>^<]*>)
//
//(src[\s]*=[\s]*["'][^'^"]*["']{1})
//
//(['"][^'^"]*['"]) 去头去尾部 获得url









+ (NSArray *)parserToArrayWithXML:(NSString *)xml {
    
    if(xml.length == 0){
        return nil;
    }
    NSMutableArray *resultArray = [NSMutableArray new];
    
    NSString *content = xml;
    
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"<" withString:@"_____<"];
    content = [content stringByReplacingOccurrencesOfString:@">" withString:@">_____"];
    
    NSArray<NSString *> *subContents = [content componentsSeparatedByString:@"_____"];
    
    for (NSInteger i = 0; i < subContents.count; i++) {
        NSString *subContent = subContents[i];
        
        // 忽略项
        if(subContent.length <= 0 || [subContent hasPrefix:@"</"]){
            continue;
        }
        
        // 判断是否是标签
        if([subContent hasPrefix:@"<"]) {
            NSMutableDictionary *dict = [NSMutableDictionary new];
            NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"([\\w])+\\s*=\\s*\"[^\"]*\"" options:0 error:nil];
            id result = [regularExpretion matchesInString:subContent options:0 range:NSMakeRange(0, subContent.length)];
            for (NSInteger i = 0; i < [result count]; i++) {
                
                
                NSString *str = [subContent substringWithRange:[result[i] range]];
                str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                NSRange range = [str localizedStandardRangeOfString:@"="];
                NSString *key = [str substringWithRange:NSMakeRange(0, range.location)];
                NSString *value = [str substringWithRange:NSMakeRange(range.location + 1, str.length - range.location - 1)];
                value = [value stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                if(key && value) {
                    dict[key] = value;
                }
            }
            [resultArray addObject:dict];
        }else {
            // 添加到 text
            [resultArray addObject:subContent];
        }
    }
    
    if(resultArray.count > 0){
        return resultArray;
    }else {
        return nil;
    }
}

+(NSString*)parserToLiveIdWithXML:(NSString *)xml {
    /*
     您的直播【ZZZZ】于2018-01-20 00:00开始~<a href="javascript:void(0)" live_id="50" onclick="on_click_msg('7acb38b454d04a66bea1a2e454d6bc2b','http://online-test.boxuegu.com/web/html/construe.html?id=50');">点击进入直播教室>></a>
     //*/
    
    // (live_id)\s*=\s*[\"\']\s*[0-9]*\s*[\"\']
    NSString *liveIdValue = nil;
    NSArray *arrAttribute = [self parserToArrayWithXML:xml];
    if(arrAttribute && arrAttribute.count>0) {
        for(id item in arrAttribute) {
            if([item isKindOfClass:[NSDictionary class]]) {
                liveIdValue = [item[@"live_id"] copy];
                break;
            }
        }
    }
    
    return liveIdValue;
}

@end
