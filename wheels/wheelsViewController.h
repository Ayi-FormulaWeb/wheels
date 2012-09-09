//
//  wheelsViewController.h
//  wheels
//
//  Created by Ayi Chen on 12/9/9.
//  Copyright (c) 2012年 Ayi Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wheelsViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage:(id)sender;

- (void)previousPage;
- (void)nextPage;

@end
