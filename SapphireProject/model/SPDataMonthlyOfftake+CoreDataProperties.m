//
//  SPDataMonthlyOfftake+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 28/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataMonthlyOfftake+CoreDataProperties.h"

@implementation SPDataMonthlyOfftake (CoreDataProperties)

+ (NSFetchRequest<SPDataMonthlyOfftake *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataMonthlyOfftake"];
}

@dynamic categoryId;
@dynamic channel_id;
@dynamic productId;
@dynamic refId;
@dynamic status;
@dynamic storeId;
@dynamic timeMT;
@dynamic totalQty;
@dynamic totalSales;
@dynamic userId;
@dynamic categoryName;
@dynamic productName;
@dynamic storeName;

@end
