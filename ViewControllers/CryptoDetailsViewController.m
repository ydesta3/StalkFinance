//
//  CryptoDetailsViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/13/22.
//

#import "CryptoDetailsViewController.h"

@interface CryptoDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ticker;
@property (weak, nonatomic) IBOutlet UILabel *conversionId;
@property (weak, nonatomic) IBOutlet UILabel *open;
@property (weak, nonatomic) IBOutlet UILabel *high;
@property (weak, nonatomic) IBOutlet UILabel *low;
@property (weak, nonatomic) IBOutlet UILabel *twentyFourHrHigh;
@property (weak, nonatomic) IBOutlet UILabel *marketCap;
@property (weak, nonatomic) IBOutlet UILabel *supply;
@property (weak, nonatomic) IBOutlet UILabel *twentyFourHrVol;
@property (weak, nonatomic) IBOutlet UILabel *previousClose;
@property (weak, nonatomic) IBOutlet UILabel *marketPrice;
@property (weak, nonatomic) IBOutlet UILabel *percentChange;

@end

@implementation CryptoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ticker.text = [self.crypto.ticker uppercaseString];
    self.conversionId.text = [self.crypto.conversionId uppercaseString];
    self.open.text = [NSString stringWithFormat: @"%@", self.crypto.openPrice];
    self.high.text = [NSString stringWithFormat: @"%@",self.crypto.highTwentyFour];
    self.low.text = [NSString stringWithFormat: @"%@", self.crypto.lowTwentyFour];
    self.twentyFourHrHigh.text = [NSString stringWithFormat: @"%@", self.crypto.highTwentyFour];
    self.marketCap.text = [NSString stringWithFormat: @"%@", self.crypto.marketCap];
    self.twentyFourHrVol.text = [NSString stringWithFormat: @"%@", self.crypto.twentyFourHrVolDollars];
    self.previousClose.text = [NSString stringWithFormat: @"%@",self.crypto.previousClose];
    self.marketPrice.text = (NSString *)self.crypto.currentPrice;
    NSString *marketChangePercentString = [NSString stringWithFormat: @"%@", self.crypto.percentChange];
    self.percentChange.text = [ marketChangePercentString stringByAppendingString:@" %"];
    self.supply.text = self.crypto.supply;
    
    
}
- (IBAction)didTapDismiss:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
