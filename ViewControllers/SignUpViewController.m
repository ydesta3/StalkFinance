//
//  signUpViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/6/22.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onSignupTap:(id)sender {
    // initialize a user object
       PFUser *newUser = [PFUser user];
       
       // set user properties
       newUser.email = self.emailField.text;
       newUser.username = self.usernameField.text;
       newUser.password = self.passwordField.text;
       
       // call sign up function on the object
       [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
           if (error != nil) {
               NSLog(@"Error: %@", error.localizedDescription);
           } else {
               NSLog(@"User registered successfully");
               // manually segue to logged in view
               SceneDelegate *sceneDelegate = (SceneDelegate *)UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
               UITabBarController *tabbViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabViewController"];
               sceneDelegate.window.rootViewController = tabbViewController;
           }
       }];
    
}


@end
