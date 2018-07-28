//
//  BXGConstrueChatRightCell.m
//  Boxuegu
//
//  Created by wurenying on 2018/1/12.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import "BXGConstrueChatRightCell.h"

#import "BXGLiveManager.h"

@interface BXGConstrueChatRightCell()
@property (nonatomic, strong) UIImageView *iconImgV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *bubbleImgV;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation BXGConstrueChatRightCell

- (void)setModel:(BXGLiveDialogModel *)model {
    _model = model;
    if(model) {
        if(model.userAvatar.length > 0) {
            [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:model.userAvatar] placeholderImage:[UIImage imageNamed:@"live_room_chat_user_icon"]];
        }else {
            self.iconImgV.image = [UIImage imageNamed:@"live_room_chat_user_icon"];
        }
        self.nameLabel.text = model.userName;
        _timeLabel.text = model.time.description;
        
        
        NSRegularExpression *expression = [[NSRegularExpression alloc]initWithPattern:@"\\[em2_[0-9]{2}\\]" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray<NSTextCheckingResult *> *array= [expression matchesInString:model.content options:NSMatchingReportProgress range:NSMakeRange(0, model.content.length)];
        //
        if(model.content.length > 0) {
            NSMutableAttributedString *string = [NSMutableAttributedString new];
            [string appendAttributedString:[[NSAttributedString alloc]initWithString:model.content.copy]];
//            init[[NSAttributedString alloc]initWithString:];
            
             for (NSInteger i = array.count - 1; i >= 0; i--) {
                 NSString *subString = [model.content substringWithRange:array[i].range];
                 subString = [subString substringWithRange:NSMakeRange(5, 2)];
                 subString = [NSString stringWithFormat:@"live_chat_emoji_%@",subString];
                 NSTextAttachment *attachment = [NSTextAttachment new];
                 attachment.bounds = CGRectMake(0, 0, 20, 20);
                 attachment.image = [UIImage imageNamed:subString];
                 
//                 前后加空格
                 NSMutableAttributedString *mAttString = [NSMutableAttributedString new];
//                 [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:@" "]];
                 [mAttString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
                 [mAttString appendAttributedString:[[NSAttributedString alloc]initWithString:@" "]];
                 [string replaceCharactersInRange:array[i].range withAttributedString:mAttString];
             }
            self.contentLabel.attributedText = string;
        }
        
    }else {
        self.iconImgV.image = [UIImage imageNamed:@"live_room_chat_user_icon"];
        self.nameLabel.text = @" ";
        self.timeLabel.text = @" ";
        self.contentLabel.text = @" ";
    }
}

#pragma mark - ui

- (UIImageView *)iconImgV {
    
    if(_iconImgV == nil) {
        
        _iconImgV = [UIImageView new];
        _iconImgV.image = [UIImage imageNamed:@"live_room_chat_user_icon"];
    }
    return _iconImgV;
}

- (UILabel *)nameLabel {
    
    if(_nameLabel == nil) {
        
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont PingFangSCRegularWithSize:12];
        _nameLabel.textColor = [UIColor colorWithHex:666666];
        _nameLabel.text = @"我的名字";
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    
    if(_timeLabel == nil) {
        
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont PingFangSCRegularWithSize:12];
        _timeLabel.textColor = [UIColor colorWithHex:999999];
        _timeLabel.text = @"20:00";
    }
    return _timeLabel;
}

- (UIImageView *)bubbleImgV {
    
    if(_bubbleImgV == nil) {
        
        _bubbleImgV = [UIImageView new];
        _bubbleImgV.backgroundColor = UIColor.themeColor;
        _bubbleImgV.layer.cornerRadius = 7;
//        _bubbleImgV.image = [UIImage imageNamed:@"live_room_chat_bubble_blue"];
    }
    return _bubbleImgV;
}

- (UILabel *)contentLabel {
    
    if(_contentLabel  == nil) {
        
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont PingFangSCRegularWithSize:15];
        _contentLabel.textColor = [UIColor colorWithHex:0xffffff];
        _contentLabel.text = @"";
    }
    return _contentLabel;
}

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
        [self installUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self installUI];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        [self installUI];
    }
    return self;
}

#define kBXGConstrueChatLeftCell_TopMargin 10
#define kBXGConstrueChatLeftCell_LeftMargin 15
#define kBXGConstrueChatLeftCell_RightMargin 15

- (void)installUI {
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *iconImgV = self.iconImgV;
    UILabel *nameLabel = self.nameLabel;
    UILabel *timeLabel = self.timeLabel;
    UIImageView *bubbleImgV = self.bubbleImgV;
    UILabel *contentLabel = self.contentLabel;
    
    [self.contentView addSubview:iconImgV];
    [self.contentView addSubview:nameLabel];
    [self.contentView addSubview:timeLabel];
    [self.contentView addSubview:bubbleImgV];
    [self.contentView addSubview:contentLabel];
    
    [iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kBXGConstrueChatLeftCell_RightMargin);
        make.top.offset(kBXGConstrueChatLeftCell_TopMargin);
        make.width.height.offset(33);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImgV).offset(-4);
        make.right.equalTo(iconImgV.mas_left).offset(-10);
    }];
    
    [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel);
        make.right.equalTo(nameLabel.mas_left).offset(-10);
        make.left.offset(kBXGConstrueChatLeftCell_RightMargin);
    }];
    timeLabel.textAlignment = NSTextAlignmentRight;
    
    [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [bubbleImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nameLabel.mas_right).offset(5);
        make.bottom.lessThanOrEqualTo(@100);
        make.left.greaterThanOrEqualTo(self.contentView).offset(42);
        make.top.equalTo(nameLabel.mas_bottom).offset(2);
        make.bottom.offset(-15);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bubbleImgV.mas_right).offset(-10);
//        make.right.equalTo(bubbleImgV.mas_right).offset(-10 - 15);
        make.left.equalTo(bubbleImgV.mas_left).offset(10);
        make.top.equalTo(bubbleImgV.mas_top).offset(10);
        make.bottom.equalTo(bubbleImgV.mas_bottom).offset(-10);
    }];
}

@end
