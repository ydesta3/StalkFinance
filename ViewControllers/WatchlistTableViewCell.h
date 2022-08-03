//
//  WatchlistTableViewCell.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/27/22.
//

#import <UIKit/UIKit.h>
#import "Crypto.h"
#import "Stock.h"


NS_ASSUME_NONNULL_BEGIN

@interface WatchlistTableViewCell : UITableViewCell

    @property (strong, nonatomic) Stock *baseCom;
    @property (weak, nonatomic) IBOutlet UILabel *ticker;
    @property (weak, nonatomic) IBOutlet UILabel *currentPrice;
    @property (weak, nonatomic) IBOutlet UILabel *percentMarketChange;
    @property (weak, nonatomic) IBOutlet UILabel *conversionId;

@end

NS_ASSUME_NONNULL_END
