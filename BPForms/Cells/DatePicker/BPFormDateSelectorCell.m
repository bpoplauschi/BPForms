//
//  BPFormDateSelectorCell.m
//
//  Copyright (c) 2014 Florent Pillet
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

#import <Masonry/Masonry.h>
#import "BPAppearance.h"
#import "BPFormDateSelectorCell.h"
#import "BPFormFloatLabelTextField.h"

#define DATE_LABEL_HEIGHT			44.0
#define DATE_PICKER_HEIGHT 			216.0

@interface BPFormDateSelectorCell ()

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) BPFormFloatLabelTextField *dateLabel;
@property (nonatomic, strong) UIButton *toggleButton;
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) MASConstraint *widthConstraint;
@property (nonatomic, strong) MASConstraint *heightConstraint;

@end

@implementation BPFormDateSelectorCell

// auto-synthesize doesn't work here since the properties are defined in a base class (BPFormCell)
@synthesize spaceToNextCell = _spaceToNextCell;
@synthesize customContentHeight = _customContentHeight;
@synthesize customContentWidth = _customContentWidth;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) != nil) {
		[self setupCell];
		[self setupDateSelector];
	}
	return self;
}

- (void)setupCell {
	_containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [BPAppearance sharedInstance].datePickerCellBackgroundColor;
    CGFloat cornerRadius = [BPAppearance sharedInstance].datePickerCellCornerRadius;
    if (cornerRadius  != 0.0f) {
		_containerView.layer.cornerRadius = cornerRadius;
		_containerView.layer.masksToBounds = YES;
    }

	[self.contentView addSubview:_containerView];

	[_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
		_widthConstraint = make.width.equalTo(self.contentView.mas_width).offset(-30);
		make.centerX.equalTo(self.contentView.mas_centerX);
		make.top.equalTo(self.contentView.mas_top);
		_heightConstraint = make.height.equalTo(self.contentView.mas_height).offset(-_spaceToNextCell);
	}];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.customCellHeight = 44;
	self.validationState = BPFormValidationStateNone;
}

- (void)setupDateSelector
{
	// placeholder label (using a textfield to get a floating label for free)
	_dateLabel = [[BPFormFloatLabelTextField alloc] init];
	_dateLabel.textColor = [BPAppearance sharedInstance].datePickerCellDateTextColor;
	_dateLabel.font = [BPAppearance sharedInstance].datePickerCellDateTextFont;
	_dateLabel.floatingLabel.font = [BPAppearance sharedInstance].datePickerCellDateFloatingLabelFont;
	_dateLabel.backgroundColor = [UIColor clearColor];
	_dateLabel.enabled = NO;

	[_containerView addSubview:_dateLabel];

	[_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(_containerView.mas_left);
		make.right.equalTo(_containerView.mas_right);
		make.top.equalTo(_containerView.mas_top);
		make.height.equalTo(@(DATE_LABEL_HEIGHT));
	}];

	// invisible button to toggle the date picker
	_toggleButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_toggleButton setTitleColor:[BPAppearance sharedInstance].inputCellTextFieldTextColor forState:UIControlStateNormal];
	_toggleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	_toggleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;

	[_toggleButton addTarget:self action:@selector(toggleDatePicker:) forControlEvents:UIControlEventTouchUpInside];

	[_containerView addSubview:_toggleButton];

	// need to set the frame, otherwise there are cases where, even if the constraints are fine, the frame remains zero-rect
	_toggleButton.frame = CGRectMake(roundf(30.0f / 2.0f), self.frame.origin.y, self.frame.size.width - 30.0f, self.frame.size.height);

	[_toggleButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(_containerView.mas_centerX);
		make.top.equalTo(_containerView.mas_top);
		make.width.equalTo(_containerView.mas_width);
		make.height.equalTo(_containerView.mas_height);
	}];

	// prepare date picker
	_datePicker = [[UIDatePicker alloc] init];
	_datePicker.datePickerMode = UIDatePickerModeDate;
	_datePicker.hidden = YES;
	[_datePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];

	[_containerView addSubview:_datePicker];

	[_datePicker mas_updateConstraints:^(MASConstraintMaker *make) {
		make.width.equalTo(_containerView.mas_width);
		make.height.equalTo(@(DATE_PICKER_HEIGHT));
		make.left.equalTo(_containerView.mas_left);
		make.bottom.equalTo(_containerView.mas_bottom);
	}];

	[self refreshDateLabel];
}

