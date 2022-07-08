//
//  APIManager.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/7/22.
//

#import "BDBOAuth1SessionManager.h"
#import "Stock.h"


NS_ASSUME_NONNULL_BEGIN

@interface APIManager : BDBOAuth1SessionManager

@property (nonatomic, strong) IBOutlet UIRefreshControl *refresh;

+ (instancetype)shared;

- (void)fetchStockQuote:(void(^)(NSArray *stocks, NSError *error))completion;


@end

NS_ASSUME_NONNULL_END