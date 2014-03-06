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


@class BPFormInfoCell;

/**
 *  Base form cell class, holds common fields
 */
@interface BPFormCell : UITableViewCell

@property (nonatomic, assign) CGFloat customCellHeight;             // set this to use any height for the cell

@property (nonatomic, assign, getter = isMandatory) BOOL mandatory; // if set to YES, an icon will appear next the the cell indicating this is mandatory

@property (nonatomic, strong) BPFormInfoCell *infoCell;             // the info cell describing the cell state (i.e. the reason why the validation failed)

@property (nonatomic, assign) BOOL shouldShowInfoCell;              // YES if the info cell needs to be displayed

/**
 *  Calculate the cell height
 *  If customCellHeight is set, returns that value, otherwise it just measures the size of the cell.
 *
 *  @return the cell height
 */
- (CGFloat)cellHeight;

/**
 *  Refresh the mandatory state based on isMandatory
 */
- (void)refreshMandatoryState;

@end
