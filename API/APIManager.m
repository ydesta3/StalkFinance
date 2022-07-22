//
//  APIManager.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/7/22.
//

#import "APIManager.h"

@implementation APIManager
    NSString *stockUrl = @"https://yfapi.net/ws/screeners/v1/finance/screener/predefined/saved?count=50&scrIds=day_gainers";
    NSString *headlinesApiUrl = @"https://newsapi.org/v2/top-headlines?q=";
    NSString *businessNewsApiUrl = @"https://newsapi.org/v2/top-headlines?country=us&category=business";
    NSString *cryptoUrl = @"https://alpha.financeapi.net/market/get-realtime-prices?symbols=BTC-USD%2CETH-USD%2CXRP-USD%2CDOGE-USD%2CSOL-USD%2CSHIB-USD%2CADA-USD%2CMATIC-USD%2CLTC-USD%2CUSDT-USD";


+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

-(void) fetchStockQuote :(void(^)(NSArray *stocks, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:stockUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSString *key = [dict objectForKey: @"APIKey"];
    [request addValue:key forHTTPHeaderField:@"X-API-KEY"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@": YD1: %@", [error localizedDescription]);
            }
           else {
               NSDictionary *stockDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSDictionary *financeDictionary = stockDictionary[@"finance"];
               NSLog(@": YD2: %@", financeDictionary);
               NSDictionary *result = financeDictionary[@"result"];
               NSLog(@"stockResults: %@", result);
               NSMutableArray *quotes = nil;
               for (NSDictionary *dict in result) {
                   quotes = dict[@"quotes"];
               }
               NSLog(@"stockQuotes: %@", quotes);
               NSMutableArray *stocks = [Stock arrayOfStocks:quotes];
               completion(stocks, nil);
           }
       }];
    [task resume];
}

- (void)fetchCryptoQuotes:(void(^)(NSArray *stocks, NSError *error))completion{
    NSURL *url = [NSURL URLWithString:cryptoUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSString *key = [dict objectForKey: @"APIKey"];
    [request addValue:key forHTTPHeaderField:@"X-API-KEY"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@": YD1: %@", [error localizedDescription]);
           }
          else {
              NSDictionary *cryptoDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
              NSLog(@": CryptoDictionary: %@", cryptoDictionary);
              NSMutableArray *quotes = cryptoDictionary[@"data"];
              NSLog(@"cryptoQ: %@", quotes);
              NSMutableArray *cryptoAttributes = [[NSMutableArray alloc] init];
              for (NSMutableDictionary *dict in quotes) {
                  NSMutableDictionary *cryptoAttribute = dict[@"attributes"];
                  NSMutableDictionary *cryptoAttributee = dict[@"meta"];
                  [cryptoAttribute addEntriesFromDictionary:cryptoAttributee];
                  [cryptoAttributes addObject: cryptoAttribute];
              }
              NSLog(@"cryptoAttributes: %@", cryptoAttributes);
              NSMutableArray *cryptos = [Crypto arrayOfCryptoAttributes:cryptoAttributes];
              completion(cryptos, nil);
          }
      }];
   [task resume];
    
}

- (void)fetchNews: (void(^)(NSArray *newsArticles, NSError *error))completion{
    NSURL *url = [NSURL URLWithString:businessNewsApiUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSString *key = [dict objectForKey: @"News"];
    [request addValue:key forHTTPHeaderField:@"X-Api-Key"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@": YD: %@", [error localizedDescription]);
           }
          else {
              NSDictionary *newsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
              NSLog(@": NewsDictionary: %@", newsDictionary);
              self.allNews = newsDictionary[@"articles"];
              NSLog(@": Storylines: %@", self.allNews);
              NSMutableArray *articleOfNews = [News arrayOfNews:self.allNews];
              completion(articleOfNews, nil);
          }
      }];
   [task resume];
    
}

- (void)fetchHeadlineNews: (void(^)(NSArray *allNewsArticles, NSError *error))completion{
    NSString *appendEndpoint = [headlinesApiUrl stringByAppendingString:ticker];
    NSURL *urlforSpecificHeadlines = [NSURL URLWithString:appendEndpoint];
    NSMutableURLRequest *requestForHeadlines = [NSMutableURLRequest requestWithURL:urlforSpecificHeadlines cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    [requestForHeadlines setHTTPMethod:@"GET"];
    [requestForHeadlines setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSString *key = [dict objectForKey: @"News"];
    [requestForHeadlines addValue:key forHTTPHeaderField:@"X-Api-Key"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:requestForHeadlines completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@": YD: %@", [error localizedDescription]);
           }
          else {
              NSDictionary *newsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
              NSLog(@": NewsDictionary: %@", newsDictionary);
              NSMutableArray *storylines = newsDictionary[@"articles"];
              for (NSMutableDictionary *dict in storylines) {
                  [self.allNews insertObject:dict atIndex:0];
              }
              NSLog(@": Storylines: %@", self.allNews);
              NSMutableArray *allNewsArticles = [News arrayOfNews:self.allNews];
              completion(allNewsArticles, nil);


          }
      }];
   [task resume];
    
}

@end
