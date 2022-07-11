//
//  LogoutViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/6/22.
//

#import "LogoutViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "AccountChoiceViewController.h"


@interface LogoutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end

@implementation LogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *accountOwner = [PFUser currentUser];
    NSString *at = @"@";
    self.userName.text = [ at stringByAppendingString:accountOwner.username];

}
- (IBAction)onSignoutTap:(id)sender {
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AccountChoiceViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"InitialViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
    
    
}

@end
