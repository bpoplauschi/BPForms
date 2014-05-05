//
//  BPFormInputTextFieldCell.m
//
//  Copyright (c) 2014 Bogdan Poplauschi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "BPFormInputTextFieldCell.h"
#import <Masonry.h>
#import "BPAppearance.h"


@implementation BPFormInputTextFieldCell

+ (Class)textInputClass {
    return [BPFormTextField class];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupTextField];
        
        [self.contentView bringSubviewToFront:self.validationImageView];
        
        [self.mandatoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.textField.mas_left).with.offset(-4).priorityHigh();
        }];
        
        [self.validationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textField.mas_right).priorityHigh();
            make.centerY.equalTo(self.textField.mas_centerY).priorityHigh();
        }];
    }
    return self;
}

- (void)setupTextField {
    Class textInputClass = [[self class] textInputClass];
    if (!textInputClass) {
        textInputClass = [BPFormTextField class];
    }
    
    self.textField = [[textInputClass alloc] init];
    
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.textColor = [BPAppearance sharedInstance].inputCellTextFieldTextColor;
    self.textField.font = [BPAppearance sharedInstance].inputCellTextFieldFont;
    self.textField.backgroundColor = [BPAppearance sharedInstance].inputCellTextFieldBackgroundColor;
    
    self.textField.layer.borderColor = [BPAppearance sharedInstance].inputCellTextFieldBorderColor.CGColor;
    self.textField.layer.borderWidth = 0.5;
    
    [self.contentView addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@([BPAppearance sharedInstance].elementWidth));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@([BPAppearance sharedInstance].elementHeight));
    }];
}

@end
