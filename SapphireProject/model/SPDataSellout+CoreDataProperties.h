//
//  SPDataSellout+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 28/02/19.
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
@property (nullable, nonatomic, copy) NSString *idTable;
@property (nullable, nonatomic, copy) NSString *productId;
@property (nullable, nonatomic, copy) NSString *statusInstalation;
@property (nullable, nonatomic, copy) NSString *statusStock;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *timeSellout;
@property (nullable, nonatomic, copy) NSString *totalQty;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, retain) NSData *photofile;
@property (nullable, nonatomic, copy) NSString *category_id;
@property (nullable, nonatomic, copy) NSString *categoryName;
@property (nullable, nonatomic, copy) NSString *productName;
@property (nullable, nonatomic, copy) NSString *storeName;

@end

NS_ASSUME_NONNULL_END
