//
//  SpaPickerControllerViewController.h
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/12/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpaPickerViewController;

@protocol SpaPickerViewControllerDelegate <NSObject>

- (void)pickerViewControllerDidCancel:(SpaPickerViewController *)pickerViewController;
- (void)pickerViewControllerDidSave:(SpaPickerViewController *)pickerViewController;

@end

@interface SpaPickerViewController : UIViewController

@property (weak) id <SpaPickerViewControllerDelegate> delegate;
@property (nonatomic) UIColor *tintColor;
@property (nonatomic) id selectedValue;

- (instancetype)initWithTitle:(NSString *)title values:(NSArray *)values;

@end
