//
//  SPDealer+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDealer+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDealer (CoreDataProperties)

+ (NSFetchRequest<SPDealer *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *iddealer;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *status;

@end

NS_ASSUME_NONNULL_END
