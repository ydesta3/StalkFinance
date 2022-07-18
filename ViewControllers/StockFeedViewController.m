//
//  StockFeedViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/8/22.
//

#import "StockFeedViewController.h"
#import "APIManager.h"
#import "Stock.h"
#import "StockCell.h"
#import "StockFeedViewController.h"
#import "StockDetailsViewController.h"
#import "DateTools.h"

@interface StockFeedViewController () <StockDetailsViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *stockTableView;
@property (nonatomic, strong)NSMutableArray *stocksArray;
@property (weak, nonatomic) IBOutlet UILabel *todaysDate;
@property (nonatomic, strong) IBOutlet UIRefreshControl *refresh;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong)NSMutableArray *filteredStocksArray;
@property (nonatomic, assign) BOOL isFiltered;

@end

@implementation StockFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stockTableView.dataSource = self;
    self.stockTableView.delegate = self;
    
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
    [[APIManager shared] fetchStockQuote:^(NSArray * _Nonnull stocks, NSError * _Nonnull error) {
        
        if (stocks) {
            self.stocksArray = (NSMutableArray *)stocks;
            NSLog(@"Successfully loaded Stock Feed");
            //
            for (Stock *stock in stocks) {
                // uses text field in stock model to fetch the text body of a stock.
                NSString *ticker = stock.ticker;
                NSLog(@": YD: %@", ticker);
            }
        } else {
            NSLog(@"Error getting Stock Feed: %@", error.localizedDescription);
        }
        [self.stockTableView reloadData];
        [self.refresh endRefreshing];
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        self.isFiltered = false;
    } else {
        self.isFiltered = true;
        self.filteredStocksArray = [[NSMutableArray alloc] init];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString: @"toStockDetails"]){
        StockDetailsViewController *stockDetailsController = [segue destinationViewController];
        NSIndexPath *index = self.stockTableView.indexPathForSelectedRow;
        Stock *dataToPass = self.stocksArray[index.row];
        stockDetailsController.stock = dataToPass;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StockCell *stockCell = [tableView dequeueReusableCellWithIdentifier:@"stockCell"];
    Stock *stock = self.stocksArray[indexPath.row];
    // sets stock instance to current stock in stock cell
    stockCell.stock = stock;
    stockCell.selectionStyle = nil;
    return stockCell;
} 

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.stocksArray.count;
}

@end
