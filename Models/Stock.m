//
//  Stock.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/7/22.
//

#import "Stock.h"

@implementation Stock

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self){
        self.ticker = dictionary[@"symbol"];
        self.companyName = dictionary[@"shortName"];
        self.currentPrice = dictionary[@"regularMarketPrice"];
        self.openPrice = dictionary[@""];
        self.percentChange = dictionary[@""];
        self.highPrice = dictionary[@"regularMarketDayHigh"];
        self.lowPrice = dictionary[@"regularMarketDayLow"];
        self.tradingVolume = dictionary[@"regularMarketVolume"];
        self.lowFiftyTwo = dictionary[@"fiftyTwoWeekLow"];
        self.highFiftyTwo = dictionary[@"fiftyTwoWeekHigh"];
        self.insight = dictionary[@""];
        self.insightTitle = dictionary[@""];
        self.insightProvider = dictionary[@""];
        self.insightDate = dictionary[@""];

    }
    return self;
}


+ (NSMutableArray *)arrayOfStocks:(NSArray *)dictionaries {
    NSMutableArray *stocks = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Stock *stock = [[Stock alloc] initWithDictionary:dictionary];
        [stocks addObject:stock];
    }
    return stocks;
}

@end
