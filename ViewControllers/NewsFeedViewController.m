//
//  NewsFeedViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/6/22.
//

#import "NewsFeedViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "AccountChoiceViewController.h"
#import "NewsFeedCell.h"
#import "APIManager.h"
#import "News.h"
#import "Stock.h"

@import SafariServices;


@interface NewsFeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITableView *newsFeedTableView;
@property (nonatomic, strong)NSMutableArray *newsArray;
@property (nonatomic, strong) IBOutlet UIRefreshControl *refresh;

@end

@implementation NewsFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *accountOwner = [PFUser currentUser];
    self.userName.text = [ @"@" stringByAppendingString:accountOwner.username];
    self.newsFeedTableView.dataSource = self;
    self.newsFeedTableView.delegate = self;
    [self fetchNews];
    [self updateToPersonalizedNews];
    self.refresh = [[UIRefreshControl alloc] init];
    [self.refresh setTintColor:[UIColor whiteColor]];
    [self.refresh addTarget:self action:@selector(updateToPersonalizedNews) forControlEvents:UIControlEventValueChanged];
    [self.newsFeedTableView addSubview: self.refresh];

}

-(void)fetchNews{
    // Get NewsFeed
    [[APIManager shared] fetchNews:^(NSArray * _Nonnull newsArticles, NSError * _Nonnull error) {
        
        if (newsArticles) {
            self.newsArray = (NSMutableArray *)newsArticles;
            NSLog(@"Successfully loaded News Feed");
        } else {
            NSLog(@"Error getting News Feed: %@", error.localizedDescription);
        }
        [self.newsFeedTableView reloadData];
        [self.refresh endRefreshing];
    }];
}

- (void) updateToPersonalizedNews{
    NSMutableArray *keywords = [[NSMutableArray alloc] init];
    [[PFUser query] getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
    {
        PFUser *currentUser = [PFUser currentUser];
        [keywords addObjectsFromArray:[currentUser valueForKey:@"StocksOfInterest"]];
        NSString *key = [keywords lastObject];
        NSLog(@"TICKERS: %@", key);
        if (keywords != nil){
            [[APIManager shared] fetchHeadlineNews:(NSString *) key completion:^(NSMutableArray *keywordArticles, NSError *error) {
                if (keywordArticles) {
                    //[self.newsArray addObjectsFromArray:keywordArticles]
                    NSLog(@"Successfully loaded Headline News");
                    for (News *dict in keywordArticles) {
                        [self.newsArray insertObject:dict atIndex:0];
                        NSLog(@": Updated News Descriptions: %@", dict.description);
                    }
                } else {
                    NSLog(@"Error getting Headline News: %@", error.localizedDescription);
                }
                [self.newsFeedTableView reloadData];
           }];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];    
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NewsFeedCell *newsFeed = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    News *article = self.newsArray[indexPath.row];
    // sets news instance to be an article in an index of the news collection
    newsFeed.news = article;
    newsFeed.selectionStyle = nil;
    return newsFeed;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    News *selectedArticle = self.newsArray[indexPath.row];
    NSString *articleUrlString = selectedArticle.urlToArticle;
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", articleUrlString]];
    SFSafariViewController *safariViewCont = [[SFSafariViewController alloc] initWithURL:URL];
    [self presentViewController:safariViewCont animated:YES completion:nil];
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}



@end
