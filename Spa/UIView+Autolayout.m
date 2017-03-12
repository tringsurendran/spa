//
//  UIView+Autolayout.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/12/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "UIView+Autolayout.h"

@implementation UIView (Autolayout)

- (NSArray *)addConstraintsWithVisualFormats:(NSArray*)formats views:(NSDictionary *)views {
    return [self addConstraintsWithVisualFormats:formats metrics:nil views:views];
}

- (NSArray *)addConstraintsWithVisualFormats:(NSArray*)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views {
    for (UIView *view in views.allValues) {
        if ([view isKindOfClass:[UIView class]]) {
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
    }
    
    NSMutableArray *constraints = [NSMutableArray array];
    for(NSString *format in formats) {
        NSArray *addedConstraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self addConstraints:addedConstraints];
        [constraints addObjectsFromArray:addedConstraints];
    }
    return constraints;
}

- (void)addConstraintsToFillSuperview {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.superview addConstraintsWithVisualFormats:@[@"H:|[self]|", @"V:|[self]|"] views:@{@"self": self}];
}


@end
