//
//  CryptoFeedViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/11/22.
//

#import "CryptoFeedViewController.h"
#import "CryptoCell.h"
#import "Stock.h"
#import "StockCell.h"
#import "APIManager.h"
#import "CryptoDetailsViewController.h"
#import "DateTools.h"



@interface CryptoFeedViewController ()<CryptoDetailsViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *cryptoTableView;
@property (nonatomic, strong)NSMutableArray *cryptoArray;

@end

@implementation CryptoFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cryptoTableView.dataSource = self;
    self.cryptoTableView.delegate = self;
    [self fetchCryptoData];
}

-(void) fetchCryptoData{
    // Get timeline
    [[APIManager shared] fetchCryptoQuotes:^(NSArray * _Nonnull cryptos, NSError * _Nonnull error) {
        
        if (cryptos) {
            self.cryptoArray = (NSMutableArray *)cryptos;
            NSLog(@"Successfully loaded Crypto Feed");
            //
            for (Crypto *crypto in cryptos) {
                // uses text field in stock model to fetch the text body of a stock.
                NSString *ticker = crypto.ticker;
                NSLog(@": cryptoTickers: %@", ticker);
            }
        } else {
            NSLog(@"Error getting Crypto Feed: %@", error.localizedDescription);
        }
        [self.cryptoTableView reloadData];
        
    
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString: @"toCryptoDetails"]){
        CryptoDetailsViewController *cryptoDetailsController = [segue destinationViewController];
        NSIndexPath *index = self.cryptoTableView.indexPathForSelectedRow;
        Crypto *dataToPass = self.cryptoArray[index.row];
        cryptoDetailsController.crypto = dataToPass;
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        CryptoCell *cryptoCell = [tableView dequeueReusableCellWithIdentifier:@"cryptoCell"];
        Crypto *crypto = self.cryptoArray[indexPath.row];
        // sets stock instance to current stock in stock cell
        //cryptoCell.cryptoMeta = crypto;
        cryptoCell.crypto = crypto;
        //cryptoCell.cryptoMeta = crypto;
        cryptoCell.selectionStyle = nil;
        
        return cryptoCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

@end
