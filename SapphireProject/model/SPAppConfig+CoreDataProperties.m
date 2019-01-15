//
//  SPAppConfig+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 15/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPAppConfig+CoreDataProperties.h"

@implementation SPAppConfig (CoreDataProperties)

+ (NSFetchRequest<SPAppConfig *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPAppConfig"];
}

@dynamic parameterName;
@dynamic parameterValue;
@dynamic parameterFormat;

@end
