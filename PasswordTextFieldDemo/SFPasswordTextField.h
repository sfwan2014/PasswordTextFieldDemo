//
//  SFPasswordTextField.h
//  PasswordTextFieldDemo
//
//  Created by DBC on 2018/7/2.
//  Copyright © 2018年 DBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFPasswordTextField : UIView <UIKeyInput>

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, assign) NSInteger maxTextLength; // 输入的最多内容
@end

