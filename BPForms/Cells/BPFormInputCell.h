//
//  BPFormInputCell.h
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
#import "BPFormTextField.h"

@class BPFormInputCell;

typedef void (^TextFieldEditingBlock)   (BPFormInputCell *inCell, NSString *inText);
typedef BOOL (^TextFieldShouldEditBlock)(BPFormInputCell *inCell, NSString *inText);


typedef NS_ENUM(NSInteger, BPFormValidationState) {
    BPFormValidationStateInvalid = -1,
    BPFormValidationStateValid,
    BPFormValidationStateNone
};

/**
 *  Represents the main input cell for the form
 */
@interface BPFormInputCell : BPFormCell

// UI components
@property (nonatomic, strong) BPFormTextField   *textField;
@property (nonatomic, strong) UIImageView       *mandatoryImageView;
@property (nonatomic, strong) UIImageView       *validationImageView;

@property (nonatomic, assign) BPFormValidationState validationState;

// Blocks matching the UITextFieldDelegate methods
@property (nonatomic, copy) TextFieldEditingBlock    didBeginEditingBlock;  // Block called from `textFieldDidBeginEditing:`
@property (nonatomic, copy) TextFieldEditingBlock    didEndEditingBlock;    // Block called from `textFieldDidBeginEditing:`
@property (nonatomic, copy) TextFieldShouldEditBlock shouldChangeTextBlock; // Block called from `textfield:shouldChangeCharactersInRange:replacementString:`. Return YES if the text should change
@property (nonatomic, copy) TextFieldShouldEditBlock shouldReturnBlock;     // Block called from `textFieldShouldReturn:`. Return YES if the text should change

/**
 *  Will update the UI according to the validation state
 */
- (void)updateAccordingToValidationState;

/**
 *  Use to set a custom image as mandatory icon
 *
 *  @param inMandatoryImageName - the image name must point to a file in the main bundle
 */
+(void)setMandatoryImageName:(NSString *)inMandatoryImageName;

/**
 *  Use to set custom images as valid and invalid icons
 *
 *  @param inValidImageName   - the image name must point to a file in the main bundle
 *  @param inInvalidImageName - the image name must point to a file in the main bundle
 */
+(void)setValidImageName:(NSString *)inValidImageName invalidImageName:(NSString *)inInvalidImageName;

@end
