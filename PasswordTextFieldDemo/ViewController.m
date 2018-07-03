//
//  ViewController.m
//  PasswordTextFieldDemo
//
//  Created by DBC on 2018/7/2.
//  Copyright © 2018年 DBC. All rights reserved.
//

#import "ViewController.h"
#import "SFPasswordTextField.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SFPasswordTextField *textField;

@property (weak, nonatomic) IBOutlet UIView *testView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textField.secureTextEntry = YES;
    self.textField.textColor = [UIColor redColor];
    self.textField.font = [UIFont systemFontOfSize:18];
    
    [self.textField becomeFirstResponder];
}

@end
