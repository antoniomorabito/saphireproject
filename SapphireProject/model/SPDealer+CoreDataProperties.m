//
//  SPDealer+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDealer+CoreDataProperties.h"

@implementation SPDealer (CoreDataProperties)

+ (NSFetchRequest<SPDealer *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDealer"];
}

@dynamic iddealer;
@dynamic name;
@dynamic status;

@end
