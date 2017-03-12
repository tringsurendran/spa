//
//  NSCalendar+Spa.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/9/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "NSCalendar+Spa.h"

@implementation NSCalendar (Spa)

- (NSArray *)getDaysOfCurrentMonth {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSMutableArray *datesThisMonth = [NSMutableArray array];
    NSRange rangeOfDays = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSDateComponents *components = [cal components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate date]];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    for (NSInteger i = rangeOfDays.location; i < NSMaxRange(rangeOfDays); ++i) {
        [components setDay:i];
        NSDate *dayInMonth = [cal dateFromComponents:components];
        [datesThisMonth addObject:dayInMonth];
    }
    return datesThisMonth;
}

@end
