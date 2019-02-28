//
//  SPMessageUtility.h
//  SapphireProject
//
//  Created by mac on 21/11/18.
//  Copyright © 2018 telkom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^utilityHandler)(BOOL success,NSString* value);
typedef void (^utilityHandlerSecond)(BOOL success,NSString* valueFirst,NSString* valuesecond);
@interface SPMessageUtility : NSObject
+(BOOL)message :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc;
+(BOOL)messagemaaf :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc;

+ (void)paymentMethod :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;
+(void)customYesOrNo :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;
+(void)customMessageDialog :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;

+(void)customvouchermessage :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;
+(void)customInputDialog:(NSString *)amount
                 message:(NSString *)messageInfo
             placeholder:(NSString *)placeholderInfo
placeholderSecond:(NSString *)ppl
          viewController:(UIViewController *)vc
               completiH:(utilityHandlerSecond)handler;

+(void)customDeleteYesOrno :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;
+(void)customLocation :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;


+(void)customMaafMessageDialog :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;
@end
