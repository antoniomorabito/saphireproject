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

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
   

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
    
    UIToolbar *toolbars = [[UIToolbar alloc] init];
    [toolbars setBarStyle:UIBarStyleBlackTranslucent];
    [toolbars sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbars setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    _fieldCustomerName.inputAccessoryView = toolbars;
    _fieldPhoneNumber.inputAccessoryView = toolbars;
    _fieldStatus.inputAccessoryView = toolbars;
    _fieldCategory.inputAccessoryView = toolbars;
    // Do any additional setup after loading the view.
    
    
    
    
}

-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}

- (IBAction)didTapPickLocation:(id)sender {
    NSArray *fruits = @[@"Apple", @"Banana", @"Grape", @"Watermelon", @"Lychee"];
    self.datasLocations = [[NSMutableArray alloc]initWithArray:fruits copyItems:YES];
    
    
    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"Lokasi"
                                                   cancelButtonTitle:@"Cancel"
                                                  confirmButtonTitle:@"Confirm"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.needFooterView = NO;
    [picker show];
}

#pragma mark - CZPickerViewDataSource
- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView {
    return self.datasLocations.count;
}
- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
    NSLog(@"%@ is chosen!", self.datasLocations[row]);
    
    self.fieldLocation.text =self.datasLocations[row];
    
}
- (NSString *)czpickerView:(CZPickerView *)pickerView
               titleForRow:(NSInteger)row{
    return self.datasLocations[row];
}

- (void)czpickerViewDidClickCancelButton:(CZPickerView *)pickerView {

    NSLog(@"Canceled.");
}
- (void)czpickerViewWillDisplay:(CZPickerView *)pickerView {
    NSLog(@"Picker will display.");
    
    [self.fieldLocation resignFirstResponder];
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)didTapSubmit:(id)sender {
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
    else{
    return YES;
    }
    
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
