//
//  SPDataMonthlyOfftake+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 23/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataMonthlyOfftake+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDataMonthlyOfftake (CoreDataProperties)

+ (NSFetchRequest<SPDataMonthlyOfftake *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *categoryId;
@property (nullable, nonatomic, copy) NSString *channel_id;
@property (nullable, nonatomic, copy) NSString *productId;
@property (nullable, nonatomic, copy) NSString *refId;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *timeMT;
@property (nullable, nonatomic, copy) NSString *totalQty;
@property (nullable, nonatomic, copy) NSString *totalSales;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *status;

@end

NS_ASSUME_NONNULL_END
