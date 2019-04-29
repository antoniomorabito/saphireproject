//
//  SPDataAttendanceIn+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 26/04/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataAttendanceIn+CoreDataProperties.h"

@implementation SPDataAttendanceIn (CoreDataProperties)

+ (NSFetchRequest<SPDataAttendanceIn *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataAttendanceIn"];
}

@dynamic idattendance;
@dynamic imagefotdata;
@dynamic photo;
@dynamic refId;
@dynamic remark;
@dynamic storeId;
@dynamic tanggal;
@dynamic time_attandance;
@dynamic userId;
@dynamic status;

@end
