//
//  BPFormButtonCell.m
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


#import "BPFormButtonCell.h"
#import "BPAppearance.h"
#import <Masonry.h>


@interface BPFormButtonCell ()

@property (nonatomic, strong) MASConstraint *widthConstraint;
@property (nonatomic, strong) MASConstraint *heightConstraint;

@end


@implementation BPFormButtonCell

// auto-synthesize doesn't work here since the properties are defined in a base class (BPFormCell)
@synthesize spaceToNextCell = _spaceToNextCell;
@synthesize customContentHeight = _customContentHeight;
@synthesize customContentWidth = _customContentWidth;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        [self setupButton];
    }
    return self;
}

- (void)setupCell {
    self.backgroundColor = [BPAppearance sharedInstance].buttonCellBackgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setupButton {
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor clearColor];
    [self.button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.button];
    
    // need to set the frame, otherwise there are cases where, even if the constraints are fine, the frame remains zero-rect
    self.button.frame = CGRectMake(roundf(30.0f / 2.0f), self.frame.origin.y, self.frame.size.width - 30.0f, self.frame.size.height - self.spaceToNextCell);
    
    [self.widthConstraint uninstall];
    [self.heightConstraint uninstall];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        self.widthConstraint = make.width.equalTo(self.mas_width).offset(-30);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        self.heightConstraint = make.height.equalTo(self.mas_height).offset(-self.spaceToNextCell);
    }];
}

- (void)buttonPressed:(id)sender {
    if (self.buttonActionBlock) {
        self.buttonActionBlock();
    }
}

- (void)setSpaceToNextCell:(CGFloat)inSpaceToNextCell {
    if (inSpaceToNextCell != _spaceToNextCell) {
        _spaceToNextCell = inSpaceToNextCell;
        
        if (self.customContentHeight == 0) {
            
            [self.heightConstraint uninstall];
            [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
                self.heightConstraint = make.height.equalTo(self.mas_height).offset(-inSpaceToNextCell);
            }];
        }
    }
}

- (void)setCustomContentHeight:(CGFloat)inCustomContentHeight {
    if (inCustomContentHeight != _customContentHeight) {
        _customContentHeight = inCustomContentHeight;
        
        [self.heightConstraint uninstall];
        [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
            self.heightConstraint = make.height.equalTo(@(inCustomContentHeight));
        }];
    }
}

- (void)setCustomContentWidth:(CGFloat)inCustomContentWidth {
    if (inCustomContentWidth != _customContentWidth) {
        _customContentWidth = inCustomContentWidth;
        
        [self.widthConstraint uninstall];
        [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
            self.widthConstraint = make.width.equalTo(@(inCustomContentWidth));
        }];
    }
}

@end
