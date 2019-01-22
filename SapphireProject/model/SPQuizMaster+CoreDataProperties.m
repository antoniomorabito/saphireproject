//
//  SPQuizMaster+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPQuizMaster+CoreDataProperties.h"

@implementation SPQuizMaster (CoreDataProperties)

+ (NSFetchRequest<SPQuizMaster *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPQuizMaster"];
}

@dynamic idquiz;
@dynamic periode;
@dynamic question;
@dynamic answer;
@dynamic answer_1;
@dynamic answer_2;
@dynamic answer_3;
@dynamic answer_4;
@dynamic answer_5;
@dynamic created_by;
@dynamic created_date;
@dynamic updated_by;
@dynamic updated_date;

@end
