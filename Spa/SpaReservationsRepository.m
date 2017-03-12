//
//  SpaReservationsRepository.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/9/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaReservationsRepository.h"
#import "SpaDB.h"
#import "MyReservation+CoreDataClass.h"
#import "NSManagedObjectContext+Spa.h"

@implementation SpaReservationsRepository

- (void)saveReservation:(NSDictionary *)reservationDetails {
    NSManagedObjectContext *context = [[SpaDB sharedInstance] backgroundContextWithName:@"saveReservation"];
    MyReservation *myReservation = [NSEntityDescription insertNewObjectForEntityForName:@"MyReservation"
                                  inManagedObjectContext:context];
    myReservation.serviceName = reservationDetails[@"serviceName"];
    myReservation.date = reservationDetails[@"date"];
    myReservation.partySize = [reservationDetails[@"partySize"] intValue];
    myReservation.identifier = [SpaReservationsRepository getUniqueIdentifier];
    [context saveAndCascadeToPersistentStore]; // Handle error if any while saving
}

+ (NSString *)getUniqueIdentifier
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

@end
