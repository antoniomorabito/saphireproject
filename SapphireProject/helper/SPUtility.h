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
+(NSString *)formattanggal:(NSString *)time;
+(NSString *)convertDateToString:(NSDate *)strDate toFormat:(NSString *)strToFormat;

+(NSDate *)convertStringToDate:(NSString *)strDate fromFormat:(NSString *)strFromFormat;
+(NSString *)intervalhours:(NSDate *)strDate toFormat:(NSDate *)afterdate;
@end
