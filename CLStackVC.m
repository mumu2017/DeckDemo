//
//  CLStackVC.m
//  DeckDemo
//
//  Created by 陈林 on 16/8/18.
//  Copyright © 2016年 Chen Lin. All rights reserved.
//

#import "CLStackVC.h"
#import "CLDeck.h"
#import "CLCard.h"

@interface CLStackVC ()

@property (strong, nonatomic) NSArray *deck;
//@property (strong, nonatomic) NSArray *deckImageList;

@end

@implementation CLStackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgImage"]];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.frame = self.view.frame;
    [self.view addSubview:bgImageView];
    
    [self carousel];

}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return (NSInteger)[self.deck count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 66.0f, 88.0f)];

        view.contentMode = UIViewContentModeScaleAspectFit;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
//    label.text = [self.items[(NSUInteger)index] stringValue];
    CLCard *card = self.deck[index];
    ((UIImageView *)view).image = card.image;

    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 2;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 66.0f, 88.0f)];
        
        view.contentMode = UIViewContentModeScaleAspectFit;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0f];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
//    label.text = (index == 0)? @"[": @"]";
    CLCard *card = self.deck[index];
    ((UIImageView *)view).image = card.image;
    return view;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
    
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = (self.deck)[(NSUInteger)index];
    NSLog(@"Tapped view number: %@", item);
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
}

- (NSArray *)deck {
    if (!_deck) {
        _deck = [CLDeck MnemonicosisDeck];
    }
    return _deck;
}

- (iCarousel *)carousel {
    
    if (!_carousel) {
        
        _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(20, 64, 280, 320)];
        [self.view addSubview:_carousel];
        
        _carousel.clipsToBounds = YES;
        _carousel.delegate = self;
        _carousel.dataSource = self;
        _carousel.type = iCarouselTypeLinear;

    }
    return _carousel;
}

//- (void)preCard {
//    NSInteger preIndex = self.deckView.currentIndex-1;
//    
//    if (self.nextButton.enabled == NO) {
//        self.nextButton.enabled = YES;
//    }
//    self.preButton.enabled = (preIndex> 0);
//    
//    
//    [self.deckView scrollToIndex:preIndex animated:YES];
//}
//
//- (void)nextCard {
//    
//    NSInteger nextIndex = self.deckView.currentIndex+1;
//    if (self.preButton.enabled == NO) {
//        self.preButton.enabled = YES;
//    }
//    self.nextButton.enabled = (nextIndex < [self.deckView.dataSource numberOfViews]-1);
//    
//    NSLog(@"%ld",nextIndex);
//    [self.deckView scrollToIndex:nextIndex animated:YES];
//    
//}

@end
