//
//  SPDataWeeklyOfftake+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 28/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataWeeklyOfftake+CoreDataProperties.h"

@implementation SPDataWeeklyOfftake (CoreDataProperties)

+ (NSFetchRequest<SPDataWeeklyOfftake *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataWeeklyOfftake"];
}

@dynamic categoryId;
@dynamic channel_id;
@dynamic productId;
@dynamic refId;
@dynamic status;
@dynamic storeId;
@dynamic timeWT;
@dynamic totalQty1;
@dynamic totalQty2;
@dynamic totalQty3;
@dynamic totalSales;
@dynamic userId;
@dynamic categoryName;
@dynamic productName;
@dynamic storeName;
@dynamic channelName;

@end
