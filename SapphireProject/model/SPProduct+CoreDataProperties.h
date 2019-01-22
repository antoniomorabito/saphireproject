//
//  SPProduct+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPProduct+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPProduct (CoreDataProperties)

+ (NSFetchRequest<SPProduct *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *idproduct;
@property (nullable, nonatomic, copy) NSString *category_id;
@property (nullable, nonatomic, copy) NSString *region_id;
@property (nullable, nonatomic, copy) NSString *channel_id;
@property (nullable, nonatomic, copy) NSString *model_product;
@property (nullable, nonatomic, copy) NSString *price;
@property (nullable, nonatomic, copy) NSString *incentive;
@property (nullable, nonatomic, copy) NSString *periode_start;
@property (nullable, nonatomic, copy) NSString *periode_end;
@property (nullable, nonatomic, copy) NSString *status;

@end

NS_ASSUME_NONNULL_END
