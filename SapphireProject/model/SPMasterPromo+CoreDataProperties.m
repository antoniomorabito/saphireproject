//
//  SPMasterPromo+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 18/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPMasterPromo+CoreDataProperties.h"

@implementation SPMasterPromo (CoreDataProperties)

+ (NSFetchRequest<SPMasterPromo *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPMasterPromo"];
}

@dynamic idPromo;
@dynamic path_photo;
@dynamic title;

@end
