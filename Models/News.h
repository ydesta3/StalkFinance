//
//  News.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/18/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface News : NSObject

    @property (nonatomic, strong) NSString *author;
    @property (nonatomic, strong) NSString *title;
    @property (nonatomic, strong) NSString *content;
    @property (nonatomic, strong) NSString *synopsis;
    @property (nonatomic, strong) NSURL *url;
    @property (nonatomic, strong) NSURL *publishedAt;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)arrayOfNews:(NSArray *)dictionaries;


@end

NS_ASSUME_NONNULL_END
