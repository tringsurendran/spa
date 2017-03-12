//
//  SpaServiceInfolView.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/8/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaServiceInfoView.h"

@interface SpaServiceInfoView ()

@property (nonatomic) UIButton *partySizeCountButton;
@property (nonatomic) UIImageView *spaImageView;

@end

@implementation SpaServiceInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setBorderColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor];
        [self.layer setBorderWidth:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.spaImageView = imageView;
        [imageView setBackgroundColor:[UIColor grayColor]];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.numberOfLines = 2;
        [label setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:24]];
        label.text = @"Hot Stone Massage";
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:label];
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectZero];
        [separator setBackgroundColor:[UIColor lightGrayColor]];
        separator.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:separator];
        
        UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        descriptionLabel.numberOfLines = 0;
        [descriptionLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11]];
        descriptionLabel.text = @"Massage focused on the deepest layer of muscles to target knots and release chronic muscle tension.";
        descriptionLabel.textColor = [UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1.0];
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:descriptionLabel];
        
        UILabel *partySizeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [partySizeLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
        partySizeLabel.text = @"PARTY SIZE";
        partySizeLabel.textColor = [UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1.0];
        partySizeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:partySizeLabel];
        
        self.partySizeCountButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.partySizeCountButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11]];
        [self.partySizeCountButton setTitleColor:[UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.partySizeCountButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.partySizeCountButton];
        [self.partySizeCountButton addTarget:self action:@selector(partySizeCountButtonAction) forControlEvents:UIControlEventTouchUpInside];
        self.partySize = @1;
        
        NSDictionary *views = @{@"imageView" : imageView, @"label" : label, @"separator" : separator, @"descriptionLabel" : descriptionLabel, @"partySizeLabel" : partySizeLabel, @"partySizeCountButton" : self.partySizeCountButton} ;
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView(125)]-10-[label]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[label(<=65)]-10-[separator(0.5)]-10-[descriptionLabel]-(>=10@750)-[partySizeLabel]-10@750-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView]-10-[separator]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView]-10-[descriptionLabel]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[partySizeLabel]-10-[partySizeCountButton(40)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[partySizeCountButton(40)]" options:0 metrics:nil views:views]];

        [self fetchAndUpdateImage];

    }
    return self;
}

- (void)setPartySize:(NSNumber *)partySize {
    _partySize = partySize;
    [self.partySizeCountButton setTitle:[NSString stringWithFormat:@"%@", partySize] forState:UIControlStateNormal];
}

- (void)partySizeCountButtonAction {
    [self.delegate didTapOnPartySize:self];
}

-(void)fetchAndUpdateImage {
    
    __weak SpaServiceInfoView *weakSelf = self;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[NSURL URLWithString:@"http://images.wisegeek.com/massage-stones-and-candles.jpg"]
                                                completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                    
                                                    NSLog(@"%@", response);
                                                    
                                                    if(location != nil) {
                                                        dispatch_sync(dispatch_get_main_queue(), ^{
                                                            UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:location]];
                                                            if([image isKindOfClass:[UIImage class]]) {
                                                                [weakSelf.spaImageView setImage:image];
                                                            }
                                                        });
                                                    }
                                                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                }];
    [task resume];
}

@end
