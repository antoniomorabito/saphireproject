//
//  SPDataMonthlyOfftake+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 23/02/19.
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
@dynamic storeId;
@dynamic timeMT;
@dynamic totalQty;
@dynamic totalSales;
@dynamic userId;
@dynamic status;

@end
