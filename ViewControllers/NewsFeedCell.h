//
//  NewsFeedCell.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/13/22.
//

#import <UIKit/UIKit.h>
#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsFeedCell : UITableViewCell

@property (strong, nonatomic) News *news;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;

@end

NS_ASSUME_NONNULL_END
