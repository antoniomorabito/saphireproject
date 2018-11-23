//
//  SPMessageUtility.m
//  SapphireProject
//
//  Created by mac on 21/11/18.
//  Copyright © 2018 telkom. All rights reserved.
//

#import "SPMessageUtility.h"

@implementation SPMessageUtility
+(BOOL)message :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc;
{
    __block BOOL value;
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Saphire"
                                  message:text
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             value= YES;
                         }];
    [alert addAction:ok];
    [vc presentViewController:alert animated:YES completion:nil];
    
    return value;
}
+ (void)paymentMethod :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;
{
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Pertamina MS2"
                                                                  message:@"Payment method"
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cc = [UIAlertAction actionWithTitle:@"Credit Card "
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
                         {
                             /** What we write here???????? **/
                             NSLog(@"you pressed Yes, please button");
                             
                             handler(YES,@"cc");
                             // call method whatever u need
                         }];
    
    UIAlertAction* dokuwallet = [UIAlertAction actionWithTitle:@"Doku Wallet"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action)
                                 {
                                     /** What we write here???????? **/
                                     NSLog(@"you pressed No, thanks button");
                                     handler(YES,@"dw");;
                                     // call method whatever u need
                                 }];
    
    UIAlertAction* permataBank = [UIAlertAction actionWithTitle:@"Permata Bank / ATM Bersama"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action)
                                  {
                                      /** What we write here???????? **/
                                      NSLog(@"you pressed No, thanks button");
                                      handler(YES,@"permata");
                                      // call method whatever u need
                                  }];
    
    
    UIAlertAction* MandiriClickpay = [UIAlertAction actionWithTitle:@"Mandiri Clickpay"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action)
                                      {
                                          /** What we write here???????? **/
                                          handler(YES,@"mandiri");
                                          // call method whatever u need
                                      }];
    
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel payment"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action)
                             {
                                 /** What we write here???????? **/
                                 handler(YES,@"");
                                 // call method whatever u need
                             }];
    
    
    [alert addAction:cc];
    [alert addAction:dokuwallet];
    [alert addAction:permataBank];
    [alert addAction:MandiriClickpay];
    [alert addAction:cancel];
    //    [vc.presentViewController:alert animated:YES completion:nil];
    
    [vc presentViewController:alert animated:YES completion:nil];
    
}

+(void)customYesOrNo :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;
{
    __block BOOL value;
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Pertamina MS2"
                                  message:text
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"YES"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             value= YES;
                             handler(YES,@"");
                         }];
    
    
    UIAlertAction* no = [UIAlertAction
                         actionWithTitle:@"NO"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             value= NO;
                             handler(NO,@"");
                         }];
    
    [alert addAction:ok];
    [alert addAction:no];
    [vc presentViewController:alert animated:YES completion:nil];
}

+(void)customDeleteYesOrno :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;{
    __block BOOL value;
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Pertamina MS2"
                                  message:text
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes "
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             value= YES;
                             handler(YES,@"");
                         }];
    
    
    UIAlertAction* no = [UIAlertAction
                         actionWithTitle:@"No"
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             value= YES;
                             handler(NO,@"");
                         }];
    
    [alert addAction:ok];
    [alert addAction:no];
    [vc presentViewController:alert animated:YES completion:nil];
}
+(void)customMessageDialog :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler
{
    __block BOOL value;
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Pertamina MS2"
                                  message:text
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             value= YES;
                             handler(YES,@"");
                         }];
    [alert addAction:ok];
    [vc presentViewController:alert animated:YES completion:nil];
    
    
}

+(void)customInputDialog:(NSString *)amount
                 message:(NSString *)messageInfo
             placeholder:(NSString *)placeholderInfo
          viewController:(UIViewController *)vc
               completiH:(utilityHandler)handler;{
    
    __block NSString *value = amount;
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Pertamina MS2"
                                                                              message: messageInfo
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = placeholderInfo;
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        if ([placeholderInfo isEqualToString:@"email field"])
        {
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        else
        {
            textField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        
        NSLog(@"nilai value: %@",namefield.text);
        value = namefield.text;
        handler(YES,value);
        
    }]];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                       handler(NO,value);
                                   }];
    
    [alertController addAction:cancelAction];
    
    NSLog(@"nilai value L: %@",value);
    [vc presentViewController:alertController animated:YES completion:nil];
    
    
}

+(void)customLocation :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;
{
    __block BOOL value;
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Pertamina MS2"
                                  message:text
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Cek pengaturan lokasi anda"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             value= YES;
                             handler(YES,@"");
                         }];
    
    
    UIAlertAction* no = [UIAlertAction
                         actionWithTitle:@"Batal melakukan pengecekan lokasi"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             value= YES;
                             handler(NO,@"");
                         }];
    
    [alert addAction:ok];
    [alert addAction:no];
    [vc presentViewController:alert animated:YES completion:nil];
}
+(BOOL)messagemaaf :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc;{
    __block BOOL value;
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Maaf"
                                  message:text
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             value= YES;
                         }];
    [alert addAction:ok];
    [vc presentViewController:alert animated:YES completion:nil];
    
    return value;
}
+(void)customMaafMessageDialog :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;{
    __block BOOL value;
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Maaf"
                                  message:text
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             value= YES;
                             handler(YES,@"");
                         }];
    [alert addAction:ok];
    [vc presentViewController:alert animated:YES completion:nil];
    
}
+(void)customvouchermessage :(NSString *)text needAction :(BOOL)actionType viewController :(UIViewController *)vc CH:(utilityHandler)handler;{
    __block BOOL value;
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Voucher valid."
                                  message:text
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             value= YES;
                             handler(YES,@"");
                         }];
    [alert addAction:ok];
    [vc presentViewController:alert animated:YES completion:nil];
}
@end
