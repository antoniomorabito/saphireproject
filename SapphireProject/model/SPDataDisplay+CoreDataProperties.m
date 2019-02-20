//
//  SPDataDisplay+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 20/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataDisplay+CoreDataProperties.h"

@implementation SPDataDisplay (CoreDataProperties)

+ (NSFetchRequest<SPDataDisplay *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataDisplay"];
}

@dynamic storeId;
@dynamic timeDisplay;
@dynamic productId;
@dynamic refId;
@dynamic photo;
@dynamic userId;

@end
