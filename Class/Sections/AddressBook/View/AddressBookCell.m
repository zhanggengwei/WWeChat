//
//  AddressBookCell.m
//  WWeChat
//
//  Created by WzxJiang on 16/7/1.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "AddressBookCell.h"

@implementation AddressBookCell

- (void)awakeFromNib {
    _imgViewWidthLayout.constant = ScaleWidth(45) - 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(UserObject *)model {
    [self.avaterImgView yy_setImageWithURL:[NSURL URLWithString:model.avaterUrl] placeholder:UIImageForKitBundle(@"default_avater")];
    self.nickNameLabel.text    = model.nickName;
}

@end
