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
        self.ticker = dictionary[@"identifier"];
        
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
