//
//  SPLogin.m
//  SapphireProject
//
//  Created by mac on 21/11/18.
//  Copyright © 2018 telkom. All rights reserved.
//

#import "SPLogin.h"

@interface SPLogin ()

@end

@implementation SPLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIToolbar *toolbars = [[UIToolbar alloc] init];
    [toolbars setBarStyle:UIBarStyleBlackTranslucent];
    [toolbars sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbars setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    
    self.fieldusername.delegate = self;
    self.fieldusername.inputAccessoryView = toolbars;
    
    self.fieldPassword.delegate = self;
    self.fieldPassword.inputAccessoryView = toolbars;
    
    // Do any additional setup after loading the view.
}
#pragma mark - Private Method
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerKeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerKeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)registerKeyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = aNotification.userInfo;
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Create animation.
    void (^animations)(void) = ^() {
        CGPoint newOffset = self->_scrollView.contentOffset;
        newOffset.y = 160;
        self.scrollView.contentOffset = newOffset;
    };
    
    // Begin animation.
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:animations
                     completion:nil];
}

- (void)registerKeyboardWillHide:(NSNotification *)aNotification {
    NSDictionary *userInfo = aNotification.userInfo;
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Create animation.
    void (^animations)(void) = ^() {
        CGPoint newOffset = self->_scrollView.contentOffset;
        newOffset.y = 0;
        self.scrollView.contentOffset = newOffset;
    };
    
    // Begin animation.
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:animations
                     completion:^(BOOL finished) {
                     }];
}
-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

bool isTap=false;
- (IBAction)didTapSwitch:(id)sender {
    if (isTap) {
        _switchtapcontroler.selected = false;
        _fieldPassword.secureTextEntry = true;
        isTap = false;
    }
    else{
        _switchtapcontroler.selected = true;
        _fieldPassword.secureTextEntry = false;
        
        isTap = true;
    }
}
- (IBAction)didTapSignIn:(id)sender {
    
    
    if (_fieldusername.text.length == 0) {
    
        [SPMessageUtility message:@"Field username is still empty" needAction:YES viewController:self];
    }
    else if (_fieldPassword.text.length == 0)
    {
        [SPMessageUtility message:@"Field password is still empty" needAction:YES viewController:self];
    }
    else{
        
        SPNetworkManager *network = [[SPNetworkManager alloc]init];
        
        NSDictionary *data =@{@"username":_fieldusername.text,@"password":_fieldPassword.text,
                              @"fcm":@"null"
                              };
        [network doLogin:data view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
           
            
            if (success) {
                
                //get app config
                [network doGetConfig:nil view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
                   
                    
                    if (success) {
                         NSArray *datacontent = (NSArray *)responseObject;
                        NSLog(@"nilai data content : %@",datacontent);
                                    for (int i = 0; i<datacontent.count; i++) {
                        
                        
                                        NSDictionary *object = [datacontent objectAtIndex:i];
                        
                                        SPAppConfig *app = [SPAppConfig MR_createEntity];
                                        app.parameterFormat = ParseString([object objectForKey:@"parameterFormat"]);
                                        app.parameterName = ParseString([object objectForKey:@"parameterName"]);
                                        app.parameterValue = ParseString([object objectForKey:@"parameterValue"]);
                                        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                        
                        
                                    }
                        
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeIndeterminate;
                        hud.label.text = @"";
                        [hud showAnimated:YES];
                        [self initCategory];
                        [self initProduct];
                        [self initQuizMaster];
                        [self initDealers];
                        [self initStores];
                        [self initCompetitior];
                        [hud hideAnimated:YES];
                        UIViewController *vc =[[UIStoryboard storyboardWithName:@"SPMain" bundle:nil]instantiateViewControllerWithIdentifier:@"navtabbar"];
                        
                        
                        [self presentViewController:vc animated:YES completion:nil];
                    }
                    else{
                        NSLog(@"response error config adalah :%@",responseObject);
                        [SPMessageUtility message:[responseObject objectForKey:@"error_description"] needAction:YES viewController:self];
                    }
                }];
               
            }
            else{
                
                NSLog(@"response error :%@",responseObject);
                [SPMessageUtility message:[responseObject objectForKey:@"error_description"] needAction:YES viewController:self];
            }
            
        }];
        
    
 
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
