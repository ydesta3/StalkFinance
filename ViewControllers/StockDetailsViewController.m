//
//  StockDetailsViewController.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/13/22.
//

#import "StockDetailsViewController.h"

@interface StockDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ticker;
@property (weak, nonatomic) IBOutlet UILabel *companyName;

@end

@implementation StockDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ticker.text = self.stock.ticker;
    self.companyName.text = self.stock.companyName;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
