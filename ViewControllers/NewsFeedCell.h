//
//  NewsFeedCell.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/13/22.
//

#import <UIKit/UIKit.h>
#import "Stock.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsFeedCell : UITableViewCell

@property (strong, nonatomic) Stock *news;


@end

NS_ASSUME_NONNULL_END
