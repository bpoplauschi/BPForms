//
//  BPFormInfoCell.m
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


#import "BPFormInfoCell.h"
#import <Masonry.h>
#import "BPAppearance.h"


@implementation BPFormInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupCell];
        [self setupLabel];
    }
    return self;
}

- (void)setupCell {
    self.customCellHeight = [BPAppearance sharedInstance].infoCellHeight;
    self.backgroundColor = [BPAppearance sharedInstance].infoCellBackgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setupLabel {
    self.label = [[UILabel alloc] init];
    
    self.label.textColor = [BPAppearance sharedInstance].infoCellLabelTextColor;
    self.label.font = [BPAppearance sharedInstance].infoCellLabelFont;
    self.label.backgroundColor = [BPAppearance sharedInstance].infoCellLabelBackgroundColor;
    self.label.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:self.label];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).offset(-30);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@10);
    }];
}

- (CGFloat)cellHeight {
    if (self.customCellHeight) {
        return self.customCellHeight;
    }
    return self.bounds.size.height;
}

@end
