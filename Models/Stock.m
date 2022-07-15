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
        self.openPrice = dictionary[@"regularMarketOpen"];
        self.percentChange = dictionary[@"regularMarketChangePercent"];
        self.highPrice = dictionary[@"regularMarketDayHigh"];
        self.lowPrice = dictionary[@"regularMarketDayLow"];
        self.tradingVolume = dictionary[@"regularMarketVolume"];
        self.lowFiftyTwo = dictionary[@"fiftyTwoWeekLow"];
        self.highFiftyTwo = dictionary[@"fiftyTwoWeekHigh"];
        self.ask = dictionary[@"ask"];
        self.averageAnalystRating = dictionary[@"fiftyTwoWeekHigh"];
        self.averageDailyVolume10Day = dictionary[@"averageDailyVolume10Day"];
        self.bidSize = dictionary[@"bidSize"];
        self.currency = dictionary[@"currency"];
        self.exchange = dictionary[@"exchange"];
        self.marketCap = dictionary[@"marketCap"];
        self.quoteSourceName = dictionary[@"quoteSourceName"];
        self.twoHundredDayAverage = dictionary[@"twoHundredDayAverage"];
        self.region = dictionary[@"region"];
    
        self.insight = dictionary[@""];
        self.insightTitle = dictionary[@""];
        self.insightProvider = dictionary[@""];
        self.insightDate = dictionary[@""];

    }
    return self;
}


+ (NSMutableArray *)arrayOfStocks:(NSArray *)dictionariesArray {
    NSMutableArray *stocks = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionariesArray) {
        Stock *stock = [[Stock alloc] initWithDictionary:dictionary];
        [stocks addObject:stock];
    }
    return stocks;
}

@end
