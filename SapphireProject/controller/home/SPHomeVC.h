//
//  SPHomeVC.h
//  SapphireProject
//
//  Created by mac on 26/12/18.
//  Copyright © 2018 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
#import "SPHomeMenuCell.h"
@interface SPHomeVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,CZPickerViewDataSource, CZPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic)NSMutableArray *datas;
@end
