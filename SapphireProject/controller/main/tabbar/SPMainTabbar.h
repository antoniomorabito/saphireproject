//
//  SPMainTabbar.h
//  SapphireProject
//
//  Created by mac on 23/11/18.
//  Copyright © 2018 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
#import "SPHomeVC.h"
#import "SPAttendanceVC.h"
@interface SPMainTabbar : UIViewController<UITabBarDelegate>
@property (weak, nonatomic) IBOutlet SPMainTab *mainCustomTabbar;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic)  SPAttendanceVC *attendancevc;

@end
