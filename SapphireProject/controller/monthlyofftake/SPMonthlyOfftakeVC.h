//
//  SPMonthlyOfftakeVC.h
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
#import "SPMonthlyOfftakeCell.h"
@interface SPMonthlyOfftakeVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldPilihTanggal;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldPilihLokasi;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldPilihKategori;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
