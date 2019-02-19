//
//  SPDataCompetitor+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 19/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataCompetitor+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDataCompetitor (CoreDataProperties)

+ (NSFetchRequest<SPDataCompetitor *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *timeCompetitor;
@property (nullable, nonatomic, copy) NSString *brand;
@property (nullable, nonatomic, copy) NSString *normalPrice;
@property (nullable, nonatomic, copy) NSString *salePrice;
@property (nullable, nonatomic, copy) NSString *remark;
@property (nullable, nonatomic, copy) NSString *idTable;
@property (nullable, nonatomic, copy) NSString *productId;
@property (nullable, nonatomic, copy) NSString *startPeriode;
@property (nullable, nonatomic, copy) NSString *endPeriode;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *photo;
@property (nullable, nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
