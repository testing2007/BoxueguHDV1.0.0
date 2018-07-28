//
//  TestDWViewController.m
//  Demo
//
//  Created by apple on 2018/6/29.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import "TestDWViewController.h"
#import "BXGDownloadAPI.h"
#import "BXGDownloadAPIModel.h"
//#import "BXGPersistDownloadAPIModel.h"

@interface TestDWViewController ()<BXGDownloadAPIDelegate>

@property (weak, nonatomic) IBOutlet UILabel *id1Label;
@property (weak, nonatomic) IBOutlet UILabel *id2Label;
@property (weak, nonatomic) IBOutlet UILabel *id3Label;
@property (weak, nonatomic) IBOutlet UILabel *id4Label;
@property (weak, nonatomic) IBOutlet UIButton *ct1Btn;
@property (weak, nonatomic) IBOutlet UIButton *ct2Btn;
@property (weak, nonatomic) IBOutlet UIButton *ct3Btn;
@property (weak, nonatomic) IBOutlet UIButton *ct4Btn;

@property (nonatomic, strong) BXGDownloadAPI *downloader;
@property (nonatomic, strong) NSArray *videoIds;

@property (nonatomic, strong) UIButton *button;
@end

@implementation TestDWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    _videoIds = @[@"84DA0323602FB8799C33DC5901307461",
//                          @"5CB9550BBCBAA86F9C33DC5901307461",
//                          @"44997A2026B5B04D9C33DC5901307461",
//                          @"2FF22C993D872B009C33DC5901307461"];
    self.videoIds = @[@"D01C970FEBE252BA9C33DC5901307461"];
    _id1Label.text = _videoIds[0];
//    _id2Label.text = _videoIds[1];
//    _id3Label.text = _videoIds[2];
//    _id4Label.text = _videoIds[3];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 100);
    [btn addTarget:self action:@selector(bt1OnPress:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    _button = btn;
    
    _downloader = [[BXGDownloadAPI alloc] init];
    [_downloader registerObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bt1OnPress:(id)sender {
    static bool bStart = true;
    if(bStart) {
        BXGDownloadAPIModel *item = [[BXGDownloadAPIModel alloc] initWithCourseId:@"courseId"
                                                                    andCourseName:@"courseName"
                                                                    andCourseType:1
                                                                andCourseImageUrl:@""
                                                                       andPhaseId:1
                                                                     andPhaseName:@""
                                                                     andPhaseSort:1
                                                                      andModuleId:1
                                                                    andModuleName:@""
                                                                    andModuleSort:1
                                                                     andSectionId:1
                                                                   andSectionName:@""
                                                                   andSectionSort:1
                                                                 andSectionIsPass:1
                                                                  andSectionIsTry:1
                                                                       andPointId:1
                                                                     andPointName:@""
                                                                     andPointSort:1
                                                                       andVideoId:1
                                                                     andCCVideoId:_videoIds[0] andIsWatched:false];
        
    [_downloader addDownloadItem:item];
//    [_downloader startAPI];
        bStart = NO;
        [_button setTitle:@"暂停" forState:UIControlStateNormal];
    } else {
        [_downloader allPauseDownload];
        [_button setTitle:@"开始" forState:UIControlStateNormal];
        bStart = YES;
    }
}
//
//- (IBAction)bt2OnPress:(id)sender {
//    BXGDownloadAPIModel *item = [[BXGDownloadAPIModel alloc] initWithCourseId:@"courseId2"
//                                                                  andCourseName:@"courseName"
//                                                                  andCourseType:@"courseType"
//                                                                     andPhaseId:@"phaseId"
//                                                                   andPhaseName:@"phaseName"
//                                                                   andPhaseSort:@"phaseSort"
//                                                                    andModuleId:@"moduleId"
//                                                                  andModuleName:@"moduleName"
//                                                                  andModuleSort:@"moudleSort"
//                                                                   andSectionId:@"sectionId"
//                                                                 andSectionName:@"sectionName"
//                                                                 andSectionSort:@"sectionSort"
//                                                               andSectionIsPass:@"sectionIsPass"
//                                                                andSectionIsTry:@"sectionIsTry"
//                                                                     andPointId:@"pointId"
//                                                                   andPointName:@"pointName"
//                                                                   andPointSort:@"pointSort"
//                                                                     andVideoId:@"videoId"
//                                                                   andCCVideoId:_videoIds[1]
//                                                                   andIsWatched:NO];
//    [_downloader addAPIDownloadItem:item];
//    [_downloader startAPI];
//}
//- (IBAction)bt3OnPress:(id)sender {
//    BXGDownloadAPIModel *item = [[BXGDownloadAPIModel alloc] initWithCourseId:@"courseId3"
//                                                                  andCourseName:@"courseName"
//                                                                  andCourseType:@"courseType"
//                                                                     andPhaseId:@"phaseId"
//                                                                   andPhaseName:@"phaseName"
//                                                                   andPhaseSort:@"phaseSort"
//                                                                    andModuleId:@"moduleId"
//                                                                  andModuleName:@"moduleName"
//                                                                  andModuleSort:@"moudleSort"
//                                                                   andSectionId:@"sectionId"
//                                                                 andSectionName:@"sectionName"
//                                                                 andSectionSort:@"sectionSort"
//                                                               andSectionIsPass:@"sectionIsPass"
//                                                                andSectionIsTry:@"sectionIsTry"
//                                                                     andPointId:@"pointId"
//                                                                   andPointName:@"pointName"
//                                                                   andPointSort:@"pointSort"
//                                                                     andVideoId:@"videoId"
//                                                                 andCCVideoId:_videoIds[2]
//                                                                 andIsWatched:NO];
//    [_downloader addAPIDownloadItem:item];
//    [_downloader startAPI];
//}
//- (IBAction)bt4OnPress:(id)sender {
//    BXGDownloadAPIModel *item = [[BXGDownloadAPIModel alloc] initWithCourseId:@"courseId4"
//                                                                andCourseName:@"courseName"
//                                                                  andCourseType:@"courseType"
//                                                                     andPhaseId:@"phaseId"
//                                                                   andPhaseName:@"phaseName"
//                                                                   andPhaseSort:@"phaseSort"
//                                                                    andModuleId:@"moduleId"
//                                                                  andModuleName:@"moduleName"
//                                                                  andModuleSort:@"moudleSort"
//                                                                   andSectionId:@"sectionId"
//                                                                 andSectionName:@"sectionName"
//                                                                 andSectionSort:@"sectionSort"
//                                                               andSectionIsPass:@"sectionIsPass"
//                                                                andSectionIsTry:@"sectionIsTry"
//                                                                     andPointId:@"pointId"
//                                                                   andPointName:@"pointName"
//                                                                   andPointSort:@"pointSort"
//                                                                     andVideoId:@"videoId"
//                                                                 andCCVideoId:_videoIds[3]
//                                                                 andIsWatched:NO];
//    [_downloader addAPIDownloadItem:item];
//    [_downloader startAPI];
//
//}

#pragma mark - BXGDownloadAPIDelegate
//-(void)downloadProgressForAPIPersisitDownloadItem:(BXGPersistDownloadAPIModel*)apiPersistDownloadItem {
//    NSString* customId = apiPersistDownloadItem.apiDownloaderItem.ccVideoId;
//    NSLog(@"testVC progress=%lf, videoId=%@", apiPersistDownloadItem.progress, customId);
//    if([customId isEqualToString:_videoIds[0]]) {
//        _id1Label.text = [NSString stringWithFormat:@"%f", apiPersistDownloadItem.progress];
//    } else if([customId isEqualToString:_videoIds[1]]) {
//        _id2Label.text = [NSString stringWithFormat:@"%f", apiPersistDownloadItem.progress];
//    } else if([customId isEqualToString:_videoIds[2]]) {
//        _id3Label.text = [NSString stringWithFormat:@"%f", apiPersistDownloadItem.progress];
//    } else if([customId isEqualToString:_videoIds[3]]) {
//        _id4Label.text = [NSString stringWithFormat:@"%f", apiPersistDownloadItem.progress];
//    }
//}
//
//-(void)downloadStateForAPIPersistDownloadItem:(BXGPersistDownloadAPIModel*)apiPersistDownloadItem andError:(NSError*)error {
//    NSLog(@"downloadStateForAPIPersistDownloadItem state=%ld, error=%@", apiPersistDownloadItem.downloadState, error.debugDescription);
//}
//
//-(void)requestDownloadURLFailForAPIPersistDownloadItem:(BXGPersistDownloadAPIModel*)apiPersistDownloadItem andErrorReason:(NSString*)errorReason {
//    NSLog(@"requestDownloadURLFailForAPIPersistDownloadItem ErrorReason=%@", errorReason);
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
