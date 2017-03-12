//
//  MyReservation+CoreDataProperties.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/10/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "MyReservation+CoreDataProperties.h"

@implementation MyReservation (CoreDataProperties)

+ (NSFetchRequest<MyReservation *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MyReservation"];
}

@dynamic date;
@dynamic identifier;
@dynamic partySize;
@dynamic serviceName;

@end
