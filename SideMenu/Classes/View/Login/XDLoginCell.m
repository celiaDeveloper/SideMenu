//
//  XDLoginCell.m
//  SideMenu
//
//  Created by Celia on 2017/6/21.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "XDLoginCell.h"

@implementation XDLoginCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.frame = CGRectMake(0, 0, mScreenWidth, 180*m6PScale);
    
}

//- (void)setTextField:(UITextField *)textField {
//    if (_textField != textField) {
//        _textField = textField;
//    }
//    _textField.borderStyle = UITextBorderStyleNone;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
