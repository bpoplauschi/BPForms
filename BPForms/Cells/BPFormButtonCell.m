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


@implementation BPFormButtonCell

- (id)initWithButtonHeight:(CGFloat)inButtonHeight {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (self) {
        [self setupCell];
        [self setupButtonWithHeight:inButtonHeight];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        [self setupButtonWithHeight:[BPAppearance sharedInstance].elementHeight];
    }
    return self;
}

- (void)setupCell {
    self.backgroundColor = [BPAppearance sharedInstance].buttonCellBackgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setupButtonWithHeight:(CGFloat)inHeight {
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor clearColor];
    [self.button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.button];
    
    self.button.frame = CGRectMake(round((self.frame.size.width - self.frame.origin.x - [BPAppearance sharedInstance].elementWidth) / 2), self.frame.origin.y, [BPAppearance sharedInstance].elementWidth, [BPAppearance sharedInstance].elementHeight);
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@([BPAppearance sharedInstance].elementWidth));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@([BPAppearance sharedInstance].elementHeight));
    }];
}

- (void)buttonPressed:(id)sender {
    if (self.buttonActionBlock) {
        self.buttonActionBlock();
    }
}

@end
