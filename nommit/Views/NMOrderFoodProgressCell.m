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
        [self setupSeparator];
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

- (void)setupSeparator
{
    separator = [[UIView alloc] init];
    separator.backgroundColor = UIColorFromRGB(0xD8D8D8);
    // separator.backgroundColor = [UIColor redColor];
    separator.frame = CGRectMake(210, 0, 1, 115);
    [self.contentView addSubview:separator];
    
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-25-[_digitInput]-25-|" options:0 metrics:nil views:views ]];
    
    // adding the target,actions for available events
    [_digitInput addTarget:self action:@selector(didBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [_digitInput addTarget:self action:@selector(didEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    [_digitInput addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_digitInput addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
}

// dismissing the keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_digitInput resignFirstResponder];
}

/////////// recating on demo events ///////////
-(void)didBeginEditing:(id)sender
{
    CHDigitInput *input = (CHDigitInput *)sender;
    NSLog(@"did begin editing %i",input.value);
}

-(void)didEndEditing:(id)sender
{
    CHDigitInput *input = (CHDigitInput *)sender;
    NSLog(@"did end editing %i",input.value);
}

-(void)textDidChange:(id)sender
{
    CHDigitInput *input = (CHDigitInput *)sender;
    NSLog(@"text did change %i",input.value);
}

-(void)valueChanged:(id)sender
{
    CHDigitInput *input = (CHDigitInput *)sender;
    NSLog(@"value changed %i",input.value);
}



@end
