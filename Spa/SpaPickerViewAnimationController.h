//
//  SpaPickerViewAnimationController.h
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/12/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SpaPickerViewAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, getter=isPresenting) BOOL presenting;


@end
