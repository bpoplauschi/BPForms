//
//  BPFormViewController.h
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


typedef NS_ENUM(NSInteger, BPFormKeyboardMode) {
	BPFormKeyboardModeAuto      = -1,
	BPFormKeyboardModeDontMove  = 0,
    BPFormKeyboardModeMove      = 1
};

@class BPFormCell;
@class BPFormInputCell;

/**
 *  Main class, represents the form controller
 */
@interface BPFormViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>

/**
 *  The table view
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  Array of arrays of BPFormCell objects. Each element from the ```formCells``` array is a section, having an array of cells.
 */
@property (nonatomic, strong) NSArray *formCells;

/**
 *  Set this to use a custom height for headers
 */
@property (nonatomic, assign) CGFloat customSectionHeaderHeight;

/**
 *  Set this to use a custom height for footers
 */
@property (nonatomic, assign) CGFloat customSectionFooterHeight;

/**
 *  Set this to manually specify if the form should try to adjust it's size for the keyboard.
 *	
 *  By default the form will check if it is in a popover, and let the popover adjust it's size instead of the form view itself.
 */
@property (nonatomic) BPFormKeyboardMode keyboardMode;

/**
 *  Set the header title for a specified section
 *
 *  @param inHeaderTitle the header title
 *  @param inSection     the section
 */
- (void)setHeaderTitle:(NSString *)inHeaderTitle forSection:(int)inSection;

/**
 *  Set the footer title for a specified section
 *
 *  @param inFooterTitle the title
 *  @param inSection     the section
 */
- (void)setFooterTitle:(NSString *)inFooterTitle forSection:(int)inSection;

/**
 *  Checks all the form cells if they are valid
 *
 *  @return YES if all the cells are valid
 */
- (BOOL)allCellsAreValid;

/**
 *  Forces the validation on all input fields
 */
- (void)forceValidation;

/**
 *  Will return the cell that contains the UI element that is first responder or nil, if none found
 *
 *  @return the cell (or nil)
 */
- (BPFormCell *)cellContainingFirstResponder;

/**
 *  Triggers the update (appear/dissapear) of the info cell for a provided cell
 *
 *  @param inInputCell the input cell
 */
- (void)updateInfoCellBelowInputCell:(BPFormInputCell *)inInputCell;

@end
