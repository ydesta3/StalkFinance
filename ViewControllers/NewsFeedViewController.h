//
//  NewsFeedViewController.h
//  StalkFinance
//
//  Created by Yonatan Desta on 7/6/22.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@protocol NewsFeedViewDelegate

@end

@interface NewsFeedViewController : UIViewController<NewsFeedViewDelegate>

    @property (nonatomic, weak) id<NewsFeedViewDelegate> delegate;
    @property(nonatomic, retain)NSMutableArray *stocksOfInterest;

@end

NS_ASSUME_NONNULL_END
