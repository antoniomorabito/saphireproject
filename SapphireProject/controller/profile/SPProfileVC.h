//
//  SPProfileVC.h
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
#import "SPProfileCell.h"
@interface SPProfileVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,FDTakeDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet RoundImageView *imageBackground;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *datas;
    @property (strong, nonatomic) FDTakeController *fdTake;
    
    @property (strong,nonatomic)NSData *fileData;
    @property (strong,nonatomic)NSString *fileName;
    @property (strong,nonatomic)NSString *filePath;
@end
