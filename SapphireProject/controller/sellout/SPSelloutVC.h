//
//  SPSelloutVC.h
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
#import "SPMainTakeImageCell.h"
#import "SPCollectionImageCell.h"

@interface SPSelloutVC : UIViewController<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,FDTakeDelegate>
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldDate;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldLocation;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldCategory;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldProductName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldCustomerName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *fieldCustomerAddress;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldCustomerPhoneNumber;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldCustomerPrice;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldProdukKeberadaan;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldProdukInstalasi;
@property (weak, nonatomic) IBOutlet UITextField *fieldSubTotalPrice;
@property (weak, nonatomic) IBOutlet UIStepper *fieldCounterAddAndMin;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalSubPrice;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *fieldcustomerAddress;


@property (strong, nonatomic) FDTakeController *fdTake;

@property (strong,nonatomic)NSData *fileData;
@property (strong,nonatomic)NSString *fileName;
@property (strong,nonatomic)NSString *filePath;
@end
