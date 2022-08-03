//
//  CryptoDetailsViewController.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/13/22.
//

#import <UIKit/UIKit.h>
#import "Crypto.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CryptoDetailsViewDelegate


@end

@interface CryptoDetailsViewController : UIViewController <UINavigationControllerDelegate>

    @property (nonatomic, weak) id<CryptoDetailsViewDelegate> delegate;
    @property (strong, nonatomic) Crypto *crypto;

@end

NS_ASSUME_NONNULL_END
