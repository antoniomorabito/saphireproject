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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    
    self.datas = [[NSMutableArray alloc]initWithObjects:@"Sell out",@"Monthly Offtake",@"Weekly Offtake",@"Attendance Overview",@"Sell Out Overview",@"Competitor Info",@"Feedback",@"SKU",@"SKU Overview", nil];
  
    
    [self.collectionView reloadData];
    
    

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Running on background thread, don't call UIKit
        
        [self initCategory];
        [self initProduct];
        [self initQuizMaster];
        [self initDealers];
        [self initStores];
        [self initCompetitior];
        dispatch_async(dispatch_get_main_queue(), ^{
            // Running on main thread, feel free to call UIKit
        });
    });
   
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
    else if ([data isEqualToString:@"Attendance Overview"]) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPAttendanceOverview" bundle:nil]instantiateViewControllerWithIdentifier:@"navaattendanceoverview"];
        
        [self presentViewController:vc animated:YES completion:nil];
       
    }
    else if ([data isEqualToString:@"Sell Out Overview"]) {
      
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPSellOutOverview" bundle:nil]instantiateViewControllerWithIdentifier:@"navselloutoverview"];
        
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
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPSKU" bundle:nil]instantiateViewControllerWithIdentifier:@"navsku"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([data isEqualToString:@"SKU Overview"]){
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPSKUOverview" bundle:nil]instantiateViewControllerWithIdentifier:@"navSKUOverview"];
        
        [self presentViewController:vc animated:YES completion:nil];
    }


    
    
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
   else if ([data isEqualToString:@"Attendance Overview"]) {
         cell.iconimage.image =[UIImage imageNamed:@"ic_attendance_overview"];
   }
   else if ([data isEqualToString:@"Sell Out Overview"]) {
         cell.iconimage.image =[UIImage imageNamed:@"ic_sellout_overview"];
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
   else if ([data isEqualToString:@"SKU Overview"]){
         cell.iconimage.image =[UIImage imageNamed:@"ic_sku_overview"];
   }
    
    //Add your cell Values here
    
    return cell;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(void)initCategory{
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetCategory:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
            [SPUtility initBannerNotif:@"Information" subtitle:@"Sync category done" body:@""];
        }
        else{
            
        }
        
    }];
}

-(void)initProduct{
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetProducts:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
            [SPUtility initBannerNotif:@"Information" subtitle:@"Sync products done" body:@""];
        }
        else{
            
        }
        
    }];
}

-(void)initCompetitior{
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetCompetitor:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
            [SPUtility initBannerNotif:@"Information" subtitle:@"Sync competitor done" body:@""];
        }
        else{
            
        }
        
    }];
}
-(void)initDealers{
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetDealer:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
            [SPUtility initBannerNotif:@"Information" subtitle:@"Sync dealers done" body:@""];
        }
        else{
            
        }
        
    }];
}

-(void)initQuizMaster{
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetQuiz:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
            [SPUtility initBannerNotif:@"Information" subtitle:@"Sync quiz master done" body:@""];
        }
        else{
            
        }
        
    }];
}

-(void)initStores{
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetStore:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
            [SPUtility initBannerNotif:@"Information" subtitle:@"Sync stores done" body:@""];
        }
        else{
            
        }
        
    }];
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




