//
//  SPDataAttendanceOut+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 20/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataAttendanceOut+CoreDataProperties.h"

@implementation SPDataAttendanceOut (CoreDataProperties)

+ (NSFetchRequest<SPDataAttendanceOut *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataAttendanceOut"];
}

@dynamic attandance_id;
@dynamic foto;
@dynamic refId;
@dynamic remark;
@dynamic tanggal;
@dynamic time_attandance;
@dynamic userId;
@dynamic imagefotdata;

@end
