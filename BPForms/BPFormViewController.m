//
//  BPFormViewController.m
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


#import "BPFormViewController.h"
#import "BPAppearance.h"
#import "BPFormCell.h"
#import "BPFormInputCell.h"
#import "BPFormTextField.h"
#import "BPFormInfoCell.h"
#import <Masonry.h>
#import "UITextField+BPForms.h"
#import "UITextView+BPForms.h"
#import "BPFormInputTextFieldCell.h"
#import "BPFormInputTextViewCell.h"


@interface BPFormViewController ()

@property (nonatomic, strong) NSMutableDictionary *sectionHeaderTitles; // dictionary holding (section, title) pairs
@property (nonatomic, strong) NSMutableDictionary *sectionFooterTitles; // dictionary holding (section, title) pairs

@end


@implementation BPFormViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupFormVC];
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setupFormVC];
    }
    
    return self;
}

- (void)setupFormVC {
    self.keyboardMode = BPFormKeyboardModeAuto;
	
    self.sectionHeaderTitles = [NSMutableDictionary dictionary];
    self.sectionFooterTitles = [NSMutableDictionary dictionary];
    
    self.customSectionHeaderHeight = 0.0;
    self.customSectionFooterHeight = 0.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setupTableView];
    
    // need to react to keyboard, in detail make the table view visible at all time, so scrolling is available when the keyboard is on
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldMoveForKeyboard {
    BOOL result = YES;
    
    switch (self.keyboardMode) {
        case BPFormKeyboardModeMove:
            result = YES;
            break;
        case BPFormKeyboardModeDontMove:
            result = NO;
            break;
        case BPFormKeyboardModeAuto:
        default:
            result = YES;
            for (UIView *v = self.tableView; v.superview != nil; v=v.superview) {
                if ([v isKindOfClass:NSClassFromString(@"UIPopoverView")] || [v isKindOfClass:NSClassFromString(@"_UIPopoverView")]) {
                    result = NO;
                    break;
                }
            }
            break;
    }
    
	return result;
}

- (void)keyboardWillShow:(NSNotification *)inNotification {
	if ([self shouldMoveForKeyboard]) {
		// make the tableview fit the visible area of the screen, so it's scrollable to all the cells
		// note: for landscape, the sizes are switched, so we need to use width as height
		
		CGSize keyboardSize = [[[inNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
		
        // the keyboard height is always the smallest one
        // we used to have CGFloat keyboardHeight = (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) ? keyboardSize.width : keyboardSize.height;
        // but when the app is launched directly in landscape, the interface is UIDeviceInterfaceUnknown
        
		CGFloat keyboardHeight = (keyboardSize.width > keyboardSize.height) ? keyboardSize.height : keyboardSize.width;
        
        CGFloat padding = 20;
        // get the existing inset and make the bottom = keyboard height + a padding
        // note that insets.top is 0 (iOS6) and 64 (iOS7)
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.bottom = keyboardHeight + padding;
		self.tableView.contentInset = insets;
		self.tableView.scrollIndicatorInsets = insets;
        
        BPFormCell *firstResponderCell = [self cellContainingFirstResponder];
		NSIndexPath *selectedRow = [self.tableView indexPathForCell:firstResponderCell];
		[self.tableView scrollToRowAtIndexPath:selectedRow atScrollPosition:UITableViewScrollPositionNone animated:YES];
	}
}

- (void)keyboardWillHide:(NSNotification *)inNotification {
	if ([self shouldMoveForKeyboard]) {
		[UIView animateWithDuration:0.25 animations:^{
            // get the existing inset and reset the bottom to 0
            UIEdgeInsets insets = self.tableView.contentInset;
            insets.bottom = [self bottomInsetWhenKeyboardIsHidden];
			self.tableView.contentInset = insets;
			self.tableView.scrollIndicatorInsets = insets;
		}];
	}
}

- (CGFloat)bottomInsetWhenKeyboardIsHidden {

	BOOL isToolBarShowing = self.navigationController.toolbar && !self.navigationController.toolbar.hidden;
	return isToolBarShowing ? self.navigationController.toolbar.frame.size.height : 0;
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.backgroundView = nil;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height);
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
    }];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [BPAppearance sharedInstance].tableViewBackGroundColor;
}

