//
//  DefaultSettingsViewController.m
//  wheels
//
//  Created by Ayi Chen on 12/9/9.
//  Copyright (c) 2012年 Ayi Chen. All rights reserved.
//

#import "DefaultSettingsViewController.h"

@interface DefaultSettingsViewController ()

@end

@implementation DefaultSettingsViewController

@synthesize welcomeLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    if ([PFUser currentUser]) {
        [welcomeLabel setText:[NSString stringWithFormat:@"Welcome %@!", [[PFUser currentUser] username]]];
    } else {
        [welcomeLabel setText:@"Not logged in"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) { // 沒有使用者登入
        // 開啟Login畫面
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsFacebook |PFLogInFieldsSignUpButton | PFLogInFieldsPasswordForgotten;
        
        logInViewController.delegate = self;
        logInViewController.signUpController.delegate = self;
        [self presentViewController:logInViewController animated:YES completion:NULL];
        
        
        // 創造 sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        
        
        // Present the log in view controller
        //        [self presentViewController:logInViewController animated:YES completion:NULL];
        
    }
}


#pragma mark - PFLogInViewControllerDelegate



// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // 確認兩個欄位已經填寫完畢
    if (username && password && username.length !=0 && password.length !=0) {
        return YES; // 開始登入流程
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // 中斷登入流程
}

/* 當 PFUser 登入時，Sent to the delegate。 */
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/* 當登入失敗時時，Sent to the delegate。 */
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - PFSignUpViewControllerDelegate

/* Sent to the delegate，以確認是否申請註冊應當提交到伺服器。 */
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // 遍歷所有提交的數據
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // 檢查完成
            informationComplete = NO;
            break;
        }
    }
    
    // 顯示一個警告，如果一個表格沒有完成
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

/* 當PFUser完成註冊申請時，Sent to the delegate。 */
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/* 當PFUser嘗試註冊失敗時，Sent to the delegate。 */
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}


#pragma mark - Logout button handler

- (IBAction)logOutButtonTapAction:(id)sender {
    [PFUser logOut];
    // Present the log in view controller
    [self viewDidAppear:YES];
    //    [self.navigationController popViewControllerAnimated:YES];
}
@end
