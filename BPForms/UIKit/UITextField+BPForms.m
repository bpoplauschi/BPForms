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
    frame.size.width -= xOffset;
    
    // also, on iOS6 and earlier, the text starts right from the top, so add a similar 12 pixel vertical offset
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        frame.origin.y += 12;
    }
    
    inBounds = frame;
    return CGRectInset(inBounds, 0, 0);
}

@end
