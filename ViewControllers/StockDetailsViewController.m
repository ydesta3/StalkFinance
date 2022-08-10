//
//  StockDetailsViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/13/22.
//

#import "StockDetailsViewController.h"
#import <Parse/Parse.h>
#import "SCLAlertView-Objective-C-umbrella.h"

@interface StockDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ticker;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *exchange;
@property (weak, nonatomic) IBOutlet UILabel *analystRating;
@property (weak, nonatomic) IBOutlet UILabel *open;
@property (weak, nonatomic) IBOutlet UILabel *high;
@property (weak, nonatomic) IBOutlet UILabel *low;
@property (weak, nonatomic) IBOutlet UILabel *fiftyTwoWeekHigh;
@property (weak, nonatomic) IBOutlet UILabel *fiftyTwoWeekLow;
@property (weak, nonatomic) IBOutlet UILabel *marketPrice;
@property (weak, nonatomic) IBOutlet UILabel *percentChange;
@property (weak, nonatomic) IBOutlet UILabel *ask;
@property (weak, nonatomic) IBOutlet UILabel *askSize;
@property (weak, nonatomic) IBOutlet UILabel *bid;
@property (weak, nonatomic) IBOutlet UILabel *bidSize;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *scrollVew;
@property (nonatomic, strong) NSDate *viewSessionStart;
@property (nonatomic, strong) NSDate *viewSessionEnd;

@end

@implementation StockDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 2;
    formatter.roundingMode = NSNumberFormatterRoundUp;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+300);
    self.ticker.text = self.stock.ticker;
    self.companyName.text = self.stock.companyName;
    self.exchange.text = self.stock.exchange;
    self.analystRating.text = [NSString stringWithFormat: @"%@", self.stock.averageAnalystRating];
    self.open.text = [formatter stringFromNumber:self.stock.openPrice];
    self.high.text = [formatter stringFromNumber:self.stock.highPrice];
    self.low.text = [formatter stringFromNumber: self.stock.lowPrice];
    self.fiftyTwoWeekHigh.text = [formatter stringFromNumber: self.stock.highFiftyTwo];
    self.fiftyTwoWeekLow.text = [formatter stringFromNumber:self.stock.lowFiftyTwo];
    NSString *currentPriceString = [formatter stringFromNumber: self.stock.currentPrice];
    self.marketPrice.text = [ @"$ " stringByAppendingString:currentPriceString];
    NSString *marketChangePercentString = [formatter stringFromNumber: self.stock.percentChange];
    self.percentChange.text =  [ marketChangePercentString stringByAppendingString:@"%"];
    self.ask.text = [NSString stringWithFormat: @"%@", self.stock.ask];
    NSString *askSizeFormat = [NSString stringWithFormat: @"%@", self.stock.askSize];
    self.askSize.text = askSizeFormat;
    self.bid.text = [NSString stringWithFormat: @"%@", self.stock.bid];
    NSString *bidSizeFormat = [NSString stringWithFormat: @"%@", self.stock.bidSize];
    self.bidSize.text = bidSizeFormat;
}

- (IBAction)onDoubleTap:(id)sender {
    NSString *keyword = self.stock.ticker;
    [[PFUser query] getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
    {
        PFUser *currentUser = [PFUser currentUser];
        [currentUser addObject:keyword forKey:@"StocksOfInterest"];
        [[PFUser currentUser] saveInBackground];
    }];
    SCLAlertView *alert = [[SCLAlertView alloc] init];
        //alert.showAnimationType = SCLAlertViewHideAnimationSlideOutToCenter;
    alert.hideAnimationType = SCLAlertViewHideAnimationSlideOutFromCenter;
    alert.backgroundType = SCLAlertViewBackgroundBlur;
    [alert showSuccess:self title:@"Added to WatchList" subTitle:[self.stock.companyName stringByAppendingString:@" was saved to your WatchList"] closeButtonTitle:@"Done" duration:0.0f];
}

- (void)viewDidAppear:(BOOL)animated{
    self.viewSessionEnd = nil;
    self.viewSessionStart = [NSDate date];
}

- (void)viewDidDisappear:(BOOL)animated{
    self.viewSessionEnd = [NSDate date];
    NSTimeInterval distanceBetweenDates = [self.viewSessionStart timeIntervalSinceDate:self.viewSessionEnd];
    NSString *minutesBetweenDates = [NSString stringWithFormat:@"%f", (distanceBetweenDates / 60)];
    [[PFUser query] getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        [[PFUser currentUser] addObject: minutesBetweenDates forKey:@"TimeSpent"];
        [[PFUser currentUser] addObject: self.stock.ticker forKey:@"TimeSpentTicker"];
        [[PFUser currentUser] saveInBackground];
    }];
    self.viewSessionStart = nil;
    
}

- (IBAction)didTapDismiss:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
