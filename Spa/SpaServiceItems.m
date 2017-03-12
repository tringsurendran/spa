//
//  SpaServiceItems.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/7/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaServiceItems.h"
#import "SpaServiceItem.h"

@implementation SpaServiceItems

- (NSArray *)services {
    NSMutableArray *serviceList = [NSMutableArray new];
    [serviceList addObject:[[SpaServiceItem alloc] initWithName:@"Swedish Massage" available:NO]];
    [serviceList addObject:[[SpaServiceItem alloc] initWithName:@"Deep Tissue Massage" available:NO]];
    [serviceList addObject:[[SpaServiceItem alloc] initWithName:@"Hot Stone Massage" available:YES]];
    [serviceList addObject:[[SpaServiceItem alloc] initWithName:@"Refelexolgy" available:NO]];
    [serviceList addObject:[[SpaServiceItem alloc] initWithName:@"Trigger Point Theraphy" available:NO]];
    return serviceList;
}

@end
