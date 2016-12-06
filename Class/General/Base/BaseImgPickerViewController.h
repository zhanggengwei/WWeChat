//
//  BaseImgPickerViewController.h
//  WWeChat
//
//  Created by WzxJiang on 16/6/30.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseImgPickerViewController : UIImagePickerController

typedef NS_ENUM(NSInteger, ImgPickerType) {
    ImgPickerTypeCamera,
    ImgPickerTypeOnePhoto,
    ImgPickerTypeMorePhoto
};

@property(nonatomic,copy)void(^selectBlock)(UIImage * selectImg);
@property(nonatomic,copy)void(^cancelBlock)();

- (instancetype)initWithType:(ImgPickerType)type;

@end
