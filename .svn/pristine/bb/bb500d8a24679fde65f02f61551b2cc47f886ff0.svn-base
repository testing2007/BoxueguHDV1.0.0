//
//  BXGConstruePlanDayCell.m
//  Boxuegu
//
//  Created by wurenying on 2018/1/10.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import "BXGConstrueLiveCell.h"
//#import "BXGConstruePlanDayModel.h"
#import "BXGConstruePlanTagListView.h"
#import "BXGConstureOnAirImageView.h"

@interface BXGConstrueLiveCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) BXGConstureOnAirImageView *onAirTag;
@property (nonatomic, strong) UIButton *studyBtn;

@property (nonatomic, strong) UILabel *teacherLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *durantionLabel;
@property (nonatomic, strong) UIImageView *recommandImgV; // 推荐

@property (nonatomic, strong) UIView *watchedTagView;

@property (nonatomic, strong) NSArray<NSNumber *> *randomColorList;
@property (nonatomic, strong) BXGConstruePlanTagListView *tagListView;
//@property (nonatomic, strong) BXGConstruePlanDayModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation BXGConstrueLiveCell

- (UIView *)watchedTagView {
    
    if(_watchedTagView == nil) {
        
        _watchedTagView = [UIView new];
        UIView *bgView = [UIView new];
        [_watchedTagView addSubview:bgView];
        
        UIButton *titleBtn = [UIButton new];
        titleBtn.titleLabel.font = [UIFont PingFangSCRegularWithSize:12];
        [titleBtn setTitle:@"已参加" forState:UIControlStateNormal];
        [bgView addSubview:titleBtn];
        bgView.backgroundColor = [UIColor colorWithHex:0xff554c];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(0);
            make.left.offset(0);
            make.centerY.offset(0);
            make.height.equalTo(titleBtn);
        }];
        
        [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.right.offset(-5);
            make.centerY.offset(0);
            make.height.offset(15);
        }];
        [bgView layoutIfNeeded];
        bgView.layer.cornerRadius = 3;
        [_watchedTagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView.mas_left);
            make.right.equalTo(bgView.mas_right);
            make.bottom.equalTo(bgView.mas_bottom);
            make.top.equalTo(bgView.mas_top);
        }];
    }
    return _watchedTagView;
}

//- (void)setModel:(BXGConstruePlanDayModel *)model andIndexPath:(NSIndexPath *) indexPath {
//    _indexPath = indexPath;
//    self.model = model;
//}

//- (UITableViewCellSelectionStyle)selectionStyle {
//    return UITableViewCellSelectionStyleNone;
//}

- (BXGConstureOnAirImageView *)onAirTag {
    if(_onAirTag == nil) {
        _onAirTag = [BXGConstureOnAirImageView new];
    }
    return _onAirTag;
}

- (NSArray<NSNumber *> *)randomColorList {
    if(_randomColorList == nil) {
        
//        _randomColorList = @[@(0x56C688),@(0x52B0E8),@(0x7B879A),@(0xFFA455),@((0xFF7C7D))];
        _randomColorList = @[@(0x56C688),@(0x56C688),@(0x56C688),@(0x56C688),@((0x56C688))];
    }
    return _randomColorList;
}

- (UIImageView *)recommandImgV {
    
    if(_recommandImgV == nil) {
        
        _recommandImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"直播-推荐标签"]];
        _recommandImgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _recommandImgV;
}

