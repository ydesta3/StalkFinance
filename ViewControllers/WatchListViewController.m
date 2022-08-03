//
//  WatchListViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/27/22.
//

#import "WatchListViewController.h"
#import "Crypto.h"
#import "Stock.h"
#import "StockCell.h"
#import "APIManager.h"
#import "WatchlistTableViewCell.h"

@interface WatchListViewController ()<UITableViewDelegate, UITableViewDataSource>

    @property (nonatomic, strong)NSMutableArray *watchListArray;
    @property (weak, nonatomic) IBOutlet UITableView *watchListTableView;
    @property (nonatomic, strong) IBOutlet UIRefreshControl *refresh;

@end

@implementation WatchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.watchListTableView.dataSource = self;
    self.watchListTableView.delegate = self;
    
    
    [self fetchWatchListData];
    self.refresh = [[UIRefreshControl alloc] init];
    [self.refresh setTintColor:[UIColor whiteColor]];
    [self.refresh addTarget:self action:@selector(fetchWatchListData) forControlEvents:UIControlEventValueChanged];
    [self.watchListTableView addSubview: self.refresh];
}

-(void) fetchWatchListData{
    // Get timeline
    NSMutableArray *keywords = [[NSMutableArray alloc] init];
    [[PFUser query] getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        PFUser *currentUser = [PFUser currentUser];
        [keywords addObjectsFromArray:[currentUser valueForKey:@"StocksOfInterest"]];
        NSString *tickers = [keywords componentsJoinedByString:@"%2C"];
        [[APIManager shared] fetchWatchlist:(NSString *) tickers completion:^(NSArray *stocks, NSError *error) {
            if (stocks) {
                self.watchListArray = (NSMutableArray *)stocks;
            }
            [self.watchListTableView reloadData];
            [self.refresh endRefreshing];
            
        }];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WatchlistTableViewCell *stockCell = [tableView dequeueReusableCellWithIdentifier:@"WatchListCell"];
    Stock *stock = self.watchListArray[indexPath.row];
    stockCell.baseCom = stock;
    stockCell.selectionStyle = nil;
    return stockCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.watchListArray.count;
}

@end
