//
//  SPDataLastCheckIn+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 10/04/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataLastCheckIn+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDataLastCheckIn (CoreDataProperties)

+ (NSFetchRequest<SPDataLastCheckIn *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *attandance_id;
@property (nullable, nonatomic, copy) NSString *time_attandance;
@property (nullable, nonatomic, copy) NSString *refId;
@property (nullable, nonatomic, copy) NSString *store_id;
@property (nullable, nonatomic, copy) NSString *photo;

@end

NS_ASSUME_NONNULL_END
