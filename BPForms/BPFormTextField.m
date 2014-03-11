//
//  BPFormTextField.m
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


#import "BPFormTextField.h"
#import "BPFormInputCell.h"

@implementation BPFormTextField

- (CGRect)textRectForBounds:(CGRect)inBounds {
    return [self _adjustRectForBounds:inBounds];
}

- (CGRect)editingRectForBounds:(CGRect)inBounds {
    return [self _adjustRectForBounds:inBounds];
}

- (CGRect)_adjustRectForBounds:(CGRect)inBounds {
    CGRect frame = inBounds;
    // add a 5 pixel origin.x offset so that the text doesn't start right from the margin
    frame.origin.x = 5;
    frame.size.width -=5;
    // also, on iOS6 and earlier, the text starts right from the top, so add a similar 12 pixel vertical offset
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        frame.origin.y = 12;
    }
    inBounds = frame;
    return CGRectInset(inBounds, 0, 0);
}

- (BPFormInputCell *)containerTableViewCell {
    UIView *view = self;
    while ((view = view.superview)) {
        if ([view isKindOfClass:[BPFormCell class]]) {
            break;
        }
    }
    return (BPFormInputCell *)view;
}

@end
