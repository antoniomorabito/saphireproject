


//
//  SPFeedbackOverview.m
//  SapphireProject
//
//  Created by mac on 01/03/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPFeedbackOverview.h"

@interface SPFeedbackOverview ()

@end

@implementation SPFeedbackOverview
{
    NSMutableArray *datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    datas = [[NSMutableArray alloc]init];
    
    SPUser *user = [SPUser MR_findFirst];
    NSArray *tempdata = [SPDataFeedBack MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"userId == %@",user.userId]];
    datas = [[NSMutableArray alloc]initWithArray:tempdata];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SPDataFeedBack *data = [datas objectAtIndex:indexPath.row];
    
    if ([data.status isEqualToString:@"Terkirim ke Server"]) {
        
        [SPMessageUtility customDeleteYesOrno:@"Apakah anda yakin ingin menghapus data ini?" needAction:YES viewController:self CH:^(BOOL success, NSString *value) {
            
            
            if (success) {
                
                [self->datas removeObject:data];
                [data MR_deleteEntity];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                
                
                [self.tableView reloadData];
            }
            else{
                
            }
        }];
    }
    else{
        
        [SPMessageUtility customYesOrNo:@"Apakah anda ingin mengirim ulang data ini ke server?" needAction:YES viewController:self CH:^(BOOL success, NSString *value) {
            
            
            if (success) {
                SPNetworkManager *network = [[SPNetworkManager alloc]init];
                
                NSDictionary *datakiriman= @{@"storeId":data.storeId,
                                             @"timeFeedback":data.timeFeedback,
                                             @"categoryId":data.categoryId,
                                             @"statusBuy":data.statusBuy,
                                             @"customerName":data.customerName,
                                             @"customerPhone":data.customerPhone,
                                             @"customerName":data.customerName,
                                             @"CustomerFeedback":data.customerFeedback,
                                        @"refId":data.refId
                                             };
                
                [network doAddFeedback:datakiriman  view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
                    
                    if (success) {
                        [SPMessageUtility customMessageDialog:[responseObject objectForKey:@"message"] needAction:YES viewController:self CH:^(BOOL success, NSString *value) {
                            
                            
                            data.status = @"Terkirim ke Server";
                            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                            
                            [self.tableView reloadData];
                        }];
                        
                    }
                    else
                    {
                        [SPMessageUtility message:@"Masih gagal dikirim, silahkan cek ulang internet anda" needAction:YES viewController:self];
                    }
                    
                }];
                
            }
        }];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 166;
}

- (IBAction)didTapBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPDataFeedBack *datasellout = [datas objectAtIndex:indexPath.row];
    SPSelloutoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"overcell" forIndexPath:indexPath];
    
//    cell.lblPrice.text = [NSString stringWithFormat:@"Rp %@",[SPUtility changeFormat:[datasellout.customerPrice doubleValue]]];
    cell.lblPrice.hidden = YES;
    
    cell.lblLokasi.text = datasellout.storeName;
    cell.lblStatus.text = datasellout.status;
    cell.lblTanggal.text = datasellout.timeFeedback;
    cell.lblCustomerName.text = datasellout.customerName;
    cell.lblProductName.text =[NSString stringWithFormat:@"%@",datasellout.categoryname];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
