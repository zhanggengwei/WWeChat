//
//  WZXAction.h
//  WZXSheet
//
//  Created by wordoor－z on 16/4/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXAction : UIButton
typedef NS_ENUM(NSInteger,WSheetType) {
    WSheetTypeDefault,
    WSheetTypeCancel
};
@property (nonatomic,assign)WSheetType type;

+ (WZXAction *)actionWithTitle:(NSString *)title type:(WSheetType)type handler:(void (^)(WZXAction * action))handler;
@end
