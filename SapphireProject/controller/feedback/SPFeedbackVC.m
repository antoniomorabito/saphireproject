//
//  SPFeedbackVC.m
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPFeedbackVC.h"

@interface SPFeedbackVC ()

@end

@implementation SPFeedbackVC
{
    NSMutableArray *datacategory;
    NSMutableArray *datastores;
    NSMutableArray *statusbuy;
    
    NSString *storeid;
    NSString *categoryid;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    storeid = [[NSString alloc]init];
    categoryid = [[NSString alloc]init];
    //untuk data category
    NSArray *aryCountries = [SPCategory MR_findAll];
    datacategory = [[NSMutableArray alloc]init];
    for (SPCategory * category in aryCountries) {
        [datacategory addObject:category.name];
//        NSLog(@"nilai category : %@",category.name);
    }
    
    
    NSArray *arraystore = [SPStore MR_findAll];
    
    datastores = [[NSMutableArray alloc]init];
    for (SPStore * store in arraystore) {
        [datastores addObject:store.name];
    }

    statusbuy =[[NSMutableArray alloc]init];
    
    [statusbuy addObject:@"Tidak Beli"];
    [statusbuy addObject:@"Beli"];
    _fieldDate.delegate = self;
    _fieldLocation.delegate = self;
    _fieldCategory.delegate = self;
    _fieldStatus.delegate = self;
    _fieldPhoneNumber.delegate =self;
    _fieldCustomerName.delegate = self;
    
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _fieldDate.inputView = dummyView;
    _fieldLocation.inputView = dummyView;
    _fieldCategory.inputView = dummyView;
    _fieldStatus.inputView = dummyView;
    
    UIToolbar *toolbars = [[UIToolbar alloc] init];
    [toolbars setBarStyle:UIBarStyleBlackTranslucent];
    [toolbars sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbars setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    _fieldCustomerName.inputAccessoryView = toolbars;
    _fieldPhoneNumber.inputAccessoryView = toolbars;
//    _fieldStatus.inputAccessoryView = toolbars;
//    _fieldCategory.inputAccessoryView = toolbars;
    _textFeedback.inputAccessoryView = toolbars;
    // Do any additional setup after loading the view.
    
    
    
    
}

-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}

- (IBAction)didTapPickLocation:(id)sender {
 

//    NSLog(@"data store :%@",datastore);
    
    
    if (datastores.count >0) {
        [SearchStringPickerViewController showPickerWithTitle:@"Toko"
                                                         rows:datastores
                                             initialSelection:0
                                                   sourceView:sender
                                                    doneBlock:^(NSInteger selectedIndex, NSString *selectedValue) {
                                                        NSLog(@"Index: %ld, value: %@", (long)selectedIndex, selectedValue);
                                                        
                                                        _fieldLocation.text =selectedValue;
                                                        
                                 SPStore *store = [SPStore MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name== %@",selectedValue]];
                                                        
                                                        storeid = store.idstore;
                                                    }
         
         
                                                  cancelBlock:nil
                                    presentFromViewController:self];
    }
}



- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)didTapSubmit:(id)sender {
    
    if (_fieldDate.text.length == 0) {
        [SPMessageUtility message:@"Belum masukin tanggal" needAction:YES viewController:self];
    }
    else if (_fieldLocation.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin lokasinya" needAction:YES viewController:self];
    }
    
    else if (_fieldCategory.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin kategorinya" needAction:YES viewController:self];
    }
    else if (_fieldStatus.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin statusnya" needAction:YES viewController:self];
    }
    else if (_fieldCustomerName.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin kustomernya" needAction:YES viewController:self];
    }
    else if (_fieldPhoneNumber.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin no telepon" needAction:YES viewController:self];
    }
    else if (_textFeedback == 0)
    {
        [SPMessageUtility message:@"Belum masukin isi feedbacknya" needAction:YES viewController:self];
    }
    else{
        
        SPNetworkManager *network = [[SPNetworkManager alloc]init];
        
        NSLog(@"store id : %@",storeid );
        NSDictionary *data= @{@"storeId":storeid,
                       @"timeFeedback":_fieldDate.text,
                       @"categoryId":categoryid,
                       @"statusBuy":_fieldStatus.text,
                       @"customerName":_fieldCustomerName.text,
                       @"customerPhone":_fieldPhoneNumber.text,
                       @"CustomerFeedback":_textFeedback.text
                       };
        
        [network doAddFeedback:data view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
           
            if (success) {
                [SPMessageUtility customMessageDialog:[responseObject objectForKey:@"message"] needAction:YES viewController:self CH:^(BOOL success, NSString *value) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    
                    
                }];
            }
            else{
                
            }
            
        }];
    }

}
- (IBAction)didTapDate:(UITextField *)sender {
    
    LSLDatePickerDialog *dpDialog = [[LSLDatePickerDialog alloc] init];
    [dpDialog showWithTitle:@"Pilih tanggal" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel"
                defaultDate:[NSDate date] minimumDate:nil maximumDate:nil datePickerMode:UIDatePickerModeDate
                   callback:^(NSDate * _Nullable date){
                       if(date)
                       {
                           NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                           [formatter setDateStyle:NSDateFormatterMediumStyle];
                           NSLog(@"Date selected: %@",[formatter stringFromDate:date]);
                           self.fieldDate.text =[formatter stringFromDate:date];
                           
                           [self.fieldDate resignFirstResponder];
                       }
                   }
     ];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _fieldDate) {
        return FALSE;
    }
    else if (textField == _fieldLocation) {
        return FALSE;
    }
    
    else if (textField == _fieldCategory) {
        return FALSE;
    }
    else if (textField == _fieldStatus) {
        return FALSE;
    }
    else{
    return YES;
    }
    
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
        newOffset.y = 250;
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

- (IBAction)didTapCategory:(id)sender {
   
 
    
//    NSLog(@"data category :%@",datacategory);
    
    
    if (datacategory.count >0) {
        [SearchStringPickerViewController showPickerWithTitle:@"Kategori produk"
                                                         rows:datacategory
                                             initialSelection:0
                                                   sourceView:sender
                                                    doneBlock:^(NSInteger selectedIndex, NSString *selectedValue) {
                                                        NSLog(@"Index: %ld, value: %@", (long)selectedIndex, selectedValue);
                                                        
                                                        _fieldCategory.text =selectedValue;
                                                        
                                                        
                                                        SPCategory *category = [SPCategory MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name== %@",selectedValue]];
                                                        
                                                        categoryid = category.idcategory;
                                                    }
                                                  cancelBlock:nil
                                    presentFromViewController:self];
    }

}
- (IBAction)didTapStatus:(id)sender {
    
    [SearchStringPickerViewController showPickerWithTitle:@"Status beli"
                                                     rows:statusbuy
                                         initialSelection:0
                                               sourceView:sender
                                                doneBlock:^(NSInteger selectedIndex, NSString *selectedValue) {
                                                    NSLog(@"Index: %ld, value: %@", (long)selectedIndex, selectedValue);
                                                    
                                                    _fieldStatus.text =selectedValue;
                                                }
                                              cancelBlock:nil
                                presentFromViewController:self];
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
