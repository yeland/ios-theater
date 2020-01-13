//
//  RatingView.m
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/6.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RatingView.h"
#import "ios_theater-Swift.h"

@interface RatingView()

@property MovieDetailsViewModel *movieDetailsViewModel;

@end

@implementation RatingView

- (void)configure:(MovieDetailsViewModel*) movieDetailsViewModel
{
  self.movieDetailsViewModel = movieDetailsViewModel;
  _numberLabel.text = [NSString stringWithFormat:@"%.1f", movieDetailsViewModel.ratingNumber];
  NSMutableAttributedString *ratingString = [_starsLabel setStarsWithRating:movieDetailsViewModel.ratingNumber size:15];
  [ratingString addAttribute:NSForegroundColorAttributeName value:[UIColor systemYellowColor] range:NSMakeRange(0, 5)];
  _starsLabel.attributedText = ratingString;
  [_fiveLabel genenrateFullStarsWithNumber:5];
  [_fourLabel genenrateFullStarsWithNumber:4];
  [_threeLabel genenrateFullStarsWithNumber:3];
  [_twoLabel genenrateFullStarsWithNumber:2];
  [_oneLabel genenrateFullStarsWithNumber:1];
  _fiveProgress.progress = [[movieDetailsViewModel percentOfStars][0] floatValue];
  _fourProgress.progress = [[movieDetailsViewModel percentOfStars][1] floatValue];
  _threeProgress.progress = [[movieDetailsViewModel percentOfStars][2] floatValue];
  _twoProgress.progress = [[movieDetailsViewModel percentOfStars][3] floatValue];
  _oneProgress.progress = [[movieDetailsViewModel percentOfStars][4] floatValue];
}

- (void)setRatingCount
{
  NSString *words = NSLocalizedString(@"ratingCount", @"");
  _ratingCountLabel.text = [NSString stringWithFormat:@"%ld %@", (long)_movieDetailsViewModel.ratingCount, words];
}

@end
