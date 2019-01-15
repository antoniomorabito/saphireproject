//
//  SPAppConfig+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 15/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPAppConfig+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPAppConfig (CoreDataProperties)

+ (NSFetchRequest<SPAppConfig *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *parameterName;
@property (nullable, nonatomic, copy) NSString *parameterValue;
@property (nullable, nonatomic, copy) NSString *parameterFormat;

@end

NS_ASSUME_NONNULL_END
