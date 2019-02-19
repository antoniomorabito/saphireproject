//
//  SPWeeklyOfftakeVC.m
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPWeeklyOfftakeVC.h"

@interface SPWeeklyOfftakeVC ()

@end

@implementation SPWeeklyOfftakeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
  
    if (indexPath.section) {
         return 200;
    }
    else{
        return 220;
    }
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        SPHeaderCellOfftake *cell = [tableView dequeueReusableCellWithIdentifier:@"headercell" forIndexPath:indexPath];
        
        // Configure the cell...
        
        return cell;
    }
    else if (indexPath.row == 1)
    {
        SPMiddleWeeklyOfftakeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"middleofftake" forIndexPath:indexPath];
        
        // Configure the cell...
        
        return cell;
    }
    else{
        SPFooterWeeklyOfftakeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"footercell" forIndexPath:indexPath];
        
        // Configure the cell...
        
        return cell;
    }
   
}
- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
