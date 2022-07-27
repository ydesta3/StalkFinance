//
//  APIManager.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/7/22.
//

#import "BDBOAuth1SessionManager.h"
#import "Stock.h"
#import "Crypto.h"
#import "News.h"





NS_ASSUME_NONNULL_BEGIN

@interface APIManager : BDBOAuth1SessionManager


+ (instancetype)shared;

- (void)fetchStockQuote:(void(^)(NSArray *stocks, NSError *error))completion;
- (void)fetchCryptoQuotes:(void(^)(NSArray *crypto, NSError *error))completion;
- (void)fetchNews:(void(^)(NSArray *newsArticles, NSError *error))completion;
- (void)fetchHeadlineNews:(NSString *)ticker completion:(void(^)(NSMutableArray *allNewsArticles, NSError *error))completion;




@end

NS_ASSUME_NONNULL_END
