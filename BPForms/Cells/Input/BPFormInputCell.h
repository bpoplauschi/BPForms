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

/**
 *  Input cell block called on edit
 *
 *  @param inCell the cell
 *  @param inText the new text value
 */
typedef void (^BPFormInputCellEditingBlock)   (BPFormInputCell *inCell, NSString *inText);

/**
 *  Input cell block called on should edit
 *
 *  @param inCell the cell
 *  @param inText the new text value
 *
 *  @return YES if we should edit
 */
typedef BOOL (^BPFormInputCellShouldEditBlock)(BPFormInputCell *inCell, NSString *inText);

/**
 *  Block used for validation
 *
 *  @param pattern the pattern
 *  @param message the message to be displayed if the pattern is not matched
 *
 *  @return the block created
 */
BPFormInputCellShouldEditBlock BPValidateBlockWithPatternAndMessage(NSString *pattern, NSString *message);


/**
 *  Represents the main input cell for the form
 */
@interface BPFormInputCell : BPFormCell

/**
 *  Block matching UITextField delegate method
 */
@property (nonatomic, copy) BPFormInputCellEditingBlock    didBeginEditingBlock;

/**
 *  Block matching UITextField delegate method
 */
@property (nonatomic, copy) BPFormInputCellEditingBlock    didEndEditingBlock;

/**
 *  Block matching UITextField delegate method
 */
@property (nonatomic, copy) BPFormInputCellShouldEditBlock shouldChangeTextBlock;

/**
 *  Block matching UITextField delegate method
 */
@property (nonatomic, copy) BPFormInputCellShouldEditBlock shouldReturnBlock;

/**
 *  By default BPFormInputCell uses the BPFormTextField/BPFormTextView class for text fields. This can be customized by providing a different class
 */
+ (Class)textInputClass;

@end
