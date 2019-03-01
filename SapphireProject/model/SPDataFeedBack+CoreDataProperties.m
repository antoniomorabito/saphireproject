//
//  SPDataFeedBack+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 01/03/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPDataFeedBack+CoreDataProperties.h"

@implementation SPDataFeedBack (CoreDataProperties)

+ (NSFetchRequest<SPDataFeedBack *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPDataFeedBack"];
}

@dynamic categoryId;
@dynamic customerFeedback;
@dynamic customerName;
@dynamic customerPhone;
@dynamic statusBuy;
@dynamic storeId;
@dynamic timeFeedback;
@dynamic userId;
@dynamic categoryname;
@dynamic status;
@dynamic refId;

@end
