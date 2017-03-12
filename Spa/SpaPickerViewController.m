//
//  SpaPickerControllerViewController.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/12/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaPickerViewController.h"
#import "UIView+Autolayout.h"

CGFloat const kSpaPickerViewHeaderMarginWidth = 10.f;


@interface SpaPickerViewController () <UIPickerViewDelegate , UIPickerViewDataSource>

@property (nonatomic) UIView *headerView;
@property (nonatomic) UIPickerView *pickerView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) NSArray *values;


@end

@implementation SpaPickerViewController

- (instancetype)initWithTitle:(NSString *)title values:(NSArray *)values {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = title;
        self.values = values;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.headerView];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    [self.pickerView setBackgroundColor:[UIColor whiteColor]];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.pickerView];
    
    [self.view addConstraintsWithVisualFormats:@[@"H:|[header]|",
                                                @"H:|[content]|",
                                                @"V:|[header(50)][content(200)]|"]
                                         views:@{@"header": self.headerView,
                                                    @"content": self.pickerView}];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.exclusiveTouch = YES;
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cancelButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    cancelButton.tintColor = [UIColor whiteColor];
    [self.headerView addSubview:cancelButton];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveButton setTitle:@"Done" forState:UIControlStateNormal];
    saveButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    saveButton.tintColor = [UIColor whiteColor];
    saveButton.exclusiveTouch = YES;
    [self.headerView addSubview:saveButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = self.title;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.headerView addSubview:self.titleLabel];
    NSDictionary *metrics = @{@"margin": @(kSpaPickerViewHeaderMarginWidth)};
    [self.headerView addConstraintsWithVisualFormats:@[@"H:|-(margin)-[cancel(55)]-(15)-[title]-(15)-[save(55)]-(margin)-|",
                                                       @"V:|[cancel]|",
                                                       @"V:|[title]|",
                                                       @"V:|[save]|"] metrics:metrics
                                               views:@{@"cancel": cancelButton,
                                                       @"save": saveButton,
                                                       @"title": self.titleLabel}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView.backgroundColor = self.tintColor;
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    self.headerView.backgroundColor = tintColor;
}

- (id)selectedValue {
    return [self.values objectAtIndex:[self.pickerView selectedRowInComponent:0]];
}

- (void)setSelectedValue:(id)selectedValue {
    [self.pickerView selectRow:[self.values indexOfObject:selectedValue] inComponent:0 animated:YES];
}

#pragma mark - Actions

- (void)cancelButtonPressed:(id)sender {
    [self.delegate pickerViewControllerDidCancel:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveButtonPressed:(id)sender {
    [self.delegate pickerViewControllerDidSave:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <UIPickerViewDataSource>

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.values count];
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%@",[self.values objectAtIndex:row]];
}


@end
