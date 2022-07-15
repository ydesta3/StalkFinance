//
//  Stock.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/7/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Stock : NSObject

    @property (nonatomic, strong) NSString *ticker;
    @property (nonatomic, strong) NSString *companyName;
    @property (nonatomic, strong) NSNumber *currentPrice;
    @property (nonatomic, strong) NSNumber *openPrice;
    @property (nonatomic, strong) NSNumber *percentChange;
    @property (nonatomic, strong) NSNumber *highPrice;
    @property (nonatomic, strong) NSNumber *lowPrice;
    @property (nonatomic, strong) NSNumber *tradingVolume;
    @property (nonatomic, strong) NSNumber *lowFiftyTwo;
    @property (nonatomic, strong) NSNumber *highFiftyTwo;
    @property (nonatomic, strong) NSString *insight;
    @property (nonatomic, strong) NSString *insightTitle;
    @property (nonatomic, strong) NSString *insightProvider;
    @property (nonatomic, strong) NSDate *insightDate;
    @property (nonatomic, strong) NSNumber *ask;
    @property (nonatomic, strong) NSDecimalNumber *averageAnalystRating;
    @property (nonatomic, strong) NSNumber *averageDailyVolume10Day;
    @property (nonatomic, strong) NSNumber *bidSize;
    @property (nonatomic, strong) NSString *currency;
    @property (nonatomic, strong) NSString *exchange;
    @property (nonatomic, strong) NSNumber *marketCap;
    @property (nonatomic, strong) NSString *quoteSourceName;
    @property (nonatomic, strong) NSString *twoHundredDayAverage;
    @property (nonatomic, strong) NSString *region;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)arrayOfStocks:(NSArray *)dictionaries;


@end

NS_ASSUME_NONNULL_END
