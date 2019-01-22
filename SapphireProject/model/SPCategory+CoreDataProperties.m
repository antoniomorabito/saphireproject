//
//  SPCategory+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPCategory+CoreDataProperties.h"

@implementation SPCategory (CoreDataProperties)

+ (NSFetchRequest<SPCategory *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPCategory"];
}

@dynamic idcategory;
@dynamic name;
@dynamic status;
@dynamic created_by;
@dynamic created_date;

@end
