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


- (void)doGetChannel:(NSDictionary* )data
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

- (void)doGetDealer:(NSDictionary* )data
                 view:(UIView *)view
    completionHandler:(SPCompletionHandler)handler;

- (void)doGetCompetitor:(NSDictionary* )data
               view:(UIView *)view
  completionHandler:(SPCompletionHandler)handler;

- (void)doGetProducts:(NSDictionary* )data
                   view:(UIView *)view
      completionHandler:(SPCompletionHandler)handler;


- (void)doGetMasterPromo:(NSDictionary* )data
                 view:(UIView *)view
    completionHandler:(SPCompletionHandler)handler;

- (void)doGetDataProductsByCategory:(NSString* )idproduct
                 view:(UIView *)view
    completionHandler:(SPCompletionHandler)handler;

- (void)doSellout:(NSDictionary* )data
        imagedata:(NSData *)imageData
    imageFileName:(NSString*)filename
             view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;


- (void)doAddDisplay:(NSDictionary* )data
        imagedata:(NSData *)imageData
    imageFileName:(NSString*)filename
             view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;

- (void)doAddFeedback:(NSDictionary* )data
             view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;

- (void)doAddSKU:(NSDictionary* )data
            imagedata:(NSData *)imageData
        imageFileName:(NSString*)filename
                 view:(UIView *)view
    completionHandler:(SPCompletionHandler)handler;


- (void)doCompetitorInfo:(NSDictionary* )data
       imagedata:(NSData *)imageData
   imageFileName:(NSString*)filename
            view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;

- (void)doAttendanceIn :(NSDictionary* )data
             imagedata:(NSData *)imageData
         imageFileName:(NSString*)filename
                  view:(UIView *)view
   completionHandler:(SPCompletionHandler)handler;

- (void)doAttendanceOut :(NSDictionary* )data
              imagedata:(NSData *)imageData
          imageFileName:(NSString*)filename
                   view:(UIView *)view
      completionHandler:(SPCompletionHandler)handler;


- (void)doMonthlyOfftake:(NSDictionary* )data
            view:(UIView *)view
completionHandler:(SPCompletionHandler)handler;
    
- (void)doWeeklyOfftake:(NSDictionary* )data
                        view:(UIView *)view
           completionHandler:(SPCompletionHandler)handler;
@end
