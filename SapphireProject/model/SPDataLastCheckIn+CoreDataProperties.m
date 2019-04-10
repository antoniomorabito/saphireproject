//
//  SPDataLastCheckIn+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 10/04/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataLastCheckIn+CoreDataProperties.h"

@implementation SPDataLastCheckIn (CoreDataProperties)

+ (NSFetchRequest<SPDataLastCheckIn *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataLastCheckIn"];
}

@dynamic attandance_id;
@dynamic time_attandance;
@dynamic refId;
@dynamic store_id;
@dynamic photo;

@end
