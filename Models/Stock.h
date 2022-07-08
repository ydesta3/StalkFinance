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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)arrayOfStocks:(NSArray *)dictionaries;


@end

NS_ASSUME_NONNULL_END
