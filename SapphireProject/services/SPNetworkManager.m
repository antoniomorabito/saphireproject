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
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
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
        
        
//        NSLog(@"response object config : %@",responseObject);
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:nil error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
//             handler(NO,json,nil);
//             [hud hideAnimated:YES];
            
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data config : %@",jsonDictionaryOrArray);
        }
          NSArray *dataContent = [jsonDictionaryOrArray objectForKey:@"content"];
          NSLog(@"array content : %@",dataContent);
        
        handler(YES,dataContent,nil);
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
        [hud hideAnimated:YES];
    }];
}

- (void)doGetMasterPromo:(NSDictionary* )data
                    view:(UIView *)view
       completionHandler:(SPCompletionHandler)handler;{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
    
    //    NSLog(@"user data  : %@ dan username %@ dan user company : %@ , dan user id :%@",user.token,user.username,user.companyId,user.userId);
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    
    
    [manager GET:[NSString stringWithFormat:@"%@promo",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        //        NSLog(@"response category : %@",responseObject);
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data category : %@",jsonDictionaryOrArray);
        }
        [SPMasterPromo MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        
        NSArray *dataContent = [jsonDictionaryOrArray objectForKey:@"data"];
        
        for (int i = 0; i<dataContent.count; i++) {
            SPMasterPromo *app = [SPMasterPromo MR_createEntity];
            
            NSDictionary *object = [dataContent objectAtIndex:i];
            
            app.idPromo = ParseString([object objectForKey:@"id"]);
            app.path_photo = ParseString([object objectForKey:@"path_photo"]);
            app.title = ParseString([object objectForKey:@"title"]);
        
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
        handler(YES,responseObject,nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
    
    }];
}
- (void)doGetStore:(NSDictionary* )data
              view:(UIView *)view
 completionHandler:(SPCompletionHandler)handler;{

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    SPUser *user = [SPUser MR_findFirst];

    //    NSLog(@"user data  : %@ dan username %@ dan user company : %@ , dan user id :%@",user.token,user.username,user.companyId,user.userId);
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];


    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];

    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];

    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"privilege"];

    NSLog(@"nilai url : %@",[NSString stringWithFormat:@"%@stores",kCABaseURL] );


    [manager GET:[NSString stringWithFormat:@"%@stores",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {


//        NSLog(@"response stores stores : %@",responseObject);

        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:nil error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error stores : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray

            NSLog(@"json data store : %@",jsonDictionaryOrArray);
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


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
    


    }];
    

}

