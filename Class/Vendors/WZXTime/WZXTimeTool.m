//
//  WZXTimeStampToTimeTool.m
//  WWeChat
//
//  Created by wordoor－z on 16/2/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WZXTimeTool.h"
@interface WZXTimeTool()

@property(nonatomic,copy)NSDateFormatter * formatter;

@end
@implementation WZXTimeTool

NSDateFormatter * StaticFormatter() {
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    return formatter;
}

+ (NSDictionary *)locationTime {
    NSDate *datenow = [NSDate date];
    return [self timeStrToTimeDic:[StaticFormatter() stringFromDate:datenow]];
}

+ (NSDictionary *)timeStampToTimeStr:(NSTimeInterval)timeStamp scale:(NSInteger)scale {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStamp/pow(10, scale)];
    return [self timeStrToTimeDic:[StaticFormatter() stringFromDate:confromTimesp]];
}

+ (NSDictionary *)timeStrToTimeDic:(NSString *)timeStr {
    NSMutableDictionary * muDic = [[NSMutableDictionary alloc]init];
    NSArray * arr = [timeStr componentsSeparatedByString:@"-"];
    [muDic setObject:arr[0] forKey:@"year"];
    [muDic setObject:arr[1] forKey:@"month"];
    [muDic setObject:arr[2] forKey:@"day"];
    [muDic setObject:arr[3] forKey:@"hour"];
    [muDic setObject:arr[4] forKey:@"minute"];
    [muDic setObject:arr[5] forKey:@"second"];
    return [muDic copy];
}

+ (NSString *)compareWithTimeDic:(NSDictionary *)timeDic {
    NSDictionary * nowDic = [self locationTime];
    NSString * timeStr = @"";
    
    if([timeDic[@"year"]integerValue] < [nowDic[@"year"] integerValue]){
        timeStr = [NSString stringWithFormat:@"%ld年前",[nowDic[@"year"] integerValue] - [timeDic[@"year"]integerValue]];
    }
    else if([timeDic[@"year"]integerValue] == [nowDic[@"year"] integerValue]) {
        if ([timeDic[@"month"]integerValue] < [nowDic[@"month"]integerValue]) {
            timeStr = [NSString stringWithFormat:@"%ld个月前",[nowDic[@"month"] integerValue] - [timeDic[@"month"]integerValue]];
        }
        else if([timeDic[@"month"]integerValue] == [nowDic[@"month"]integerValue]) {
            if([timeDic[@"day"]integerValue] < [nowDic[@"day"]integerValue]) {
                timeStr = [NSString stringWithFormat:@"%ld天前",[nowDic[@"day"] integerValue] - [timeDic[@"day"]integerValue]];
                if ([timeStr isEqualToString:@"一天前"]) {
                    timeStr = @"昨天";
                }
                if ([timeStr isEqualToString:@"两天前"]) {
                    timeStr = @"前天";
                }
            } else if([timeDic[@"day"]integerValue] == [nowDic[@"day"]integerValue]) {
               if([timeDic[@"hour"]integerValue] == [nowDic[@"hour"]integerValue]
                  &&
                  [timeDic[@"minute"]integerValue] == [nowDic[@"minute"]integerValue]
                  &&
                  [timeDic[@"second"]integerValue] == [nowDic[@"second"]integerValue]) {
                   timeStr = [NSString stringWithFormat:@"%@:%@",timeDic[@"hour"],timeDic[@"minute"]];
               } else {
                    timeStr = [NSString stringWithFormat:@"%@:%@",timeDic[@"hour"],timeDic[@"minute"]];
                }
            }
        }

    }
    return timeStr;
}

+ (NSString *)compareWithTime:(NSTimeInterval)time {
    return [self compareWithTimeDic:[self timeStampToTimeStr:time scale:3]];
}
@end
