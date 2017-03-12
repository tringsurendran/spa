//
//  SpaServiceItem.h
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/7/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpaServiceItem : NSObject

@property (nonatomic, readonly) BOOL isAvailable;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *spaServiceDescription;


- (instancetype)initWithName:(NSString *)name available:(BOOL)isAvailable;

@end