- (void)doGetChannel:(NSDictionary* )data
                view:(UIView *)view
   completionHandler:(SPCompletionHandler)handler;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
    
    //    NSLog(@"user data  : %@ dan username %@ dan user company : %@ , dan user id :%@",user.token,user.username,user.companyId,user.userId);
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    
    
    [manager GET:[NSString stringWithFormat:@"%@master-channels",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        //        NSLog(@"response quia : %@",responseObject);
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data quiz : %@",jsonDictionaryOrArray);
        }
        [SPChannel MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        
        NSArray *dataContent = [jsonDictionaryOrArray objectForKey:@"data"];
        
        for (int i = 0; i<dataContent.count; i++) {
            SPChannel *app = [SPChannel MR_createEntity];
            
            NSDictionary *object = [dataContent objectAtIndex:i];
            
            app.idChannel = ParseString([object objectForKey:@"id"]);
            app.name = ParseString([object objectForKey:@"name"]);
            app.status = ParseString([object objectForKey:@"status"]);
            app.created_by = ParseString([object objectForKey:@"created_by"]);
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
        handler(YES,responseObject,nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
    
        
    }];
}
- (void)doGetQuiz:(NSDictionary* )data
             view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;{

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
    
    //    NSLog(@"user data  : %@ dan username %@ dan user company : %@ , dan user id :%@",user.token,user.username,user.companyId,user.userId);
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    
    
    [manager GET:[NSString stringWithFormat:@"%@master-quiz?datetime=02-01-2019",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
//        NSLog(@"response quia : %@",responseObject);
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data quiz : %@",jsonDictionaryOrArray);
        }
        [SPQuizMaster MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        
        NSArray *dataContent = [jsonDictionaryOrArray objectForKey:@"data"];
        
        for (int i = 0; i<dataContent.count; i++) {
            SPQuizMaster *app = [SPQuizMaster MR_createEntity];
            
            NSDictionary *object = [dataContent objectAtIndex:i];
            
            app.idquiz = ParseString([object objectForKey:@"id"]);
            app.periode = ParseString([object objectForKey:@"periode"]);
            app.question = ParseString([object objectForKey:@"question"]);
            app.answer = ParseString([object objectForKey:@"answer"]);
            app.answer_1 = ParseString([object objectForKey:@"answer_1"]);
            app.answer_2 = ParseString([object objectForKey:@"answer_2"]);
            app.answer_3 = ParseString([object objectForKey:@"answer_3"]);
            app.answer_4 = ParseString([object objectForKey:@"answer_4"]);
            app.answer_5 = ParseString([object objectForKey:@"answer_5"]);
            app.created_by = ParseString([object objectForKey:@"created_by"]);
            app.created_date = ParseString([object objectForKey:@"created_date"]);
            app.updated_by = ParseString([object objectForKey:@"updated_by"]);
            app.updated_date = ParseString([object objectForKey:@"updated_date"]);
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
        handler(YES,responseObject,nil);
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
    
        
    
    }];
}
- (void)doGetCategory:(NSDictionary* )data
                 view:(UIView *)view
    completionHandler:(SPCompletionHandler)handler;{;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
    
    //    NSLog(@"user data  : %@ dan username %@ dan user company : %@ , dan user id :%@",user.token,user.username,user.companyId,user.userId);
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    
    
    [manager GET:[NSString stringWithFormat:@"%@master-categories?page=0&limit=10&order=name,asc&keyword=",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
//        NSLog(@"response category : %@",responseObject);
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data category : %@",jsonDictionaryOrArray);
        }
        [SPQuizMaster MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        
        NSArray *dataContent = [jsonDictionaryOrArray objectForKey:@"data"];
        
        for (int i = 0; i<dataContent.count; i++) {
            SPCategory *app = [SPCategory MR_createEntity];
            
            NSDictionary *object = [dataContent objectAtIndex:i];
            
            app.idcategory = ParseString([object objectForKey:@"id"]);
            app.name = ParseString([object objectForKey:@"name"]);
            app.status = ParseString([object objectForKey:@"status"]);
            app.created_by = ParseString([object objectForKey:@"created_by"]);
            app.created_date = ParseString([object objectForKey:@"created_date"]);
            
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
        handler(YES,responseObject,nil);
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
    
    }];
}
- (void)doGetDealer:(NSDictionary* )data
               view:(UIView *)view
  completionHandler:(SPCompletionHandler)handler;{

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
    
    //    NSLog(@"user data  : %@ dan username %@ dan user company : %@ , dan user id :%@",user.token,user.username,user.companyId,user.userId);
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    
    
    [manager GET:[NSString stringWithFormat:@"%@master-dealers",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
//        NSLog(@"response dealer : %@",responseObject);
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data dealer  : %@",jsonDictionaryOrArray);
        }
        [SPDealer MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        
        NSArray *dataContent = [jsonDictionaryOrArray objectForKey:@"data"];
        
        for (int i = 0; i<dataContent.count; i++) {
            SPDealer *app = [SPDealer MR_createEntity];
            
            NSDictionary *object = [dataContent objectAtIndex:i];
            
            app.iddealer = ParseString([object objectForKey:@"id"]);
            app.name = ParseString([object objectForKey:@"name"]);
            app.status = ParseString([object objectForKey:@"status"]);
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
        handler(YES,responseObject,nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"error response nya adalah : %@",ErrorResponse);
        NSData *data = [ErrorResponse dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        handler(NO,json,error);
        
        
    }];
}
- (void)doGetCompetitor:(NSDictionary* )data
                   view:(UIView *)view
      completionHandler:(SPCompletionHandler)handler;{

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
    
    //    NSLog(@"user data  : %@ dan username %@ dan user company : %@ , dan user id :%@",user.token,user.username,user.companyId,user.userId);
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    
    
    [manager GET:[NSString stringWithFormat:@"%@competitors",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
//        NSLog(@"response competitors : %@",responseObject);
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data competitor : %@",jsonDictionaryOrArray);
        }
        [SPCompetitor MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        
        NSArray *dataContent = [jsonDictionaryOrArray objectForKey:@"data"];
        
        for (int i = 0; i<dataContent.count; i++) {
            SPCompetitor *app = [SPCompetitor MR_createEntity];
            
            NSDictionary *object = [dataContent objectAtIndex:i];
            
            app.idcompetitor = ParseString([object objectForKey:@"id"]);
            app.name = ParseString([object objectForKey:@"name"]);
            app.status = ParseString([object objectForKey:@"status"]);
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
        handler(YES,responseObject,nil);
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
    
    
    }];
}
- (void)doGetProducts:(NSDictionary* )data
                 view:(UIView *)view
    completionHandler:(SPCompletionHandler)handler;{

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
    
    //    NSLog(@"user data  : %@ dan username %@ dan user company : %@ , dan user id :%@",user.token,user.username,user.companyId,user.userId);
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    
    
    [manager GET:[NSString stringWithFormat:@"%@master-products?page=0&limit=10",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
//        NSLog(@"response master-products?page=0&limit=10 : %@",responseObject);
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data products : %@",jsonDictionaryOrArray);
        }
        [SPProduct MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        
        NSArray *dataContent = [jsonDictionaryOrArray objectForKey:@"data"];
        
        for (int i = 0; i<dataContent.count; i++) {
            SPProduct *app = [SPProduct MR_createEntity];
            
            NSDictionary *object = [dataContent objectAtIndex:i];
            
            app.idproduct = ParseString([object objectForKey:@"id"]);
            app.category_id = ParseString([object objectForKey:@"category_id"]);
            app.region_id = ParseString([object objectForKey:@"region_id"]);
            app.channel_id = ParseString([object objectForKey:@"channel_id"]);
            app.model_product = ParseString([object objectForKey:@"model_product"]);
            app.price = ParseString([object objectForKey:@"price"]);
            app.incentive = ParseString([object objectForKey:@"incentive"]);
            app.periode_start = ParseString([object objectForKey:@"periode_start"]);
            app.periode_end = ParseString([object objectForKey:@"periode_end"]);
            app.status = ParseString([object objectForKey:@"status"]);
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
        handler(YES,responseObject,nil);
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
    
    
    }];
}
- (void)doGetDataProductsByCategory:
                                (NSString* )idproduct
                               view:(UIView *)view
                  completionHandler:(SPCompletionHandler)handler;{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
  
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    [manager GET:[NSString stringWithFormat:@"%@master-products?page=0&limit=20&categoryId=%@",kCABaseURL,idproduct]  parameters:NULL progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data products : %@",jsonDictionaryOrArray);
        }
        [SPProduct MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        
        NSArray *dataContent = [jsonDictionaryOrArray objectForKey:@"data"];
        
        for (int i = 0; i<dataContent.count; i++) {
            SPProduct *app = [SPProduct MR_createEntity];
            
            NSDictionary *object = [dataContent objectAtIndex:i];
            
            app.idproduct = ParseString([object objectForKey:@"id"]);
            app.category_id = ParseString([object objectForKey:@"category_id"]);
            app.region_id = ParseString([object objectForKey:@"region_id"]);
            app.channel_id = ParseString([object objectForKey:@"channel_id"]);
            app.model_product = ParseString([object objectForKey:@"model_product"]);
            app.price = ParseString([object objectForKey:@"price"]);
            app.incentive = ParseString([object objectForKey:@"incentive"]);
            app.periode_start = ParseString([object objectForKey:@"periode_start"]);
            app.periode_end = ParseString([object objectForKey:@"periode_end"]);
            app.status = ParseString([object objectForKey:@"status"]);
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
        handler(YES,responseObject,nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
    
        
        
    }];
}
- (void)doSellout:(NSDictionary* )data
             view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
    
    //    NSLog(@"user data  : %@ dan username %@ dan user company : %@ , dan user id :%@",user.token,user.username,user.companyId,user.userId);
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    
    
    [manager POST:[NSString stringWithFormat:@"%@sellout/add",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
//        NSLog(@"sellout/add : %@",responseObject);
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data  : %@",jsonDictionaryOrArray);
        }
    
        handler(YES,responseObject,nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"error response nya sellout adalah : %@",ErrorResponse);
        NSData *data = [ErrorResponse dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        handler(NO,json,error);
        
        
    }];
}
- (void)doAddFeedback:(NSDictionary* )data
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
    
    
    
    [manager POST:[NSString stringWithFormat:@"%@feedback/add",kCABaseURL]  parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        //        NSLog(@"sellout/add : %@",responseObject);
        
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data feedback : %@",jsonDictionaryOrArray);
        }
        
        handler(YES,jsonDictionaryOrArray,nil);
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
- (void)doAttendanceIn :(NSDictionary* )data
              imagedata:(NSData *)imageData
          imageFileName:(NSString*)filename
                   view:(UIView *)view
      completionHandler:(SPCompletionHandler)handler;
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"";
    [hud showAnimated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    
    
    //    manager.securityPolicy.allowInvalidCertificates = YES;

        [manager POST:[NSString stringWithFormat:@"%@attendances/send/in",kCABaseURL] parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData
                                        name:@"photo"
                                    fileName:filename mimeType:@"image/png"];   // add image to formData
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *jsonError;
            NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
            if(jsonError) {
                // check the error description
                NSLog(@"json error : %@", [jsonError localizedDescription]);
            } else {
                // use the jsonDictionaryOrArray
                
                NSLog(@"json data attendance in : %@",jsonDictionaryOrArray);
            }
            
            handler(YES,jsonDictionaryOrArray,nil);
            [hud hideAnimated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
            
            handler(NO,serializedData,error);
            [hud hideAnimated:YES];
        }];
    
}

- (void)doAttendanceOut :(NSDictionary* )data
               imagedata:(NSData *)imageData
           imageFileName:(NSString*)filename
                    view:(UIView *)view
       completionHandler:(SPCompletionHandler)handler;
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"";
    [hud showAnimated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SPUser *user = [SPUser MR_findFirst];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    
    
    [manager POST:[NSString stringWithFormat:@"%@attendances/send/out",kCABaseURL] parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"photo"
                                fileName:filename mimeType:@"image/png"];   // add image to formData
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data attendance in : %@",jsonDictionaryOrArray);
        }
        
        handler(YES,jsonDictionaryOrArray,nil);
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        
        handler(NO,serializedData,error);
        [hud hideAnimated:YES];
    }];
}
- (void)doAddSKU:(NSDictionary* )data
       imagedata:(NSData *)imageData
   imageFileName:(NSString*)filename
            view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;
{
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
    
    
    [manager POST:[NSString stringWithFormat:@"%@sku/add",kCABaseURL] parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"photo"
                                fileName:filename mimeType:@"image/png"];   // add image to formData
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data feedback : %@",jsonDictionaryOrArray);
        }
        
        handler(YES,jsonDictionaryOrArray,nil);
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        
        handler(NO,serializedData,error);
        [hud hideAnimated:YES];
    }];
}

