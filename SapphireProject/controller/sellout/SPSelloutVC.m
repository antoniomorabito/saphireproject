


//
//  SPSelloutVC.m
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPSelloutVC.h"

@interface SPSelloutVC ()

@end

@implementation SPSelloutVC
{
    NSMutableArray *datacategory;
    NSMutableArray *datastores;
    NSString *storeid;
    NSString *categoryid;
    NSMutableArray *datas;

    
    NSMutableArray *products;
    NSString *product_id;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //set value stepper
    _fieldCounterAddAndMin.minimumValue = 1.0f;
    
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
    
    product_id = [[NSString alloc]init];
    storeid = [[NSString alloc]init];
    categoryid = [[NSString alloc]init];
    
    _fieldLocation.delegate = self;
    _fieldCategory.delegate = self;
    _fieldProductName.delegate = self;
    _fieldSubTotalPrice.delegate = self;
    _fieldCustomerPrice.delegate = self;
    _fieldCustomerName.delegate = self;
    _fieldCustomerPhoneNumber.delegate = self;
    _fieldProdukKeberadaan.delegate =self;
    _fieldDate.delegate = self;
    
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _fieldLocation.inputView = dummyView;
    _fieldCategory.inputView = dummyView;
    _fieldProductName.inputView = dummyView;
    _fieldDate.inputView = dummyView;
    
    UIToolbar *toolbars = [[UIToolbar alloc] init];
    [toolbars setBarStyle:UIBarStyleBlackTranslucent];
    [toolbars sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbars setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    
    _fieldCustomerName.inputAccessoryView = toolbars;
    _fieldCustomerPrice.inputAccessoryView = toolbars;
    _fieldSubTotalPrice.inputAccessoryView = toolbars;
    _fieldCustomerPhoneNumber.inputAccessoryView = toolbars;
    _fieldCustomerAddress.inputAccessoryView = toolbars;
  
    _fieldProdukInstalasi.inputAccessoryView = toolbars;
    _fieldProdukKeberadaan.inputAccessoryView = toolbars;
    
    
    datas = [[NSMutableArray alloc]init];
    
    [datas addObject:@{@"header":@"index",
                       @"content":@"data"
                       }];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView reloadData];
    

}


-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _fieldLocation) {
        return FALSE;
    }
    else if (textField == _fieldCategory) {
        return FALSE;
    }
    
    else if (textField == _fieldProductName) {
        return FALSE;
    }
    else if (textField == _fieldDate) {
        return FALSE;
    }
    
    else{
        return YES;
    }
    
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
                           self->_fieldDate.text =[formatter stringFromDate:date];
                           
                           [self.fieldDate resignFirstResponder];
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
                                                        
                                                        self->_fieldLocation.text =selectedValue;
                                                        
                                                        SPStore *store = [SPStore MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name== %@",selectedValue]];
                                                        
                                                        self->storeid = store.idstore;
                                                    }
         
         
                                                  cancelBlock:nil
                                    presentFromViewController:self];
    }
    
}

- (IBAction)didTapPilihCategory:(id)sender {
    
    if (datacategory.count >0) {
        [SearchStringPickerViewController showPickerWithTitle:@"Kategori produk"
                                                         rows:datacategory
                                             initialSelection:0
                                                   sourceView:sender
                                                    doneBlock:^(NSInteger selectedIndex, NSString *selectedValue) {
                                                        NSLog(@"Index: %ld, value: %@", (long)selectedIndex, selectedValue);
                                                        
                                                        self->_fieldCategory.text =selectedValue;
                                                        
                                                        
                                                        SPCategory *category = [SPCategory MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name== %@",selectedValue]];
                                                        
                                                        self->categoryid = category.idcategory;
                                                    }
                                                  cancelBlock:nil
                                    presentFromViewController:self];
    }
}
- (IBAction)didTapPilihProduk:(id)sender {
    
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
            [products addObject:product.model_product];
        }
        [hud hideAnimated:YES];
        
        
        if (products.count >0) {
            [SearchStringPickerViewController showPickerWithTitle:@"produk"
                                                             rows:products
                                                 initialSelection:0
                                                       sourceView:sender
                                                        doneBlock:^(NSInteger selectedIndex, NSString *selectedValue) {
                                                            NSLog(@"Index: %ld, value: %@", (long)selectedIndex, selectedValue);
                                                            
                                                            self->_fieldProductName.text =selectedValue;
                                                            
                                                            
                                                            SPProduct *produk = [SPProduct MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"model_product== %@",selectedValue]];
                                                            
                                                            self->product_id = produk.idproduct;
                                                        }
                                                      cancelBlock:nil
                                        presentFromViewController:self];
        }
        else
        {
            [SPUtility initBannerNotif:@"Information" subtitle:@"Produk untuk kategori tersebut tidak ada" body:@""];
        }
        
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
- ( UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSDictionary *data = [datas objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        SPMainTakeImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"takefoto" forIndexPath:indexPath];
        
        cell.btnTakeFoto.tag = indexPath.row;
        
        [cell.btnTakeFoto addTarget:self action:@selector(didTapTakeFoto:) forControlEvents:UIControlEventTouchUpInside];
        
        //
        return cell;
    }
    else{
        SPCollectionImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imagecell" forIndexPath:indexPath];
        
        
        cell.imageBackground.image = [UIImage imageWithData:[NSData dataWithData:[data objectForKey:@"imagedata"]]];
        return cell;
    }
    
}

