//
//  NMCampaignInfoView.h
//  nommit
//
//  Created by Lucy Guo on 9/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TYMProgressBarView.h>
#import "CHDigitInput.h"

@protocol NMOrderFoodProgressCell;

@interface NMOrderFoodProgressCell : UITableViewCell

@property TYMProgressBarView *progressBarView;
@property CHDigitInput *digitInput;
@property (strong, nonatomic) NSArray *leftSold;

@property (nonatomic, weak) id<NMOrderFoodProgressCell> delegate;


@end

@protocol NMOrderFoodProgressCell

@required
-(void)didBeginEditing:(id)sender;
-(void)didEndEditing:(id)sender;
-(void)textDidChange:(id)sender;
-(void)valueChanged:(id)sender;

@end