- (void)doCompetitorInfo:(NSDictionary* )data
               imagedata:(NSData *)imageData
           imageFileName:(NSString*)filename
                    view:(UIView *)view
       completionHandler:(SPCompletionHandler)handler;
{
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
    
    
    [manager POST:[NSString stringWithFormat:@"%@competitor-info/add",kCABaseURL] parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"photo"
                                fileName:filename mimeType:@"image/png"];   // add image to formData
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data competitor : %@",jsonDictionaryOrArray);
        }
        
        handler(YES,jsonDictionaryOrArray,nil);
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *data= error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSError* errorda;
        
        if (data !=nil) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&errorda];
            NSLog(@"error json : %@",json);
            handler(NO,json,error);
        }
        else{
            NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
            handler(NO,errResponse,error);
        }
        [hud hideAnimated:YES];
    }];
}
- (void)doSellout:(NSDictionary* )data
        imagedata:(NSData *)imageData
    imageFileName:(NSString*)filename
             view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;
{
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
    
    
    [manager POST:[NSString stringWithFormat:@"%@sellout/add",kCABaseURL] parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"customerPhoto"
                                fileName:filename mimeType:@"image/png"];   // add image to formData
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data sellout : %@",jsonDictionaryOrArray);
        }
        
        handler(YES,jsonDictionaryOrArray,nil);
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
        [hud hideAnimated:YES];
    }];
}
- (void)doAddDisplay:(NSDictionary* )data
           imagedata:(NSData *)imageData
       imageFileName:(NSString*)filename
                view:(UIView *)view
   completionHandler:(SPCompletionHandler)handler;
{
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
    
    
    [manager POST:[NSString stringWithFormat:@"%@display/add",kCABaseURL] parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"photo"
                                fileName:filename mimeType:@"image/png"];   // add image to formData
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data feedback : %@",jsonDictionaryOrArray);
        }
        
        handler(YES,jsonDictionaryOrArray,nil);
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
        [hud hideAnimated:YES];
    }];
}

