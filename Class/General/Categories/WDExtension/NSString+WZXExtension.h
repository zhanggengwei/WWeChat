//
//  NSString+WDExtension.h
//  PopOn
//
//  Created by WzxJiang on 16/6/17.
//  Copyright © 2016年 wordoor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (WZXExtension)

- (CGFloat)wzx_stringHeightWithFont:(UIFont *)font width:(CGFloat)width;

- (CGSize)wzx_stringSizeWithFont:(UIFont *)font;

- (NSString *)wzx_MD5String;

- (NSString *)wzx_SHA1String;

- (NSUInteger)wzx_getBytesLength;

- (NSString *)wzx_stringByDeletingPictureResolution;

@end
