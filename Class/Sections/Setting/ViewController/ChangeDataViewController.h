//
//  ChangeDataViewController.h
//  WWeChat
//
//  Created by wordoor－z on 16/2/15.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "RootViewController.h"
#import "BaseTextField.h"

@interface ChangeDataViewController : RootViewController

typedef NS_ENUM(NSInteger,ChangeType) {
    ChangeNickName,
    ChangeAddress,
    ChangeSex,
    ChangePath,
    ChangeSign
};
- (instancetype)initWithType:(ChangeType)type;

@end
