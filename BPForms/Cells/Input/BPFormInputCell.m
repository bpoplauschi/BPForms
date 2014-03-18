//
//  BPFormInputCell.m
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


#import "BPFormInputCell.h"
#import "BPFormInfoCell.h"
#import "BPAppearance.h"
#import <Masonry.h>

BPFormInputCellShouldEditBlock BPValidateBlockWithPatternAndMessage(NSString *pattern, NSString *message) {
    return ^BOOL(BPFormInputCell *inCell, NSString *inText) {
        NSString *emailRegEx = pattern;
        
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:emailRegEx
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
        
        if (inText.length && (1 == [regex numberOfMatchesInString:inText options:0 range:NSMakeRange(0, [inText length])]) ) {
            inCell.validationState = BPFormValidationStateValid;
            inCell.shouldShowInfoCell = NO;
        } else if (!inCell.mandatory && !inText.length) {
            inCell.validationState = BPFormValidationStateNone;
            inCell.shouldShowInfoCell = NO;
        } else {
            inCell.validationState = BPFormValidationStateInvalid;
            inCell.infoCell.label.text = message;
            inCell.shouldShowInfoCell = YES;
        }
        return YES;
    };
}

@implementation BPFormInputCell

+ (Class)textInputClass {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Must subclass BPFormInputCell"]
                                 userInfo:nil];
    return nil;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    self.backgroundColor = [BPAppearance sharedInstance].inputCellBackgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.validationState = BPFormValidationStateNone;
}

@end
