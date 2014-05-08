//
//  BPAppearance.h
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


/**
 *  Class used to customize the appearance of forms
 */
@interface BPAppearance : NSObject

+ (BPAppearance *)sharedInstance;

// -- Colors --
@property (nonatomic, strong) UIColor *tableViewBackGroundColor;            // default is white

@property (nonatomic, strong) UIColor *inputCellBackgroundColor;            // default is white
@property (nonatomic, strong) UIColor *inputCellTextFieldTextColor;         // default is black
@property (nonatomic, strong) UIColor *inputCellTextFieldBackgroundColor;   // default is (0.93, 0.93, 0.93, 1.0)
@property (nonatomic, strong) UIColor *inputCellTextFieldBorderColor;       // default is (0.85, 0.85, 0.85, 1.0)

@property (nonatomic, strong) UIColor *infoCellBackgroundColor;             // default is white
@property (nonatomic, strong) UIColor *infoCellLabelTextColor;              // default is (0.25, 0.25, 0.25, 1.0)
@property (nonatomic, strong) UIColor *infoCellLabelBackgroundColor;        // default is clear

@property (nonatomic, strong) UIColor *buttonCellBackgroundColor;           // default is white

@property (nonatomic, strong) UIColor *headerFooterLabelTextColor;          // default is dark-gray


// -- Fonts --
@property (nonatomic, strong) UIFont *inputCellTextFieldFont;               // default is system-14
@property (nonatomic, strong) UIFont *inputCellTextFieldFloatingLabelFont;  // default is system-8

@property (nonatomic, strong) UIFont *infoCellLabelFont;                    // default is system-10

@property (nonatomic, strong) UIFont *headerFooterLabelFont;                // default is system-12


// -- Sizes --
@property (nonatomic, assign) CGFloat infoCellHeight;                       // default is 16
@property (nonatomic, assign) CGFloat spaceBetweenCells;                    // default is 8

@end
