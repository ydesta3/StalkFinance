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
    @property (nonatomic, strong) NSString *symbol;
    @property (nonatomic, strong) NSNumber *cryptoName;
    @property (nonatomic, strong) NSNumber *currentPrice;
    @property (nonatomic, strong) NSNumber *openPrice;
    @property (nonatomic, strong) NSNumber *percentChange;
    @property (nonatomic, strong) NSNumber *tradingVolume;
    @property (nonatomic, strong) NSNumber *lowTwentyFour;
    @property (nonatomic, strong) NSNumber *highTwentyFour;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)arrayOfCryptoAttributes:(NSArray *)dictionaries;

@end



NS_ASSUME_NONNULL_END
