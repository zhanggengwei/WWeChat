//
//  AddressBookCell.h
//  WWeChat
//
//  Created by WzxJiang on 16/7/1.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserObject.h"
@interface AddressBookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avaterImgView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewWidthLayout;
@property(nonatomic, strong)UserObject * model;
@end
