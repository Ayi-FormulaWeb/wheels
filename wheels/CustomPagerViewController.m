//
//  CustomPagerViewController.m
//  wheels
//
//  Created by Ayi Chen on 12/9/9.
//  Copyright (c) 2012年 Ayi Chen. All rights reserved.
//

#import "CustomPagerViewController.h"

@interface CustomPagerViewController ()

@end

@implementation CustomPagerViewController

- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View1"]];
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View2"]];
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View3"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View4"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View5"]];
}
@end
