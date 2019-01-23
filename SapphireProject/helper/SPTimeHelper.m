//
//  SPTimeHelper.m
//  SapphireProject
//
//  Created by mac on 23/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPTimeHelper.h"

@implementation SPTimeHelper
-(void)initTime{
    // At an opportune time (e.g. app start):
    TrueTimeClient *client = [TrueTimeClient sharedInstance];
    [client startWithPool:@[@"time.apple.com"] port:123];
    
    // You can now use this instead of [NSDate date]:
    NSDate *now = [[client referenceTime] now];
    
    // To block waiting for fetch, use the following:
    [client fetchIfNeededWithSuccess:^(NTPReferenceTime *referenceTime) {
        NSLog(@"True time: %@", [referenceTime now]);
    } failure:^(NSError *error) {
        NSLog(@"Error! %@", error);
    }];
}
@end
