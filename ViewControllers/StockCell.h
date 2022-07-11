//
//  StockCell.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "Stock.h"


NS_ASSUME_NONNULL_BEGIN

@interface StockCell : UITableViewCell

@property (strong, nonatomic) Stock *stock;

@property (weak, nonatomic) IBOutlet UILabel *stockTicker;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *percentMarketChange;



@end

NS_ASSUME_NONNULL_END
