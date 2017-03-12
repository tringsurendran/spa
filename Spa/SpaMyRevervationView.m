//
//  SpaMyRevervationView.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/10/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaMyRevervationView.h"
#import "UIColor+Spa.h"

@interface SpaMyRevervationView ()

@property (nonatomic) UILabel * dateLabel;
@property (nonatomic) UILabel * timeLabel;
@property (nonatomic) UILabel * serviceNameLabel;
@property (nonatomic) UILabel * partySizeLabel;
@property (nonatomic) UILabel * decsriptionLabel;

@end

@implementation SpaMyRevervationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setBorderColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor];
        [self.layer setBorderWidth:0.5];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
        [headerView setBackgroundColor:[UIColor spaBlue]];
        headerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:headerView];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.dateLabel setTextColor:[UIColor whiteColor]];
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.dateLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
        [headerView addSubview:self.dateLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.timeLabel setTextColor:[UIColor whiteColor]];
        [self.timeLabel setTextAlignment:NSTextAlignmentRight];
        [self.timeLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [headerView addSubview:self.timeLabel];
        
        self.serviceNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.serviceNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.serviceNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:23]];
        [self addSubview:self.serviceNameLabel];
        
        self.partySizeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.partySizeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.partySizeLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        [self addSubview:self.partySizeLabel];
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectZero];
        [separator setBackgroundColor:[UIColor lightGrayColor]];
        separator.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:separator];
        
        self.decsriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.decsriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.decsriptionLabel.numberOfLines = 0;
        [self.decsriptionLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13]];
        [self addSubview:self.decsriptionLabel];
        
        UIButton *rescheduleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rescheduleButton setBackgroundColor:[UIColor spaBlue]];
        [rescheduleButton setTitle:@"RESHEDULE" forState:UIControlStateNormal];
        [rescheduleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rescheduleButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        [rescheduleButton.layer setCornerRadius:5];
        rescheduleButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:rescheduleButton];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setBackgroundColor:[UIColor darkGrayColor]];
        [cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        [cancelButton.layer setCornerRadius:5];
        [self addSubview:cancelButton];

        NSDictionary *views = @{@"headerView" : headerView, @"serviceNameLabel" : self.serviceNameLabel, @"partySizeLabel" : self.partySizeLabel, @"separator" : separator, @"decsriptionLabel" : self.decsriptionLabel, @"rescheduleButton" : rescheduleButton, @"cancelButton" : cancelButton, @"dateLabel" : self.dateLabel, @"timeLabel" : self.timeLabel };
        NSDictionary *metrics = @{@"buttonWidth" : @(120), @"buttonHeight" : @(40)};
        
        [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[dateLabel]-(>=20@750)-[timeLabel]-10-|" options:0 metrics:nil views:views]];
        [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[dateLabel]|" options:0 metrics:nil views:views]];
        [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[timeLabel]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headerView(50)]" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView]-(10@750)-[serviceNameLabel]-(10@750)-[partySizeLabel]-10-[separator(0.5)]-10-[decsriptionLabel(50)]-(>=10@750)-[rescheduleButton(buttonHeight)]-10-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[serviceNameLabel]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[partySizeLabel]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[separator]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[decsriptionLabel]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rescheduleButton(buttonWidth)]" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[cancelButton(buttonWidth)]" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[cancelButton(==rescheduleButton)]-10-|" options:0 metrics:nil views:views]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:rescheduleButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:-([metrics[@"buttonWidth"] integerValue] / 2) - 10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant: (([metrics[@"buttonWidth"] integerValue] / 2)) + 10]];
    }
    return self;
}

- (void)setMyReservation:(MyReservation *)myReservation {
    self.serviceNameLabel.text = myReservation.serviceName;
    self.partySizeLabel.text = [NSString stringWithFormat:@"PARTY SIZE - %d",myReservation.partySize];
    self.dateLabel.text = [[self dateFormatter] stringFromDate:myReservation.date];
    self.timeLabel.text = [[self timeFormatter] stringFromDate:myReservation.date];
    self.decsriptionLabel.text = @"Massage focused on the deepest layer of muscles to target knots and release chronic muscle tension.";
}

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dayFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dayFormatter = [[NSDateFormatter alloc] init];
        dayFormatter.dateFormat = @"EEEE MMM dd yyyy";
    });
    return dayFormatter;
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





@end
