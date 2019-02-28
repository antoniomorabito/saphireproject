//
//  SPDataSellout+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 28/02/19.
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
@dynamic idTable;
@dynamic productId;
@dynamic statusInstalation;
@dynamic statusStock;
@dynamic storeId;
@dynamic timeSellout;
@dynamic totalQty;
@dynamic userId;
@dynamic status;
@dynamic photofile;
@dynamic category_id;
@dynamic categoryName;
@dynamic productName;
@dynamic storeName;

@end
