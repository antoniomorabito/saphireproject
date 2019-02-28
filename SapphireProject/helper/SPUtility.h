//
//  SPUtility.h
//  SapphireProject
//
//  Created by mac on 23/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPNetworkManager.h"
@interface SPUtility : NSObject
+(void)initBannerNotif:(NSString *)title subtitle:(NSString*)mes body:(NSString*)bodmessage;
+(NSString *)changeFormat:(double)hasil;
@end
