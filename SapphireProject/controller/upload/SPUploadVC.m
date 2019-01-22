//
//  SPUploadVC.m
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPUploadVC.h"

@interface SPUploadVC ()

@end

@implementation SPUploadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    // Do any additional setup after loading the view.
    
    self.datas = [[NSMutableArray alloc]initWithObjects:@"SKU",@"Sell Out",@"Feedback",@"Competitor Info", nil];
    
    [self.tableView reloadData];
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    NSString *data= [self.datas objectAtIndex:indexPath.row];
    SPUploadCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"uploadcell" forIndexPath:indexPath];
    
    cell.lblUpload.text = data;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}



@end