- (void)setHeaderTitle:(NSString *)inHeaderTitle forSection:(int)inSection {
    if ([inHeaderTitle length] && inSection >= 0) {
        self.sectionHeaderTitles[@(inSection)] = inHeaderTitle;
    }
}

- (void)setFooterTitle:(NSString *)inFooterTitle forSection:(int)inSection {
    if ([inFooterTitle length] && inSection >= 0) {
        self.sectionFooterTitles[@(inSection)] = inFooterTitle;
    }
}

#pragma mark - Validation
- (BOOL)allCellsAreValid {
    BOOL valid = YES;
    
    for (NSArray *section in self.formCells) {
        for (UITableViewCell *cell in section) {
            if ([cell isKindOfClass:[BPFormCell class]]) {
                if (BPFormValidationStateInvalid == ((BPFormCell *)cell).validationState) {
                    valid = NO;
                    break;
                }
            }
        }
    }
    
    return valid;
}

- (void)forceValidation {
    for (NSArray *section in self.formCells) {
        for (UITableViewCell *cell in section) {
            if ([cell isKindOfClass:[BPFormInputTextFieldCell class]]) {
                BPFormInputTextFieldCell *inputTextFieldCell = (BPFormInputTextFieldCell*)cell;
                inputTextFieldCell.shouldChangeTextBlock(inputTextFieldCell, inputTextFieldCell.textField.text);
                [inputTextFieldCell updateAccordingToValidationState];
                [self updateInfoCellBelowInputCell:inputTextFieldCell];
            } else if ([cell isKindOfClass:[BPFormInputTextViewCell class]]) {
                BPFormInputTextViewCell *inputTextViewCell = (BPFormInputTextViewCell*)cell;
                inputTextViewCell.shouldChangeTextBlock(inputTextViewCell, inputTextViewCell.textView.text);
                [inputTextViewCell updateAccordingToValidationState];
                [self updateInfoCellBelowInputCell:inputTextViewCell];
            }
        }
    }
}

