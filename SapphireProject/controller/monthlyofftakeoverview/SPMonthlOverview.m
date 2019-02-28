//
//  SPMonthlOverview.m
//  SapphireProject
//
//  Created by mac on 28/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPMonthlOverview.h"

@interface SPMonthlOverview ()

@end

@implementation SPMonthlOverview
{
    NSMutableArray *datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *rawdata = [SPDataMonthlyOfftake MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"refId == %@",@""]];
//    for (SPDataMonthlyOfftake *indata in rawdata) {
//        
//        [indata MR_deleteEntity];
//        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    }
    
    
    datas = [[NSMutableArray alloc]init];
    
    SPUser *user = [SPUser MR_findFirst];
    NSArray *tempdata = [SPDataMonthlyOfftake MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"userId == %@",user.userId]];
    
    datas = [[NSMutableArray alloc]initWithArray:tempdata];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPDataMonthlyOfftake *datasellout = [datas objectAtIndex:indexPath.row];
    SPSelloutoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selloutoverview" forIndexPath:indexPath];
    
  
    cell.lblPrice.hidden = YES;
    
    cell.lblLokasi.text = datasellout.storeName;
    cell.lblStatus.text = datasellout.status;
    cell.lblTanggal.text = datasellout.timeMT;
    cell.lblCustomerName.hidden = YES;
    cell.lblProductName.text = datasellout.productName;

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 166;
}
- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
