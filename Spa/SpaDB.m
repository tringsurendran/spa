//
//  SpaDB.m
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/9/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "SpaDB.h"

@interface SpaDB ()

@property (nonatomic) NSManagedObjectModel *model;
@property (nonatomic) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic) NSManagedObjectContext *privateWriterContext;
@property (nonatomic) NSManagedObjectContext *mainContext;

@end

@implementation SpaDB

+ (instancetype)sharedInstance {
    static SpaDB *_db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _db = [[SpaDB alloc] init];
    });
    return _db;
}

- (instancetype)init {
    if (self = [super init]) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SpaModel" withExtension:@"momd"];
        self.model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        self.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        
        self.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        self.mainContext.name = @"MainContext";
        [self.mainContext setPersistentStoreCoordinator:self.coordinator];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"Spa.sqlite"];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            NSError *error = nil;
            NSDictionary *migrationOptions = @{
                                               NSMigratePersistentStoresAutomaticallyOption: @(YES),
                                               NSInferMappingModelAutomaticallyOption: @(YES)
                                               };
            NSPersistentStoreCoordinator *psc = [self.mainContext persistentStoreCoordinator];
            NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:migrationOptions error:&error];
            if (!store) {
                NSLog(@"Error initializing persistentStoreCoordinator: %@\n%@", [error localizedDescription], [error userInfo]);
            }
        });
    }
    return self;
}

- (NSManagedObjectContext *)backgroundContextWithName:(NSString *)name {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.name = name;
    context.parentContext = self.mainContext;
    
    return context;
}



@end
