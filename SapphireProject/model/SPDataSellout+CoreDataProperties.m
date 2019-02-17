//
//  SPDataSellout+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 18/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataSellout+CoreDataProperties.h"

@implementation SPDataSellout (CoreDataProperties)

+ (NSFetchRequest<SPDataSellout *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataSellout"];
}

@dynamic customerAddress;
@dynamic customerName;
@dynamic customerPhone;
@dynamic customerPhoto;
@dynamic customerPrice;
@dynamic productId;
@dynamic statusInstalation;
@dynamic statusStock;
@dynamic storeId;
@dynamic timeSellout;
@dynamic totalQty;
@dynamic userId;
@dynamic idTable;

@end
