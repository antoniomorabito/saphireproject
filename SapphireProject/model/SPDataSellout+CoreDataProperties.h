//
//  SPDataSellout+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 18/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataSellout+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDataSellout (CoreDataProperties)

+ (NSFetchRequest<SPDataSellout *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *customerAddress;
@property (nullable, nonatomic, copy) NSString *customerName;
@property (nullable, nonatomic, copy) NSString *customerPhone;
@property (nullable, nonatomic, copy) NSString *customerPhoto;
@property (nullable, nonatomic, copy) NSString *customerPrice;
@property (nullable, nonatomic, copy) NSString *productId;
@property (nullable, nonatomic, copy) NSString *statusInstalation;
@property (nullable, nonatomic, copy) NSString *statusStock;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *timeSellout;
@property (nullable, nonatomic, copy) NSString *totalQty;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *idTable;

@end

NS_ASSUME_NONNULL_END
