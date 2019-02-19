//
//  SPMonthlyOfftakeCell.h
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPMonthlyOfftakeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblNameProduk;
@property (weak, nonatomic) IBOutlet UILabel *lblHarga;
@property (weak, nonatomic) IBOutlet UILabel *lblUnit;
@property (weak, nonatomic) IBOutlet UILabel *lblChannel;
@property (weak, nonatomic) IBOutlet UIStepper *btnAddOrMin;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *fieldTotalPenjualan;

@end