- (void)setDataWithDuration:(NSNumber *)duration
                    teacher:(NSString *)teacher
                      onAir:(NSString *)onAir
                       name:(NSString *)name
                 isCallBack:(NSString *)isCallBack
                  recommend:(NSNumber *)recommend
                 construeId:(NSNumber *)construeId
                    endTime:(NSString *)endTime
                  startTime:(NSString *)startTime
                  subjectId:(NSNumber *)subjectId
                       desc:(NSString *)desc
                subjectName:(NSString *)subjectName
                     isJoin:(NSString *)isJoin
                  indexPath:(NSIndexPath *) indexPath {
    NSMutableArray<BXGConstruePlanTagModel *> *tagList = [NSMutableArray new];
    
    // 关闭正在直播标签
    [self.onAirTag hide];
    
    // 是否是推荐
    if(recommend.integerValue == 1){
        [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15 + 23 + 4);
        }];
        self.recommandImgV.hidden = false;
        self.watchedTagView.hidden = true;
        
    }else if([isJoin isEqualToString:@"Y"]){
        [self.watchedTagView layoutIfNeeded];
        CGFloat offset = self.watchedTagView.bounds.size.width;
        [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15 + offset + 4);
        }];
        self.watchedTagView.hidden = false;
        self.recommandImgV.hidden = true;
    }else {
        [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
        }];
        self.watchedTagView.hidden = true;
        self.recommandImgV.hidden = true;
    }
    
    // 学科标签
    
    if(subjectName.length > 0) {
        
        NSInteger index = 0;
        if(self.indexPath) {
            index = self.indexPath.row % self.randomColorList.count;
        }
        BXGConstruePlanTagModel *tagModel = [[BXGConstruePlanTagModel alloc] initWithTitle:subjectName andColor:[UIColor colorWithHex:self.randomColorList[index].intValue]];
        [tagList addObject:tagModel];
    }
    
    // 是否在直播
    if(onAir.length > 0 && [onAir isEqualToString:@"Y"]) {
        
        
        
        //        [self.onAirTag show];
        //        BXGConstruePlanTagModel *tagModel = [[BXGConstruePlanTagModel alloc] initWithTitle:@"进行中" andColor:[UIColor colorWithHex:0x999999]];
        BXGConstruePlanTagModel *tagModel = [[BXGConstruePlanTagModel alloc] initWithTitle:@"进行中" andColor:UIColor.themeColor];
        [tagList addObject:tagModel];
    }else {
        
        if([isCallBack isEqualToString:@"Y"]) {
            //
            //            BXGConstruePlanTagModel *tagModel = [[BXGConstruePlanTagModel alloc] initWithTitle:@"回放" andColor:[UIColor colorWithHex:0x999999]];
            //            [tagList addObject:tagModel];
            
            
            // 是否已参加
            //            _watchedTagView
            
            
        }else {
            //
            
            //            if(model.bxgIsReplay) {
            //                BXGConstruePlanTagModel *tagModel = [[BXGConstruePlanTagModel alloc] initWithTitle:@"已结束" andColor:[UIColor colorWithHex:0x999999]];
            //                [tagList addObject:tagModel];
            //            }else {
            //                BXGConstruePlanTagModel *tagModel = [[BXGConstruePlanTagModel alloc] initWithTitle:@"未开始" andColor:[UIColor colorWithHex:0x999999]];
            //                [tagList addObject:tagModel];
            //            }
            
            
        }
    }
    
    // 组合标签 (解决异常崩溃)
    self.tagListView.modelArray = nil;
    self.tagListView.modelArray = tagList;
    
    // 配置信息
    self.nameLabel.text = name;
    self.descLabel.text = desc;
    if(teacher.length > 0) {
        self.teacherLabel.text = [NSString stringWithFormat:@"导师: %@",teacher];
    }else {
        self.teacherLabel.text = teacher;
    }
    
    self.durantionLabel.text = [NSString stringWithFormat:@"%@分钟",duration];
    
    NSString *endTimeString = [endTime converDateStringFromFormat:@"yyyy-MM-dd HH:mm" toFormat:@"HH:mm"];
    NSString *startTimeString = [startTime converDateStringFromFormat:@"yyyy-MM-dd HH:mm" toFormat:@"HH:mm"];
    NSString *dateTime = [startTime converDateStringFromFormat:@"yyyy-MM-dd HH:mm" toFormat:@"MM月dd日"];
    NSString *time = [NSString stringWithFormat:@"%@-%@",startTimeString,endTimeString];
    self.timeLabel.text = time;
    self.dateLabel.text = dateTime;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame];
    if(self) {
        [self installUI];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self installUI];
    }
    return self;
}

- (BXGConstruePlanTagListView *)tagListView {
    if(_tagListView == nil) {
        
        _tagListView = [BXGConstruePlanTagListView new];
    }
    return _tagListView;
}

- (UILabel *)nameLabel {
    
    if(_nameLabel == nil) {
        
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont PingFangSCRegularWithSize:15];
        _nameLabel.textColor = [UIColor colorWithHex:0x333333];
    }
    return _nameLabel;
}

- (UILabel *)descLabel {
    
    if(_descLabel == nil) {
        
        _descLabel = [UILabel new];
        _descLabel.font = [UIFont PingFangSCRegularWithSize:12];
        _descLabel.textColor = [UIColor colorWithHex:0x999999];
        _descLabel.numberOfLines = 2;
    }
    return _descLabel;
}

- (UILabel *)teacherLabel {
    
    if(_teacherLabel == nil) {
        
        _teacherLabel = [UILabel new];
        _teacherLabel.font = [UIFont PingFangSCRegularWithSize:12];
        _teacherLabel.textColor = [UIColor colorWithHex:0x666666];
        _teacherLabel.text = @" ";
    }
    return _teacherLabel;
}

- (UILabel *)timeLabel {
    
    if(_timeLabel == nil) {
        
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont PingFangSCRegularWithSize:12];
        _timeLabel.textColor = [UIColor colorWithHex:0x999999];
    }
    return _timeLabel;
}

- (UILabel *)dateLabel {
    
    if(_dateLabel == nil) {
        
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont PingFangSCRegularWithSize:12];
        _dateLabel.textColor = [UIColor colorWithHex:0x999999];
    }
    return _dateLabel;
}

