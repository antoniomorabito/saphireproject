//
//  SPDataCompetitor+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 01/03/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataCompetitor+CoreDataProperties.h"

@implementation SPDataCompetitor (CoreDataProperties)

+ (NSFetchRequest<SPDataCompetitor *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataCompetitor"];
}

@dynamic brand;
@dynamic categoryName;
@dynamic endPeriode;
@dynamic idTable;
@dynamic normalPrice;
@dynamic photo;
@dynamic photopath;
@dynamic productId;
@dynamic productName;
@dynamic remark;
@dynamic salePrice;
@dynamic startPeriode;
@dynamic status;
@dynamic storeId;
@dynamic storeName;
@dynamic timeCompetitor;
@dynamic userId;
@dynamic categoryId;
@dynamic totalPromotor;
@dynamic estimationSellout;

@end
