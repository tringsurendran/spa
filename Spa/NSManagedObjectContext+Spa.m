//
//  NSManagedObjectContext+Spa.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/9/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "NSManagedObjectContext+Spa.h"

@implementation NSManagedObjectContext (Spa)

- (void)saveAndCascadeToPersistentStore {
    [self performBlock:^{
        BOOL success;
        NSError *error;
        if (![self hasChanges]) {
            success = YES;
        } else {
            @try {
                success = [self save:&error];
            } @catch (NSException *exception) {
                [[NSException exceptionWithName:@"NSManagedObjectContextException" reason:nil userInfo:nil] raise];
            }
        }
        // We've saved, now get off of the private queue
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (self.parentContext) {
                [self.parentContext saveAndCascadeToPersistentStore];
            }
        });
    }];
}


@end
