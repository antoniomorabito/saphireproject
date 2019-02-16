//
//  SPSKUVC.h
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
@interface SPSKUVC : UIViewController<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (unsafe_unretained, nonatomic) IBOutlet JVFloatLabeledTextField *fieldTanggal;
@property (unsafe_unretained, nonatomic) IBOutlet JVFloatLabeledTextField *fieldPilihLokasi;
@property (unsafe_unretained, nonatomic) IBOutlet JVFloatLabeledTextField *fieldPilihKategori;
@property (unsafe_unretained, nonatomic) IBOutlet JVFloatLabeledTextField *fieldNamModel;
@property (unsafe_unretained, nonatomic) IBOutlet UICollectionView *collectionView;

@end
