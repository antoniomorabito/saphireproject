//
//  SPCategory+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPCategory+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPCategory (CoreDataProperties)

+ (NSFetchRequest<SPCategory *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *idcategory;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, copy) NSString *created_by;
@property (nullable, nonatomic, copy) NSString *created_date;

@end

NS_ASSUME_NONNULL_END
