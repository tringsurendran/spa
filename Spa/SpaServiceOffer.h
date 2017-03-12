//
//  SpaServiceOffer.h
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/8/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpaServiceOffer : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, readonly) BOOL isAvailable;

- (instancetype)initWithName:(NSString *)name available:(BOOL)isAvailable index:(NSInteger)index;

@end
