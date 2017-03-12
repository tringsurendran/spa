//
//  MyReservation+CoreDataProperties.h
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/10/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "MyReservation+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MyReservation (CoreDataProperties)

+ (NSFetchRequest<MyReservation *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *identifier;
@property (nonatomic) int16_t partySize;
@property (nullable, nonatomic, copy) NSString *serviceName;

@end

NS_ASSUME_NONNULL_END
