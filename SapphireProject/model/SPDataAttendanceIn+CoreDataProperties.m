//
//  SPDataAttendanceIn+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 18/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataAttendanceIn+CoreDataProperties.h"

@implementation SPDataAttendanceIn (CoreDataProperties)

+ (NSFetchRequest<SPDataAttendanceIn *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataAttendanceIn"];
}

@dynamic storeId;
@dynamic time_attandance;
@dynamic remark;
@dynamic photo;
@dynamic refId;
@dynamic userId;

@end
