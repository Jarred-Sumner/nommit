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
    UILabel *progressLabel;
    UILabel *quantityLabel;
}

- (void)didBeginEditing:(id)sender;
- (void)didEndEditing:(id)sender;
- (void)textDidChange:(id)sender;
- (void)valueChanged:(id)sender;

@end

@implementation NMOrderFoodProgressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColorFromRGB(0xD3D3D3) CGColor];
        self.layer.borderWidth = 1.0f;
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[_progressBarView]-30-|" options:0 metrics:nil views:views ]];
}

- (void)setLeftSold:(NSArray *)leftSold
{
    NSNumber *left = leftSold[0];
    NSNumber *total = leftSold[1];
    progressLabel.text = [NSString stringWithFormat:@"%@/%@ sold", left, total];
}

- (void)setupProgressLabel
{
    progressLabel = [[UILabel alloc] init];
    progressLabel.textColor = UIColorFromRGB(0x787878);
    progressLabel.font = [UIFont fontWithName:@"Avenir" size:24.0f];
    progressLabel.frame = CGRectMake(40, 15, 150, 50);
    [self.contentView addSubview:progressLabel];
}

- (void)setupSeparator
{
    separator = [[UIView alloc] init];
    separator.backgroundColor = UIColorFromRGB(0xD8D8D8);
    // separator.backgroundColor = [UIColor redColor];
    separator.frame = CGRectMake(210, 0, 1, 115);
    [self.contentView addSubview:separator];
    
}

- (void)setupQuantityLabel
{
    quantityLabel = [[UILabel alloc] initWithFrame:CGRectMake(separator.frame.origin.x + 35, 15, 50, 20)];
    quantityLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0f];
    quantityLabel.textColor = UIColorFromRGB(0x494949);
    quantityLabel.text = @"Quantity";
    [self.contentView addSubview:quantityLabel];
}

- (void)setupDigitInput
{
    _digitInput = [[CHDigitInput alloc] initWithNumberOfDigits:1];
    _digitInput.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    _digitInput.digitOverlayImage = [UIImage imageNamed:@"digitOverlay"];
    _digitInput.digitBackgroundImage = [UIImage imageNamed:@"digitControlBG"];
    
    //digitInput.backgroundView = digitBGView;
    
    _digitInput.placeHolderCharacter = @"1";
    
    // we are using an overlayimage, so make the bg color clear color
    
    _digitInput.digitViewBackgroundColor = [UIColor clearColor];
    _digitInput.digitViewHighlightedBackgroundColor = [UIColor clearColor];
    
    _digitInput.digitViewTextColor = [UIColor whiteColor];
    _digitInput.digitViewHighlightedTextColor = UIColorFromRGB(0x42B7BB);
    
    // _digitInput.frame = CGRectMake(220, 20, 50, 53);
    
    // we changed the default settings, so call redrawControl
    [_digitInput redrawControl];
    
    [self.contentView addSubview:_digitInput];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_progressBarView, _digitInput);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_progressBarView]-45-[_digitInput]-20-|" options:0 metrics:nil views:views ]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[_digitInput]-15-|" options:0 metrics:nil views:views ]];
    
    // adding the target,actions for available events
    [_digitInput addTarget:_delegate action:@selector(didBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [_digitInput addTarget:_delegate action:@selector(didEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    [_digitInput addTarget:_delegate action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_digitInput addTarget:_delegate action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
}

// dismissing the keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_digitInput resignFirstResponder];
}

@end
