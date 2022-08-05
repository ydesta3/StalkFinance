//
//  WatchlistTableViewCell.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/27/22.
//

#import "WatchlistTableViewCell.h"

@implementation WatchlistTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 2;
    formatter.roundingMode = NSNumberFormatterRoundUp;
    self.ticker.text = [self.baseCom.ticker uppercaseString];
    NSString *currentPriceStringRounded = [formatter stringFromNumber:self.baseCom.currentPrice];
    self.currentPrice.text = [@"$" stringByAppendingString:currentPriceStringRounded];
    self.conversionId.text = [self.baseCom.companyName uppercaseString];
}

@end
