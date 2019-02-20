
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
    LSLDatePickerDialog *dpDialog = [[LSLDatePickerDialog alloc] init];
    [dpDialog showWithTitle:@"Pilih tanggal" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel"
                defaultDate:[NSDate date] minimumDate:nil maximumDate:nil datePickerMode:UIDatePickerModeDate
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
        
        products = [[NSMutableArray alloc]init];
        for (SPProduct * product in arrayproducts) {
            [products addObject:product];
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
    
    
    SPProduct *product = [products objectAtIndex:indexPath.row];
    
    
    SPChannel *chanel = [SPChannel MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"idChannel == %@",product.channel_id]];
    
        SPMonthlyOfftakeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"monthlyofftake" forIndexPath:indexPath];
    
    cell.lblNameProduk.text = product.model_product;
    cell.lblHarga.text = [NSString stringWithFormat:@"Rp %@",product.price];
    
    cell.lblChannel.text = chanel.name;
    
//    cell.
    cell.btnAddOrMin.tag = indexPath.row;
    
    [cell.btnAddOrMin addTarget:self action:@selector(didTapChangeValue:) forControlEvents:UIControlEventValueChanged];
    
        // Configure the cell...
        
        return cell;
    
}

-(void)didTapChangeValue:(UIStepper *)sender{
    
    NSLog(@"sender value : %f",sender.value);
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
