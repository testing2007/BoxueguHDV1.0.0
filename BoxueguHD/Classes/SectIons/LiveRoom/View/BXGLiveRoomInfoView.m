//
//  BXGConstrueIntroduceView.m
//  Boxuegu
//
//  Created by Renying Wu on 2018/1/12.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import "BXGLiveRoomInfoView.h"
//#import "BXGConstrueIntroduceModel.h"

@interface BXGLiveRoomInfoView()

// UI
//@property (nonatomic, strong) UIView *titleTagView;
//@property (nonatomic, strong) UILabel *introduceTagLabel;
//@property (nonatomic, strong) UILabel *courseNameLabel;

@property (nonatomic, strong) UILabel *subjectNameTagLabel;
@property (nonatomic, strong) UILabel *subjectNameContentLabel;

@property (nonatomic, strong) UILabel *construeContentLabel;
@property (nonatomic, strong) UILabel *construeTagLabel;

@property (nonatomic, strong) UILabel *teacherContentLabel;
@property (nonatomic, strong) UILabel *teacherTagLabel;

@property (nonatomic, strong) UILabel *construeDurationLabel;
@property (nonatomic, strong) UILabel *construeDurationTagLabel;

@property (nonatomic, strong) UILabel *construeTimeLabel;
@property (nonatomic, strong) UILabel *construeTimeTagLabel;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation BXGLiveRoomInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        
        [self installUI];
        self.backgroundColor = [UIColor colorWithHex:0xeff3f5];
    }
    return self;
}

- (void)dealloc {
    
}


#pragma make - interface

- (void)setDataWithName:(NSString *)name
        subjectName:(NSString *)subjectName
               desc:(NSString *)desc
            teacher:(NSString *)teacher
           duration:(NSString *)duration
          startTime:(NSString *)startTime
            endTime:(NSString *)endTime  {

//    self.courseNameLabel.text = name;
    
    self.subjectNameContentLabel.text = name;
    self.construeContentLabel.text = desc;
//    self.construeContentLabel.text = @"内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容";
    self.teacherContentLabel.text = teacher;
    
    self.construeDurationLabel.text = [NSString stringWithFormat:@"%zd分钟",duration.integerValue];
    self.construeTimeLabel.text = [NSString stringWithFormat:@"%@\n%@",startTime,endTime];
}

#pragma mark - getter setter

- (UIScrollView *)scrollView {
    
    if(_scrollView == nil) {
        
        _scrollView = [UIScrollView new];
    }
    return _scrollView;
}

- (UIView *)contentView {
    
    if(_contentView == nil) {
        
        _contentView = [UIView new];
    }
    return _contentView;
}

//- (UIView *)titleTagView {
//
//    if(_titleTagView == nil) {
//
//        _titleTagView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2, 25)];
//        _titleTagView.backgroundColor = [UIColor themeColor];
//        _titleTagView.layer.cornerRadius = 1;
//    }
//    return _titleTagView;
//}

//- (UILabel *)introduceTagLabel {
//
//    if(_introduceTagLabel == nil) {
//
//        _introduceTagLabel = [UILabel new];
//        _introduceTagLabel.text = @"课程简介";
//        _introduceTagLabel.font = [UIFont PingFangSCRegularWithSize:15];
//        _introduceTagLabel.textColor = [UIColor colorWithHex:0x333333];
//    }
//    return _introduceTagLabel;
//}

//- (UILabel *)courseNameLabel {
//
//    if(_courseNameLabel == nil) {
//
//        _courseNameLabel = [UILabel new];
//        _courseNameLabel.font = [UIFont PingFangSCRegularWithSize:15];
//        _courseNameLabel.textColor = [UIColor colorWithHex:0x333333];
//        _courseNameLabel.text = @"";
//    }
//    return _courseNameLabel;
//}

- (UILabel *)subjectNameTagLabel {
    
    if(_subjectNameTagLabel == nil) {
        
        _subjectNameTagLabel = [UILabel new];
        _subjectNameTagLabel.font = [UIFont PingFangSCRegularWithSize:15];
        _subjectNameTagLabel.text = @"直播名称:";
        _subjectNameTagLabel.textColor = [UIColor colorWithHex:0x34495E];
        _subjectNameTagLabel.numberOfLines = 0;
        
//34495E;
//        font-family: PingFangSC-Regular;
//        font-size: 30px;
//    color: #;
//        line-height: 30px;
        
    }
    return _subjectNameTagLabel;
}

- (UILabel *)subjectNameContentLabel {
    
    if(_subjectNameContentLabel == nil) {
        
        _subjectNameContentLabel = [UILabel new];
        _subjectNameContentLabel.font = [UIFont PingFangSCRegularWithSize:15];
        _subjectNameContentLabel.textColor = [UIColor colorWithHex:0x34495E];
        _subjectNameContentLabel.numberOfLines = 0;
        _subjectNameContentLabel.text = @" ";
    }
    return _subjectNameContentLabel;

}

