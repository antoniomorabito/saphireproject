

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
    UIViewController* vc ;
    if (tag == 0) {
       vc= [[UIStoryboard storyboardWithName:@"SPTabHome" bundle:nil]instantiateViewControllerWithIdentifier:@"navtabbar"];
    }
    
   else if (tag == 1) {
        vc= [[UIStoryboard storyboardWithName:@"SPTabHome" bundle:nil]instantiateViewControllerWithIdentifier:@"navtabbar"];
    }
    
   else if (tag == 2) {
       vc= [[UIStoryboard storyboardWithName:@"SPTabHome" bundle:nil]instantiateViewControllerWithIdentifier:@"navtabbar"];
   }
    
   else if (tag == 3) {
       vc= [[UIStoryboard storyboardWithName:@"SPTabHome" bundle:nil]instantiateViewControllerWithIdentifier:@"navtabbar"];
   }
    
    
    [self.mainCustomTabbar setSelectedItem:[self.mainCustomTabbar.items objectAtIndex:tag]];
    
    
    vc.view.frame = self.containerView.bounds;
    [self.containerView addSubview:vc.view];
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
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
