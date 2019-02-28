//
//  SPHomeVC.m
//  SapphireProject
//
//  Created by mac on 26/12/18.
//  Copyright © 2018 telkom. All rights reserved.
//

#import "SPHomeVC.h"

@interface SPHomeVC ()

@end

@implementation SPHomeVC
{
    NSMutableArray *datamenu;
    NSArray *dataSap;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    
    self.datas = [[NSMutableArray alloc]initWithObjects:@"Sell out",@"Monthly Offtake",@"Weekly Offtake",@"Competitor Info",@"Feedback",@"SKU",@"Display",@"Overview", nil];
  
    
    [self.collectionView reloadData];
    
    

    
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark : Collection View Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;

{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
      NSString *data = [self.datas objectAtIndex:indexPath.row];
    if ([data isEqualToString:@"Sell out"]) {
        
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPSellOut" bundle:nil]instantiateViewControllerWithIdentifier:@"navsellout"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([data isEqualToString:@"Monthly Offtake"]) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPOffTake-Monthly" bundle:nil]instantiateViewControllerWithIdentifier:@"navmonthlyofftake"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([data isEqualToString:@"Weekly Offtake"]) {
        
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPOffTake-Weekly" bundle:nil]instantiateViewControllerWithIdentifier:@"navweeklyofftake"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([data isEqualToString:@"Competitor Info"]) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPCompetitor" bundle:nil]instantiateViewControllerWithIdentifier:@"navcompetitor"];
        
        [self presentViewController:vc animated:YES completion:nil];
//
    }
    else if ([data isEqualToString:@"Feedback"]) {
     
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPFeedback" bundle:nil]instantiateViewControllerWithIdentifier:@"dofeedback"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([data isEqualToString:@"SKU"]) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPSku_V2" bundle:nil]instantiateViewControllerWithIdentifier:@"navsku"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
   
    else if ([data isEqualToString:@"Display"]){
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPDisplay" bundle:nil]instantiateViewControllerWithIdentifier:@"navdisplay"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    else if ([data isEqualToString:@"Overview"]){
         dataSap = @[@"Attendance", @"Display", @"Sell out", @"Monthly Offtake", @"Weekly Offtake",@"Competitor",@"SKU",@"Feedback"];
       
        CZPickerView *pickerWithImage = [[CZPickerView alloc] initWithHeaderTitle:@"Overview" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
        pickerWithImage.delegate = self;
        pickerWithImage.dataSource = self;
        pickerWithImage.needFooterView = YES;
        [pickerWithImage show];
        

    }



    
    
}

- (void)czpickerViewDidClickCancelButton:(CZPickerView *)pickerView {
    [self.navigationController setNavigationBarHidden:YES];
    NSLog(@"Canceled.");
}
    
- (void)czpickerViewWillDisplay:(CZPickerView *)pickerView {
    NSLog(@"Picker will display.");
}
    
- (void)czpickerViewDidDisplay:(CZPickerView *)pickerView {
    NSLog(@"Picker did display.");
}
    
- (void)czpickerViewWillDismiss:(CZPickerView *)pickerView {
    NSLog(@"Picker will dismiss.");
}
    
- (void)czpickerViewDidDismiss:(CZPickerView *)pickerView {
    NSLog(@"Picker did dismiss.");
    
    
}
- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
        NSLog(@"%@ is chosen!", dataSap[row]);
    
    NSString *dataov = dataSap[row];
    if([dataov isEqualToString:@"Attendance"])
    {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPAttendanceOverview" bundle:nil]instantiateViewControllerWithIdentifier:@"navaattendanceoverview"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([dataov isEqualToString:@"Display"])
    {
        
    }
    else if ([dataov isEqualToString:@"Sell out"])
    {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPSellOutOverview" bundle:nil]instantiateViewControllerWithIdentifier:@"navselloutoverview"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([dataov isEqualToString:@"Monthly Offtake"])
    {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPOffTakeMonthlyOverview" bundle:nil]instantiateViewControllerWithIdentifier:@"navMonthlyOfftake"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([dataov isEqualToString:@"Weekly Offtake"])
    {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPAttendanceOverview" bundle:nil]instantiateViewControllerWithIdentifier:@"navaattendanceoverview"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([dataov isEqualToString:@"Competitor"])
    {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPAttendanceOverview" bundle:nil]instantiateViewControllerWithIdentifier:@"navaattendanceoverview"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([dataov isEqualToString:@"SKU"])
    {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPSKUOverview" bundle:nil]instantiateViewControllerWithIdentifier:@"navSKUOverview"];
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    else if ([dataov isEqualToString:@"Feedback"])
    {
        
    }
    
}
    - (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemsAtRows:(NSArray *)rows {
  
    }
    
- (NSString *)czpickerView:(CZPickerView *)pickerView
                   titleForRow:(NSInteger)row{
        return dataSap[row];
    }

- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView {
    return dataSap.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *data = [self.datas objectAtIndex:indexPath.row];
    SPHomeMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuCell" forIndexPath:indexPath];
    
    cell.lbljudul.text = [NSString stringWithFormat:@"%@",data];
    if ([data isEqualToString:@"Sell out"]) {
        
        cell.iconimage.image =[UIImage imageNamed:@"ic_sellout"];
    }
   else if ([data isEqualToString:@"Monthly Offtake"]) {
         cell.iconimage.image =[UIImage imageNamed:@"ic_offtake_monthly"];
    }
   else if ([data isEqualToString:@"Weekly Offtake"]) {
         cell.iconimage.image =[UIImage imageNamed:@"ic_offtake_weekly"];
   }

   else if ([data isEqualToString:@"Competitor Info"]) {
         cell.iconimage.image =[UIImage imageNamed:@"ic_competition_info"];
   }
   else if ([data isEqualToString:@"Feedback"]) {
         cell.iconimage.image =[UIImage imageNamed:@"ic_feedback"];
   }
   else if ([data isEqualToString:@"SKU"]) {
         cell.iconimage.image =[UIImage imageNamed:@"ic_sku"];
   }
   else if ([data isEqualToString:@"Display"]){
       cell.iconimage.image =[UIImage imageNamed:@"ic_sku_overview"];
   }
   else if ([data isEqualToString:@"Overview"]){
       cell.iconimage.image =[UIImage imageNamed:@"ic_overview"];
   }
    
    //Add your cell Values here
    
    return cell;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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




