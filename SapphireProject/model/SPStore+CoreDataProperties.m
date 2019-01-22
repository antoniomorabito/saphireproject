//
//  SPStore+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPStore+CoreDataProperties.h"

@implementation SPStore (CoreDataProperties)

+ (NSFetchRequest<SPStore *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPStore"];
}

@dynamic idstore;
@dynamic area_id;
@dynamic region_id;
@dynamic channel_id;
@dynamic dealer_id;
@dynamic name;
@dynamic address;
@dynamic latitude;
@dynamic longitude;
@dynamic created_by;
@dynamic created_date;
@dynamic updated_by;
@dynamic updated_create;
@dynamic user_id;

@end
