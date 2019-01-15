//
//  SPUser+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 15/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPUser (CoreDataProperties)

+ (NSFetchRequest<SPUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *token;
@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *photo;
@property (nullable, nonatomic, copy) NSString *levelId;
@property (nullable, nonatomic, copy) NSString *levelName;
@property (nullable, nonatomic, copy) NSString *gradeId;
@property (nullable, nonatomic, copy) NSString *gradeName;
@property (nullable, nonatomic, copy) NSString *statusId;
@property (nullable, nonatomic, copy) NSString *statusName;
@property (nullable, nonatomic, copy) NSString *typeId;
@property (nullable, nonatomic, copy) NSString *typeName;
@property (nullable, nonatomic, copy) NSString *companyId;
@property (nullable, nonatomic, copy) NSString *companyName;
@property (nullable, nonatomic, copy) NSString *areaId;
@property (nullable, nonatomic, copy) NSString *areaName;

@end

NS_ASSUME_NONNULL_END
