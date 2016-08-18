//
//  CLStackVC.h
//  DeckDemo
//
//  Created by 陈林 on 16/8/18.
//  Copyright © 2016年 Chen Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface CLStackVC : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) iCarousel *carousel;

@end
