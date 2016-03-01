//
//  DanMuChooseViewController.m
//  DanDanPlayForMac
//
//  Created by JimHuang on 16/2/2.
//  Copyright © 2016年 JimHuang. All rights reserved.
//

#import "DanMuChooseViewController.h"
#import "DanMuChooseViewModel.h"
#import "VideoInfoModel.h"
#import "DownLoadOtherDanmakuViewController.h"

@interface DanMuChooseViewController ()
@property (weak) IBOutlet NSPopUpButton *providerButton;
@property (weak) IBOutlet NSPopUpButton *shiBanBurron;
@property (weak) IBOutlet NSPopUpButton *episodeButton;
@property (strong, nonatomic) DanMuChooseViewModel *vm;

@end

@implementation DanMuChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear{
    [super viewDidAppear];
    [JHProgressHUD showWithMessage:kLoadMessage parentView: self.view];
    [self.vm refreshCompletionHandler:^(NSError *error) {
        [JHProgressHUD disMiss];
        [self reloadData];
    }];
}


- (instancetype)initWithVideoID:(NSString *)videoID{
    if ((self = kViewControllerWithId(@"DanMuChooseViewController"))) {
        self.vm = [[DanMuChooseViewModel alloc] initWithVideoID: videoID];
    }
    return self;
}
//点击确认 发送播放通知
- (IBAction)clickOKButton:(NSButton *)sender {
    if (!self.episodeButton.itemTitles.count) return;
    
    [JHProgressHUD showWithMessage:@"挖坟中..." parentView:self.view];
    [self.vm downThirdPartyDanMuWithIndex:[self.episodeButton indexOfSelectedItem] provider:[self.providerButton titleOfSelectedItem] completionHandler:^(id responseObj) {
        [JHProgressHUD disMiss];
        NSString *shiBanTitle = [self.shiBanBurron titleOfSelectedItem]?[self.shiBanBurron titleOfSelectedItem]:@"";
        NSString *episodeTitle = [self.episodeButton titleOfSelectedItem]?[self.episodeButton titleOfSelectedItem]:@"";
        //通知更新匹配名称
        [[NSNotificationCenter defaultCenter] postNotificationName:@"mathchVideo" object:self userInfo:@{@"animateTitle": [shiBanTitle stringByAppendingString: episodeTitle]}];
        //通知关闭列表视图控制器
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disMissViewController" object:self userInfo:nil];
        //通知开始播放
        [[NSNotificationCenter defaultCenter] postNotificationName:@"danMuChooseOver" object:self userInfo:responseObj];
    }];
}

- (IBAction)clickBackButton:(NSButton *)sender {
    [self dismissController: self];
}

- (IBAction)clickDownOtherDanmakuButton:(NSButton *)sender {
    NSArray *arr = self.vm.episodeTitleArr;
    if (arr.count) {
        [self presentViewControllerAsModalWindow:[[DownLoadOtherDanmakuViewController alloc] initWithVideos:arr danMuSource:[self.providerButton titleOfSelectedItem]]];
    }
}



- (IBAction)selectEpisode:(NSPopUpButton *)sender {
    [sender setTitle: [sender titleOfSelectedItem]];
}

- (IBAction)selectShiBan:(NSPopUpButton *)sender {
    NSInteger index = [sender indexOfSelectedItem];
    
    self.vm.episodeTitleArr = self.vm.shiBanArr[index].videos;
    [self reloadEpisodeButton];
    
    [sender setTitle: [sender titleOfSelectedItem]];
    [self.episodeButton setTitle: [self.episodeButton itemTitleAtIndex: 0]];
}

- (IBAction)selectProvider:(NSPopUpButton *)sender {
    NSInteger index = [sender indexOfSelectedItem];
    
    self.vm.shiBanArr = self.vm.contentDic[self.vm.providerArr[index]];
    self.vm.episodeTitleArr = self.vm.shiBanArr.firstObject.videos;
    [self reloadShiBanButton];
    [self reloadEpisodeButton];
    
    [sender setTitle: [sender titleOfSelectedItem]];
    [self.shiBanBurron setTitle: [self.shiBanBurron itemTitleAtIndex: 0]];
    [self.episodeButton setTitle: [self.episodeButton itemTitleAtIndex: 0]];
}

#pragma mark - 私有方法
- (void)reloadData{
    [self reloadShiBanButton];
    [self reloadEpisodeButton];
    [self reloadProviderButton];
}

- (void)reloadProviderButton{
    [self.providerButton removeAllItems];
    
    NSInteger supplierNum = [self.vm providerNum];
    for (int i = 0; i < supplierNum; ++i) {
        [self.providerButton addItemWithTitle: [self.vm providerNameWithIndex: i]];
    }
}

- (void)reloadShiBanButton{
    [self.shiBanBurron removeAllItems];
    
    NSInteger shiBanNum = [self.vm shiBanNum];
    for (int i = 0; i < shiBanNum; ++i) {
        [self.shiBanBurron addItemWithTitle: [self.vm shiBanTitleWithIndex: i]];
    }
}

- (void)reloadEpisodeButton{
    [self.episodeButton removeAllItems];
    
    NSInteger episodeNum = [self.vm episodeNum];
    
    for (int i = 0; i < episodeNum; ++i) {
        [self.episodeButton addItemWithTitle: [self.vm episodeTitleWithIndex: i]];
    }
}

@end