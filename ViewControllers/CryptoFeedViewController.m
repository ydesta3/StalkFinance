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

@interface CryptoFeedViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *cryptoTableView;
@property (nonatomic, strong)NSMutableArray *cryptoArray;

@end

@implementation CryptoFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cryptoTableView.dataSource = self;
    self.cryptoTableView.delegate = self;
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
        CryptoCell *cryptoCell = [tableView dequeueReusableCellWithIdentifier:@"cryptoCell"];
        Crypto *crypto = self.cryptoArray[indexPath.row];
        // sets stock instance to current stock in stock cell
        cryptoCell.crypto = crypto;
        cryptoCell.selectionStyle = nil;
        
        return cryptoCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;//self.stocksArray.count;
}

@end
