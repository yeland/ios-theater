//
//  RatingView.h
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/7.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ios_theater-Swift.h"
@class MovieDetailsViewModel;

@interface RatingView : UIView
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *starsLabel;

-(void) configure: (MovieDetailsViewModel*) movieDetailsViewModel;

@end
