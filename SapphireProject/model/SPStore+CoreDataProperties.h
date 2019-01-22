//
//  SPStore+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPStore+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPStore (CoreDataProperties)

+ (NSFetchRequest<SPStore *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *idstore;
@property (nullable, nonatomic, copy) NSString *area_id;
@property (nullable, nonatomic, copy) NSString *region_id;
@property (nullable, nonatomic, copy) NSString *channel_id;
@property (nullable, nonatomic, copy) NSString *dealer_id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *longitude;
@property (nullable, nonatomic, copy) NSString *created_by;
@property (nullable, nonatomic, copy) NSString *created_date;
@property (nullable, nonatomic, copy) NSString *updated_by;
@property (nullable, nonatomic, copy) NSString *updated_create;
@property (nullable, nonatomic, copy) NSString *user_id;

@end

NS_ASSUME_NONNULL_END
