//
//  SPWeeklyOfftakeVC.h
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
#import "SPFooterWeeklyOfftakeCell.h"
#import "SPMiddleWeeklyOfftakeCell.h"
#import "SPHeaderCellOfftake.h"
@interface SPWeeklyOfftakeVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
