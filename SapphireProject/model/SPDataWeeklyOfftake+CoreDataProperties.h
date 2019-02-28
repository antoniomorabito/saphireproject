//
//  SPDataWeeklyOfftake+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 28/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataWeeklyOfftake+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDataWeeklyOfftake (CoreDataProperties)

+ (NSFetchRequest<SPDataWeeklyOfftake *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *refId;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *timeWT;
@property (nullable, nonatomic, copy) NSString *productId;
@property (nullable, nonatomic, copy) NSString *totalQty1;
@property (nullable, nonatomic, copy) NSString *totalQty2;
@property (nullable, nonatomic, copy) NSString *totalQty3;
@property (nullable, nonatomic, copy) NSString *totalSales;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *categoryId;
@property (nullable, nonatomic, copy) NSString *channel_id;
@property (nullable, nonatomic, copy) NSString *status;

@end

NS_ASSUME_NONNULL_END
