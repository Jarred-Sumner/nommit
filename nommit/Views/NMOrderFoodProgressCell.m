//
//  NMCampaignInfoView.m
//  nommit
//
//  Created by Lucy Guo on 9/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderFoodProgressCell.h"

@interface NMOrderFoodProgressCell() {
    UIView *separator;
}

@end

@implementation NMOrderFoodProgressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupProgressBar];
        [self setupProgressLabel];
        [self setupSeparator];
        [self setupQuantityLabel];
        [self setupDigitInput];
    }
    return self;
}

- (void)setupProgressBar
{
    // Create a progress bar view and set its appearance
    _progressBarView = [[TYMProgressBarView alloc] init];
    _progressBarView.barBorderWidth = 1.0f;
    _progressBarView.barBorderWidth = 0;
    _progressBarView.barBackgroundColor = UIColorFromRGB(0xDCDCDC);
    _progressBarView.barFillColor = UIColorFromRGB(0x42B7BB);
    _progressBarView.barInnerPadding = 0;
    _progressBarView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Add it to your view
    [self.contentView addSubview:_progressBarView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_progressBarView);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_progressBarView]-130-|" options:0 metrics:nil views:views ]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[_progressBarView]-30-|" options:0 metrics:nil views:views ]];
}

- (void)setupProgressLabel
{
    _progressLabel = [[UILabel alloc] init];
    _progressLabel.textColor = UIColorFromRGB(0x787878);
    _progressLabel.font = [UIFont fontWithName:@"Avenir" size:24.0f];
    _progressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    // _progressLabel.frame = CGRectMake(40, 15, 150, 50);

    [self.contentView addSubview:_progressLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-27-[_progressLabel]-130-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_progressLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressLabel) ]];
}

- (void)setupSeparator
{
    separator = [[UIView alloc] init];
    separator.backgroundColor = UIColorFromRGB(0xD8D8D8);
    separator.frame = CGRectMake(210, 0, 1, 103);
    [self.contentView addSubview:separator];
    
}

- (void)setupQuantityLabel
{
    _quantityLabel = [[UILabel alloc] initWithFrame:CGRectMake(separator.frame.origin.x + 35, 8, 50, 20)];
    _quantityLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0f];
    _quantityLabel.textColor = UIColorFromRGB(0x494949);
    _quantityLabel.text = @"Quantity";
    [self.contentView addSubview:_quantityLabel];
}

- (void)setupDigitInput
{
    _quantityInput = [[CHDigitInput alloc] initWithNumberOfDigits:1];
    _quantityInput.translatesAutoresizingMaskIntoConstraints = NO;
    
    _quantityInput.digitOverlayImage = [UIImage imageNamed:@"digitOverlay"];
    _quantityInput.digitBackgroundImage = [UIImage imageNamed:@"digitControlBG"];
    
    _quantityInput.placeHolderCharacter = @"1";
    
    _quantityInput.digitViewBackgroundColor = [UIColor clearColor];
    _quantityInput.digitViewHighlightedBackgroundColor = [UIColor clearColor];
    
    _quantityInput.digitViewTextColor = [UIColor whiteColor];
    _quantityInput.digitViewHighlightedTextColor = UIColorFromRGB(0x42B7BB);
    
    // we changed the default settings, so call redrawControl
    [_quantityInput redrawControl];
    
    [self.contentView addSubview:_quantityInput];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_progressBarView, _quantityInput);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_progressBarView]-45-[_quantityInput]-20-|" options:0 metrics:nil views:views ]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-25-[_quantityInput]-15-|" options:0 metrics:nil views:views ]];
    
    // adding the target,actions for available events
    [_quantityInput addTarget:_delegate action:@selector(quantityDidChange) forControlEvents:UIControlEventValueChanged];
}

// dismissing the keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_quantityInput resignFirstResponder];
}

@end