- (UILabel *)durantionLabel {
    
    if(_durantionLabel == nil) {
        
        _durantionLabel = [UILabel new];
        _durantionLabel.font = [UIFont PingFangSCRegularWithSize:12];
        _durantionLabel.textColor = [UIColor colorWithHex:0x999999];
    }
    return _durantionLabel;
}

- (UIButton *)studyBtn {
    
    if(_studyBtn == nil) {
        
        _studyBtn = [UIButton new];
        [_studyBtn setTitle:@"学习" forState:UIControlStateNormal];
        [_studyBtn setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
        _studyBtn.titleLabel.font = [UIFont PingFangSCRegularWithSize:13];
        _studyBtn.userInteractionEnabled = false;
        _studyBtn.layer.borderColor = [UIColor themeColor].CGColor;
        _studyBtn.layer.borderWidth = 1;
        _studyBtn.layer.cornerRadius = 18 * 0.5;
        _studyBtn.hidden = true;
    }
    return _studyBtn;
}

- (void)installUI {
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *nameLabel = self.nameLabel;
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(15);
    }];
    
    [self.contentView addSubview:self.recommandImgV];
    [self.recommandImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.offset(23);
        make.height.offset(15);
        make.centerY.equalTo(self.nameLabel);
    }];
    
    [self.contentView addSubview:self.watchedTagView];
    [self.watchedTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(self.nameLabel);
    }];
    
    
    UIButton *studyBtn = self.studyBtn;
    [self.contentView addSubview:studyBtn];
    [studyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(nameLabel.mas_centerY);
        make.width.offset(47);
        make.height.offset(18);
    }];
    
    [studyBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    BXGConstureOnAirImageView *onAirTag = self.onAirTag;
    [self.contentView addSubview:onAirTag];
    [onAirTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(5);
        make.centerY.equalTo(nameLabel);
        make.right.lessThanOrEqualTo(studyBtn.mas_left).offset(-15);
    }];
    
//    UIView *offsetView = [UIView new];
//    [self.contentView addSubview:offsetView];
//    [offsetView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(onAirTag).offset(0);
//        make.right.equalTo(studyBtn).offset(0);
//        make.centerY.equalTo(nameLabel);
//    }];
    
    
    [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
//    [offsetView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
//    [offsetView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    [onAirTag setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UILabel *descLabel = self.descLabel;
    [self.contentView addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.right.offset(-15);
    }];
    
    BXGConstruePlanTagListView *tagListView = self.tagListView;
    [self.contentView addSubview:tagListView];
    [tagListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(-15);
        make.top.equalTo(descLabel.mas_bottom).offset(10);
        make.height.offset(15);
        
    }];
    
    UILabel *teacherLabel = self.teacherLabel;
    
    [self.contentView addSubview:teacherLabel];
    [teacherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(tagListView.mas_bottom).offset(10);
        make.bottom.offset(-15);
    }];
    
    [teacherLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [teacherLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    UILabel *durantionLabel = self.durantionLabel;
    [self.contentView addSubview:durantionLabel];
    [durantionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(teacherLabel);
        make.right.offset(-15);
    }];
    [durantionLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UIView *spView = [UIView new];
    [self.contentView addSubview:spView];
    spView.backgroundColor = [UIColor colorWithHex:0x999999];
    [spView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(10);
        make.width.offset(1);
        make.right.equalTo(durantionLabel.mas_left).offset(-10);
        make.centerY.equalTo(teacherLabel);
    }];
    
    UILabel *dateLabel = self.dateLabel;
    
    UILabel *timeLabel = self.timeLabel;
    [self.contentView addSubview:timeLabel];
    
    [self.contentView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(teacherLabel);
        make.right.equalTo(timeLabel.mas_left).offset(-5);
        make.left.equalTo(teacherLabel.mas_right).offset(15);
    }];
    [dateLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateLabel);
        make.right.equalTo(spView.mas_left).offset(-10);
//        make.left.equalTo(dateLabel.mas_right).offset(5);
    }];
    [timeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UIView *bottomSpView = [UIView new];
    [self.contentView addSubview:bottomSpView];
    [bottomSpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(-0);
        make.bottom.offset(-1);
        make.height.offset(1);
    }];
    bottomSpView.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    
//    self add
    
    // title Label
    
    // onAir tag
    
    // study btn
    
    // des label
    
    // callback tag

    // subject tag
    
    // teadcher label
    
    // time label
    
    // durantion label
}


//id = 85,
//
//subjectId = 118,
//desc = 20171219大数据串讲课20171219大数据串讲课20171219大数据串讲课20171219大数据串讲课20171219大数据串讲课20171219大数据串讲课20171219大数据串讲课20,
//endTime = 2017-12-20 01:40,
//subjectName = 大数据,
//teacher = 王大上老师老师,转转,
//onAir = N,
//duration = 100,
//liveRoom = FA7EB7A1391D1CEF9C33DC5901307461,
//startTime = 2017-12-20 00:00,
//name = 20171219大数据串讲课





@end
