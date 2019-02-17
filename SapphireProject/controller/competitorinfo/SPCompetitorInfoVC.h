//
//  SPCompetitorInfoVC.h
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
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

@end
