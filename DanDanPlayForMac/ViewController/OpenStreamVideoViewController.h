//
//  OpenStreamVideoViewController.h
//  DanDanPlayForMac
//
//  Created by JimHuang on 16/3/5.
//  Copyright © 2016年 JimHuang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OpenStreamVideoViewController : NSViewController
- (instancetype)initWithURL:(NSString *)URL danmakuSource:(DanDanPlayDanmakuSource)danmakuSource;
@end
