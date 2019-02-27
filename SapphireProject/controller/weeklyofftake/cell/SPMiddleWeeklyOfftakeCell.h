//
//  SPMiddleWeeklyOfftakeCell.h
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPMiddleWeeklyOfftakeCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UILabel *lblnameproduct;
    @property (weak, nonatomic) IBOutlet UIStepper *steperValue;
    @property (weak, nonatomic) IBOutlet UILabel *lblProdutPrice;
    @property (weak, nonatomic) IBOutlet UITextField *fieldValue;
    
@end
