
//
//  SPMonthlyOfftakeVC.m
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPMonthlyOfftakeVC.h"

@interface SPMonthlyOfftakeVC ()

@end

@implementation SPMonthlyOfftakeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}
//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
        SPMonthlyOfftakeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"monthlyofftake" forIndexPath:indexPath];
        
        // Configure the cell...
        
        return cell;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
