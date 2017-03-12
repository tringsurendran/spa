//
//  SpaServiceViewController.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/7/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaServiceViewController.h"
#import "SpaServiceItems.h"
#import "SpaServiceItem.h"
#import "ScheduleViewController.h"
#import "SpaServiceOffer.h"
#import "SpaServiceOfferView.h"

@interface SpaServiceViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, SpaServiceOfferViewDelegate> {
    CGFloat currentPageIndex;
}

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) NSArray *spaServicelist;
@property (nonatomic) NSArray *views;
@property (nonatomic) NSArray *spaServiceOffers;
@property (nonatomic) BOOL isAutoScroll;
@property (nonatomic) UIPageControl *pageControl;


@end

@implementation SpaServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"SPA SERVICE";
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.scrollView];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setDirectionalLockEnabled:YES];
   // [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setBackgroundColor:[UIColor lightGrayColor]];
    self.scrollView.delegate = self;
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    [backgroundView.layer setCornerRadius:5];
    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:backgroundView];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [backgroundView addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [backgroundView setClipsToBounds:YES];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.pageControl];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:@{@"scrollView" : self.scrollView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:@{@"scrollView" : self.scrollView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[backgroundView(220)]-20-|" options:0 metrics:nil views:@{@"backgroundView" : backgroundView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[backgroundView]-10-|" options:0 metrics:nil views:@{@"backgroundView" : backgroundView}]];
    [backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:@{@"tableView" : tableView}]];
    [backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:@{@"tableView" : tableView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pageControl]|" options:0 metrics:nil views:@{@"pageControl" : self.pageControl}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl(20)]-10-[backgroundView]" options:0 metrics:nil views:@{@"pageControl" : self.pageControl, @"backgroundView" : backgroundView}]];

    [self loadContents];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)loadContents {
    [self loadContentForScrollView];
    self.spaServicelist = [[[SpaServiceItems alloc] init] services];
    self.pageControl.numberOfPages = [self.spaServiceOffers count] - 2;
}

- (void)loadSpaServiceOfferDetails {
    self.spaServiceOffers = [NSMutableArray new];
    SpaServiceOffer *offer1 = [[SpaServiceOffer alloc] initWithName:@"Deep Tissue" available:NO index:0];
    SpaServiceOffer *offer2 = [[SpaServiceOffer alloc] initWithName:@"Hot Stone" available:YES index:1];
    SpaServiceOffer *offer3 = [[SpaServiceOffer alloc] initWithName:@"Swedish" available:NO index:2];
    self.spaServiceOffers = @[offer3,offer1,offer2,offer3,offer1];
}

- (void)loadContentForScrollView {
    [self loadSpaServiceOfferDetails];
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    SpaServiceOfferView *view1 = [[SpaServiceOfferView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [view1 updateOfferDetails:[self.spaServiceOffers objectAtIndex:0]];
    view1.delegate = self;
    SpaServiceOfferView *view2 = [[SpaServiceOfferView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    [view2 updateOfferDetails:[self.spaServiceOffers objectAtIndex:1]];
    view2.delegate = self;
    SpaServiceOfferView *view3 = [[SpaServiceOfferView alloc] initWithFrame:CGRectMake(width* 2, 0, width, height)];
    [view3 updateOfferDetails:[self.spaServiceOffers objectAtIndex:2]];
    view3.delegate = self;
    self.views = @[view1, view2, view3];
    for (UIView *view in self.views) {
        [self.scrollView addSubview:view];
    }
    [self.scrollView setContentSize:CGSizeMake([self.spaServiceOffers count] * width, height)];
    [self.scrollView setContentOffset:CGPointMake(width, 0)];
}

- (void)resetCurrentView {
    CGFloat pageWidth = self.scrollView.frame.size.width ;
    int page = ceil(self.scrollView.contentOffset.x) / pageWidth;
    SpaServiceOfferView *secondView = [self.views objectAtIndex:(page) % 3];
    CGRect frame = secondView.frame;
    [secondView updateOfferDetails:[self.spaServiceOffers objectAtIndex:page]];
    frame.origin.x = (page * pageWidth);
    [secondView setFrame:frame];
}

- (void)updateViews {
    CGFloat pageWidth = self.scrollView.frame.size.width ;
    int page = ceil(self.scrollView.contentOffset.x) / pageWidth;
    if (currentPageIndex >= 0 &&  currentPageIndex != page) {
        if (currentPageIndex < page) {
            int index = page + 1;
            //forward
            SpaServiceOfferView *firstView = [self.views objectAtIndex:(index) % 3];
            CGRect frame = firstView.frame;
            [firstView updateOfferDetails:[self.spaServiceOffers objectAtIndex:index]];
            frame.origin.x = (index * pageWidth);
            [firstView setFrame:frame];
            currentPageIndex = page;
        } else {
            int index = page - 1;
            //backward
            SpaServiceOfferView *lastView = [self.views objectAtIndex:(index) % 3];
            CGRect frame = lastView.frame;
            [lastView updateOfferDetails:[self.spaServiceOffers objectAtIndex:index]];
            frame.origin.x = (index * pageWidth);
            [lastView setFrame:frame];
            currentPageIndex = page;
        }
        SpaServiceOffer *offer = [self.spaServiceOffers objectAtIndex:page];
        self.pageControl.currentPage = [offer index];
    }
}

#pragma mark <UISCrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isAutoScroll) {
        return;
    }
    CGFloat lastPageX = self.scrollView.bounds.size.width * ([self.spaServiceOffers count] - 1);
    if (self.scrollView.contentOffset.x == 0) {
        currentPageIndex = [self.spaServiceOffers count];
        self.isAutoScroll = YES;
       [self.scrollView setContentOffset:CGPointMake(([self.spaServiceOffers count] - 2) * self.scrollView.frame.size.width, 0)];
        [self resetCurrentView];
    } else if (self.scrollView.contentOffset.x == lastPageX) {
        currentPageIndex = 0;
        self.isAutoScroll = YES;
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
        [self resetCurrentView];
    }
    [self updateViews];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isAutoScroll = NO;
}

#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.spaServicelist count];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath  {
    SpaServiceItem *spaServiceItem = [self.spaServicelist objectAtIndex:indexPath.row];
    return spaServiceItem.isAvailable;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    SpaServiceItem *spaServiceItem = [self.spaServicelist objectAtIndex:indexPath.row];
    cell.textLabel.text = spaServiceItem.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.enabled = spaServiceItem.isAvailable;
    return cell;
}

#pragma mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self createSchedule];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark <SpaServiceOfferViewDelegate>

- (void)spaServiceOfferViewReserveAction:(SpaServiceOffer *)serviceOffer {
    [self createSchedule];
}

#pragma mark --

- (void)createSchedule {
    ScheduleViewController *scheduleViewController = [[ScheduleViewController alloc] init];
    [self.navigationController pushViewController:scheduleViewController animated:YES];
}


@end
