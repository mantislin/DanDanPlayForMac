//
//  ThirdPartySearchViewModel.m
//  DanDanPlayForMac
//
//  Created by JimHuang on 16/2/6.
//  Copyright © 2016年 JimHuang. All rights reserved.
//

#import "ThirdPartySearchViewModel.h"
#import "DanmakuNetManager.h"
#import "JHFloatDanmaku.h"
#import "JHScrollDanmaku.h"

@implementation ThirdPartySearchViewModel
- (NSInteger)shiBanArrCount{
    return 0;
}

- (NSInteger)infoArrCount{
    return 0;
}

- (NSString *)shiBanTitleForRow:(NSInteger)row {
    return nil;
}

- (NSString *)episodeTitleForRow:(NSInteger)row {
    return nil;
}

- (NSString *)seasonIDForRow:(NSInteger)row {
    return nil;
}

- (NSURL *)coverImg {
    return nil;
}

- (NSString *)shiBanTitle {
    return nil;
}

- (NSString *)shiBanDetail {
    return nil;
}

- (BOOL)isShiBanForRow:(NSInteger)row {
    return NO;
}

- (NSImage *)imageForRow:(NSInteger)row {
    return nil;
}

- (NSString *)aidForRow:(NSInteger)row {
    return nil;
}

- (NSArray <VideoInfoDataModel *>*)videoInfoDataModels {
    return nil;
}

- (void)refreshWithKeyWord:(NSString*)keyWord completionHandler:(void(^)(DanDanPlayErrorModel *error))complete {
    
}

- (void)refreshWithSeasonID:(NSString*)seasonId completionHandler:(void(^)(DanDanPlayErrorModel *error))complete {
    
}

- (void)downDanMuWithRow:(NSInteger)row completionHandler:(void(^)(id responseObj,DanDanPlayErrorModel *error))complete {
    
}

- (void)downThirdPartyDanmakuWithDanmakuID:(NSString *)danmakuID provider:(DanDanPlayDanmakuSource)provider completionHandler:(void(^)(NSDictionary *danmakuDic, DanDanPlayErrorModel *error))complete {
    if (!danmakuID.length){
        complete(nil, [DanDanPlayErrorModel errorWithCode:DanDanPlayErrorTypeDanmakuNoExist]);
        return;
    }
    [DanmakuNetManager downThirdPartyDanmakuWithDanmaku:danmakuID provider:provider completionHandler:^(NSDictionary *danmakuDic, DanDanPlayErrorModel *error) {
        if (danmakuDic.count == 0) {
            error = [DanDanPlayErrorModel errorWithCode:DanDanPlayErrorTypeNoMatchDanmaku];
        }
        complete(danmakuDic, error);
        
    }];
}

@end
