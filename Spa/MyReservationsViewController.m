//
//  ReservationViewController.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/7/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "MyReservationsViewController.h"
#import "SpaServiceViewController.h"
#import "SpaReservationsRepository.h"
#import "SpaMyRevervationView.h"
#import "SpaDB.h"

@interface MyReservationsViewController () <UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) SpaReservationsRepository *repository;
@property (nonatomic) NSFetchedResultsController *fetchedresultsController;

@end

@implementation MyReservationsViewController

- (void)loadView {
    [super loadView];
    self.navigationItem.title = @"MY RESERVATIONS";
    [self.view setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1]];

    // add reservation button
    UIBarButtonItem *addReservationButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(spaService:)];
    addReservationButton.title = @"+";
    [addReservationButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = addReservationButton;
    
    // collection view to list out the scheduled reservations
    UICollectionViewFlowLayout *cellLayout = [[UICollectionViewFlowLayout alloc]init];
    cellLayout.itemSize = CGSizeMake(self.view.frame.size.width - 20, 250);
    cellLayout.minimumInteritemSpacing = 10.0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:cellLayout];;
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[SpaMyRevervationView class] forCellWithReuseIdentifier:@"SpaMyReservationCollectionViewCell"];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[collectionView]-10-|" options:0 metrics:nil views:@{@"collectionView" : self.collectionView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[collectionView]-10-|" options:0 metrics:nil views:@{@"collectionView" : self.collectionView}]];
    self.repository = [[SpaReservationsRepository alloc] init];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self fetchMyReservations];
    [self.collectionView reloadData];
}

- (void)fetchMyReservations {
    // fetch all reservations
    NSFetchRequest *fetchRequest = [MyReservation fetchRequest];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    self.fetchedresultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[SpaDB sharedInstance].mainContext sectionNameKeyPath:nil cacheName:nil];
    [self.fetchedresultsController performFetch:nil];
    self.fetchedresultsController.delegate = self;
}

#pragma mark - <NSFetchedResultsControllerDelegate>

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // update collection when there is a update in reservation details
    [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.fetchedresultsController.fetchedObjects count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SpaMyRevervationView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SpaMyReservationCollectionViewCell" forIndexPath:indexPath];
    cell.myReservation = [self.fetchedresultsController.fetchedObjects objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - Actions

- (void)spaService:(id)sender {
    // push to list of spa service page
    SpaServiceViewController *spaServiceViewController = [[SpaServiceViewController alloc] init];
    [self.navigationController pushViewController:spaServiceViewController animated:YES];
}

@end
