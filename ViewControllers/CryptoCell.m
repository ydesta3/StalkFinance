//
//  CryptoCell.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/11/22.
//

#import "CryptoCell.h"

@implementation CryptoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.ticker.text = [self.crypto.ticker uppercaseString];
    self.currentPrice.text = (NSString *)self.crypto.currentPrice;
    NSString *marketChangePercentString = [NSString stringWithFormat: @"%@", self.crypto.percentChange];
    self.percentMarketChange.text = [ marketChangePercentString stringByAppendingString:@" %"];
    self.conversionId.text = [self.crypto.conversionId uppercaseString];
    
}

@end
