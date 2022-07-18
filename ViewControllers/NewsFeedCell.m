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
        self.title.text = self.news.title;
        self.synopsis.text = self.news.description;
        
    
}

@end
