//
//  BPFormMultiLineInputCell.h
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

@class BPFormMultiLineInputCell;

typedef void (^TextViewEditingBlock)   (BPFormMultiLineInputCell *inCell, NSString *inText);
typedef BOOL (^TextViewShouldEditBlock)(BPFormMultiLineInputCell *inCell, NSString *inText);


@interface BPFormMultiLineInputCell : BPFormCell

// UI components
@property (nonatomic, strong) UITextView        *textView;
@property (nonatomic, strong) UIImageView       *mandatoryImageView;
@property (nonatomic, strong) UIImageView       *validationImageView;

@property (nonatomic, assign) BPFormValidationState validationState;

// Blocks matching the UITextFieldDelegate methods
@property (nonatomic, copy) TextViewEditingBlock    didBeginEditingBlock;  // Block called from `textViewDidBeginEditing:`
@property (nonatomic, copy) TextViewEditingBlock    didEndEditingBlock;    // Block called from `textViewDidEndEditing:`
@property (nonatomic, copy) TextViewShouldEditBlock shouldChangeTextBlock; // Block called from `textview:shouldChangeCharactersInRange:replacementString:`. Return YES if the text should change

/**
 *  By default BPFormMultiLineInputCell uses the BPFormTextView class for text fields. This can be customized by providing a different class
 */
+ (Class)textViewClass;

/**
 *  Will update the UI according to the validation state
 */
- (void)updateAccordingToValidationState;

/**
 *  Use to set a custom image as mandatory icon
 *
 *  @param inMandatoryImageName - the image name must point to a file in the main bundle
 */
+ (void)setMandatoryImageName:(NSString *)inMandatoryImageName;

/**
 *  Use to set custom images as valid and invalid icons
 *
 *  @param inValidImageName   - the image name must point to a file in the main bundle
 *  @param inInvalidImageName - the image name must point to a file in the main bundle
 */
+ (void)setValidImageName:(NSString *)inValidImageName invalidImageName:(NSString *)inInvalidImageName;

@end
