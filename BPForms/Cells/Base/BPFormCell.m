//
//  BPFormCell.m
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


#import "BPFormCell.h"
#import <Masonry.h>
#import "BPFormInfoCell.h"
#import "BPAppearance.h"


// static vars that hold image names, if those were set. Used to override the default images
static NSString *BPMandatoryImageName = nil;
static NSString *BPValidImageName = nil;
static NSString *BPInvalidImageName = nil;

@implementation BPFormCell

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
        // Initialization code
        self.mandatory = NO;
        self.shouldShowInfoCell = NO;
        self.shouldShowValidation = YES;
        self.validationState = BPFormValidationStateNone;
        self.spaceToNextCell = [BPAppearance sharedInstance].spaceBetweenCells;
        
        [self setupMandatoryImageView];
        [self setupValidationImageView];
        [self setupInfoCell];
    }
    return self;
}

- (CGFloat)cellHeight {
    CGFloat cellHeight = (self.customCellHeight ?: self.bounds.size.height) + self.spaceToNextCell;
    return cellHeight;
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
    
    [self.mandatoryImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(asterixImage.size.width));
        make.top.equalTo(@4);
        make.right.equalTo(self.mas_left).offset(4 + asterixImage.size.width).priorityLow();
        make.height.equalTo(@(asterixImage.size.height));
    }];
}

- (void)setupValidationImageView {
    if (self.shouldShowValidation) {
        self.validationImageView = [[UIImageView alloc] init];
        self.validationImageView.hidden = YES;
        [self.contentView addSubview:self.validationImageView];
    }
}

- (void)setupInfoCell {
    self.infoCell = [[BPFormInfoCell alloc] init];
}

- (void)refreshMandatoryState {
    self.mandatoryImageView.hidden = !self.mandatory;
}

- (void)updateAccordingToValidationState {
    if (!self.shouldShowValidation) {
        return;
    }
    
    static UIImage *checkmarkImage = nil;
    if (!checkmarkImage) {
        if (BPValidImageName.length) {
            checkmarkImage = [UIImage imageNamed:BPValidImageName];
        } else {
            checkmarkImage = [UIImage imageNamed:@"checkmark"];
        }
        
        [self.validationImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(checkmarkImage.size.width));
            make.left.equalTo(self.mas_right).with.offset(-checkmarkImage.size.width).priorityLow();
            make.centerY.equalTo(self.mas_centerY).priorityLow();
            make.height.equalTo(@(checkmarkImage.size.height));
        }];
    }
    
    static UIImage *exclamationMarkImage = nil;
    if (!exclamationMarkImage) {
        if (BPInvalidImageName.length) {
            exclamationMarkImage = [UIImage imageNamed:BPInvalidImageName];
        } else {
            exclamationMarkImage = [UIImage imageNamed:@"exclamationMark"];
        }
    }
    
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
