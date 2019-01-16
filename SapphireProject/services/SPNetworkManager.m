//
//  SPNetworkManager.m
//  SapphireProject
//
//  Created by mac on 21/11/18.
//  Copyright © 2018 telkom. All rights reserved.
//

#import "SPNetworkManager.h"

@implementation SPNetworkManager
- (void)doLogin:(NSDictionary* )data
           view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"";
    [hud showAnimated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@auth/login",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    
        [SPUser MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
        SPUser *spuser = [SPUser MR_createEntity];
        
        spuser.userId = ParseString([responseObject objectForKey:@"auth_token"]);
        spuser.token = ParseString([responseObject objectForKey:@"token"]);
        spuser.username = ParseString([responseObject objectForKey:@"username"]);
        spuser.name = ParseString([responseObject objectForKey:@"name"]);
        spuser.photo = ParseString([responseObject objectForKey:@"photo"]);
        spuser.levelId = ParseString([responseObject objectForKey:@"levelId"]);
        spuser.levelName = ParseString([responseObject objectForKey:@"levelName"]);
        spuser.gradeId = ParseString([responseObject objectForKey:@"gradeId"]);
        spuser.gradeName = ParseString([responseObject objectForKey:@"gradeName"]);
        spuser.statusId = ParseString([responseObject objectForKey:@"statusId"]);
        spuser.statusName = ParseString([responseObject objectForKey:@"statusName"]);
        spuser.typeId = ParseString([responseObject objectForKey:@"typeId"]);
        spuser.typeName = ParseString([responseObject objectForKey:@"typeName"]);
        spuser.companyId = ParseString([responseObject objectForKey:@"companyId"]);
        spuser.companyName = ParseString([responseObject objectForKey:@"companyName"]);
        spuser.areaId = ParseString([responseObject objectForKey:@"areaId"]);
        spuser.areaName = ParseString([responseObject objectForKey:@"areaName"]);
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        handler(YES,responseObject,nil);
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"error response nya adalah : %@",ErrorResponse);
        NSData *data = [ErrorResponse dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            handler(NO,json,error);
    
        [hud hideAnimated:YES];
    }];
}
- (void)doGetConfig:(NSDictionary* )data
               view:(UIView *)view
  completionHandler:(SPCompletionHandler)handler;{
    
}
@end
