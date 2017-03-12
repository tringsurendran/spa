//
//  SpaPickerViewAnimationController.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/12/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaPickerViewAnimationController.h"
#import "SpaPickerViewController.h"
#import "UIView+Autolayout.h"

static CGFloat const kAnimationDuration = 0.3f;

@interface SpaPickerViewAnimationController ()

@property UIButton *overlayButton;
@property SpaPickerViewController *pickerViewController;

@property NSLayoutConstraint *pickerTopConstraint;
@property NSLayoutConstraint *pickerBottomConstraint;

@end

@implementation SpaPickerViewAnimationController

- (instancetype)init {
    self = [super init];
    if (self) {
        _overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_overlayButton addTarget:self action:@selector(overlayButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        _overlayButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kAnimationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    SpaPickerViewController *pickerViewController = (SpaPickerViewController *)[transitionContext viewControllerForKey:self.isPresenting ? UITransitionContextToViewControllerKey : UITransitionContextFromViewControllerKey];
    UIView *pickerView = pickerViewController.view;
    
    if (self.isPresenting) {
        self.overlayButton.alpha = 0.f;
        [containerView addSubview:self.overlayButton];
        [self.overlayButton addConstraintsToFillSuperview];
        
        self.pickerViewController = pickerViewController;
        [containerView addSubview:pickerView];
        [containerView addConstraintsWithVisualFormats:@[@"H:|[pickerView]|"] views:@{@"pickerView": pickerView}];
        
        self.pickerTopConstraint = [NSLayoutConstraint constraintWithItem:pickerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
        self.pickerTopConstraint.priority = UILayoutPriorityDefaultHigh;
        [containerView addConstraint:self.pickerTopConstraint];
        
        self.pickerBottomConstraint = [NSLayoutConstraint constraintWithItem:pickerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
        self.pickerBottomConstraint.priority = UILayoutPriorityRequired;
        
        [containerView layoutIfNeeded];
        // animation to bring view from bottom
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.overlayButton.alpha = 1.f;
            [containerView addConstraint:self.pickerBottomConstraint];
            [containerView layoutIfNeeded];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        
        return;
    }
    
    // animation to hide view to bottom
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.overlayButton.alpha = 0.f;
        [containerView removeConstraint:self.pickerBottomConstraint];
        [containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [pickerView removeFromSuperview];
        [self.overlayButton removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (void)overlayButtonPressed:(id)sender; {
    [self.pickerViewController.delegate pickerViewControllerDidCancel:self.pickerViewController];
}

@end
