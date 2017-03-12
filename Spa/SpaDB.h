//
//  SpaDB.h
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/9/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface SpaDB : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *mainContext;
- (NSManagedObjectContext *)backgroundContextWithName:(NSString *)name;
+ (instancetype)sharedInstance;

@end
