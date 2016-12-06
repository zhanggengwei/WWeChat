 //
//  BaseImgPickerViewController.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/30.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "BaseImgPickerViewController.h"

@interface BaseImgPickerViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation BaseImgPickerViewController {
    ImgPickerType _type;
}

- (instancetype)initWithType:(ImgPickerType)type {
    if (self = [super init]) {
        _type = type;
        [self setUp];
    }
    return self;
}

#pragma mark - 这里我遇到一个问题，在进入图片选择页面后，每次push都会导致delegate改变，但是在其它项目又不会出现，所以这么处理
//- (void)setDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate {
//    delegate = self;
//    [super setDelegate:delegate];
//}

- (void)setUp {
    self.delegate = self;
    self.allowsEditing = YES;
    if (_type == ImgPickerTypeCamera) {
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            NSLog(@"模拟器不能打开摄像头");
        }
    } else if (_type == ImgPickerTypeOnePhoto) {
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"选择");
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [picker dismissViewControllerAnimated:YES completion:^{
            if (_selectBlock) {
                _selectBlock(image);
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:^{
        if (_cancelBlock) {
            _cancelBlock();
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
