//
//  SPStaticPage+CoreDataProperties.m
//  SapphireProject
//
//  Created by mac on 08/04/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPStaticPage+CoreDataProperties.h"

@implementation SPStaticPage (CoreDataProperties)

+ (NSFetchRequest<SPStaticPage *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SPStaticPage"];
}

@dynamic page;
@dynamic content;

@end
