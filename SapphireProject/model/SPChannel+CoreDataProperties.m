//
//  SPChannel+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 20/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPChannel+CoreDataProperties.h"

@implementation SPChannel (CoreDataProperties)

+ (NSFetchRequest<SPChannel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPChannel"];
}

@dynamic idChannel;
@dynamic name;
@dynamic status;
@dynamic created_by;

@end
