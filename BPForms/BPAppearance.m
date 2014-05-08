//
//  BPAppearance.m
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


#import "BPAppearance.h"

@implementation BPAppearance

+(BPAppearance *)sharedInstance {
    static dispatch_once_t onceToken;
    static id instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (id)init {
    if (self = [super init]) {
        [self loadDefaults];
    }
    return self;
}

- (void)loadDefaults {
    self.tableViewBackGroundColor           = [UIColor whiteColor];
    
    self.inputCellBackgroundColor           = [UIColor whiteColor];
    self.inputCellTextFieldTextColor        = [UIColor blackColor];
    self.inputCellTextFieldBackgroundColor  = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.0f];
    self.inputCellTextFieldBorderColor      = [UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.0f];
    
    self.infoCellBackgroundColor            = [UIColor whiteColor];
    self.infoCellLabelTextColor             = [UIColor colorWithRed:0.25f green:0.25f blue:0.25f alpha:1.0f];
    self.infoCellLabelBackgroundColor       = [UIColor clearColor];
    
    self.buttonCellBackgroundColor          = [UIColor whiteColor];
    
    self.headerFooterLabelTextColor         = [UIColor darkGrayColor];
    
    self.inputCellTextFieldFont             = [UIFont systemFontOfSize:14.0f];
    self.inputCellTextFieldFloatingLabelFont= [UIFont systemFontOfSize: 8.0f];
    self.infoCellLabelFont                  = [UIFont systemFontOfSize:10.0f];
    self.headerFooterLabelFont              = [UIFont systemFontOfSize:12.0f];
    
    self.infoCellHeight = 16.0f;
    self.spaceBetweenCells = 8.0f;
}

@end
