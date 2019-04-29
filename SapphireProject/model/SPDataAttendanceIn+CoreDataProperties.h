//
//  SPDataAttendanceIn+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 26/04/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataAttendanceIn+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDataAttendanceIn (CoreDataProperties)

+ (NSFetchRequest<SPDataAttendanceIn *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *idattendance;
@property (nullable, nonatomic, retain) NSData *imagefotdata;
@property (nullable, nonatomic, copy) NSString *photo;
@property (nullable, nonatomic, copy) NSString *refId;
@property (nullable, nonatomic, copy) NSString *remark;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *tanggal;
@property (nullable, nonatomic, copy) NSString *time_attandance;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *status;

@end

NS_ASSUME_NONNULL_END
