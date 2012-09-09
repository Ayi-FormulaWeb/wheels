//
//  DefaultSettingsViewController.h
//  wheels
//
//  Created by Ayi Chen on 12/9/9.
//  Copyright (c) 2012年 Ayi Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultSettingsViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;

-(IBAction)logOutButtonTapAction:(id)sender;

@end
