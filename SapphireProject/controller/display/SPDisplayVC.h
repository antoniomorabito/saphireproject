//
//  SPDisplayVC.h
//  SapphireProject
//
//  Created by mac on 20/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
#import "SPMainTakeImageCell.h"
#import "SPCollectionImageCell.h"
@interface SPDisplayVC : UIViewController<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,FDTakeDelegate>
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *pilihLokasi;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *pilihTanggal;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *pilihModelBarang;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) FDTakeController *fdTake;

@property (strong,nonatomic)NSData *fileData;
@property (strong,nonatomic)NSString *fileName;
@property (strong,nonatomic)NSString *filePath;
@end
