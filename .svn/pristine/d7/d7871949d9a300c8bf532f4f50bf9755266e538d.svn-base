//
//  BXGConstrueIntroduceModel.m
//  Boxuegu
//
//  Created by wurenying on 2018/1/11.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import "BXGConstrueIntroduceModel.h"

@implementation BXGConstrueIntroduceModel
- (NSDictionary<NSString *,id> *)dictionaryWithValuesForKeys:(NSArray<NSString *> *)keys {
    
    NSMutableArray * fittedKeys = [NSMutableArray new];
    NSArray *allkeys = keys;
    for(NSInteger i = 0; i < allkeys.count; i++) {
        
        id value = [self valueForKey:allkeys[i]];
        if(value && (value != [NSNull null])) {
            
            [fittedKeys addObject:allkeys[i]];
        }
    }
    
    if(fittedKeys.count > 0) {
        
        return [super dictionaryWithValuesForKeys:fittedKeys];
    }else {
        
        return [NSDictionary new];
    }
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return@{@"idx" : @"id",
            @"des" : @"description",
            @"isDelete": @"delete",
            };
}
@end
