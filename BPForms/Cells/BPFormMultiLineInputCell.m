//
//  BPFormMultiLineInputCell.m
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


#import "BPFormMultiLineInputCell.h"
#import "BPFormInfoCell.h"
#import "BPAppearance.h"
#import <Masonry.h>
#import "BPFormTextView.h"

// static vars that hold image names, if those were set. Used to override the default images
static NSString *BPMandatoryImageName = nil;
static NSString *BPValidImageName = nil;
static NSString *BPInvalidImageName = nil;

@implementation BPFormMultiLineInputCell

+ (Class)textViewClass {
    return [BPFormTextView class];
}

+ (void)setMandatoryImageName:(NSString *)inMandatoryImageName {
    BPMandatoryImageName = inMandatoryImageName;
}

+ (void)setValidImageName:(NSString *)inValidImageName invalidImageName:(NSString *)inInvalidImageName {
    BPValidImageName = inValidImageName;
    BPInvalidImageName = inInvalidImageName;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        [self setupTextView];
        [self setupMandatoryImageView];
        [self setupValidationImageView];
        [self setupInfoCell];
    }
    return self;
}

- (void)setupCell {
    self.backgroundColor = [BPAppearance sharedInstance].inputCellBackgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.validationState = BPFormValidationStateNone;
}

- (void)setupTextView {
    Class textViewClass = [[self class] textViewClass];
    if (!textViewClass) {
        textViewClass = [BPFormTextView class];
    }
    
    self.textView = [[textViewClass alloc] init];
    
    self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textView.textColor = [BPAppearance sharedInstance].inputCellTextFieldTextColor;
    self.textView.font = [BPAppearance sharedInstance].inputCellTextFieldFont;
    self.textView.backgroundColor = [BPAppearance sharedInstance].inputCellTextFieldBackgroundColor;
    
    self.textView.layer.borderColor = [BPAppearance sharedInstance].inputCellTextFieldBorderColor.CGColor;
    self.textView.layer.borderWidth = 0.5;
    
    [self.contentView addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@([BPAppearance sharedInstance].elementWidth));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@([BPAppearance sharedInstance].elementHeight * 2));
    }];
}

- (void)setupMandatoryImageView {
    static UIImage *asterixImage = nil;
    if (!asterixImage) {
        if (BPMandatoryImageName.length) {
            asterixImage = [UIImage imageNamed:BPMandatoryImageName];
        } else {
            asterixImage = [UIImage imageNamed:@"asterix"];
        }
    }
    
    self.mandatoryImageView = [[UIImageView alloc] initWithImage:asterixImage];
    self.mandatoryImageView.hidden = YES;
    [self.contentView addSubview:self.mandatoryImageView];
    
    [self.mandatoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(asterixImage.size.width));
        make.right.equalTo(self.textView.mas_left).with.offset(-4);
        make.top.equalTo(@4);
        make.height.equalTo(@(asterixImage.size.height));
    }];
}

- (void)setupValidationImageView {
    self.validationImageView = [[UIImageView alloc] init];
    self.validationImageView.hidden = YES;
    [self.contentView addSubview:self.validationImageView];
}

- (void)setupInfoCell {
    self.infoCell = [[BPFormInfoCell alloc] init];
}

- (void)refreshMandatoryState {
    self.mandatoryImageView.hidden = !self.isMandatory;
}

- (void)updateAccordingToValidationState {
    static UIImage *checkmarkImage = nil;
    if (!checkmarkImage) {
        if (BPValidImageName.length) {
            checkmarkImage = [UIImage imageNamed:BPValidImageName];
        } else {
            checkmarkImage = [UIImage imageNamed:@"checkmark"];
        }
    }
    
    static UIImage *exclamationMarkImage = nil;
    if (!exclamationMarkImage) {
        if (BPInvalidImageName.length) {
            exclamationMarkImage = [UIImage imageNamed:BPInvalidImageName];
        } else {
            exclamationMarkImage = [UIImage imageNamed:@"exclamationMark"];
        }
    }
    
    [self.validationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(checkmarkImage.size.width));
        make.left.equalTo(self.textView.mas_right).with.offset(-checkmarkImage.size.width);
        make.centerY.equalTo(self.textView.mas_centerY);
        make.height.equalTo(@(checkmarkImage.size.height));
    }];
    
    switch (self.validationState) {
        case BPFormValidationStateValid:
            self.validationImageView.image = checkmarkImage;
            self.validationImageView.hidden = NO;
            break;
        case BPFormValidationStateInvalid:
            self.validationImageView.image = exclamationMarkImage;
            self.validationImageView.hidden = NO;
            break;
        case BPFormValidationStateNone:
            self.validationImageView.image = nil;
            self.validationImageView.hidden = YES;
            break;
    }
}

@end