-(void)didTapTakeFoto:(UIButton *)sender
{
    
    if (datas.count ==1) {
        NSLog(@"data take foto");
        self.fdTake = [[FDTakeController alloc] init];
        self.fdTake.delegate = self;
        
        [self.fdTake takePhoto];
    }
    
    
}

#pragma mark - FDTakeDelegate

- (void)takeController:(FDTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt
{
    if (madeAttempt) {
        NSLog(@"The take was cancelled after selecting media");
    } else {
        NSLog(@"The take was cancelled without selecting media");
        //        [self cancelUploadImages];
        
    }
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    
    UIImage *viewImage =[self imageWithImage:photo scaledToSize:CGSizeMake(100, 100)];
    
    NSData *imageData = UIImageJPEGRepresentation(viewImage, 0.0);
    _fileData = imageData;
    PHAsset *asset = nil;
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
    if (fetchResult != nil && fetchResult.count > 0) {
        // get last photo from Photos
        asset = [fetchResult lastObject];
        //        NSLog(@"file name is :%@",asset);
    }
    
    
    if (asset) {
        // get photo info from this asset
        PHImageRequestOptions * imageRequestOptions = [[PHImageRequestOptions alloc] init];
        imageRequestOptions.synchronous = YES;
        [[PHImageManager defaultManager]
         requestImageDataForAsset:asset
         options:imageRequestOptions
         resultHandler:^(NSData *imageData, NSString *dataUTI,
                         UIImageOrientation orientation,
                         NSDictionary *info)
         {
             //             NSLog(@"info = %@", info);
             if ([info objectForKey:@"PHImageFileURLKey"]) {
                 // path looks like this -
                 // file:///var/mobile/Media/DCIM/###APPLE/IMG_####.JPG
                 NSString *path = [[info objectForKey:@"PHImageFileURLKey"]lastPathComponent];
                 
                 NSLog(@"check the path : %@",path);
                 //                 _fileData = imageData;
                 self->_fileName = path;
                 //                 NSLog(@"check the datae : %@",_fileData);
                 //                 _filePath =@"tst";
                 
                 [self writeImageData:viewImage filename:path];
                 
                 
                 
             }
         }];
    }
    
}
- (void)writeImageData:(UIImage *)image filename:(NSString *)name
{
    UIImage *myImage = [UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(image)];
    
    NSData *jpgDat = UIImageJPEGRepresentation(myImage, 0.5);
    NSString *urlTemp = [self documentsPathForFileName:name];
    [jpgDat writeToFile:urlTemp atomically:YES]; //Write the file
    _filePath = [NSString stringWithFormat:@"%@",urlTemp];
    
    
    NSLog(@"file path nya : %@",_filePath);
    
    //    NSLog(@"image yang akan di post ke peladen : %@",_filePath);
    
    
    
    
    [datas addObject:@{
                       @"header":@"content",
                       @"imagedata":_fileData,
                       @"imagefilenam":_fileName,
                       @"imagefilepath":_filePath
                       }];
    
    [self.collectionView reloadData];
}
- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return datas.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapBack:(id)sender {
    
      [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)didTapChangeValue:(UIStepper *)sender {
    NSLog(@"sender value %d ",(int)sender.value);
    
    _fieldSubTotalPrice.text = [NSString stringWithFormat:@"%d",(int)sender.value];
    
    NSInteger nilai = [_fieldSubTotalPrice.text integerValue];
    double subcounter =[_fieldCustomerPrice.text doubleValue];
    
    NSLog(@"datanya : %ld dan subcotn: %f",(long)nilai,subcounter);
    double hasil = nilai *subcounter;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setCurrencySymbol:@""];
    NSNumber *numberDone = [NSNumber numberWithDouble:hasil];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *text = [formatter stringFromNumber:numberDone];
    _lblTotalSubPrice.text = [NSString stringWithFormat:@"Rp %@",text];
    
    
    
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
    else if (_fieldProductName.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin produk" needAction:YES viewController:self];
    }
    else if (_fieldCustomerName.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin nama pelanggan" needAction:YES viewController:self];
    }
    else if (_fieldCustomerPhoneNumber.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin no telepon" needAction:YES viewController:self];
    }
    else if (_fieldCustomerPrice.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin harga pelanggan" needAction:YES viewController:self];
    }
    else if (_fieldProdukKeberadaan.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin produk keberadaan" needAction:YES viewController:self];
    }
    
    else if (_fieldProdukInstalasi.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin produk instalasi" needAction:YES viewController:self];
    }
    else{
        
        SPNetworkManager *network = [[SPNetworkManager alloc]init];
        
        SPUser *user = [SPUser MR_findFirst];
          NSString *newID = [[NSUUID UUID] UUIDString];
        NSDictionary *data= @{@"storeId":storeid,
                              @"timeSellout":_fieldDate.text,
                              @"productId":product_id,
                              @"totalQty":_fieldSubTotalPrice.text,
                              @"statusStock":_fieldProdukKeberadaan.text,
                              @"statusInstalation":_fieldProdukInstalasi.text,
                              @"customerName":_fieldCustomerName.text,
                              @"customerPhone":_fieldCustomerPhoneNumber.text,
                              @"customerAddress":_fieldCustomerAddress.text,
                              @"customerPrice":_fieldCustomerPrice.text,
                              @"refId":newID
                              };
        
        
        
        [network doSellout:data imagedata:_fileData imageFileName:_fileName view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
            SPDataSellout *sellout = [SPDataSellout MR_createEntity];
            if (success) {
                
                
                [SPMessageUtility customMessageDialog:[responseObject objectForKey:@"message"] needAction:YES viewController:self CH:^(BOOL success, NSString *value) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    sellout.idTable = newID;
                    sellout.userId =user.userId;
                    sellout.productName = self->_fieldProductName.text;
                    sellout.storeName = self->_fieldLocation.text;
                    sellout.categoryName = self->_fieldCategory.text;
                    sellout.customerAddress =self->_fieldcustomerAddress.text;
                    sellout.customerName = self->_fieldCustomerName.text;
                    sellout.customerPhone = self->_fieldCustomerPhoneNumber.text;
                    sellout.customerPhoto = self->_fileName;
                    sellout.customerPrice = self->_fieldCustomerPrice.text;
                    sellout.photofile = self->_fileData;
                    sellout.productId = self->product_id;
                    sellout.category_id = self->categoryid;
                    sellout.storeId = self->storeid;
                    sellout.timeSellout = self->_fieldDate.text;
                    sellout.totalQty = self->_fieldSubTotalPrice.text;
                    sellout.statusStock = self->_fieldProdukKeberadaan.text;
                    sellout.statusInstalation = self->_fieldProdukInstalasi.text;
                  
                    sellout.status = @"Terkirim ke Server";
                     [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                }];
            }
            else{
                 [SPMessageUtility customMessageDialog:@"Data anda tersimpan secara lokal, silahkan upload ulang atau review kembali di overviewnya" needAction:YES viewController:self CH:^(BOOL success, NSString *value) {
                     sellout.idTable = newID;
                     sellout.userId =user.userId;
                     sellout.productName = self->_fieldProductName.text;
                     sellout.storeName = self->_fieldLocation.text;
                     sellout.categoryName = self->_fieldCategory.text;
                     sellout.customerAddress =self->_fieldcustomerAddress.text;
                     sellout.customerName = self->_fieldCustomerName.text;
                     sellout.customerPhone = self->_fieldCustomerPhoneNumber.text;
                     sellout.customerPhoto = self->_fileName;
                     sellout.customerPrice = self->_fieldCustomerPrice.text;
                     sellout.photofile = self->_fileData;
                     sellout.productId = self->product_id;
                     sellout.category_id = self->categoryid;
                     sellout.storeId = self->storeid;
                     sellout.timeSellout = self->_fieldDate.text;
                     sellout.totalQty = self->_fieldSubTotalPrice.text;
                     sellout.statusStock = self->_fieldProdukKeberadaan.text;
                     sellout.statusInstalation = self->_fieldProdukInstalasi.text;
                     sellout.status = @"Belum terkirim ke server";
                     [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                 }];
              
            }
            
            
        }];
        
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
