//
//  SPDataFeedBack+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 17/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataFeedBack+CoreDataProperties.h"

@implementation SPDataFeedBack (CoreDataProperties)

+ (NSFetchRequest<SPDataFeedBack *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataFeedBack"];
}

@dynamic storeId;
@dynamic timeFeedback;
@dynamic categoryId;
@dynamic statusBuy;
@dynamic customerName;
@dynamic customerPhone;
@dynamic customerFeedback;

@end
