//
//  StockCell.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/8/22.
//

#import "StockCell.h"

@implementation StockCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.stockTicker.text = self.stock.ticker;
    self.companyName.text = self.stock.companyName;
    NSString *currentPriceString = [NSString stringWithFormat: @"%@", self.stock.currentPrice];
    self.currentPrice.text = currentPriceString;
    NSString *marketChangePercentString = [NSString stringWithFormat: @"%@", self.stock.percentChange];
    self.percentMarketChange.text = marketChangePercentString;
    


    
}

@end
