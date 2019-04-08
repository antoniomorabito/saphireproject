//
//  SPStaticPage+CoreDataProperties.h
//  SapphireProject
//
//  Created by mac on 08/04/19.
//  Copyright © 2019 telkom. All rights reserved.
//
//

#import "SPStaticPage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPStaticPage (CoreDataProperties)

+ (NSFetchRequest<SPStaticPage *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *page;
@property (nullable, nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
