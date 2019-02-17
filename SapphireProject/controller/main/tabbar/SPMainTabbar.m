

//
//  SPMainTabbar.m
//  SapphireProject
//
//  Created by mac on 23/11/18.
//  Copyright © 2018 telkom. All rights reserved.
//

#import "SPMainTabbar.h"

@interface SPMainTabbar ()

@end

@implementation SPMainTabbar

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainCustomTabbar.delegate = self;
    
    
    [self changeViewBySelectedItem:0];
    

    _attendancevc= [[UIStoryboard storyboardWithName:@"SPAttendace_v2" bundle:nil]instantiateViewControllerWithIdentifier:@"navAttendance"];


//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // Running on background thread, don't call UIKit
//
//        [self initCategory];
//        [self initProduct];
//        [self initQuizMaster];
//        [self initDealers];
//        [self initStores];
//        [self initCompetitior];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // Running on main thread, feel free to call UIKit
//        });
//    });

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
{
  
    switch (item.tag)
    {
        case 0:
          
            NSLog(@"no 1");
            [self changeViewBySelectedItem:0];
            break;
        case 1:
          NSLog(@"no 2");
            [self changeViewBySelectedItem:1];
            break;
        case 2:
           NSLog(@"no 3");
            [self changeViewBySelectedItem:2];
            break;
            
        case 3:
            NSLog(@"no 4");
            [self changeViewBySelectedItem:3];
            break;
    }

}

-(void)changeViewBySelectedItem:(NSInteger)tag
{
   
    if (tag == 0) {
        UIViewController* vc = [[UIStoryboard storyboardWithName:@"SPTabHome" bundle:nil]instantiateViewControllerWithIdentifier:@"navtabbar"];
        [self.mainCustomTabbar setSelectedItem:[self.mainCustomTabbar.items objectAtIndex:tag]];
        
        
        vc.view.frame = self.containerView.bounds;
        [self.containerView addSubview:vc.view];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
    }
    
   else if (tag == 1) {
       
       
       [self.mainCustomTabbar setSelectedItem:[self.mainCustomTabbar.items objectAtIndex:tag]];
       
       
       _attendancevc.view.frame = self.containerView.bounds;
       [self.containerView addSubview:_attendancevc.view];
       [self addChildViewController:_attendancevc];
       [_attendancevc didMoveToParentViewController:self];
    }
    
   else if (tag == 2) {
        UIViewController* vc= [[UIStoryboard storyboardWithName:@"SPTabUpload" bundle:nil]instantiateViewControllerWithIdentifier:@"navUpload"];
       [self.mainCustomTabbar setSelectedItem:[self.mainCustomTabbar.items objectAtIndex:tag]];
       
       
       vc.view.frame = self.containerView.bounds;
       [self.containerView addSubview:vc.view];
       [self addChildViewController:vc];
       [vc didMoveToParentViewController:self];
   }
    
   else if (tag == 3) {
        UIViewController* vc= [[UIStoryboard storyboardWithName:@"SPTabProfile" bundle:nil]instantiateViewControllerWithIdentifier:@"navprofile"];
       [self.mainCustomTabbar setSelectedItem:[self.mainCustomTabbar.items objectAtIndex:tag]];
       
       
       vc.view.frame = self.containerView.bounds;
       [self.containerView addSubview:vc.view];
       [self addChildViewController:vc];
       [vc didMoveToParentViewController:self];
   }
    
    
   
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
