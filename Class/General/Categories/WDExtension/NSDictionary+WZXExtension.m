//
//  NSDictionary+WDExtension.m
//  PopOn
//
//  Created by WzxJiang on 16/6/17.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import "NSDictionary+WZXExtension.h"

@implementation NSDictionary (WZXExtension)

- (NSString *)wzx_jsonString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:nil];
    return data ? [[NSString alloc] initWithData:data
                                        encoding:NSUTF8StringEncoding] : nil;
}

@end
