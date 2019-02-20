//
//  SPCompetitorInfoVC.h
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
#import "SPMainTakeImageCell.h"
#import "SPCollectionImageCell.h"
@interface SPCompetitorInfoVC : UIViewController<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblTanggal;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldLokasi;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldCategory;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldTipeProduk;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldPilihKompetitor;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldHargaProduk;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldDeskripsiPromo;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldAwalPeriode;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldAkhirPeriode;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) FDTakeController *fdTake;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldTotalPromo;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldEstimasiSellout;

@property (strong,nonatomic)NSData *fileData;
@property (strong,nonatomic)NSString *fileName;
@property (strong,nonatomic)NSString *filePath;

@end
