//
//  ThridPartService.m
//  PopOn
//
//  Created by wordoor－z on 16/4/6.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ThridPartService.h"

#import <AVOSCloud/AVOSCloud.h>
@implementation ThridPartService

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] initNav];
        [[self class] initAVOS];
    });
}

+ (void)initAVOS {
    [AVOSCloud setApplicationId:@"YavVlGleImoT5XVkekX0kyGm-gzGzoHsz"
                      clientKey:@"nPIl7IkH9LtvsnUK7b8hxlS4"];
}

+ (void)initNav {
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:54/255.0 green:53/255.0 blue:58/255.0 alpha:1]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

@end
