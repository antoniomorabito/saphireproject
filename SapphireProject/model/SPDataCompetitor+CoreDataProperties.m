//
//  SPDataCompetitor+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 19/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataCompetitor+CoreDataProperties.h"

@implementation SPDataCompetitor (CoreDataProperties)

+ (NSFetchRequest<SPDataCompetitor *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataCompetitor"];
}

@dynamic timeCompetitor;
@dynamic brand;
@dynamic normalPrice;
@dynamic salePrice;
@dynamic remark;
@dynamic idTable;
@dynamic productId;
@dynamic startPeriode;
@dynamic endPeriode;
@dynamic storeId;
@dynamic photo;
@dynamic userId;

@end
