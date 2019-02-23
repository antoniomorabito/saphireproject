//
//  SPDataSKU+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 23/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataSKU+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDataSKU (CoreDataProperties)

+ (NSFetchRequest<SPDataSKU *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *timeSku;
@property (nullable, nonatomic, copy) NSString *categoryId;
@property (nullable, nonatomic, copy) NSString *productId;
@property (nullable, nonatomic, retain) NSData *photo;
@property (nullable, nonatomic, copy) NSString *refId;
@property (nullable, nonatomic, copy) NSString *qty;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *status;

@end

NS_ASSUME_NONNULL_END
