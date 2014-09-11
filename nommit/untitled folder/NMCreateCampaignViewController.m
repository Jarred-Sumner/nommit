//
//  NMCreateCampaignViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/10/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMCreateCampaignViewController.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "NMFoodItem.h"
#import "NMColors.h"
#import "NMFoodsViewController.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "DBCameraSegueViewController.h"
#import "NMMenuNavigationController.h"

const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;

const static CGFloat kJVFieldFontSize = 16.0f;

const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface NMCreateCampaignViewController ()<DBCameraViewControllerDelegate> {
    UIButton *addImage;
    JVFloatLabeledTextField *titleField;
    JVFloatLabeledTextField *priceField;
    JVFloatLabeledTextView *descriptionField;
    BOOL imageSet;
}

@end

@implementation NMCreateCampaignViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
