//
//  SpaDayCollectionViewCell.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/9/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaDayCollectionViewCell.h"
#import "UIColor+Spa.h"

@interface SpaDayCollectionViewCell ()

@property (nonatomic) UILabel *weekDayLabel;
@property (nonatomic) UILabel *dayLabel;
@property (nonatomic) UIView *topBannerView;
@property (nonatomic) UIView *selectedView;

@end

@implementation SpaDayCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.topBannerView = [[UIView alloc] init];
        [self.topBannerView setBackgroundColor:[UIColor spaBlue]];
        [self addSubview:self.topBannerView];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.weekDayLabel = [[UILabel alloc] init];
        [self addSubview:self.weekDayLabel];
        [self.weekDayLabel setTextAlignment:NSTextAlignmentCenter];
        [self.weekDayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10]];
        
        self.dayLabel = [[UILabel alloc] init];
        [self addSubview:self.dayLabel];
        [self.dayLabel setTextAlignment:NSTextAlignmentCenter];
        [self.dayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15]];
        
        self.selectedView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedView.backgroundColor = [UIColor spaBlue];
        [self addSubview:self.selectedView];
        self.selectedView.alpha = 0;
    }
    return self;
}

- (void)setDate:(NSDate *)date {
    [self.weekDayLabel setText:[[[self weekDayFormatter] stringFromDate:date] uppercaseString]];
    [self.dayLabel setText:[[self dayFormatter] stringFromDate:date]];
    _date = date;
    [self setNeedsLayout];
}

- (NSDateFormatter *)weekDayFormatter {
    static NSDateFormatter *weekFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weekFormatter = [[NSDateFormatter alloc] init];
        weekFormatter.dateFormat = @"EEE";
    });
    return weekFormatter;
}

- (NSDateFormatter *)dayFormatter {
    static NSDateFormatter *dayFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dayFormatter = [[NSDateFormatter alloc] init];
        dayFormatter.dateFormat = @"dd";
    });
    return dayFormatter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.topBannerView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 15)];
    [self.weekDayLabel sizeToFit];
    [self.dayLabel sizeToFit];
    CGFloat contentAreaCenter = ((CGRectGetHeight(self.bounds) - CGRectGetHeight(self.topBannerView.bounds)) / 2) + CGRectGetHeight(self.topBannerView.bounds);
    CGFloat spacing = 2;
    self.weekDayLabel.frame = CGRectMake(0, contentAreaCenter - CGRectGetHeight(self.weekDayLabel.frame) - spacing, CGRectGetWidth(self.bounds), CGRectGetHeight(self.weekDayLabel.frame));
    self.dayLabel.frame = CGRectMake(0, contentAreaCenter +  spacing, CGRectGetWidth(self.bounds), CGRectGetHeight(self.dayLabel.frame));
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.selectedView.alpha = selected ? 0.3 : 0.0;
}

@end
