//
//  SPChannel+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 20/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPChannel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPChannel (CoreDataProperties)

+ (NSFetchRequest<SPChannel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *idChannel;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, copy) NSString *created_by;

@end

NS_ASSUME_NONNULL_END
