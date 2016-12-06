//
//  ChangeAvaterViewController.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/30.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "ChangeAvaterViewController.h"
#import "ChangeDataViewModel.h"
#import "WZXSheetView.h"
#import "BaseImgPickerViewController.h"
@interface ChangeAvaterViewController ()

@end

@implementation ChangeAvaterViewController {
    UIImageView   * _avaterView;
    ChangeDataViewModel * _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp {
    self.title = @"个人头像";
    self.view.backgroundColor = [UIColor blackColor];
    [self.avaterView yy_setImageWithURL:[NSURL URLWithString:[Statics currentUser].avaterUrl] placeholder:UIImageForKitBundle(@"default_avater")];
    [self addRightBtnWithImgName:UIImagePathForKitBundle(@"barbuttonicon_more") Action:@selector(showAlertView)];
}

#pragma mark -- 修改头像部分 --

- (void)showAlertView {
    WZXSheetView * sheet = [WZXSheetView sheetWithTitle:nil message:nil];
    @weakify(self)
    [sheet addAction:[WZXAction actionWithTitle:@"取消" type:WSheetTypeCancel handler:^(WZXAction *action) {
        NSLog(@"取消");
    }]];
    [sheet addAction:[WZXAction actionWithTitle:@"拍照" type:WSheetTypeDefault handler:^(WZXAction *action) {
        @strongify(self)
        [self toCamera];
    }]];
    [sheet addAction:[WZXAction actionWithTitle:@"从手机相册选择" type:WSheetTypeDefault handler:^(WZXAction *action) {
        @strongify(self)
        [self toPhoto];
    }]];
    [sheet addAction:[WZXAction actionWithTitle:@"保存图片" type:WSheetTypeDefault handler:^(WZXAction *action) {
        @strongify(self)
        [self toSave];
    }]];
    [sheet show];
}

- (void)toCamera {
    BaseImgPickerViewController * pickerVC = [[BaseImgPickerViewController alloc] initWithType:ImgPickerTypeCamera];
    [pickerVC setSelectBlock:^(UIImage * selectImg) {
        
    }];
    [pickerVC setCancelBlock:^{
        
    }];
    [self presentViewController:pickerVC animated:YES completion:nil];
}

- (void)toPhoto {
    BaseImgPickerViewController * pickerVC = [[BaseImgPickerViewController alloc] initWithType:ImgPickerTypeOnePhoto];
    [pickerVC setSelectBlock:^(UIImage * selectImg) {
        @weakify(self)
        NSData * imgData = UIImageJPEGRepresentation(selectImg, 0.5);
        [[self viewModel] changeAvater:imgData success:^(id response, NSInteger code) {
            @strongify(self)
            [WZXProgressTool showSuccess:nil Interaction:YES];
            self->_avaterView.image = selectImg;
        } failure:^(NSError *error) {
        }];
    }];
    [pickerVC setCancelBlock:^{
        
    }];
    [self presentViewController:pickerVC animated:YES completion:nil];
}

- (void)toSave {
    UIImageWriteToSavedPhotosAlbum(self.avaterView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [WZXProgressTool showSuccess:@"已保存" Interaction:YES];
    }
}


- (UIImageView *)avaterView {
    if (!_avaterView) {
        _avaterView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleWidth(130), self.view.frame.size.width, self.view.frame.size.width)];
        [self.view addSubview:_avaterView];
    }
    return _avaterView;
}

- (ChangeDataViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ChangeDataViewModel alloc]init];
    }
    return _viewModel;
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
