//
//  SPSKUVC.m
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPSKUVC.h"

@interface SPSKUVC ()

@end

@implementation SPSKUVC
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
    NSArray *aryCountries = [SPCategory MR_findAll];
    
    datas = [[NSMutableArray alloc]init];
    
    [datas addObject:@{@"header":@"index",
                        @"content":@"data"
                        }];
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
    _fieldTanggal.delegate = self;
    _fieldPilihLokasi.delegate = self;
    _fieldPilihKategori.delegate = self;
    _fieldNamModel.delegate= self;
    _fieldQuantity.delegate = self;
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _fieldTanggal.inputView = dummyView;
    _fieldPilihLokasi.inputView = dummyView;
    _fieldPilihKategori.inputView = dummyView;
    _fieldNamModel.inputView = dummyView;

    
    UIToolbar *toolbars = [[UIToolbar alloc] init];
    [toolbars setBarStyle:UIBarStyleBlackTranslucent];
    [toolbars sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbars setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
 
    _fieldNamModel.inputAccessoryView = toolbars;
    _fieldQuantity.inputAccessoryView =toolbars;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView reloadData];
    // Do any additional setup after loading the view.
}
-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}
- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                           self.fieldTanggal.text =[formatter stringFromDate:date];
                           
                           [self.fieldTanggal resignFirstResponder];
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _fieldTanggal) {
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
                                                            
                                                            self->_fieldNamModel.text =selectedValue;
                                                            
                                                            
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


- (IBAction)didTapSubmit:(id)sender {
    if (_fieldTanggal.text.length == 0) {
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
    else if (_fieldNamModel.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin produk" needAction:YES viewController:self];
    }
    else if (_fieldQuantity.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin qty" needAction:YES viewController:self];
    }
    else if (_fileName.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin gambar" needAction:YES viewController:self];
    }
    else{
        SPNetworkManager *network = [[SPNetworkManager alloc]init];
         NSString *newID = [[NSUUID UUID] UUIDString];
        NSLog(@"store id : %@",storeid );
        NSDictionary *data= @{@"storeId":storeid,
                              @"timeSku":_fieldTanggal.text,
                              @"categoryId":categoryid,
                              @"productId":product_id,
                              @"refId":newID,
                              @"qty":_fieldQuantity.text
                              };
        
 
        [network doAddSKU:data imagedata:_fileData imageFileName:_fileName view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
           
            NSLog(@"response object: %@",responseObject);
            if (success) {
                [SPMessageUtility customMessageDialog:[responseObject objectForKey:@"message"] needAction:YES viewController:self CH:^(BOOL success, NSString *value) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    SPDataSKU *datasku = [SPDataSKU MR_createEntity];
                    
                    datasku.refId = newID;
                    datasku.productId = product_id;
                    datasku.qty = _fieldQuantity.text;
                    datasku.storeId = storeid;
                    datasku.timeSku =_fieldTanggal.text;
                    datasku.categoryId = categoryid;
                    datasku.status = @"terkirim";
                    
                }];
            }
            else{
                
                SPDataSKU *datasku = [SPDataSKU MR_createEntity];
                
                datasku.refId = newID;
                datasku.productId = product_id;
                datasku.qty = _fieldQuantity.text;
                datasku.storeId = storeid;
                datasku.timeSku =_fieldTanggal.text;
                datasku.categoryId = categoryid;
                datasku.status = @"tidakterkirim";
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
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



@end
