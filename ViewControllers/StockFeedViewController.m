//
//  StockFeedViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/8/22.
//

#import <Parse/Parse.h>
#import "StockFeedViewController.h"
#import "APIManager.h"
#import "Stock.h"
#import "StockCell.h"
#import "StockFeedViewController.h"
#import "StockDetailsViewController.h"
#import "DateTools.h"
#import "NewsFeedViewController.h"
#import "WatchlistTableViewCell.h"

@interface StockFeedViewController () <UISearchBarDelegate, StockDetailsViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *stockTableView;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (nonatomic, strong)NSMutableArray *stocksArray;
@property (nonatomic, strong)NSMutableArray *cacheOfInterestedStocks;
@property (weak, nonatomic) IBOutlet UILabel *todaysDate;
@property (nonatomic, strong) IBOutlet UIRefreshControl *refresh;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong)NSMutableArray *fetchedStockCache;
@property (nonatomic, assign) NSTimer *delay;

@end

@implementation StockFeedViewController

    double delay = 0.5;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stockTableView.dataSource = self;
    self.stockTableView.delegate = self;
    self.searchTableView.dataSource = self;
    self.searchTableView.delegate = self;
    self.searchBar.delegate = self;
    
    //date formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, YYYY"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];
    self.todaysDate.text = dateToday;
    
    [self fetchStocks];
    self.refresh = [[UIRefreshControl alloc] init];
    [self.refresh setTintColor:[UIColor whiteColor]];
    [self.refresh addTarget:self action:@selector(fetchStocks) forControlEvents:UIControlEventValueChanged];
    [self.stockTableView addSubview: self.refresh];
}

-(void)fetchStocks{
    // Get Feed
    NSString *trendingEnterprises = @"AAPL%2CTSLA%2CMETA%2CBA%2CNKE%2CLCID%2CAMC%2CCLOV%2CGME%2CNIO";
    [[APIManager shared] fetchWatchlist:(NSString *) trendingEnterprises completion:^(NSMutableArray *keywordArticles, NSError *error) {
        if (keywordArticles) {
            self.stocksArray = keywordArticles;
        }
        [self.stockTableView reloadData];
        [self.refresh endRefreshing];
    }];
    [[APIManager shared] fetchStockQuote:^(NSMutableArray * _Nonnull stocks, NSError * _Nonnull error) {
        if (stocks) {
            [self.stocksArray addObjectsFromArray:stocks];
        }
        [self.stockTableView reloadData];
        [self.refresh endRefreshing];
    }];
    [self.stockTableView reloadData];
    [self.refresh endRefreshing];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        self.fetchedStockCache = nil;
        [self.searchTableView reloadData];
    } else {
        self.fetchedStockCache = nil;
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(searchApi:) withObject:searchText afterDelay:delay];
    }
}

- (void)searchApi:(NSString *)searchText{
    self.fetchedStockCache = [[NSMutableArray alloc] init];
    [[APIManager shared] fetchWatchlist:(NSString *) searchText completion:^(NSMutableArray *keywordArticles, NSError *error) {
        if (keywordArticles) {
            [self.fetchedStockCache addObjectsFromArray:keywordArticles];
        }
        [self.searchTableView reloadData];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString: @"toStockDetails"]){
        StockDetailsViewController *stockDetailsController = [segue destinationViewController];
        NSIndexPath *index = self.stockTableView.indexPathForSelectedRow;
        Stock *dataToPass = self.stocksArray[index.row];
        stockDetailsController.stock = dataToPass;
    } else if ([segue.identifier isEqualToString: @"searchToDetails"]){
        StockDetailsViewController *stockDetailsController = [segue destinationViewController];
        NSIndexPath *index = self.searchTableView.indexPathForSelectedRow;
        Stock *dataToPass = self.fetchedStockCache[index.row];
        stockDetailsController.stock = dataToPass;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StockCell *stockCell;
    if (tableView == self.stockTableView){
        stockCell = [tableView dequeueReusableCellWithIdentifier:@"stockCell"];
        stockCell.stock  = self.stocksArray[indexPath.row];
    } else if (tableView == self.searchTableView){
        stockCell = [tableView dequeueReusableCellWithIdentifier:@"stockSearchCell"];
        stockCell.stock = self.fetchedStockCache[indexPath.row];
    }
    stockCell.selectionStyle = nil;
    return stockCell;
} 

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchTableView){
        return self.fetchedStockCache.count;
    } else if (tableView == self.stockTableView){
        return self.stocksArray.count;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Stock *stockOfInterest = self.stocksArray[indexPath.row];
    if (tableView == self.searchTableView){
        stockOfInterest = self.fetchedStockCache[indexPath.row];
    }
    NSString *keyword = stockOfInterest.ticker;
    [[PFUser query] getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
    {
        PFUser *currentUser = [PFUser currentUser];
        [currentUser addObject:keyword forKey:@"ViewedStocks"];
        [[PFUser currentUser] saveInBackground];
    }];
    NSDictionary *dimensions = @{
      // Define ranges to bucket data points into meaningful segments
      @"Stock Ticker": [NSString stringWithFormat: @"%@", stockOfInterest.ticker],
      @"User": [NSString stringWithFormat: @"%@", [PFUser currentUser]],
    };
    // Send the dimensions to Parse along with the event
    [PFAnalytics trackEvent:@"UserToStockEngagement" dimensions:dimensions];
}

@end

