//
//  NewsFeedCell.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/13/22.
//

#import "NewsFeedCell.h"
#import "UIImageview+AFNetworking.h"


@implementation NewsFeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.title.text = (NSString *)self.news.title;
    if ([self.synopsis.text isEqualToString:@"<null>"]){
        self.synopsis.text = @" ";
    } else {
        self.synopsis.text = [NSString stringWithFormat:@"%@", self.news.synopsis];
    }
    NSString *urltoImageString = [NSString stringWithFormat:@"%@", self.news.urlImage];
    if ([urltoImageString isEqualToString:@"<null>"]){
        self.articleImage.image = [UIImage imageNamed:@"newspaper.fill"];
    } else {
        NSURL *url = [NSURL URLWithString:urltoImageString];
        [self.articleImage setImageWithURL:url];
    }
    
}

@end
