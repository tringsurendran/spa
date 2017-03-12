//
//  ScheduleViewController.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/7/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "ScheduleViewController.h"
#import "SpaServiceInfoView.h"
#import "NSCalendar+Spa.h"
#import "UIColor+Spa.h"
#import "SpaDayCollectionViewCell.h"
#import "SpaReservationsRepository.h"
#import "SpaTimeCollectionViewCell.h"
#import "SpaPickerViewController.h"
#import "SpaPickerViewAnimationController.h"

CGFloat kScheduleViewControllerViewPadding = 10.0;

@interface ScheduleViewController () <UICollectionViewDelegate, UICollectionViewDataSource, SpaPickerViewControllerDelegate, UIViewControllerTransitioningDelegate, SpaServiceInfoViewDelegate>

@property (nonatomic) SpaServiceInfoView *spaServiceInfoView;
@property (nonatomic) UICollectionView *calendarCollectionView;
@property (nonatomic) UICollectionView *timeCollectionView;
@property (nonatomic) NSArray *dates;
@property (nonatomic) NSArray *availableTimes;
@property (nonatomic) UIButton *reserveButton;
@property (nonatomic) SpaPickerViewController *pickerViewController;
@property (nonatomic) SpaPickerViewAnimationController *animationController;

@end

@implementation ScheduleViewController

- (void)loadView {
    [super loadView];
    self.navigationItem.title = @"SCHEDULE";
    [self.view setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1]];

    self.spaServiceInfoView = [[SpaServiceInfoView alloc] initWithFrame:CGRectMake(kScheduleViewControllerViewPadding, kScheduleViewControllerViewPadding, self.view.bounds.size.width - (kScheduleViewControllerViewPadding * 2), 200)];
    self.spaServiceInfoView.delegate = self;
    [self.view addSubview:self.spaServiceInfoView];
    
    self.reserveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 64 - 45, self.view.bounds.size.width, 45)];
    [self.reserveButton setBackgroundColor:[UIColor spaBlue]];
    self.reserveButton.titleLabel.textColor = [UIColor whiteColor];
    [self.reserveButton setTitle:@"RESERVE" forState:UIControlStateNormal];
    [self.reserveButton addTarget:self action:@selector(reserveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.reserveButton];
    self.reserveButton.alpha = 0.5;
    self.reserveButton.enabled = NO;
    
    self.dates = [[NSCalendar currentCalendar] getDaysOfCurrentMonth];
    self.availableTimes = [self getAvailableTimes];
    [self loadCalendarCollectionView];
    [self loadTimeCollectionView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[calendarCollectionView]-10-[timeCollectionView(>=40)]-(>=20@1000)-[reserveButton]" options:0 metrics:nil views:@{@"calendarCollectionView" : self.calendarCollectionView, @"reserveButton" : self.reserveButton, @"timeCollectionView" : self.timeCollectionView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[timeCollectionView]-10-|" options:0 metrics:nil views:@{@"timeCollectionView" : self.timeCollectionView}]];
    

}

- (void)loadCalendarCollectionView {
    UICollectionViewFlowLayout *cellLayout = [[UICollectionViewFlowLayout alloc]init];
    cellLayout.itemSize = CGSizeMake(45, 75);
    cellLayout.minimumInteritemSpacing = kScheduleViewControllerViewPadding;
    cellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGRect collectionViewFrame = CGRectMake(kScheduleViewControllerViewPadding, CGRectGetMaxY(self.spaServiceInfoView.frame) + kScheduleViewControllerViewPadding, CGRectGetWidth(self.view.bounds) - (kScheduleViewControllerViewPadding * 2), 100);
    self.calendarCollectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:cellLayout];
    [self.calendarCollectionView registerClass:[SpaDayCollectionViewCell class] forCellWithReuseIdentifier:@"SpaDayCollectionViewCell"];
    [self.calendarCollectionView setDelegate:self];
    [self.calendarCollectionView setDataSource:self];
    [self.calendarCollectionView setShowsHorizontalScrollIndicator:NO];
    [self.calendarCollectionView setShowsVerticalScrollIndicator:NO];
    [self.calendarCollectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.calendarCollectionView];
}

- (void)loadTimeCollectionView {
    // TODO : need to implement dynamic layout to make it perfect
    UICollectionViewFlowLayout *cellLayout = [[UICollectionViewFlowLayout alloc]init];
    cellLayout.itemSize = CGSizeMake(80, 40);
    cellLayout.minimumInteritemSpacing = kScheduleViewControllerViewPadding;
    cellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGRect collectionViewFrame = CGRectMake(kScheduleViewControllerViewPadding, CGRectGetMaxY(self.calendarCollectionView.frame) + kScheduleViewControllerViewPadding, CGRectGetWidth(self.view.bounds) - (kScheduleViewControllerViewPadding * 2), 100);
    self.timeCollectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:cellLayout];
    [self.timeCollectionView registerClass:[SpaTimeCollectionViewCell class] forCellWithReuseIdentifier:@"SpaTimeCollectionViewCell"];
    [self.timeCollectionView setDelegate:self];
    [self.timeCollectionView setDataSource:self];
    [self.timeCollectionView setShowsHorizontalScrollIndicator:NO];
    [self.timeCollectionView setShowsVerticalScrollIndicator:NO];
    [self.timeCollectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.timeCollectionView];
    self.timeCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)updateReserveButtonState {
    BOOL shouldEnable = NO;
    if ([[self.calendarCollectionView indexPathsForSelectedItems] firstObject] && [[self.timeCollectionView indexPathsForSelectedItems] firstObject]) {
        shouldEnable = YES;
    }
    if (self.reserveButton.enabled == shouldEnable) {
        return;
    }
    self.reserveButton.enabled = shouldEnable;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.reserveButton.alpha = shouldEnable ? 1 : 0.5;
    } completion:nil];;
}

