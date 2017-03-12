//
//  AppTheme.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/7/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "AppTheme.h"
#import <UIKit/UIKit.h>

@implementation AppTheme

+ (void)applyGlobalAppearance {
    NSDictionary *colorAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionaryWithDictionary:colorAttributes];
    [UINavigationBar appearance].titleTextAttributes = textAttributes;
    [UINavigationBar appearance].tintColor =  [UIColor whiteColor];
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:31/255.0 green:182/255.0 blue:252/255.0 alpha:1];
}

@end
