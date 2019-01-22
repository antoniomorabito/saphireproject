//
//  SPQuizMaster+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPQuizMaster+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPQuizMaster (CoreDataProperties)

+ (NSFetchRequest<SPQuizMaster *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *idquiz;
@property (nullable, nonatomic, copy) NSString *periode;
@property (nullable, nonatomic, copy) NSString *question;
@property (nullable, nonatomic, copy) NSString *answer;
@property (nullable, nonatomic, copy) NSString *answer_1;
@property (nullable, nonatomic, copy) NSString *answer_2;
@property (nullable, nonatomic, copy) NSString *answer_3;
@property (nullable, nonatomic, copy) NSString *answer_4;
@property (nullable, nonatomic, copy) NSString *answer_5;
@property (nullable, nonatomic, copy) NSString *created_by;
@property (nullable, nonatomic, copy) NSString *created_date;
@property (nullable, nonatomic, copy) NSString *updated_by;
@property (nullable, nonatomic, copy) NSString *updated_date;

@end

NS_ASSUME_NONNULL_END
