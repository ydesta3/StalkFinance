//
//  APIManager.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/7/22.
//

#import "APIManager.h"

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

-(void) fetchStockQuote :(void(^)(NSArray *stocks, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:@"https://yfapi.net/ws/screeners/v1/finance/screener/predefined/saved?count=50&scrIds=day_gainers"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    [request addValue:@"GgHWhppNwH3KttVotQC8xaueTeyQlkwy7T4Nd0L3" forHTTPHeaderField:@"X-API-KEY"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@": YD1: %@", [error localizedDescription]);
//               UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Stock Info"
//                                              message:@"The Internet connection seems to be offline."
//                                              preferredStyle:UIAlertControllerStyleAlert];
//               UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault
//                                                                     handler:^(UIAlertAction * action) {[self fetchStockQuote];}];
//
//               [alert addAction:defaultAction];
            }
           else {
               NSDictionary *stockDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSLog(@": YD2: %@", stockDictionary);

           }
       }];
    [task resume];
}

@end