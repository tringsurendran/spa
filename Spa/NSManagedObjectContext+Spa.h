//
//  NSManagedObjectContext+Spa.h
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/9/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface NSManagedObjectContext (Spa)

- (void)saveAndCascadeToPersistentStore;

@end
