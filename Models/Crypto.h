//
//  Crypto.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/7/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Crypto : NSObject
    @property (nonatomic, strong) NSString *ticker;
    @property (nonatomic, strong) NSString *conversionId;
    @property (nonatomic, strong) NSString *symbol;
    @property (nonatomic, strong) NSNumber *cryptoName;
    @property (nonatomic, strong) NSString *currentPrice;
    @property (nonatomic, strong) NSNumber *openPrice;
    @property (nonatomic, strong) NSDecimalNumber *percentChange;
    @property (nonatomic, strong) NSNumber *previousClose;
    @property (nonatomic, strong) NSNumber *lowTwentyFour;
    @property (nonatomic, strong) NSNumber *highTwentyFour;
    @property (nonatomic, strong) NSNumber *marketCap;
    @property (nonatomic, strong) NSString *supply;
    @property (nonatomic, strong) NSNumber *twentyFourHrVolDollars;
    @property (nonatomic, strong) NSDate *updatedAt;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)arrayOfCryptoAttributes:(NSArray *)dictionaries;

@end



NS_ASSUME_NONNULL_END
