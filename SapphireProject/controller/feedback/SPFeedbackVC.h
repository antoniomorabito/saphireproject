//
//  SPFeedbackVC.h
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
@interface SPFeedbackVC : UIViewController<UITextFieldDelegate,CZPickerViewDataSource, CZPickerViewDelegate>
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldDate;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldLocation;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldCategory;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldStatus;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldCustomerName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldPhoneNumber;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray *datasLocations;
@end
