//
//  SpaTimeCollectionViewCell.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/11/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaTimeCollectionViewCell.h"
#import "UIColor+Spa.h"

@interface SpaTimeCollectionViewCell ()

@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UIView *selectedView;

@end

@implementation SpaTimeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
        [self.timeLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.timeLabel];
        
        self.selectedView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedView.backgroundColor = [UIColor spaBlue];
        [self addSubview:self.selectedView];
        self.selectedView.translatesAutoresizingMaskIntoConstraints = NO;
        self.selectedView.alpha = 0;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[selectedView]|" options:0 metrics:nil views:@{@"selectedView" : self.selectedView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[selectedView]|" options:0 metrics:nil views:@{@"selectedView" : self.selectedView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[timeLabel]-|" options:0 metrics:nil views:@{@"timeLabel" : self.timeLabel}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[timeLabel]-|" options:0 metrics:nil views:@{@"timeLabel" : self.timeLabel}]];
    }
    return self;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    [self.timeLabel setText:[[self timeFormatter] stringFromDate:date]];
}

- (NSDateFormatter *)timeFormatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"hh:mm a";
    });
    return formatter;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.selectedView.alpha = selected ? 0.3 : 0.0;
}


@end
