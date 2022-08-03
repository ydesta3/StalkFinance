//
//  StockDetailsViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/13/22.
//

#import "StockDetailsViewController.h"
#import <Parse/Parse.h>


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


@end

@implementation StockDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+300);
    // Do any additional setup after loading the view.
    self.ticker.text = self.stock.ticker;
    self.companyName.text = self.stock.companyName;
    self.exchange.text = self.stock.exchange;
    self.analystRating.text = [NSString stringWithFormat: @"%@", self.stock.averageAnalystRating];
    self.open.text = [NSString stringWithFormat: @"%@",self.stock.openPrice];
    self.high.text = [NSString stringWithFormat: @"%@", self.stock.highPrice];
    self.low.text = [NSString stringWithFormat: @"%@", self.stock.lowPrice];
    self.fiftyTwoWeekHigh.text = [NSString stringWithFormat: @"%@",self.stock.highFiftyTwo];
    self.fiftyTwoWeekLow.text = [NSString stringWithFormat: @"%@", self.stock.lowFiftyTwo];
    NSString *currentPriceString = [NSString stringWithFormat: @"%@", self.stock.currentPrice];
    self.marketPrice.text = [ @"$ " stringByAppendingString:currentPriceString];
    NSString *marketChangePercentString = [NSString stringWithFormat: @"%@", self.stock.percentChange];
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
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Added to WatchList"
                               message:[self.stock.companyName stringByAppendingString:@" was saved to your WatchList"]
                               preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (IBAction)didTapDismiss:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
