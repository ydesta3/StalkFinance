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

    // Configure the view for the selected state
    self.ticker.text = [self.baseCom.ticker uppercaseString];
    self.currentPrice.text = [@"$" stringByAppendingString:[NSString stringWithFormat: @"%@", self.baseCom.currentPrice]];
    self.conversionId.text = [self.baseCom.companyName uppercaseString];
}

@end
