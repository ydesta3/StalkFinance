//
//  LogoutViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/6/22.
//

#import "LogoutViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "accountChoiceViewController.h"


@interface LogoutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end

@implementation LogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *accountOwner = [PFUser currentUser];
    self.userName.text = accountOwner.username;

}
- (IBAction)onSignoutTap:(id)sender {
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    accountChoiceViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"InitialViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
