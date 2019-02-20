//
//  SPDataDisplay+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 20/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataDisplay+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDataDisplay (CoreDataProperties)

+ (NSFetchRequest<SPDataDisplay *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *timeDisplay;
@property (nullable, nonatomic, copy) NSString *productId;
@property (nullable, nonatomic, copy) NSString *refId;
@property (nullable, nonatomic, copy) NSString *photo;
@property (nullable, nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
