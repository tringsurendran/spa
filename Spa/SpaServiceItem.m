//
//  SpaServiceItem.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/7/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaServiceItem.h"

@interface SpaServiceItem ()

@property (nonatomic) BOOL isAvailable;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *spaServiceDescription;

@end

@implementation SpaServiceItem

- (instancetype)initWithName:(NSString *)name available:(BOOL)isAvailable {
    self = [super init];
    if (self) {
        self.isAvailable = isAvailable;
        self.name = name;
    }
    return self;
}

@end
