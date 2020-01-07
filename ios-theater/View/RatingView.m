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

@implementation RatingView

-(void) configure: (MovieDetailsViewModel*) movieDetailsViewModel {
  _numberLabel.text = [NSString stringWithFormat:@"%.1f", movieDetailsViewModel.ratingNumber];
  NSMutableAttributedString *ratingString = [_starsLabel setStarsWithRating:movieDetailsViewModel.ratingNumber size:16];
  [ratingString addAttribute:NSForegroundColorAttributeName value:[UIColor systemYellowColor] range:NSMakeRange(0, 5)];
  _starsLabel.attributedText = ratingString;
}

@end
