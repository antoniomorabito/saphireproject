//
//  SPCompetitor+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPCompetitor+CoreDataProperties.h"

@implementation SPCompetitor (CoreDataProperties)

+ (NSFetchRequest<SPCompetitor *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPCompetitor"];
}

@dynamic idcompetitor;
@dynamic category_id;
@dynamic name;
@dynamic status;

@end
