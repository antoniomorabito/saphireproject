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
    
    // You can now use this instead of [NSDate date]:
    NSDate *now = [[client referenceTime] now];
    
    
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
    
    
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doGetConfig:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
       
        
        if (success) {
            UIViewController *vc =[[UIStoryboard storyboardWithName:@"SPMain" bundle:nil]instantiateViewControllerWithIdentifier:@"navtabbar"];
            
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