- (NSDate *)selectedDate {
    NSIndexPath *selectedIndexPath = [[self.calendarCollectionView indexPathsForSelectedItems] firstObject];
    if (!selectedIndexPath) {
        return nil;
    }
    SpaDayCollectionViewCell *selectedCell = (SpaDayCollectionViewCell *) [self.calendarCollectionView cellForItemAtIndexPath:selectedIndexPath];
    return selectedCell.date;
}

- (NSDate *)selectedTime {
    NSIndexPath *selectedIndexPath = [[self.timeCollectionView indexPathsForSelectedItems] firstObject];
    if (!selectedIndexPath) {
        return nil;
    }
    SpaTimeCollectionViewCell *selectedCell = (SpaTimeCollectionViewCell *) [self.timeCollectionView cellForItemAtIndexPath:selectedIndexPath];
    return selectedCell.date;
}

- (void)reserveButtonAction {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendar components:( NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour) fromDate:[self selectedDate]];
    NSDateComponents *getTimeComponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:[self selectedTime]];
    [dateComponents setHour:getTimeComponents.hour];
    [dateComponents setMinute:getTimeComponents.minute];
    NSDate *selectedDateWithTime = [calendar dateFromComponents:dateComponents];
    NSDictionary *dictionary = @{@"serviceName" : @"Hot Stone Massage" , @"date" : selectedDateWithTime , @"partySize" : self.spaServiceInfoView.partySize};
    SpaReservationsRepository *repository = [[SpaReservationsRepository alloc] init];
    [repository saveReservation:dictionary];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSArray *)getAvailableTimes {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSMutableArray *times = [NSMutableArray array];
    NSDateComponents *components = [cal components:(kCFCalendarUnitHour | NSCalendarUnitMinute) fromDate:[NSDate date]];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSInteger startTime = 9;
    NSInteger endTime = 20;
    for (NSInteger i = startTime; i <= endTime; i++) {
        [components setHour:i];
        NSDate *dateWithTime = [cal dateFromComponents:components];
        [times addObject:dateWithTime];
    }
    return times;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.timeCollectionView) {
        return [self.availableTimes count];
    }
    return [self.dates count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.timeCollectionView) {
        SpaTimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SpaTimeCollectionViewCell" forIndexPath:indexPath];
        cell.date = [self.availableTimes objectAtIndex:indexPath.row];
        return cell;
    } else {
        SpaDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SpaDayCollectionViewCell" forIndexPath:indexPath];
        cell.date = [self.dates objectAtIndex:indexPath.row];
        return cell;
    }
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[collectionView cellForItemAtIndexPath:indexPath] setSelected:YES];
    [self updateReserveButtonState];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[collectionView cellForItemAtIndexPath:indexPath] setSelected:NO];
    [self updateReserveButtonState];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([[collectionView indexPathsForSelectedItems] containsObject:indexPath]) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        [self updateReserveButtonState];
        return NO;
    }
    return YES;
}

- (void)presentPickerView {
    NSArray *partSizes = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12];
    self.pickerViewController = [[SpaPickerViewController alloc] initWithTitle:@"PARTY SIZE" values:partSizes];
    self.pickerViewController.modalPresentationStyle = UIModalPresentationCustom;
    self.pickerViewController.transitioningDelegate = self;
    self.pickerViewController.delegate = self;
    self.pickerViewController.tintColor = [UIColor spaBlue];
    self.pickerViewController.selectedValue = self.spaServiceInfoView.partySize;
    self.animationController = [[SpaPickerViewAnimationController alloc] init];
    [self presentViewController:self.pickerViewController animated:YES completion:nil];
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.animationController.presenting = YES;
    return self.animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animationController.presenting = NO;
    return self.animationController;
}

#pragma mark - <TactPickerViewControllerDelegate>

- (void)pickerViewControllerDidCancel:(SpaPickerViewController *)pickerViewController {
    self.pickerViewController = nil;
    self.animationController = nil;
}

- (void)pickerViewControllerDidSave:(SpaPickerViewController *)pickerViewController {
    self.pickerViewController = nil;
    self.animationController = nil;
    self.spaServiceInfoView.partySize = pickerViewController.selectedValue;
}

#pragma mark - <SpaServiceInfoViewDelegate>

- (void)didTapOnPartySize:(SpaServiceInfoView *)view {
    [self presentPickerView];
}


@end
