//
//  SPSelloutVC.h
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
@interface SPSelloutVC : UIViewController
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldDate;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldLocation;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldCategory;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldProductName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldCustomerName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *fieldCustomerAddress;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldCustomerPhoneNumber;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldCustomerPrice;

@end
