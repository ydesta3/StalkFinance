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
    NSString *baseStockUrl = @"https://yfapi.net/v6/finance/quote?region=US&lang=en&symbols=";
    double timeOutInterval = 10.0;

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

-(void) fetchStockQuote :(void(^)(NSMutableArray *stocks, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:stockUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeOutInterval];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSString *key = [dict objectForKey: @"APIKey"];
    [request addValue:key forHTTPHeaderField:@"X-API-KEY"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error == nil) {
               NSDictionary *stockDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSDictionary *financeDictionary = stockDictionary[@"finance"];
               NSDictionary *result = financeDictionary[@"result"];
               NSMutableArray *quotes = nil;
               for (NSDictionary *dict in result) {
                   quotes = dict[@"quotes"];
               }
               NSMutableArray *stocks = [Stock arrayOfStocks:quotes];
               completion(stocks, nil);
           }
       }];
    [task resume];
}

- (void)fetchCryptoQuotes:(void(^)(NSArray *stocks, NSError *error))completion{
    NSURL *url = [NSURL URLWithString:cryptoUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeOutInterval];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSString *key = [dict objectForKey: @"APIKey"];
    [request addValue:key forHTTPHeaderField:@"X-API-KEY"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error == nil) {
              NSDictionary *cryptoDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
              NSMutableArray *quotes = cryptoDictionary[@"data"];
              NSMutableArray *cryptoAttributes = [[NSMutableArray alloc] init];
              for (NSMutableDictionary *dict in quotes) {
                  NSMutableDictionary *cryptoAttribute = dict[@"attributes"];
                  NSMutableDictionary *cryptoAttributee = dict[@"meta"];
                  [cryptoAttribute addEntriesFromDictionary:cryptoAttributee];
                  [cryptoAttributes addObject: cryptoAttribute];
              }
              NSMutableArray *cryptos = [Crypto arrayOfCryptoAttributes:cryptoAttributes];
              completion(cryptos, nil);
          }
      }];
   [task resume];
    
}

- (void)fetchNews: (void(^)(NSArray *newsArticles, NSError *error))completion{
    NSURL *url = [NSURL URLWithString:businessNewsApiUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeOutInterval];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSString *key = [dict objectForKey: @"NewsArticles"];
    [request addValue:key forHTTPHeaderField:@"X-Api-Key"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error == nil) {
              NSDictionary *newsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
              NSMutableArray *articles = newsDictionary[@"articles"];
              NSMutableArray *articleOfNews = [News arrayOfNews:articles];
              completion(articleOfNews, nil);
          }
      }];
   [task resume];
    
}

- (void)fetchHeadlineNews:(NSString *)ticker completion:(void(^)(NSMutableArray *allNewsArticles, NSError *error))completion {
    NSString *keyword = ticker;
    if (ticker != nil) {
        NSString *appendEndpoint = [headlinesApiUrl stringByAppendingString:keyword];
        NSURL *urlforSpecificHeadlines = [NSURL URLWithString:appendEndpoint];
        NSMutableURLRequest *requestForHeadlines = [NSMutableURLRequest requestWithURL:urlforSpecificHeadlines cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeOutInterval];
        [requestForHeadlines setHTTPMethod:@"GET"];
        [requestForHeadlines setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
        NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
        NSString *key = [dict objectForKey: @"NewsArticles"];
        [requestForHeadlines addValue:key forHTTPHeaderField:@"X-Api-Key"];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:requestForHeadlines completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               if (error == nil) {
                  NSDictionary *newsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                  NSMutableArray *storylinesForKeyword = newsDictionary[@"articles"];
                  NSMutableArray *keywordArticleOfNews = [News arrayOfNews:storylinesForKeyword];
                  completion(keywordArticleOfNews, nil);
              }
          }];
       [task resume];
    }
    
}

- (void)fetchWatchlist:(NSString *)ticker completion:(void(^)(NSMutableArray *allNewsArticles, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:[baseStockUrl stringByAppendingString:ticker]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeOutInterval];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSString *key = [dict objectForKey: @"APIKey"];
    [request addValue:key forHTTPHeaderField:@"X-API-KEY"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error == nil) {
              NSDictionary *financeDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
              NSDictionary *stockDictionary = financeDictionary[@"quoteResponse"];
              NSMutableArray *result = stockDictionary[@"result"];
              NSMutableArray *stocksWatchlistUsingStockAttributes = [Stock arrayOfStocks:result];
              completion(stocksWatchlistUsingStockAttributes, nil);
          }
      }];
   [task resume];
}

@end
