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
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 2;
    formatter.roundingMode = NSNumberFormatterRoundUp;
    NSString *currentPriceStringRounded = [formatter stringFromNumber:self.stock.currentPrice];
    self.currentPrice.text = [ @"$ " stringByAppendingString:currentPriceStringRounded];
    NSString *marketChangePercentStringRounded = [formatter stringFromNumber:self.stock.percentChange];
    NSString *percent = @" %";
    self.percentMarketChange.text = [ marketChangePercentStringRounded stringByAppendingString:percent];
    self.exchange.text = self.stock.exchange;
    
}

@end
