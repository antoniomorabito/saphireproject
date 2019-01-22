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
        
    
        NSLog(@"response login user :  %@",responseObject);;
        [SPUser MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
        SPUser *spuser = [SPUser MR_createEntity];
        
        spuser.userId = ParseString([responseObject objectForKey:@"userId"]);
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"";
    [hud showAnimated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
    
    NSLog(@"user data  : %@ dan username %@ dan user company : %@ , dan user id :%@",user.token,user.username,user.companyId,user.userId);
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
     [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.username] forHTTPHeaderField:@"username"];
    
     [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
     [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    

    [manager GET:[NSString stringWithFormat:@"%@app_config",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"response object config : %@",responseObject);
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:nil error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data  : %@",jsonDictionaryOrArray);
        }
        [SPAppConfig MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
        
        NSArray *dataContent = [jsonDictionaryOrArray objectForKey:@"content"];
        
        for (int i = 0; i<dataContent.count; i++) {
            SPAppConfig *app = [SPAppConfig MR_createEntity];
            
            NSDictionary *object = [dataContent objectAtIndex:i];
            
            app.parameterFormat = ParseString([object objectForKey:@"parameterFormat"]);
            app.parameterName = ParseString([object objectForKey:@"parameterName"]);
            app.parameterValue = ParseString([object objectForKey:@"parameterValue"]);
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
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
- (void)doGetStore:(NSDictionary* )data
              view:(UIView *)view
 completionHandler:(SPCompletionHandler)handler;{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"";
    [hud showAnimated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
    
//    NSLog(@"user data  : %@ dan username %@ dan user company : %@ , dan user id :%@",user.token,user.username,user.companyId,user.userId);
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];

    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    
    
    [manager GET:[NSString stringWithFormat:@"%@stores",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"response stores stores : %@",responseObject);
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data  : %@",jsonDictionaryOrArray);
        }
        [SPStore MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        
        NSArray *dataContent = [jsonDictionaryOrArray objectForKey:@"data"];
        
        for (int i = 0; i<dataContent.count; i++) {
            SPStore *app = [SPStore MR_createEntity];
            
            NSDictionary *object = [dataContent objectAtIndex:i];
            
            app.idstore = ParseString([object objectForKey:@"id"]);
            app.area_id = ParseString([object objectForKey:@"area_id"]);
            app.region_id = ParseString([object objectForKey:@"region_id"]);
            app.channel_id = ParseString([object objectForKey:@"channel_id"]);
            app.dealer_id = ParseString([object objectForKey:@"dealer_id"]);
            app.name = ParseString([object objectForKey:@"name"]);
            app.address = ParseString([object objectForKey:@"address"]);
            app.latitude = ParseString([object objectForKey:@"latitude"]);
            app.longitude = ParseString([object objectForKey:@"longitude"]);
            app.created_by = ParseString([object objectForKey:@"created_by"]);
            app.created_date = ParseString([object objectForKey:@"created_date"]);
            app.updated_by = ParseString([object objectForKey:@"updated_by"]);
            app.updated_create = ParseString([object objectForKey:@"updated_create"]);
            app.user_id = ParseString([object objectForKey:@"user_id"]);
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
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
@end
