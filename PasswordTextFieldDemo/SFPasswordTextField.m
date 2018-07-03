//
//  SFPasswordTextField.m
//  PasswordTextFieldDemo
//
//  Created by DBC on 2018/7/2.
//  Copyright © 2018年 DBC. All rights reserved.
//

#import "SFPasswordTextField.h"

@implementation SFPasswordTextField{
    NSMutableString *_innerText; // 输入的文本
    UIColor *_borderColor; // 边框颜色
    CGFloat _borderWidth; // 边框线条宽度
    CGFloat _downLineWidth; // 竖线的宽度
    
    BOOL _isSecureTextEntry; // 是否是安全输入模式
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self _init];
}

-(void)_init{
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:14];
    _innerText = [NSMutableString string];
    self.maxTextLength = 6;
    _borderColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    _borderWidth = 1;
    _downLineWidth = 0.5;
    self.secureTextEntry = NO;
}

-(NSString *)text{
    return _innerText;
}

-(void)setText:(NSString *)text{
    if (text == nil) {
        text = @"";
    }
    _innerText = [[NSMutableString alloc] initWithString:text];
}

- (BOOL)hasText{
    return _innerText.length>0;
}
- (void)insertText:(NSString *)text{
    if (text.length > 1) {
        return;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [self resignFirstResponder];
        return;
    }
    if (_innerText.length >= self.maxTextLength) {
        return;
    }
    [_innerText appendString:text];
    if (_innerText.length == self.maxTextLength) {
        [self resignFirstResponder];
    }
    [self setNeedsDisplay];
}
- (void)deleteBackward{
    if (_innerText.length == 0) {
        return;
    }
    
    NSRange range = NSMakeRange(_innerText.length - 1, 1);
    [_innerText deleteCharactersInRange:range];
    
    [self setNeedsDisplay];
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
}

- (BOOL)resignFirstResponder{
    if (self.isFirstResponder) {
        // textField did end edit
    }
    return [super resignFirstResponder];
}

- (BOOL)canResignFirstResponder{
    return YES;
}

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumbersAndPunctuation;
}
// 自动校验关闭
-(UITextAutocorrectionType)autocorrectionType{
    return UITextAutocorrectionTypeNo;
}

-(BOOL)isSecureTextEntry{
    return _isSecureTextEntry;
}

-(void)setSecureTextEntry:(BOOL)secureTextEntry{
    _isSecureTextEntry = secureTextEntry;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [self drawBorder:rect];
    
    [self drawDownLine:rect];
    
    if (self.isSecureTextEntry) {
        [self drawCircle:rect];
    } else {
        [self drawText:rect];
    }
    
}
// 画边框
-(void)drawBorder:(CGRect)rect{
    CGFloat cornerRadius = 5.0;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    // 画 框
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, _borderColor.CGColor);
    CGContextSetLineWidth(context, _borderWidth);
    
    // 上边
    CGFloat x = cornerRadius;
    CGFloat y = 0;
    CGContextMoveToPoint(context, x+_borderWidth/2.0, y+_borderWidth/2.0);
    
    x = width-cornerRadius;
    y = 0;
    CGContextAddLineToPoint(context, x-_borderWidth/2.0, y+_borderWidth/2.0);
    
    // 右上角圆弧
    CGFloat cpx = width-_borderWidth/2.0;
    CGFloat cpy = 0+_borderWidth/2.0;
    x = width;
    y = cornerRadius;
    CGContextAddQuadCurveToPoint(context, cpx, cpy, x-_borderWidth/2.0, y+_borderWidth/2.0);
    
    // 右边
    x = width;
    y = height-cornerRadius;
    CGContextAddLineToPoint(context, x-_borderWidth/2.0, y-_borderWidth/2.0);
    
    // 右下角圆弧
    cpx = width-_borderWidth/2.0;
    cpy = height-_borderWidth/2.0;
    x = width-cornerRadius;
    y = height;
    CGContextAddQuadCurveToPoint(context, cpx, cpy, x-_borderWidth/2.0, y-_borderWidth/2.0);
    
    // 下边
    x = cornerRadius;
    y = height;
    CGContextAddLineToPoint(context, x+_borderWidth/2.0, y-_borderWidth/2.0);
    
    // 左下圆角
    cpx = 0+_borderWidth/2.0;
    cpy = height-_borderWidth/2.0;
    x = 0;
    y = height-cornerRadius;
    CGContextAddQuadCurveToPoint(context, cpx, cpy, x+_borderWidth/2.0, y-_borderWidth/2.0);
    
    // 左边
    x = 0;
    y = cornerRadius;
    CGContextAddLineToPoint(context, x+_borderWidth/2.0, y+_borderWidth/2.0);
    
    // 左上角圆弧
    cpx = 0+_borderWidth/2.0;
    cpy = 0+_borderWidth/2.0;
    x = cornerRadius;
    y = 0;
    CGContextAddQuadCurveToPoint(context, cpx, cpy, x+_borderWidth/2.0, y+_borderWidth/2.0);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
}
// 画分隔线
-(void)drawDownLine:(CGRect)rect{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, _borderColor.CGColor);
    CGContextSetLineWidth(context, _downLineWidth);
    
    CGFloat contentWidth = width-_borderWidth*2 - _downLineWidth*(self.maxTextLength-1);
    CGFloat itemWidth = contentWidth/(self.maxTextLength*1.0);
    for (int i = 0; i < self.maxTextLength-1; i++) {
        CGFloat x = _borderWidth + (i+1)*itemWidth+i*_downLineWidth;
        CGFloat y = 0;
        CGContextMoveToPoint(context, x, y);
        
        y = height;
        CGContextAddLineToPoint(context, x, y);
        CGContextStrokePath(context);
    }
    
    CGContextRestoreGState(context);
}

-(void)drawCircle:(CGRect)rect{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, _textColor.CGColor);
    
    CGFloat contentWidth = width-_borderWidth*2 - _downLineWidth*(self.maxTextLength-1);
    CGFloat itemWidth = contentWidth/(self.maxTextLength*1.0);
    CGFloat radius = self.font.pointSize;
    CGFloat y = (height-radius)/2.0;
    for (int i = 0; i < _innerText.length; i++) {
        CGFloat x = _borderWidth + i*itemWidth+i*_downLineWidth+(itemWidth-radius)/2.0;
        
        CGRect circleRect = CGRectMake(x, y, radius, radius);
        CGContextFillEllipseInRect(context, circleRect);
    }
    
    CGContextRestoreGState(context);
}

-(void)drawText:(CGRect)rect{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, _textColor.CGColor);
    
    CGFloat contentWidth = width-_borderWidth*2 - _downLineWidth*(self.maxTextLength-1);
    CGFloat itemWidth = contentWidth/(self.maxTextLength*1.0);
    CGSize textSize = [self sizeForText];
    CGFloat y = (height-textSize.height)/2.0;
    for (int i = 0; i < _innerText.length; i++) {
        NSString *word = [_innerText substringWithRange:NSMakeRange(i, 1)];
        CGFloat x = _borderWidth + i*itemWidth+i*_downLineWidth+(itemWidth-textSize.width)/2.0;
        
        CGRect circleRect = CGRectMake(x, y, textSize.width, textSize.height);
        [word drawInRect:circleRect withAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.textColor}];
    }
    
    CGContextRestoreGState(context);
}

// 上下居中
-(CGSize)sizeForText{
    NSString *txt = @"O";
    CGSize size = [txt sizeWithAttributes:@{NSFontAttributeName:_font}];
    return size;
}


@end
