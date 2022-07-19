//
//  NewsFeedCell.m
//  StalkFinance
//
//  Created by Yonatan Desta on 7/13/22.
//

#import "NewsFeedCell.h"


@implementation NewsFeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.title.text = (NSString *)self.news.title;
    self.synopsis.text = (NSString *)self.news.description;
    NSURL *url = [NSURL URLWithString:self.news.urlImage];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    // stores data in image object
    UIImage *image = [UIImage imageWithData:urlData];
    self.articleImage.image = image;
    
}

@end
