


//
//  SPDisplayVC.m
//  SapphireProject
//
//  Created by mac on 20/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPDisplayVC.h"

@interface SPDisplayVC ()

@end

@implementation SPDisplayVC
{

    NSMutableArray *datastores;
    NSString *storeid;
    NSMutableArray *datas;
    NSMutableArray *products;
    NSString *product_id;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arraystore = [SPStore MR_findAll];
    
    datastores = [[NSMutableArray alloc]init];
    for (SPStore * store in arraystore) {
        [datastores addObject:store.name];
    }
    
    storeid = [[NSString alloc]init];
        product_id = [[NSString alloc]init];
    // Do any additional setup after loading the view.
    
     NSArray *arrayproducts = [SPProduct MR_findAll];
    products = [[NSMutableArray alloc]init];
    for (SPProduct * product in arrayproducts) {
        [products addObject:product.model_product];
    }
    
    datas = [[NSMutableArray alloc]init];
    
    [datas addObject:@{@"header":@"index",
                       @"content":@"data"
                       }];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
    
    _pilihTanggal.delegate = self;
    _pilihLokasi.delegate = self;
    _pilihModelBarang.delegate = self;

    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _pilihTanggal.inputView = dummyView;
    _pilihLokasi.inputView = dummyView;
    _pilihModelBarang.inputView = dummyView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapBack:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil
     ];
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
                           self.pilihTanggal.text =[formatter stringFromDate:date];
                           
                           [self.pilihTanggal resignFirstResponder];
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
                                                        
                                                        self->_pilihLokasi.text =selectedValue;
                                                        
                                                        SPStore *store = [SPStore MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name== %@",selectedValue]];
                                                        
                                                        self->storeid = store.idstore;
                                                    }
         
         
                                                  cancelBlock:nil
                                    presentFromViewController:self];
    }
}

- (IBAction)didTapPilihProduk:(id)sender {

        if (products.count >0) {
            [SearchStringPickerViewController showPickerWithTitle:@"produk"
                                                             rows:products
                                                 initialSelection:0
                                                       sourceView:sender
                                                        doneBlock:^(NSInteger selectedIndex, NSString *selectedValue) {
                                                            NSLog(@"Index: %ld, value: %@", (long)selectedIndex, selectedValue);
                                                            
                                                            self->_pilihModelBarang.text =selectedValue;
                                                            
                                                            
                                                            SPProduct *produk = [SPProduct MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"model_product== %@",selectedValue]];
                                                            
                                                            self->product_id = produk.idproduct;
                                                        }
                                                      cancelBlock:nil
                                        presentFromViewController:self];
        }

        

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _pilihTanggal) {
        return FALSE;
    }
    else if (textField == _pilihLokasi) {
        return FALSE;
    }
    
    else if (textField == _pilihModelBarang) {
        return FALSE;
    }
    else{
        return YES;
    }
    
}
- (IBAction)didTapSubmit:(id)sender {
    
    if (_pilihTanggal.text.length == 0) {
        [SPMessageUtility message:@"Belum masukin tanggal" needAction:YES viewController:self];
    }
    else if (_pilihLokasi.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin lokasinya" needAction:YES viewController:self];
    }
    
    else if (_pilihModelBarang.text.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin produk" needAction:YES viewController:self];
    }
    else if (_fileName.length == 0)
    {
        [SPMessageUtility message:@"Belum masukin gambar" needAction:YES viewController:self];
    }
    else{
        SPNetworkManager *network = [[SPNetworkManager alloc]init];
        NSString *newID = [[NSUUID UUID] UUIDString];
        
        NSDictionary *data= @{@"storeId":storeid,
                              @"timeDisplay":_pilihTanggal.text,
                              @"productId":product_id,
                              @"refId":newID
                              };
        
        [network doAddDisplay:data imagedata:_fileData imageFileName:_fileName view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
            if (success) {
                [SPMessageUtility customMessageDialog:[responseObject objectForKey:@"message"] needAction:YES viewController:self CH:^(BOOL success, NSString *value) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    
                }];
            }
        }];
    }
}

#pragma marktakefoto
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
