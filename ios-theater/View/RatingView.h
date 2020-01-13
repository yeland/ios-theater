//
//  RatingView.h
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/7.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieDetailsViewModel;

@interface RatingView : UIView

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;

@property (weak, nonatomic) IBOutlet UILabel *fiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *fiveProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *fourProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *threeProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *twoProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *oneProgress;

@property (weak, nonatomic) IBOutlet UILabel *ratingCountLabel;

- (void)configure:(MovieDetailsViewModel*) movieDetailsViewModel;
- (void)setRatingCount;

@end