- (BPFormCell *)cellContainingFirstResponder {
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        if ([cell isKindOfClass:[BPFormCell class]]) {
            BPFormCell *formCell = (BPFormCell *)cell;
            // first we check the cell itself
            if ([cell isFirstResponder]) {
                return formCell;
            }
            // then we check the contentView subviews
            for (UIView *subview in formCell.contentView.subviews) {
                if ([subview isFirstResponder]) {
                    return formCell;
                }
            }
            // fallback to self.subviews
            for (UIView *subview in formCell.subviews) {
                if ([subview isFirstResponder]) {
                    return formCell;
                }
            }
        }
    }
    return nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.formCells) {
        return self.formCells.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.formCells && (section < self.formCells.count) ) {
        return [((NSArray *)self.formCells[section]) count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.formCells && (indexPath.section < self.formCells.count) ) {
        NSArray *sectionCells = self.formCells[indexPath.section];
        BPFormCell *cell = nil;
        if (indexPath.row < sectionCells.count) {
            cell = self.formCells[indexPath.section][indexPath.row];
            if ([cell isKindOfClass:[BPFormCell class]]) {
                [cell refreshMandatoryState];
            }
        }
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.formCells && (indexPath.section < self.formCells.count) ) {
        NSArray *sectionCells = self.formCells[indexPath.section];
        if (indexPath.row < sectionCells.count) {
            BPFormCell *cell = self.formCells[indexPath.section][indexPath.row];
            return [cell cellHeight];
        }
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *headerTitle = self.sectionHeaderTitles[@(section)];
    if (headerTitle) {
        CGFloat headerHeight = self.customSectionHeaderHeight ?: [self.tableView sectionHeaderHeight];
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, headerHeight)];
        infoLabel.text = headerTitle;
        infoLabel.textColor = [BPAppearance sharedInstance].headerFooterLabelTextColor;
        infoLabel.font = [BPAppearance sharedInstance].headerFooterLabelFont;
        infoLabel.textAlignment = NSTextAlignmentCenter;
        return infoLabel;
    }
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.customSectionHeaderHeight) {
        return self.customSectionHeaderHeight;
    }
    return [self.tableView sectionHeaderHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSString *footerTitle = self.sectionFooterTitles[@(section)];
    if (footerTitle) {
        CGFloat footerHeight = self.customSectionFooterHeight ?: [self.tableView sectionFooterHeight];
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, footerHeight)];
        infoLabel.text = footerTitle;
        infoLabel.textColor = [BPAppearance sharedInstance].headerFooterLabelTextColor;
        infoLabel.font = [BPAppearance sharedInstance].headerFooterLabelFont;
        infoLabel.textAlignment = NSTextAlignmentCenter;
        return infoLabel;
    }
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.customSectionFooterHeight) {
        return self.customSectionFooterHeight;
    }
    return [self.tableView sectionFooterHeight];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    BPFormInputCell *cell = [textField containerInputCell];
    if (!cell) {
        return;
    }
    if (cell.didBeginEditingBlock) {
        cell.didBeginEditingBlock(cell, textField.text);
    }
    [self updateInfoCellBelowInputCell:cell];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL shouldChange = YES;
    BPFormInputCell *cell = [textField containerInputCell];

    if (!cell) {
        return YES;
    }

    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (cell.shouldChangeTextBlock) {
        shouldChange = cell.shouldChangeTextBlock(cell, newText);
    }
    [self updateInfoCellBelowInputCell:cell];
    [cell updateAccordingToValidationState];
    
    return shouldChange;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    BPFormInputCell *cell = [textField containerInputCell];
    if (!cell) {
        return;
    }
    
    // executing the shouldChangeTextBlock to validate the text
    if (cell.shouldChangeTextBlock) {
        cell.shouldChangeTextBlock(cell, textField.text);
    }
    
    if (cell.didEndEditingBlock) {
        cell.didEndEditingBlock(cell, textField.text);
    }
    
    [self updateInfoCellBelowInputCell:cell];
    [cell updateAccordingToValidationState];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL shouldReturn = YES;
    BPFormInputCell *cell = [textField containerInputCell];
    if (!cell) {
        return YES;
    }
    
    if (cell.shouldReturnBlock) {
        shouldReturn = cell.shouldReturnBlock(cell, textField.text);
    }
    
    BPFormInputCell *nextCell = [self nextInputCell:cell];
    if (!nextCell) {
        [textField resignFirstResponder];
    } else {
        if ([nextCell isKindOfClass:[BPFormInputTextFieldCell class]]) {
            [((BPFormInputTextFieldCell*)nextCell).textField becomeFirstResponder];
        } else if ([nextCell isKindOfClass:[BPFormInputTextViewCell class]]) {
            [((BPFormInputTextViewCell*)nextCell).textView becomeFirstResponder];
        }
    }
    
    [self updateInfoCellBelowInputCell:cell];
    return shouldReturn;
}

