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





@interface StockFeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *stockTableView;
@property (nonatomic, strong)NSMutableArray *stocksArray;



@end

@implementation StockFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stockTableView.dataSource = self;
    self.stockTableView.delegate = self;
    [self fetchStocks];
    
}

-(void)fetchStocks{
    // Get timeline
    [[APIManager shared] fetchStockQuote:^(NSArray * _Nonnull stocks, NSError * _Nonnull error) {
        
        if (stocks) {
            self.stocksArray = (NSMutableArray *)stocks;
            NSLog(@"Successfully loaded Stock Feed");
            //
            for (Stock *stock in stocks) {
                // uses text field in tweet model to fetch the text body of a tweet.
                NSString *company = stock.companyName;
                NSLog(@": YD: %@", company);
            }
        } else {
            NSLog(@"Error getting Stock Feed: %@", error.localizedDescription);
        }
        [self.stockTableView reloadData];
        
    
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StockCell *stockCell = [tableView dequeueReusableCellWithIdentifier:@"d"];
    Stock *stock = self.stocksArray[indexPath.row];
    // sets tweet instance to current tweet in tweet cell
    stockCell.stock = stock;
    stockCell.selectionStyle = nil;

    return stockCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stocksArray.count;
}

@end