//
//  Crypto.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/7/22.
//

#import "Crypto.h"

@implementation Crypto

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self){
        self.conversionId = dictionary[@"identifier"];
        if (self.conversionId == nil){
            self.conversionId = @" ";
        }
        self.percentChange = dictionary[@"percentChange"];
        self.ticker = dictionary[@"symbol"];
        if (self.ticker == nil){
            self.ticker = dictionary[@"name"];
        }
        self.currentPrice = dictionary[@"price"];
        self.openPrice = dictionary[@"open"];
        self.highTwentyFour = dictionary[@"high24"];
        self.lowTwentyFour = dictionary[@"low24"];
        self.twentyFourHrVolDollars = dictionary[@"volume24usd"];
        self.previousClose = dictionary[@"previousClose"];
        self.supply = dictionary[@"supply"];
        self.marketCap = dictionary[@"marketcap"];
        self.updatedAt = dictionary[@"\"updated_at"];
    }
    return self;
}

+ (NSMutableArray *)arrayOfCryptoAttributes:(NSArray *)dictionaries {
    NSMutableArray *cryptos = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Crypto *crypto = [[Crypto alloc] initWithDictionary:dictionary];
        [cryptos addObject:crypto];
    }
    return cryptos;
}

@end
