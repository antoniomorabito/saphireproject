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
@end
