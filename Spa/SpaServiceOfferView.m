//
//  SpaServiceOfferView.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/8/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaServiceOfferView.h"
#import "UIColor+Spa.h"

@interface SpaServiceOfferView ()

@property (nonatomic) UILabel *serviceNameLabel;
@property (nonatomic) UIButton *reserveButton;
@property (nonatomic) SpaServiceOffer *spaServiceOffer;

@end

@implementation SpaServiceOfferView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SpaImage"]];
        [backgroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [backgroundImageView setUserInteractionEnabled:YES];
        [backgroundImageView setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:backgroundImageView];
        [self sendSubviewToBack:backgroundImageView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-10)-[backgroundImageView]-(-10)-|" options:0 metrics:nil views:@{@"backgroundImageView":backgroundImageView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-10)-[backgroundImageView]-(-10)-|" options:0 metrics:nil views:@{@"backgroundImageView":backgroundImageView}]];
        
        CGFloat padding = 20;
        self.serviceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, 0, 0)];
        self.serviceNameLabel.numberOfLines = 0;
        [self addSubview:self.serviceNameLabel];
        self.reserveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.reserveButton setBackgroundColor:[UIColor spaBlue]];
        [self.reserveButton setTitle:@"RESERVE" forState:UIControlStateNormal];
        [self.reserveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.reserveButton addTarget:self action:@selector(reserveButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.reserveButton.layer setCornerRadius:5];
        [self addSubview:self.reserveButton];
        
    }
    return self;
}

- (void)updateOfferDetails:(SpaServiceOffer *)serviceOffer {
    self.spaServiceOffer = serviceOffer;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"10% OFF\n" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:36]}]];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",self.spaServiceOffer.name] attributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:24]}]];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"MASSAGE" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:32]}]];
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedText length])];
    self.serviceNameLabel.attributedText = attributedText;

    [self.reserveButton setHidden:!serviceOffer.isAvailable];
    [self setNeedsLayout];
}

- (void)reserveButtonAction {
    if (self.delegate) {
        [self.delegate spaServiceOfferViewReserveAction:self.spaServiceOffer];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = [self.serviceNameLabel sizeThatFits:CGSizeMake(200, CGFLOAT_MAX)];
    CGRect frame = self.serviceNameLabel.frame;
    frame.size = size;
    self.serviceNameLabel.frame = frame;
    self.reserveButton.frame = CGRectMake(CGRectGetMinX(self.serviceNameLabel.frame), CGRectGetMaxY(self.serviceNameLabel.frame) + 20, CGRectGetWidth(self.serviceNameLabel.frame), 40);
}

@end
