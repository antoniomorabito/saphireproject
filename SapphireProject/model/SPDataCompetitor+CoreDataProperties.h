//
//  SPDataCompetitor+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 01/03/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataCompetitor+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDataCompetitor (CoreDataProperties)

+ (NSFetchRequest<SPDataCompetitor *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *brand;
@property (nullable, nonatomic, copy) NSString *categoryName;
@property (nullable, nonatomic, copy) NSString *endPeriode;
@property (nullable, nonatomic, copy) NSString *idTable;
@property (nullable, nonatomic, copy) NSString *normalPrice;
@property (nullable, nonatomic, copy) NSString *photo;
@property (nullable, nonatomic, retain) NSData *photopath;
@property (nullable, nonatomic, copy) NSString *productId;
@property (nullable, nonatomic, copy) NSString *productName;
@property (nullable, nonatomic, copy) NSString *remark;
@property (nullable, nonatomic, copy) NSString *salePrice;
@property (nullable, nonatomic, copy) NSString *startPeriode;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *storeName;
@property (nullable, nonatomic, copy) NSString *timeCompetitor;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *categoryId;
@property (nullable, nonatomic, copy) NSString *totalPromotor;
@property (nullable, nonatomic, copy) NSString *estimationSellout;

@end

NS_ASSUME_NONNULL_END
