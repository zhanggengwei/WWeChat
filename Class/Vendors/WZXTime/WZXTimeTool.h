//
//  WZXTimeStampToTimeTool.h
//  WWeChat
//
//  Created by wordoor－z on 16/2/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZXTimeTool : NSObject

+ (NSDictionary *)timeStampToTimeStr:(NSTimeInterval)timeStamp
                               scale:(NSInteger)scale;

+ (NSDictionary *)locationTime;

+ (NSString *)compareWithTimeDic:(NSDictionary *)timeDic;

+ (NSString *)compareWithTime:(NSTimeInterval)time;
@end
