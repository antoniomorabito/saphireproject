
//
//  SPMonthlyOfftakeVC.m
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPMonthlyOfftakeVC.h"

@interface SPMonthlyOfftakeVC ()<UITextFieldDelegate>

@end

@implementation SPMonthlyOfftakeVC
{
    NSMutableArray *datacategory;
    NSMutableArray *datastores;
    NSString *storeid;
    NSString *categoryid;
    
    NSMutableArray *products;
    NSString *product_id;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

    NSArray *rawdata = [SPDataMonthlyOfftake MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"refId == %@",@""]];
    for (SPDataMonthlyOfftake *indata in rawdata) {
        
        [indata MR_deleteEntity];
         [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    for (int i= 0; i< [SPDataMonthlyOfftake MR_findAll].count; i++) {
        
        SPDataMonthlyOfftake *data = [[SPDataMonthlyOfftake MR_findAll] objectAtIndex:i];
        NSLog(@"data monthly offtake : %@",data.storeId);
    }
    // Do any additional setup after loading the view.
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
    
    storeid = [[NSString alloc]init];
    categoryid = [[NSString alloc]init];
     product_id = [[NSString alloc]init];
    
    _fieldPilihTanggal.delegate = self;
    _fieldPilihLokasi.delegate = self;
    _fieldPilihKategori.delegate = self;
    

    
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _fieldPilihTanggal.inputView = dummyView;
    _fieldPilihLokasi.inputView = dummyView;
    _fieldPilihKategori.inputView = dummyView;
}
- (IBAction)didTapPilihTanggal:(id)sender {
    
    SPAppConfig *backdate = [SPAppConfig MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"parameterName== %@",@"backdate_trans"]];
    
     SPAppConfig *nextdate = [SPAppConfig MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"parameterName== %@",@"nextdate_trans"]];
    NSDate *resultbackdate = [NSDate date];
    if (backdate) {
        
        NSInteger  backd = [backdate.parameterValue integerValue];
        resultbackdate = [resultbackdate dateByAddingTimeInterval:-backd*24*60*60];
    }
    
    NSDate *resultnextdate = [NSDate date];
    if (nextdate) {
        
        NSInteger  nextda = [nextdate.parameterValue integerValue];
        resultnextdate = [resultbackdate dateByAddingTimeInterval:+nextda*24*60*60];
    }
    
    
    
    LSLDatePickerDialog *dpDialog = [[LSLDatePickerDialog alloc] init];
    [dpDialog showWithTitle:@"Pilih tanggal" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel"
                defaultDate:[NSDate date] minimumDate:resultbackdate maximumDate:resultnextdate datePickerMode:UIDatePickerModeDate
                   callback:^(NSDate * _Nullable date){
                       if(date)
                       {
                           NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                           [formatter setDateStyle:NSDateFormatterMediumStyle];
                           NSLog(@"Date selected: %@",[formatter stringFromDate:date]);
                           self.fieldPilihTanggal.text =[formatter stringFromDate:date];
                           
                           [self.fieldPilihTanggal resignFirstResponder];
                       }
                   }
     ];
}
- (IBAction)didTapPilihLokasi:(id)sender {
    if (datastores.count >0) {
        [SearchStringPickerViewController showPickerWithTitle:@"Lokasi"
                                                         rows:datastores
                                             initialSelection:0
                                                   sourceView:sender
                                                    doneBlock:^(NSInteger selectedIndex, NSString *selectedValue) {
                                                        NSLog(@"Index: %ld, value: %@", (long)selectedIndex, selectedValue);
                                                        
                                                        self->_fieldPilihLokasi.text =selectedValue;
                                                        
                                                        SPStore *store = [SPStore MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name== %@",selectedValue]];
                                                        
                                                        self->storeid = store.idstore;
                                                    }
         
         
                                                  cancelBlock:nil
                                    presentFromViewController:self];
    }
}

- (IBAction)didTapPilihKategori:(id)sender {
    
    if (datacategory.count >0) {
        [SearchStringPickerViewController showPickerWithTitle:@"Kategori produk"
                                                         rows:datacategory
                                             initialSelection:0
                                                   sourceView:sender
                                                    doneBlock:^(NSInteger selectedIndex, NSString *selectedValue) {
                                                        NSLog(@"Index: %ld, value: %@", (long)selectedIndex, selectedValue);
                                                        
                                                        self->_fieldPilihKategori.text =selectedValue;
                                                        
                                                        
                                                        SPCategory *category = [SPCategory MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name== %@",selectedValue]];
                                                        
                                                        self->categoryid = category.idcategory;
                                                        
                                                        [self initDataProduct:self->categoryid];
                                                    }
                                                  cancelBlock:nil
                                    presentFromViewController:self];
    }
}

-(void)initDataProduct:(NSString*)categoryid
{
    
    if ([categoryid isEqualToString:@""]) {
        [SPUtility initBannerNotif:@"Information" subtitle:@"Belum memilih kategori produk" body:@""];
    }
    else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = @"";
        [hud showAnimated:YES];
        NSArray *arrayproducts = [SPProduct MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"category_id == %@",categoryid]];
        SPUser *user = [SPUser MR_findFirst];
        products = [[NSMutableArray alloc]init];
        for (SPProduct * product in arrayproducts)
        {
            SPDataMonthlyOfftake *monthlyofftake = [SPDataMonthlyOfftake MR_createEntity];
            monthlyofftake.userId = user.userId;
            monthlyofftake.totalQty = @"0";
            monthlyofftake.totalSales = @"0";
            monthlyofftake.productId = product.idproduct;
            monthlyofftake.categoryId = categoryid;
            monthlyofftake.storeId = storeid;
            monthlyofftake.refId =@"";
            monthlyofftake.timeMT =@"";
            monthlyofftake.channel_id =product.channel_id;
            [products addObject:monthlyofftake];
        }
        [hud hideAnimated:YES];
        [self.tableView reloadData];
        
        
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _fieldPilihTanggal) {
        return FALSE;
    }
    else if (textField == _fieldPilihLokasi) {
        return FALSE;
    }
    
    else if (textField == _fieldPilihKategori) {
        return FALSE;
    }
    else{
        return YES;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return products.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SPDataMonthlyOfftake *product = [products objectAtIndex:indexPath.row];

    SPChannel *chanel = [SPChannel MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"idChannel == %@",product.channel_id]];
    
    SPMonthlyOfftakeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"monthlyofftake" forIndexPath:indexPath];
    
    SPProduct *second = [SPProduct MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"idproduct == %@",product.productId]];
    
    cell.lblNameProduk.text = second.model_product;
    
    cell.lblHarga.text = [NSString stringWithFormat:@"Rp %@",second.price];
    
    cell.lblChannel.text = chanel.name;

    cell.btnAddOrMin.tag = indexPath.row;
    
    [cell.btnAddOrMin addTarget:self action:@selector(didTapChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    cell.fieldCounter.tag = indexPath.row;
    cell.fieldTotalPenjualan.tag = indexPath.row;
    
    cell.fieldCounter.text = product.totalQty;
    cell.fieldTotalPenjualan.text = product.totalSales;
    
    UIToolbar *toolbars = [[UIToolbar alloc] init];
    [toolbars setBarStyle:UIBarStyleBlackTranslucent];
    [toolbars sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbars setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    
     cell.fieldTotalPenjualan.inputAccessoryView = toolbars;
    
    [cell.fieldTotalPenjualan addTarget:self action:@selector(didtapChange:) forControlEvents:UIControlEventEditingDidEnd];
    return cell;
    
}

-(void)didtapChange:(UITextField *)sender
{
    NSLog(@"sender text field : %@",sender.text);
    SPDataMonthlyOfftake *product = [products objectAtIndex:sender.tag];
    product.totalSales = [NSString stringWithFormat:@"%@",sender.text];
    [self.tableView reloadData];
}
-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}
-(void)didTapChangeValue:(UIStepper *)sender{
    
    NSLog(@"sender value : %f",sender.value);
     SPDataMonthlyOfftake *product = [products objectAtIndex:sender.tag];
    NSNumber *myDoubleNumber = [NSNumber numberWithDouble:sender.value];
    product.totalQty = [NSString stringWithFormat:@"%@",[myDoubleNumber stringValue]];
    
    [self.tableView reloadData];

}

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
        CGPoint newOffset = self.scrollView.contentOffset;
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
        CGPoint newOffset = self.scrollView.contentOffset;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)insertNetwork:(SPDataMonthlyOfftake *)datamonthly
{
     TrueTimeClient *client = [TrueTimeClient sharedInstance];
    NSDate *now = [[client referenceTime] now];
    NSString *displayString = [NSDate stringFromDate:now withFormat:[NSDate dateFormatString]];
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    NSString *newID = [[NSUUID UUID] UUIDString];
    NSLog(@"ref id id : %@",newID );
    NSDictionary *data =@{@"storeId":datamonthly.storeId,
                          @"timeMT":displayString,
                          @"categoryId":datamonthly.categoryId,
                          @"productId":datamonthly.productId,
                          @"totalQty" : datamonthly.totalQty,
                          @"totalSales":datamonthly.totalSales,
                          @"refId":newID
                          };
    [network doMonthlyOfftake:data view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
       
        if (success) {
            datamonthly.refId = newID;
            datamonthly.timeMT = displayString;
            datamonthly.status = @"terkirim";
            
        
        }
        else{
            datamonthly.refId = newID;
            datamonthly.timeMT = displayString;
            datamonthly.status = @"belumterkirim";
        }
        
    }];
}
- (IBAction)didTapTerkirim:(id)sender {
    if (_fieldPilihTanggal.text.length == 0) {
        [SPMessageUtility message:@"Belum masukin tanggal" needAction:YES viewController:self];
    }
   else if (_fieldPilihLokasi.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin lokasinya" needAction:YES viewController:self];
    }
    
    else if (_fieldPilihKategori.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin kategorinya" needAction:YES viewController:self];
    }
    else{
       
        for (int i = 0; i<products.count; i++) {
            SPDataMonthlyOfftake *data = [products objectAtIndex:i];
            [self insertNetwork:data];
        }
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
