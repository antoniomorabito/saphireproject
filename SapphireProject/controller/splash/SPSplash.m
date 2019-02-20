//
//  SPSplash.m
//  SapphireProject
//
//  Created by mac on 21/11/18.
//  Copyright © 2018 telkom. All rights reserved.
//

#import "SPSplash.h"

@interface SPSplash ()

@end

@implementation SPSplash

- (void)viewDidLoad {
    [super viewDidLoad];
    // At an opportune time (e.g. app start):
    TrueTimeClient *client = [TrueTimeClient sharedInstance];
    [client startWithPool:@[@"time.apple.com"] port:123];

//    // You can now use this instead of [NSDate date]:
//    NSDate *now = [[client referenceTime] now];
    
    // To block waiting for fetch, use the following:
    [client fetchIfNeededWithSuccess:^(NTPReferenceTime *referenceTime) {
        NSLog(@"True time: %@", [referenceTime now]);
    } failure:^(NSError *error) {
        NSLog(@"Error! %@", error);
    }];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    Boolean mustBeUpdated = false;
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetConfig:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
       
        if (success) {
            
            
            NSArray *datacontent = (NSArray *)responseObject;
            
    
              SPAppConfig *app = [SPAppConfig MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"parameterFormat == %@",@"version"]];
            
            NSLog(@"data app nya adalah : %@",app.parameterName);
            
            NSDictionary *versionapp = [datacontent objectAtIndex:0];
            
            
            if ([[versionapp objectForKey:@"parameterValue"] isEqualToString:app.parameterValue]) {
                
                //no need to update
            }
            else{
                
                
                //need to update
                        for (int i = 0; i<datacontent.count; i++) {
                
                
                                NSDictionary *object = [datacontent objectAtIndex:i];
                
                                SPAppConfig *app = [SPAppConfig MR_createEntity];
                                app.parameterFormat = ParseString([object objectForKey:@"parameterFormat"]);
                                app.parameterName = ParseString([object objectForKey:@"parameterName"]);
                                app.parameterValue = ParseString([object objectForKey:@"parameterValue"]);
                                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                
                
                            }
                
                
                [self initCategory];
                [self initProduct];
                [self initQuizMaster];
                [self initDealers];
                [self initStores];
                [self initCompetitior];
                [self initMasterPromo];
                [self initChannel];
            }

            
            
            
            UIViewController *vc =[[UIStoryboard storyboardWithName:@"SPMain" bundle:nil]instantiateViewControllerWithIdentifier:@"navtabbar"];
//
            [self presentViewController:vc animated:YES completion:nil];
        }
        else{
            UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPAuthentication" bundle:nil]instantiateViewControllerWithIdentifier:@"login"];
            
            [self presentViewController:vc animated:YES completion:nil];
        }
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            
//            [SPUtility initBannerNotif:@"Information" subtitle:@"Sync competitor done" body:@""];
        }
        else{
            
        }
        
    }];
}
-(void)initDealers{
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetDealer:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
//            [SPUtility initBannerNotif:@"Information" subtitle:@"Sync dealers done" body:@""];
        }
        else{
            
        }
        
    }];
}

-(void)initQuizMaster{
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetQuiz:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
//            [SPUtility initBannerNotif:@"Information" subtitle:@"Sync quiz master done" body:@""];
        }
        else{
            
        }
        
    }];
}

-(void)initStores{
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetStore:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
//            [SPUtility initBannerNotif:@"Information" subtitle:@"Sync stores done" body:@""];
        }
        else{
            
        }
        
    }];
}

-(void)initMasterPromo{
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetMasterPromo:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
            //            [SPUtility initBannerNotif:@"Information" subtitle:@"Sync stores done" body:@""];
        }
        else{
            
        }
        
    }];
}
-(void)initChannel{
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetChannel:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
//            [SPUtility initBannerNotif:@"Information" subtitle:@"Sync products done" body:@""];
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