- (void)setPlaceholderString:(NSString *)placeholderString {
	_dateLabel.placeholder = placeholderString;
}

- (NSString *)placeholderString {
	return _dateLabel.placeholder ?: @"";
}

- (void)setMinDate:(NSDate *)minDate {
	_datePicker.minimumDate = minDate;
}

- (NSDate *)minDate {
	return _datePicker.minimumDate;
}

- (void)setMaxDate:(NSDate *)maxDate {
	_datePicker.maximumDate = maxDate;
}

- (NSDate *)maxDate {
	return _datePicker.maximumDate;
}

- (void)setDate:(NSDate *)date {
	_datePicker.date = date;
	_date = _datePicker.date;
	[self refreshDateLabel];
}

- (void)datePickerDateChanged:(UIDatePicker *)picker {
	self.date = _datePicker.date;
	[self refreshDateLabel];
}

- (void)refreshDateLabel {
	NSString *dateLabel = @"";
	if (_date != nil) {
		if (_dateFormatter == nil) {
			_dateFormatter = [[NSDateFormatter alloc] init];
			_dateFormatter.timeStyle = NSDateFormatterNoStyle;
			_dateFormatter.dateStyle = NSDateFormatterMediumStyle;
		}
		dateLabel = [_dateFormatter stringFromDate:_date];
	}
	_dateLabel.text = dateLabel;
}

- (UITableView *)tableView {
	UIView *sup = self.superview;
	while (sup && ![sup isKindOfClass:[UITableView class]])
		sup = sup.superview;
	return (UITableView *)sup;
}

- (void)reloadCell {
	UITableView *tableView = [self tableView];
	NSIndexPath *indexPath = [tableView indexPathForCell:self];
	if (indexPath != nil) {
		[tableView reloadData];
		if (!_datePicker.hidden)
			[tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
	}
}

- (void)toggleDatePicker:(UIButton *)sender {
	BOOL hidden = !_datePicker.hidden;
	[UIView animateWithDuration:0.25 animations:^{
		_datePicker.hidden = hidden;
		_datePicker.enabled = !hidden;

		if (!hidden) {
			// resign first responder on all text fields and text views
			for (BPFormCell *cell in [self tableView].visibleCells) {
				if ([cell isKindOfClass:[BPFormCell class]])
					[cell resignEditing];
			}
		}

		[self reloadCell];
	}];
}

- (CGFloat)cellHeight:(CGFloat)defaultRowHeight {
    CGFloat cellHeight = (self.customCellHeight ?: defaultRowHeight) + self.spaceToNextCell;
	if (!_datePicker.hidden)
		cellHeight += DATE_PICKER_HEIGHT;
	return cellHeight;
}

- (void)setSpaceToNextCell:(CGFloat)inSpaceToNextCell {
    if (inSpaceToNextCell != _spaceToNextCell) {
        _spaceToNextCell = inSpaceToNextCell;

        if (self.customContentHeight == 0) {

            [_heightConstraint uninstall];
            [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
                _heightConstraint = make.height.equalTo(_containerView.mas_height).offset(-inSpaceToNextCell);
            }];
        }
    }
}

- (void)setCustomContentHeight:(CGFloat)inCustomContentHeight {
    if (inCustomContentHeight != _customContentHeight) {
        _customContentHeight = inCustomContentHeight;

        [_heightConstraint uninstall];
        [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            _heightConstraint = make.height.equalTo(@(inCustomContentHeight));
        }];
    }
}

- (void)setCustomContentWidth:(CGFloat)inCustomContentWidth {
    if (inCustomContentWidth != _customContentWidth) {
        _customContentWidth = inCustomContentWidth;

        [_widthConstraint uninstall];

        [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
			_widthConstraint = make.width.equalTo(@(inCustomContentWidth));
        }];
    }
}

@end
