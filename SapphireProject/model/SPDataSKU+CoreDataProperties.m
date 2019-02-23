//
//  SPDataSKU+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 23/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataSKU+CoreDataProperties.h"

@implementation SPDataSKU (CoreDataProperties)

+ (NSFetchRequest<SPDataSKU *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataSKU"];
}

@dynamic storeId;
@dynamic timeSku;
@dynamic categoryId;
@dynamic productId;
@dynamic photo;
@dynamic refId;
@dynamic qty;
@dynamic userId;
@dynamic status;

@end
