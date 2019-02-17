//
//  SPAttendanceVC.h
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
@interface SPAttendanceVC : UIViewController<UITextFieldDelegate,FDTakeDelegate>
@property (weak, nonatomic) IBOutlet UITextField *fieldTempatBekerja;
@property (weak, nonatomic) IBOutlet UILabel *lblSenin;
@property (weak, nonatomic) IBOutlet UILabel *lblSelasa;
@property (weak, nonatomic) IBOutlet UILabel *lblRabu;
@property (weak, nonatomic) IBOutlet UILabel *lblKamid;
@property (weak, nonatomic) IBOutlet UILabel *lblJumat;
@property (weak, nonatomic) IBOutlet UILabel *lblSabtu;
@property (weak, nonatomic) IBOutlet UILabel *lblJamCekIn;
@property (weak, nonatomic) IBOutlet UILabel *waktuJamNow;
@property (weak, nonatomic) IBOutlet UILabel *lblJamCekOut;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalJamSkrang;
@property (weak, nonatomic) IBOutlet RoundImageView *imageViewCekIn;
@property (weak, nonatomic) IBOutlet RoundImageView *imageViewCekout;

@property (strong, nonatomic) FDTakeController *fdTake;


@property (strong,nonatomic)NSData *fileData;
@property (strong,nonatomic)NSString *fileName;
@property (strong,nonatomic)NSString *filePath;

@end
