//
//  UITextField+BPForms.m
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

#import "UITextField+BPForms.h"
#import "BPFormInputCell.h"


@implementation UITextField (BPForms)

- (BPFormInputCell *)containerInputCell {
    UIView *view = self;
    while ((view = view.superview)) {
        if ([view isKindOfClass:[BPFormInputCell class]]) {
            break;
        }
    }
    return (BPFormInputCell *)view;
}

- (CGRect)addXOffset:(CGFloat)xOffset toBounds:(CGRect)inBounds {
    CGRect frame = inBounds;
    frame.origin.x = xOffset;
    
    // The xOffset should be removed twice from the width, in order to respect the right/left simmetry, along with the width of the clear button - 19 px, if displayed.
    CGFloat clearButtonWidth = (self.clearButtonMode != UITextFieldViewModeNever) ? 19.0f : 0.0f;
    frame.size.width -= 2 * xOffset + clearButtonWidth;
    
    CGFloat yOffset = 0.0f;
    // also, on iOS6 and earlier, the text starts right from the top, so add a similar 12 pixel vertical offset
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        yOffset = 12.0f;
    } else {
        yOffset = 8.0f;
    }
    
    frame.origin.y += yOffset;
    
    inBounds = frame;
    return CGRectInset(inBounds, 0, 0);
}

@end
