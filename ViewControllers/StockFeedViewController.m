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



@interface StockFeedViewController () <UISearchBarDelegate, StockDetailsViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *stockTableView;
@property (nonatomic, strong)NSMutableArray *stocksArray;
@property (nonatomic, strong)NSMutableArray *cacheOfInterestedStocks;
@property (weak, nonatomic) IBOutlet UILabel *todaysDate;
@property (nonatomic, strong) IBOutlet UIRefreshControl *refresh;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong)NSMutableArray *filteredStocksArray;
@property (nonatomic, assign) BOOL isFiltered;

@end

@implementation StockFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stockTableView.dataSource = self;
    self.stockTableView.delegate = self;
    self.cacheOfInterestedStocks = [NSMutableArray array];
    
    _isFiltered = FALSE;
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
    NSString *key = @"AAPL%2CTSLA%2CMETA%2CBA%2CNKE%2CLCID%2CAMC%2CCLOV%2CGME%2CNIO";
    [[APIManager shared] fetchWatchlist:(NSString *) key completion:^(NSMutableArray *keywordArticles, NSError *error) {
        
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
        self.isFiltered = false;
    } else {
        self.isFiltered = true;
        self.filteredStocksArray = [[NSMutableArray alloc] init];
        for (Stock* stock in self.stocksArray){
            NSRange resultsRange = [stock.ticker rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange companyNameResultsRange = [stock.companyName rangeOfString:searchText
                                                                       options:NSCaseInsensitiveSearch];
            NSRange exchangeResultsRange = [stock.exchange rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(resultsRange.location != NSNotFound || companyNameResultsRange.location != NSNotFound ||exchangeResultsRange.location != NSNotFound){
                [self.filteredStocksArray addObject:stock];
            }
        }
    }
    [self.stockTableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString: @"toStockDetails"]){
        StockDetailsViewController *stockDetailsController = [segue destinationViewController];
        NSIndexPath *index = self.stockTableView.indexPathForSelectedRow;
        Stock *dataToPass = self.stocksArray[index.row];
        if(self.isFiltered){
            dataToPass = self.filteredStocksArray[index.row];
        }
        stockDetailsController.stock = dataToPass;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StockCell *stockCell = [tableView dequeueReusableCellWithIdentifier:@"stockCell"];
    Stock *stock = self.stocksArray[indexPath.row];
    if (self.isFiltered){
        stock = self.filteredStocksArray[indexPath.row];
    }
    stockCell.stock = stock;
    stockCell.selectionStyle = nil;
    return stockCell;
} 

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isFiltered){
        return self.filteredStocksArray.count;
    }
    return self.stocksArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Stock *stockOfInterest = self.stocksArray[indexPath.row];
    if (self.isFiltered){
        stockOfInterest = self.filteredStocksArray[indexPath.row];
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
