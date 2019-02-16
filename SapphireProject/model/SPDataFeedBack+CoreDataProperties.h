//
//  SPDataFeedBack+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 17/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataFeedBack+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPDataFeedBack (CoreDataProperties)

+ (NSFetchRequest<SPDataFeedBack *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *timeFeedback;
@property (nullable, nonatomic, copy) NSString *categoryId;
@property (nullable, nonatomic, copy) NSString *statusBuy;
@property (nullable, nonatomic, copy) NSString *customerName;
@property (nullable, nonatomic, copy) NSString *customerPhone;
@property (nullable, nonatomic, copy) NSString *customerFeedback;

@end

NS_ASSUME_NONNULL_END
