//
//  NMItemsCollectionViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/2/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMItemsCollectionViewController.h"
#import <MGScrollView.h>
#import <MGLine.h>
#import "NMColors.h"
#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>
#import "NMMiniItemView.h"

@interface NMItemsCollectionViewController ()<APParallaxViewDelegate> {
    MGScrollView *scroller;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation NMItemsCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializations
        self.view.backgroundColor = [NMColors lightGray];
        scroller = [MGScrollView scrollerWithSize:self.view.size];
        [self.view addSubview:scroller];
        
        MGLine *header = [MGLine lineWithSize:(CGSize){320, 40}];
        header.bottomBorderColor = UIColor.lightGrayColor;
        header.padding = UIEdgeInsetsMake(0, 16, 0, 16);
        header.leftItems = (id)@"This is a Heading";
        [scroller.boxes addObject:header];
        
        for (int i = 0; i < 19; i++) {
            MGLine *row = [MGLine lineWithSize:(CGSize){160, 190}];
            row.bottomBorderColor = UIColor.lightGrayColor;
            row.padding = UIEdgeInsetsMake(0, 16, 0, 16);
            
            NMMiniItemView *cell = [[NMMiniItemView alloc] initWithFrame:CGRectMake(0, 0, 160, 190)];
            cell.backgroundColor = [UIColor whiteColor];
            cell.layer.cornerRadius = 4;
            cell.clipsToBounds = YES;
            cell.layer.borderColor = [UIColorFromRGB(0xE9E9E9) CGColor];
            cell.layer.borderWidth = 1.0f;
            
            cell.itemImage = [UIImage imageNamed:@"PepperoniPizza"];
            
            
            // row.leftItems = (id)[NSString stringWithFormat:@"Row Number %d", i];
            UIImageView *blah  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PepperoniPizza"]];
            row.rightItems = (id)blah;
            [scroller.boxes addObject:row];

            
            
            
        }
        
        scroller.contentLayoutMode = MGLayoutGridStyle;

        
        [scroller addParallaxWithImage:[UIImage imageNamed:@"Image1"] andHeight:160];

        // [scroller addParallaxWithView:customView andHeight:160];
        
        [scroller.parallaxView setDelegate:self];
        
        [scroller layout];
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

#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
    NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
    NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
}

@end
