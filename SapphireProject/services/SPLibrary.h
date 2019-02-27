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
#define kCABaseURL                     @"http://saphire.id/api.saphire/"
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

#import "JVFloatLabeledTextView.h"
#import "JVFloatLabeledTextField.h"
#import "SPMessageUtility.h"
//#import <SOAPEngine64/SOAPEngine.h>
#import "SapphireProject-Swift.h"

//coredata
#import "SPStore+CoreDataProperties.h"
#import "SPAppConfig+CoreDataClass.h"
#import "SPUser+CoreDataClass.h"
#import "SPQuizMaster+CoreDataProperties.h"
#import "SapphireProject-Bridging-Header.h"
#import "SPCategory+CoreDataProperties.h"
#import "SPDealer+CoreDataProperties.h"
#import "SPCompetitor+CoreDataProperties.h"
#import "SPProduct+CoreDataProperties.h"
@import TrueTime;

#import "SearchStringPickerViewController.h"

#import "LSLDatePickerDialog.h"
#import <APBanner/APBannerManager.h>

#import "NSDate+Helper.h"
#import "SPUtility.h"

//coredata modeling
#import "SPDataAttendanceIn+CoreDataProperties.h"
#import "SPDataSellout+CoreDataProperties.h"
#import "SPDataFeedBack+CoreDataProperties.h"
#import "SPMasterPromo+CoreDataProperties.h"
#import "SPDataCompetitor+CoreDataProperties.h"
#import "SPDataDisplay+CoreDataProperties.h"
#import "SPDataAttendanceOut+CoreDataProperties.h"
#import "SPChannel+CoreDataProperties.h"
#import "SPDataMonthlyOfftake+CoreDataProperties.h"
#import "SPDataSKU+CoreDataProperties.h"
#import "SPDataWeeklyOfftake+CoreDataProperties.h"

#import "FDTakeController.h"

@import Photos;
#endif /* SPLibrary_h */
