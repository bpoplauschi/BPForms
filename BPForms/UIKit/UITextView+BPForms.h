//
//  UITextView+BPForms.h
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

@class BPFormInputCell;


@interface UITextView (BPForms)

/**
 *  Retrieve the input cell containing the current text field
 *
 *  @return the instance of the BPFormInputCell or nil
 */
- (BPFormInputCell *)containerInputCell;

/**
 *  Adds an X offset to bounds. Used by `textRectForBounds` and `editingRectForBounds` methods.
 *  The purpose is to avoid text values starting right from the edge.
 *
 *  @param xOffset  x offset in pixels
 *  @param inBounds the input bounds
 *
 *  @return the output bounds
 */
- (CGRect)addXOffset:(CGFloat)xOffset toBounds:(CGRect)inBounds;


@end
