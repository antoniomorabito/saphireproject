//
//  SPDataSellout+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 16/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataSellout+CoreDataProperties.h"

@implementation SPDataSellout (CoreDataProperties)

+ (NSFetchRequest<SPDataSellout *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataSellout"];
}

@dynamic storeId;
@dynamic timeSellout;
@dynamic productId;
@dynamic totalQty;
@dynamic statusStock;
@dynamic statusInstalation;
@dynamic customerName;
@dynamic customerPhone;
@dynamic customerAddress;
@dynamic customerPrice;
@dynamic customerPhoto;

@end
