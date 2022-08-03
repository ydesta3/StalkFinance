//
//  LoginViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/6/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"

@interface LoginViewController ()

    @property (weak, nonatomic) IBOutlet UITextField *usernameField;
    @property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
        [self.view addGestureRecognizer:gestureRecognizer];
        gestureRecognizer.cancelsTouchesInView = NO;
}

- (void)dismissKeyboard {
     [self.view endEditing:YES];
}

- (IBAction)onLoginTap:(id)sender {
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
        } else {
            // manually segue to logged in view
            SceneDelegate *sceneDelegate = (SceneDelegate *)UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITabBarController *tabbViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabViewController"];
            sceneDelegate.window.rootViewController = tabbViewController;
        }
    }];
}

@end
