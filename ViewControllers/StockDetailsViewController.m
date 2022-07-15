//
//  StockDetailsViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/13/22.
//

#import "StockDetailsViewController.h"

@interface StockDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ticker;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *exchange;
@property (weak, nonatomic) IBOutlet UILabel *analystRating;
@property (weak, nonatomic) IBOutlet UILabel *open;
@property (weak, nonatomic) IBOutlet UILabel *high;
@property (weak, nonatomic) IBOutlet UILabel *low;
@property (weak, nonatomic) IBOutlet UILabel *fiftyTwoWeekHigh;
@property (weak, nonatomic) IBOutlet UILabel *fiftyTwoWeekLow;
@property (weak, nonatomic) IBOutlet UILabel *marketPrice;
@property (weak, nonatomic) IBOutlet UILabel *percentChange;

@end

@implementation StockDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ticker.text = self.stock.ticker;
    self.companyName.text = self.stock.companyName;
    self.exchange.text = self.stock.exchange;
    self.analystRating.text = [NSString stringWithFormat: @"%@", self.stock.averageAnalystRating];
    self.open.text = [NSString stringWithFormat: @"%@",self.stock.openPrice];
    self.high.text = [NSString stringWithFormat: @"%@", self.stock.highPrice];
    self.low.text = [NSString stringWithFormat: @"%@", self.stock.lowPrice];
    self.fiftyTwoWeekHigh.text = [NSString stringWithFormat: @"%@",self.stock.highFiftyTwo];
    self.fiftyTwoWeekLow.text = [NSString stringWithFormat: @"%@", self.stock.lowFiftyTwo];
    NSString *currentPriceString = [NSString stringWithFormat: @"%@", self.stock.currentPrice];
    self.marketPrice.text = [ @"$ " stringByAppendingString:currentPriceString];
    NSString *marketChangePercentString = [NSString stringWithFormat: @"%@", self.stock.percentChange];
    self.percentChange.text =  [ marketChangePercentString stringByAppendingString:@"%"];
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
