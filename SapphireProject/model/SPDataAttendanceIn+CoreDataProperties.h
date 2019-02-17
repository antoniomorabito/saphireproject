//
//  SPDataAttendanceIn+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 18/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataAttendanceIn+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDataAttendanceIn (CoreDataProperties)

+ (NSFetchRequest<SPDataAttendanceIn *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *time_attandance;
@property (nullable, nonatomic, copy) NSString *remark;
@property (nullable, nonatomic, copy) NSString *photo;
@property (nullable, nonatomic, copy) NSString *refId;
@property (nullable, nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
