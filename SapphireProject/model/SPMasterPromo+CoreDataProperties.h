//
//  SPMasterPromo+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 18/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPMasterPromo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPMasterPromo (CoreDataProperties)

+ (NSFetchRequest<SPMasterPromo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *idPromo;
@property (nullable, nonatomic, copy) NSString *path_photo;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
