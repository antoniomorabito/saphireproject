//
//  SPUtility.m
//  SapphireProject
//
//  Created by mac on 23/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPUtility.h"

@implementation SPUtility
+(void)initBannerNotif:(NSString *)title subtitle:(NSString*)mes body:(NSString*)bodmessage{
    [APBannerManager showBannerWithTitle:title
                                subtitle:mes
                                    body:bodmessage
                                   image:[UIImage imageNamed:@"img_logo"]
                             actionBlock:^(APBannerActionType type) {
                                 switch (type) {
                                     case APBannerActionTypeTap:
                                         NSLog(@"TAP");
                                         break;
                                     case APBannerActionTypeDismiss:
                                         NSLog(@"DISMISS");
                                         break;
                                 }
                             }];
    
    [APBannerManager setTitleColor:[UIColor greenColor]];
    
    [APBannerManager setDuration:[NSNumber numberWithInteger:2]];
}


+(NSString *)changeFormat:(double)hasil{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setCurrencySymbol:@""];
    NSNumber *numberDone = [NSNumber numberWithDouble:hasil];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *text = [formatter stringFromNumber:numberDone];
    
    return text;
}

+(NSString *)formattanggal:(NSString *)time
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *dateFromString = [dateFormatter dateFromString:time];
    NSDateFormatter *dateFormattersecond = [[NSDateFormatter alloc] init];
    [dateFormattersecond setDateFormat:@"hh:mm:ss"];
    NSString *stringDate = [dateFormattersecond stringFromDate:dateFromString];
    
    NSLog(@"nilai string date : %@",stringDate);
    return stringDate;

}

+(NSString *)convertDateToString:(NSDate *)strDate toFormat:(NSString *)strToFormat
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = strToFormat;
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:strDate]];
}

+(NSString *)convertDate:(NSString *)strDate fromFormat:(NSString *)strFromFormat toFormat:(NSString *)strToFormat
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = strFromFormat;
    NSDate *dtNew = [dateFormatter dateFromString:strDate];
    dateFormatter.dateFormat = strToFormat;
    return [dateFormatter stringFromDate:dtNew];
}

+(NSDate *)convertStringToDate:(NSString *)strDate fromFormat:(NSString *)strFromFormat
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = strFromFormat;
    return [dateFormatter dateFromString:strDate];
}

+(NSString *)intervalhours:(NSDate *)strDate toFormat:(NSDate *)afterdate
{
    NSDate* date1 = strDate;
    NSDate* date2 = afterdate;
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    double secondsInAnHour = 3600;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    
    return [NSString stringWithFormat:@"%d",hoursBetweenDates];
}
@end
