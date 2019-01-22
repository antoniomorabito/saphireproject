//
//  SPNetworkManager.h
//  SapphireProject
//
//  Created by mac on 21/11/18.
//  Copyright © 2018 telkom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPLibrary.h"
typedef void (^SPCompletionHandler)(BOOL success,id responseObject, NSError *error);
@interface SPNetworkManager : NSObject
- (void)doLogin:(NSDictionary* )data
           view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;

- (void)doGetConfig:(NSDictionary* )data
           view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;

- (void)doGetStore:(NSDictionary* )data
               view:(UIView *)view
  completionHandler:(SPCompletionHandler)handler;


- (void)doGetQuiz:(NSDictionary* )data
              view:(UIView *)view
 completionHandler:(SPCompletionHandler)handler;

- (void)doGetCategory:(NSDictionary* )data
             view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;
@end