- (void)doMonthlyOfftake:(NSDictionary* )data
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
    
    
    [manager POST:[NSString stringWithFormat:@"%@monthly-offtake/add",kCABaseURL] parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
       
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data monthly offtake : %@",jsonDictionaryOrArray);
        }
        
        handler(YES,jsonDictionaryOrArray,nil);
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
        [hud hideAnimated:YES];
    }];
    
}
- (void)doWeeklyOfftake:(NSDictionary* )data
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

    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
    
    
    [manager POST:[NSString stringWithFormat:@"%@weekly-offtake/add",kCABaseURL] parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data weekly offtake : %@",jsonDictionaryOrArray);
        }
        
        handler(YES,jsonDictionaryOrArray,nil);
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
        [hud hideAnimated:YES];
    }];
}
    
- (void)doUpdatePicture:(NSDictionary* )data
              imagedata:(NSData *)imageData
          imageFileName:(NSString*)filename
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
    
    
    [manager POST:[NSString stringWithFormat:@"%@auth/profile",kCABaseURL] parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"foto"
                                fileName:filename mimeType:@"image/png"];   // add image to formData
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *jsonError;
        NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
        if(jsonError) {
            // check the error description
            NSLog(@"json error : %@", [jsonError localizedDescription]);
        } else {
            // use the jsonDictionaryOrArray
            
            NSLog(@"json data auth/profile : %@",jsonDictionaryOrArray);
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            
            SPUser *spuser = [SPUser MR_findFirst];

            spuser.photo = [jsonDictionaryOrArray objectForKey:@"photo"];
             [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        handler(YES,jsonDictionaryOrArray,nil);
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        handler(NO,errResponse,error);
        [hud hideAnimated:YES];
    }];
}
- (void)doUpdatePassword:(NSDictionary* )data
                        view:(UIView *)view
           completionHandler:(SPCompletionHandler)handler;
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = @"";
        [hud showAnimated:YES];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        SPUser *user = [SPUser MR_findFirst];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.token] forHTTPHeaderField:@"token"];
        
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.companyId] forHTTPHeaderField:@"companyId"];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",user.userId] forHTTPHeaderField:@"userId"];
        
        
        [manager POST:[NSString stringWithFormat:@"%@auth/profile",kCABaseURL] parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *jsonError;
            NSDictionary * jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NULL error:&jsonError];
            if(jsonError) {
                // check the error description
                NSLog(@"json error : %@", [jsonError localizedDescription]);
            } else {
                // use the jsonDictionaryOrArray
                
                NSLog(@"json data auth/profile : %@",jsonDictionaryOrArray);
            }
            
            handler(YES,jsonDictionaryOrArray,nil);
            [hud hideAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSData *data= error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSError* errorda;
            
            if (data !=nil) {
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&errorda];
                   NSLog(@"error json : %@",json);
                 handler(NO,json,error);
            }
            else{
            NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                handler(NO,errResponse,error);
            }
            [hud hideAnimated:YES];
        }];
    }
@end
