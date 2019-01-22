//
//  SPProduct+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPProduct+CoreDataProperties.h"

@implementation SPProduct (CoreDataProperties)

+ (NSFetchRequest<SPProduct *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPProduct"];
}

@dynamic idproduct;
@dynamic category_id;
@dynamic region_id;
@dynamic channel_id;
@dynamic model_product;
@dynamic price;
@dynamic incentive;
@dynamic periode_start;
@dynamic periode_end;
@dynamic status;

@end
