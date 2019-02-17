
//
//  SPAttendanceVC.m
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPAttendanceVC.h"

@interface SPAttendanceVC ()

@end

@implementation SPAttendanceVC
{
    NSMutableArray *datastores;
    
    NSString *storeid;
    NSString *typeFoto;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
     TrueTimeClient *client = [TrueTimeClient sharedInstance];
    
      NSDate *now = [[client referenceTime] now];
    
    NSLog(@"nilai datenya adalah : %@",now);
    // Do any additional setup after loading the view.
    

    
     NSString *displayString = [NSDate stringFromDate:now withFormat:[NSDate timeFormatString]];
    
   storeid = [[NSString alloc]init];
       typeFoto = [[NSString alloc]init];
    
    NSArray *arraystore = [SPStore MR_findAll];
    
    datastores = [[NSMutableArray alloc]init];
    for (SPStore * store in arraystore) {
        [datastores addObject:store.name];
    }
    
    
    _fieldTempatBekerja.delegate = self;
    
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _fieldTempatBekerja.inputView = dummyView;
    
    UIToolbar *toolbars = [[UIToolbar alloc] init];
    [toolbars setBarStyle:UIBarStyleBlackTranslucent];
    [toolbars sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbars setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    
     _fieldTempatBekerja.inputAccessoryView = toolbars;
    
    
    
    _waktuJamNow.text =   displayString;
    
    _lblTotalJamSkrang.text = @"00:00:00";
    
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
                                                        
                                                        self->_fieldTempatBekerja.text =selectedValue;
                                               
                                                    
                                                        SPStore *store = [SPStore MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name== %@",selectedValue]];
                                                        
                                                        storeid = store.idstore;
                                                    }
         
         
                                                  cancelBlock:nil
                                    presentFromViewController:self];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapCekIn:(id)sender {
    
    if (storeid.length == 0) {
        [SPMessageUtility message:@"Anda belum memilih lokasi " needAction:YES viewController:self];
        return;
    }
    self.fdTake = [[FDTakeController alloc] init];
    self.fdTake.delegate = self;
    typeFoto = @"cekin";
    [self.fdTake takePhoto];
}

- (IBAction)didTapCheckOu:(id)sender {
    self.fdTake = [[FDTakeController alloc] init];
    self.fdTake.delegate = self;
    typeFoto = @"cekout";
    [self.fdTake takePhoto];
    
    
  
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
- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    
    UIImage *viewImage =[self imageWithImage:photo scaledToSize:CGSizeMake(100, 100)];
    
    if ([typeFoto isEqualToString:@"cekin"]) {
        self.imageViewCekIn.image = nil;
        [self.imageViewCekIn setImage:photo];
    }
    else{
        self.imageViewCekout.image = nil;
        [self.imageViewCekout setImage:photo];
    }
  
    
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
             
                 if ([self->typeFoto isEqualToString:@"cekin"]) {
                  [self writeImageData:self.imageViewCekIn.image filename:path];
                     NSString *newID = [[NSUUID UUID] UUIDString];
                     [self insertNetworkAttendance:newID];
                 }
                 else{
                      [self writeImageData:self.imageViewCekout.image filename:path];
                 }
                 
               
                 
                 
             }
         }];
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

- (void)writeImageData:(UIImage *)image filename:(NSString *)name
{
    UIImage *myImage = [UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(image)];
    
    NSData *jpgDat = UIImageJPEGRepresentation(myImage, 0.5);
    NSString *urlTemp = [self documentsPathForFileName:name];
    [jpgDat writeToFile:urlTemp atomically:YES]; //Write the file
    _filePath = [NSString stringWithFormat:@"%@",urlTemp];

    
    NSLog(@"file path nya : %@",_filePath);
    
    //    NSLog(@"image yang akan di post ke peladen : %@",_filePath);
    
    
    
    
    
}
- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _fieldTempatBekerja) {
        return FALSE;
    }

    else{
        return YES;
    }
    
}
-(void)insertNetworkAttendance:(NSString*)refID{
    TrueTimeClient *client = [TrueTimeClient sharedInstance];
    
    NSDate *now = [[client referenceTime] now];
    
    NSLog(@"nilai date network adalah : %@",now);
    // Do any additional setup after loading the view
    NSString *displayString = [NSDate stringFromDate:now withFormat:[NSDate timestampFormatString]];
    NSDictionary *data =@{@"storeId":storeid,@"time_attandance":displayString,@"remark":@"attendancein",@"refId":refID};
    
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doAttendanceIn:data imagedata:_fileData imageFileName:_fileName view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
       
        NSLog(@"response attendance in : %@",data);
        
    }];
    
}
-(void)insertLocalAttendance:(NSString*)refID
              attendancetime:  (NSString *)timepost
            typeAttendance:  (NSString *)type{
   
    
    NSLog(@"nilai id nya  : %@",refID );
    SPDataAttendanceIn *data = [SPDataAttendanceIn MR_createEntity];

    SPUser *user = [SPUser MR_findFirst];
    data.refId = refID;
    data.photo = _filePath;
    data.userId =user.userId;
    data.storeId = storeid;
    data.time_attandance =timepost;
    data.remark =type;
     [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
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
