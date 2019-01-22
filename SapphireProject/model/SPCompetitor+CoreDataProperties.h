//
//  SPCompetitor+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPCompetitor+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPCompetitor (CoreDataProperties)

+ (NSFetchRequest<SPCompetitor *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *idcompetitor;
@property (nullable, nonatomic, copy) NSString *category_id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *status;

@end

NS_ASSUME_NONNULL_END
