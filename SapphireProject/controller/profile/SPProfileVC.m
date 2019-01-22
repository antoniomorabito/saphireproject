//
//  SPProfileVC.m
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPProfileVC.h"

@interface SPProfileVC ()

@end

@implementation SPProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datas =[[NSMutableArray alloc]initWithObjects:@"Change Password",@"Term Of Service",@"Privacy Policy",@"Log Out", nil];
    
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *data = [self.datas objectAtIndex:indexPath.row];
    
    if ([data isEqualToString:@"Change Password"]) {
        
    }
    else if ([data isEqualToString:@"Term Of Service"]) {
        
    }
    else if ([data isEqualToString:@"Privacy Policy"]) {
        
    }
    else if ([data isEqualToString:@"Log Out"]) {
        
        
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPAuthentication" bundle:nil]instantiateViewControllerWithIdentifier:@"login"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString *data = [self.datas objectAtIndex:indexPath.row];
    SPProfileCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
    
    cell.lblName.text = data;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}



@end
