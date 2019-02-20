//
//  SPDataAttendanceOut+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 20/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataAttendanceOut+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDataAttendanceOut (CoreDataProperties)

+ (NSFetchRequest<SPDataAttendanceOut *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *attandance_id;
@property (nullable, nonatomic, copy) NSString *foto;
@property (nullable, nonatomic, copy) NSString *refId;
@property (nullable, nonatomic, copy) NSString *remark;
@property (nullable, nonatomic, copy) NSString *tanggal;
@property (nullable, nonatomic, copy) NSString *time_attandance;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, retain) NSData *imagefotdata;

@end

NS_ASSUME_NONNULL_END
