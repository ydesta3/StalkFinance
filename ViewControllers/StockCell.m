//
//  StockCell.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/8/22.
//

#import "StockCell.h"
#include <math.h>

@implementation StockCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.stockTicker.text = self.stock.ticker;
    self.companyName.text = self.stock.companyName;
    NSString *currentPriceString = [NSString stringWithFormat: @"%@", self.stock.currentPrice];
    self.currentPrice.text = [ @"$ " stringByAppendingString:currentPriceString];
    NSString *marketChangePercentString = [NSString stringWithFormat: @"%@", self.stock.percentChange];
    NSString *percent = @" %";
    self.percentMarketChange.text = [ marketChangePercentString stringByAppendingString:percent];
    self.exchange.text = self.stock.exchange;
    
}

@end
