//
//  SPUser+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 15/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPUser+CoreDataProperties.h"

@implementation SPUser (CoreDataProperties)

+ (NSFetchRequest<SPUser *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPUser"];
}

@dynamic userId;
@dynamic token;
@dynamic username;
@dynamic name;
@dynamic photo;
@dynamic levelId;
@dynamic levelName;
@dynamic gradeId;
@dynamic gradeName;
@dynamic statusId;
@dynamic statusName;
@dynamic typeId;
@dynamic typeName;
@dynamic companyId;
@dynamic companyName;
@dynamic areaId;
@dynamic areaName;

@end
