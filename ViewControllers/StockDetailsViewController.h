//
//  StockDetailsViewController.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/13/22.
//

#import <UIKit/UIKit.h>
#import "Stock.h"


NS_ASSUME_NONNULL_BEGIN

@protocol StockDetailsViewDelegate

@end
@interface StockDetailsViewController : UIViewController <UINavigationControllerDelegate>

    @property (nonatomic, weak) id<StockDetailsViewDelegate> delegate;
    @property (strong, nonatomic) Stock *stock;

@end

NS_ASSUME_NONNULL_END
