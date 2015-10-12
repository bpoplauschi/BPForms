//
//  BPFormCell.h
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

#import "BPFormCellProtocol.h"

/**
 *  Cell validation state
 */
typedef NS_ENUM(NSInteger, BPFormValidationState) {
    /**
     *  Invalid
     */
    BPFormValidationStateInvalid = -1,
    /**
     *  Valid
     */
    BPFormValidationStateValid,
    /**
     *  Not verified
     */
    BPFormValidationStateNone
};


@class BPFormInfoCell;

/**
 *  Base form cell class, holds common fields
 */
@interface BPFormCell : UITableViewCell <BPFormCellProtocol>

/**
 *  The validation state
 */
@property (nonatomic, assign) BPFormValidationState validationState;

/**
 *  Set this to use any height for the cell
 */
@property (nonatomic, assign) CGFloat               customCellHeight;

/**
 *  Set this to override the content height (aka height of the content elements)
 */
@property (nonatomic, assign) CGFloat               customContentHeight;

/**
 *  Set this to override the content width (aka width of the content elements)
 */
@property (nonatomic, assign) CGFloat               customContentWidth;

/**
 *  Space till next cell. Default is BPAppearance.spaceBetweenCells
 */
@property (nonatomic, assign) CGFloat               spaceToNextCell;

/**
 *  If set to YES, an icon will appear next the the cell indicating this is mandatory
 */
@property (nonatomic, assign) BOOL                  mandatory;

/**
 *  The info cell describing the cell state (i.e. the reason why the validation failed)
 */
@property (nonatomic, strong) BPFormInfoCell        *infoCell;

/**
 *  YES if the info cell needs to be displayed
 */
@property (nonatomic, assign) BOOL                  shouldShowInfoCell;

/**
 *  YES if the validation needs to be displayed
 */
@property (nonatomic, assign) BOOL                  shouldShowValidation;

/**
 *  The imageview for the mandatory mark
 */
@property (nonatomic, strong) UIImageView           *mandatoryImageView;

/**
 *  The imageview for the validation result
 */
@property (nonatomic, strong) UIImageView           *validationImageView;

/**
 *  Refresh the mandatory state based on isMandatory
 */
- (void)refreshMandatoryState;

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