- (UILabel *)construeContentLabel {
    
    if(_construeContentLabel == nil) {
        
        _construeContentLabel = [UILabel new];
        _construeContentLabel.font = [UIFont PingFangSCRegularWithSize:15];
        _construeContentLabel.textColor = [UIColor colorWithHex:0x34495E];
        _construeContentLabel.numberOfLines = 0;
        _construeContentLabel.text = @"12321312321123123113123123131232131232112312311312312313";
    }
    return _construeContentLabel;
}

- (UILabel *)construeTagLabel {
    
    if(_construeTagLabel == nil) {
        
        _construeTagLabel = [UILabel new];
        _construeTagLabel.font = [UIFont PingFangSCRegularWithSize:15];
        _construeTagLabel.textColor = [UIColor colorWithHex:0x34495E];
        _construeTagLabel.text = @"直播内容:";
        _construeTagLabel.numberOfLines = 0;
    }
    return _construeTagLabel;
}

- (UILabel *)construeDurationLabel {
    
    if(_construeDurationLabel == nil) {
        
        _construeDurationLabel = [UILabel new];
        _construeDurationLabel.font = [UIFont PingFangSCRegularWithSize:15];
        _construeDurationLabel.textColor = [UIColor colorWithHex:0x34495E];
        _construeDurationLabel.numberOfLines = 0;
        _construeDurationLabel.text = @"1232131232112312311312312313";
    }
    return _construeDurationLabel;
}

- (UILabel *)construeDurationTagLabel {
    
    if(_construeDurationTagLabel == nil) {
        
        _construeDurationTagLabel = [UILabel new];
        _construeDurationTagLabel.font = [UIFont PingFangSCRegularWithSize:15];
        _construeDurationTagLabel.textColor = [UIColor colorWithHex:0x34495E];
        _construeDurationTagLabel.text = @"直播时长:";
        _construeDurationTagLabel.numberOfLines = 0;
    }
    return _construeDurationTagLabel;
}

- (UILabel *)construeTimeLabel {
    
    if(_construeTimeLabel == nil) {
        
        _construeTimeLabel = [UILabel new];
        _construeTimeLabel.font = [UIFont PingFangSCRegularWithSize:15];
        _construeTimeLabel.textColor = [UIColor colorWithHex:0x34495E];
        _construeTimeLabel.numberOfLines = 0;
        _construeTimeLabel.text = @"123213123211231231131231231312321312321123123113123123131232131232112312311312312313123213123211231231131231231312321312321123123113123123131232131232112312311312312313";
    }
    return _construeTimeLabel;
}

- (UILabel *)construeTimeTagLabel {
    
    if(_construeTimeTagLabel == nil) {
        
        _construeTimeTagLabel = [UILabel new];
        _construeTimeTagLabel.font = [UIFont PingFangSCRegularWithSize:15];
        _construeTimeTagLabel.textColor = [UIColor colorWithHex:0x34495E];
        _construeTimeTagLabel.text = @"直播时间:";
        _construeTimeTagLabel.numberOfLines = 0;
    }
    return _construeTimeTagLabel;
}

- (UILabel *)teacherContentLabel {
    
    if(_teacherContentLabel == nil) {
        
        _teacherContentLabel = [UILabel new];
        _teacherContentLabel.font = [UIFont PingFangSCRegularWithSize:15];
        _teacherContentLabel.textColor = [UIColor colorWithHex:0x34495E];
        _teacherContentLabel.numberOfLines = 0;
        _teacherContentLabel.text = @"123213123211231231131231231312321312321123123113123123131232131232112312311312312313123213123211231231131231231312321312321123123113123123131232131232112312311312312313123213123211231231131231231312321312321123123113123123131232131232112312311312312313123213123211231231131231231312321312321123123113123123131232131232112312311312312313";
    }
    return _teacherContentLabel;
}

- (UILabel *)teacherTagLabel {
    
    if(_teacherTagLabel == nil) {
        
        _teacherTagLabel = [UILabel new];
        _teacherTagLabel.font = [UIFont PingFangSCRegularWithSize:15];
        _teacherTagLabel.textColor = [UIColor colorWithHex:0x34495E];
        _teacherTagLabel.text = @"直播导师:";
        _teacherTagLabel.numberOfLines = 0;
        
    }
    return _teacherTagLabel;
}

#pragma mark - ui


#pragma mark -

- (void)installUI {
    
    // addsubview
    UIScrollView *scrollView = self.scrollView;
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.offset(0);
    }];
    
    UIView *contentView = self.contentView;
    [scrollView addSubview:contentView];
    
