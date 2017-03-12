//
//  UIView+Autolayout.h
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/12/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Autolayout)

- (NSArray *)addConstraintsWithVisualFormats:(NSArray*)formats views:(NSDictionary *)views;
- (NSArray *)addConstraintsWithVisualFormats:(NSArray*)formats metrics:(NSDictionary *)metrics views:(NSDictionary *)views;
- (void)addConstraintsToFillSuperview;

@end
