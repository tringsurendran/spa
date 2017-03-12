//
//  SpaReservationsRepository.h
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/9/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpaReservationsRepository : NSObject

- (void)saveReservation:(NSDictionary *)reservationDetails;
- (NSArray *)fetchMyReservations;

@end
