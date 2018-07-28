//
//  BXGPlayerGradientView.m
//  Boxuegu
//
//  Created by RenyingWu on 2017/11/7.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "BXGPlayerGradientView.h"

@interface BXGPlayerGradientView()
@property (nonatomic, assign) BXGPlayerGradientViewType type;
@property (nonatomic, strong) CAGradientLayer *graditLayer;
@end

@implementation BXGPlayerGradientView

- (instancetype)initWithType:(BXGPlayerGradientViewType)type {
    self = [super initWithFrame:CGRectZero];
    if(self) {
        _type = type;
        _graditLayer = [CAGradientLayer layer];
        [self.layer addSublayer:_graditLayer];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)didMoveToSuperview {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (_type) {
        case BXGPlayerGradientViewTypeHeader:
            self.graditLayer.colors = @[(__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor,
                                        (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.38].CGColor,
                                        (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor];
            self.graditLayer.locations = @[@(0.0),@(0.82),@(0.96)];
            self.graditLayer.opacity = 0.5;
            break;
        case BXGPlayerGradientViewTypeFooter:
            self.graditLayer.colors = @[(__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor,
                                        (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.14].CGColor,
                                        (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor];
            
            
            
            self.graditLayer.locations = @[@(0.0),@(0.07),@(1)];
            self.graditLayer.opacity = 0.5;
            break;
    }
    
    
//opacity:0.3;
//    background-image:linear-gradient(-180deg, #000000 0%, rgba(0,0,0,0.38) 82%, rgba(0,0,0,0.00) 96%);
//width:750px;
//height:128px;
    
    
//opacity:0.4;
//    background-image:linear-gradient(-180deg, rgba(0,0,0,0.00) 0%, rgba(0,0,0,0.14) 7%, #000000 100%);
//width:750px;
//height:94px;
    
    

    
    
    
    self.graditLayer.startPoint = CGPointMake(0, 0);
    self.graditLayer.endPoint = CGPointMake(0, 1);
    self.graditLayer.frame = self.bounds;
}

@end
