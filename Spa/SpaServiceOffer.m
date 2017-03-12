//
//  SpaServiceOffer.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/8/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaServiceOffer.h"

@interface SpaServiceOffer ()

@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger index;
@property (nonatomic) BOOL isAvailable;

@end

@implementation SpaServiceOffer

- (instancetype)initWithName:(NSString *)name available:(BOOL)isAvailable index:(NSInteger)index {
    self = [super init];
    if (self) {
        self.isAvailable = isAvailable;
        self.name = name;
        self.index = index;
    }
    return self;
}


@end