//    UIView *titleTagView = self.titleTagView;
//    [contentView addSubview:titleTagView];
//
//    UIView *introduceTagLabel = self.introduceTagLabel;
//    [contentView addSubview:introduceTagLabel];
//
//    UIView *courseNameLabel = self.courseNameLabel;
//    [contentView addSubview:courseNameLabel];
    
    UIView *subjectNameContentLabel = self.subjectNameContentLabel;
    [contentView addSubview:subjectNameContentLabel];
    
    UIView *subjectNameTagLabel = self.subjectNameTagLabel;
    [contentView addSubview:subjectNameTagLabel];
    [subjectNameTagLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [subjectNameTagLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UIView *construeTagLabel = self.construeTagLabel;
    [contentView addSubview:construeTagLabel];
    
    UIView *construeContentLabel = self.construeContentLabel;
    [contentView addSubview:construeContentLabel];
    [construeContentLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    UILabel *teacherTagLabel = self.teacherTagLabel;
    [contentView addSubview:teacherTagLabel];
    
    UILabel *teacherContentLabel = self.teacherContentLabel;
    [contentView addSubview:teacherContentLabel];
    [teacherContentLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    UILabel *construeDurationTagLabel = self.construeDurationTagLabel;
    [contentView addSubview:construeDurationTagLabel];
    
    UILabel *construeDurationLabel = self.construeDurationLabel;
    [contentView addSubview:construeDurationLabel];
    [construeDurationLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    
    UILabel *construeTimeTagLabel = self.construeTimeTagLabel;
    [contentView addSubview:construeTimeTagLabel];
    
    UILabel *construeTimeLabel = self.construeTimeLabel;
    [contentView addSubview:construeTimeLabel];
    [construeTimeLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    
    // layout
    
#define kContentAndTagXOffset 10
    
//    [titleTagView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [subjectNameTagLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//    [introduceTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(25);
//        make.left.equalTo(titleTagView.mas_right).offset(5);
//        make.right.offset(-25);
//
//    }];
//
//    [titleTagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(25);
//        make.centerY.equalTo(introduceTagLabel);
//        make.width.offset(2);
//        make.height.offset(25);
//
//    }];
    
//    [courseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(introduceTagLabel.mas_bottom).offset(25);
//        make.left.equalTo(titleTagView);
//        make.right.offset(-25);
//
//    }];
    
    // subjectName
    
    [subjectNameContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(courseNameLabel.mas_bottom).offset(10);
        make.top.offset(25);
        make.right.offset(-25);
        make.left.equalTo(subjectNameTagLabel.mas_right).offset(kContentAndTagXOffset);
        make.height.greaterThanOrEqualTo(subjectNameTagLabel);
    }];
    [subjectNameTagLabel sizeToFit];
    [subjectNameTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(titleTagView);
        make.left.offset(25);
//        make.top.equalTo(subjectNameContentLabel);
        make.top.offset(25);
        make.width.offset(subjectNameTagLabel.bounds.size.width);
    }];
    

    // construeContent
    [construeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subjectNameContentLabel.mas_bottom).offset(22);
        
        make.right.offset(-25);
        make.left.equalTo(subjectNameTagLabel.mas_right).offset(kContentAndTagXOffset);
        make.height.greaterThanOrEqualTo(construeTagLabel);
    }];
    
    [construeTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.top.equalTo(construeContentLabel);
    }];
    
    [construeTagLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    // teacher
    
    
    [teacherTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.top.equalTo(teacherContentLabel);
    }];
    
    [teacherContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(construeContentLabel.mas_bottom).offset(22);
        make.left.equalTo(subjectNameTagLabel.mas_right).offset(kContentAndTagXOffset);
        make.right.offset(-25);
        make.height.greaterThanOrEqualTo(teacherTagLabel);
    }];
    
    [teacherTagLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    // durantion
    
    
    [construeDurationTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.top.equalTo(construeDurationLabel);
    }];
    
    [construeDurationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(teacherContentLabel.mas_bottom).offset(22);
        make.left.equalTo(subjectNameTagLabel.mas_right).offset(kContentAndTagXOffset);
        make.right.offset(-25);
        make.height.greaterThanOrEqualTo(construeDurationTagLabel);
        make.bottom.offset(-25);
    }];
    
    [construeDurationTagLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    // time
    
    
    
//    [construeTimeTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(titleTagView);
//        make.top.equalTo(construeTimeLabel);
//    }];
//
//    [construeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(construeDurationLabel.mas_bottom).offset(10);
//        make.left.equalTo(subjectNameTagLabel.mas_right).offset(kContentAndTagXOffset);
//        make.right.offset(-25);
//        make.height.greaterThanOrEqualTo(construeTimeTagLabel);
//        make.bottom.offset(-25);
//    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.width.equalTo(scrollView);
        make.bottom.offset(0);
    }];
    
    [construeTimeTagLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}
@end
