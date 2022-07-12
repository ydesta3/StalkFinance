//
//  CryptoCell.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/11/22.
//

#import <UIKit/UIKit.h>
#import "Crypto.h"


NS_ASSUME_NONNULL_BEGIN

@interface CryptoCell : UITableViewCell
@property (strong, nonatomic) Crypto *crypto;
@property (weak, nonatomic) IBOutlet UILabel *ticker;
@property (weak, nonatomic) IBOutlet UILabel *crypSymbol;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *percentMarketChange;

@end

NS_ASSUME_NONNULL_END
