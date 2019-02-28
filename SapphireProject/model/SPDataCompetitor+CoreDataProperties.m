//
//  SPDataCompetitor+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 28/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataCompetitor+CoreDataProperties.h"

@implementation SPDataCompetitor (CoreDataProperties)

+ (NSFetchRequest<SPDataCompetitor *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataCompetitor"];
}

@dynamic brand;
@dynamic endPeriode;
@dynamic idTable;
@dynamic normalPrice;
@dynamic photo;
@dynamic productId;
@dynamic remark;
@dynamic salePrice;
@dynamic startPeriode;
@dynamic storeId;
@dynamic timeCompetitor;
@dynamic userId;
@dynamic categoryName;
@dynamic productName;
@dynamic storeName;
@dynamic status;
@dynamic photopath;

@end