- (BPFormInputCell *)nextInputCell:(BPFormInputCell *)currentCell {
    BOOL foundCurrentCell = NO;
    
    for (NSArray *section in self.formCells) {
        for (BPFormCell *cell in section) {
            if (!foundCurrentCell) {
                if (cell == currentCell) {
                    foundCurrentCell = YES;
                }
            } else {
                if ([cell isKindOfClass:[BPFormInputCell class]]) {
                    return (BPFormInputCell *)cell;
                }
            }
        }
    }
    return nil;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    BPFormInputCell *cell = [textView containerInputCell];
    if (!cell) {
        return;
    }
    if (cell.didBeginEditingBlock) {
        cell.didBeginEditingBlock(cell, textView.text);
    }
    [self updateInfoCellBelowInputCell:cell];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    BPFormInputCell *cell = [textView containerInputCell];
    if (!cell) {
        return;
    }
    
    // executing the shouldChangeTextBlock to validate the text
    if (cell.shouldChangeTextBlock) {
        cell.shouldChangeTextBlock(cell, textView.text);
    }
    
    if (cell.didEndEditingBlock) {
        cell.didEndEditingBlock(cell, textView.text);
    }
    
    [self updateInfoCellBelowInputCell:cell];
    [cell updateAccordingToValidationState];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    BOOL shouldChange = YES;
    BPFormInputCell *cell = [textView containerInputCell];
    
    if (!cell) {
        return YES;
    }
    
    NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (cell.shouldChangeTextBlock) {
        shouldChange = cell.shouldChangeTextBlock(cell, newText);
    }
    [self updateInfoCellBelowInputCell:cell];
    [cell updateAccordingToValidationState];
    
    return shouldChange;
}

#pragma mark - Show / hide info cells
- (BPFormInfoCell *)infoCellBelowInputCell:(BPFormCell *)inInputCell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:inInputCell];
    NSIndexPath *nextPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
    UITableViewCell *cellBelow = [self.tableView cellForRowAtIndexPath:nextPath];
    if (cellBelow && [cellBelow isKindOfClass:[BPFormInfoCell class]]) {
        return (BPFormInfoCell *)cellBelow;
    }
    return nil;
}

- (void)showInfoCellBelowInputCell:(BPFormCell *)inInputCell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:inInputCell];
    
    BPFormInfoCell *infoCell = [self infoCellBelowInputCell:inInputCell];
    if (infoCell)
        return;
    
    NSMutableArray *newFormCells = [NSMutableArray array];
    for (int sectionIndex=0; sectionIndex<self.formCells.count; sectionIndex++) {
        NSArray *section = self.formCells[sectionIndex];
        if (sectionIndex == indexPath.section) {
            NSMutableArray *newSection = [NSMutableArray arrayWithArray:section];
            [newSection insertObject:inInputCell.infoCell atIndex:indexPath.row + 1];
            [newFormCells addObject:newSection];
        } else {
            [newFormCells addObject:section];
        }
    }
    self.formCells = [newFormCells copy];
    
    NSIndexPath *nextPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
    
    [self.tableView insertRowsAtIndexPaths:@[nextPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)removeInfoCellBelowInputCell:(BPFormCell *)inInputCell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:inInputCell];
    
    BPFormInfoCell *infoCell = [self infoCellBelowInputCell:inInputCell];
    if (!infoCell)
        return;
    
    NSMutableArray *newFormCells = [NSMutableArray array];
    for (int sectionIndex=0; sectionIndex<self.formCells.count; sectionIndex++) {
        NSArray *section = self.formCells[sectionIndex];
        if (sectionIndex == indexPath.section) {
            NSMutableArray *newSection = [NSMutableArray arrayWithArray:section];
            [newSection removeObjectAtIndex:indexPath.row + 1];
            [newFormCells addObject:newSection];
        } else {
            [newFormCells addObject:section];
        }
    }
    self.formCells = [newFormCells copy];
    
    NSIndexPath *nextPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
    [self.tableView deleteRowsAtIndexPaths:@[nextPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)updateInfoCellBelowInputCell:(BPFormInputCell *)inInputCell {
    BOOL isEditing = NO;
    if ([inInputCell isKindOfClass:[BPFormInputTextFieldCell class]]) {
        isEditing = ((BPFormInputTextFieldCell*)inInputCell).textField.isEditing;
    }
    
    if (inInputCell.shouldShowInfoCell && !isEditing) {
        [self showInfoCellBelowInputCell:inInputCell];
    } else {
        [self removeInfoCellBelowInputCell:inInputCell];
    }
}

@end
