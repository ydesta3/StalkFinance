//
//  News.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/18/22.
//

#import "News.h"

@implementation News

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self){
    
        
        
    }

    return self;
}

+ (NSMutableArray *)arrayOfNews:(NSArray *)dictionaries {
    NSMutableArray *newsArticles = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        News *news = [[News alloc] initWithDictionary:dictionary];
        [newsArticles addObject:news];
    }
    return newsArticles;
}

@end
