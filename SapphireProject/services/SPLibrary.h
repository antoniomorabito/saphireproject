//
//  SPLibrary.h
//  SapphireProject
//
//  Created by mac on 21/11/18.
//  Copyright © 2018 telkom. All rights reserved.
//

#ifndef SPLibrary_h
#define SPLibrary_h
#define ParseString(data) [data isKindOfClass:[NSNull class]] ? @"" : data
#define ParseInt(data) [data isKindOfClass:[NSNull class]] ? 0 : data
#define ParseArray(data) [data isKindOfClass:[NSNull class]] ? nil : data
#define kCABaseURL                     @"https://apps.pertamina.com/svc_ms2mobiledev/svc_ms2mobile.asmx?op="
//http://apibrightgas-homeservices.azurewebsites.net/
#define kCABaseRawImage                     @"http://nikahyuu.com/api/"
#import <MagicalRecord/MagicalRecord.h>
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import <UserNotifications/UserNotifications.h>
#import "AssetsLibrary/AssetsLibrary.h"
#import <AddressBook/AddressBook.h>


#import "SPMessageUtility.h"
//#import <SOAPEngine64/SOAPEngine.h>
#import "XMLReader.h"
#import "SapphireProject-Swift.h"
#endif /* SPLibrary_h */
