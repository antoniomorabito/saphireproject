
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
-(NSString *)getDocumentDirectoryPath:(NSString *)Name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:Name];
    NSLog(@"savedImagePath: %@", savedImagePath);
    return savedImagePath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
  
    [self initData];
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
    
    
}

-(void)initData{
    TrueTimeClient *client = [TrueTimeClient sharedInstance];
    
    NSDate *now = [[client referenceTime] now];
   
    /// cek dlu ada gak dari API last cek in
    SPDataLastCheckIn *data = [SPDataLastCheckIn MR_findFirst];
    if (data) {
     
        NSLog(@"datanya ada : %@ ",data.attandance_id);
        
        //setup tanggal attendancenya
        NSString *dateString = data.time_attandance;
    
//        NSLog(@"time attenda : %@",dateString);
        
        
//        NSLog(@"hasil convert : %@",[SPUtility formattanggal:dateString]);
        
        _waktuJamNow.text =[SPUtility convertDateToString:now toFormat:@"hh:mm:ss"];
        
        //jam cek in
        _lblJamCekIn.text =[SPUtility formattanggal:dateString];
        
        
        // substract time and hour
        
        NSDate *convertdatenow = [SPUtility convertStringToDate:[SPUtility convertDateToString:now toFormat:@"yyyy-MM-dd hh:mm:ss"] fromFormat:@"yyyy-MM-dd hh:mm:ss"];
        
        
          NSDate * convertdatefromcekin = [SPUtility convertStringToDate:dateString fromFormat:@"yyyy-MM-dd hh:mm:ss"];
        
        
        NSLog(@"interval waktu : %@",[SPUtility intervalhours:convertdatenow toFormat: convertdatefromcekin]);
        
        
        // check interval waktu
        _lblTotalJamSkrang.text =[NSString stringWithFormat:@"%@ hours",[SPUtility intervalhours:convertdatenow toFormat: convertdatefromcekin]];
        
        
        // cek image urlnya
        [_imageViewCekIn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data.photo]]];
        
        //cek storenya
        SPStore *store = [SPStore MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"idstore == %@",data.store_id]];
        
        //get id store
        storeid = store.idstore;
        _fieldTempatBekerja.text = store.name;
        
        _fieldTempatBekerja.enabled = false;
        
        self.btnCheckIn.enabled =false;
        self.btnCheckOut.enabled =true;
        
    }
    else{
        
        
        
        NSLog(@"datanya gak ada dari last cek in:");
        
        
        //check dari lokal aja
        NSString *functiondate = [NSDate stringFromDate:now withFormat:@"yyyy-MM-dd"];
        //    NSLog(@"get function date id : %@",functiondate);
        SPUser *user =[SPUser MR_findFirst];
        
        SPDataAttendanceIn *attendanceIn = [SPDataAttendanceIn MR_findFirstOrderedByAttribute:@"time_attandance" ascending:NO];
        
        NSLog(@"attendance id nya last or gak : %@",attendanceIn.idattendance);
        
        
        if (attendanceIn) {
            
            NSLog(@"in nya ada");
            
            if ([attendanceIn.status isEqualToString:@"OPENED"]) {
                
            }
            else{
                
                
            }
        }
        else
        {
            
        }
    }


    
    
    

    // Do any additional setup after loading the view.
   
    
}

-(void)anothersetup{
      TrueTimeClient *client = [TrueTimeClient sharedInstance];
     NSDate *now = [[client referenceTime] now];
     NSString *functiondate = [NSDate stringFromDate:now withFormat:@"yyyy-MM-dd"];
    //    NSLog(@"get function date id : %@",functiondate);
    SPUser *user =[SPUser MR_findFirst];
    
    SPDataAttendanceIn *attendanceIn = [SPDataAttendanceIn MR_findFirstOrderedByAttribute:@"time_attandance" ascending:NO];
    
    NSLog(@"attendance id nya last or gak : %@",attendanceIn.idattendance);
    //[SPDataAttendanceIn MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"tanggal == %@ and userId == %@",functiondate,user.userId]];
    if (attendanceIn) {
        //kalau ada buat kondisi dari awal lagi ntuk proses cek out
        
        SPDataAttendanceOut *attendanceout = [SPDataAttendanceOut MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"tanggal == %@ and userId == %@ and attandance_id == %@",functiondate,user.userId,attendanceIn.idattendance]];
        
        
        if (attendanceout) {
            NSLog(@"ada outnya loj");
            //kalau ada..init baru lagi
            _btnCheckIn.enabled = true;
            _btnCheckOut.enabled = false;
            _fieldTempatBekerja.enabled = true;
            
            NSString *displayString = [NSDate stringFromDate:now withFormat:[NSDate timeFormatString]];
            
            storeid = [[NSString alloc]init];
            typeFoto = [[NSString alloc]init];
            
            NSArray *arraystore = [SPStore MR_findAll];
            
            datastores = [[NSMutableArray alloc]init];
            for (SPStore * store in arraystore) {
                [datastores addObject:store.name];
            }
            
            _waktuJamNow.text =   displayString;
            
            _lblTotalJamSkrang.text = @"00:00:00";
            _imageViewCekIn.image = NULL;
            _imageViewCekout.image = NULL;
            _lblJamCekIn.text = @"";
            _lblJamCekOut.text = @"";
            _fieldTempatBekerja.text = @"";
            
            
        }
        else{
            NSLog(@"gak ada  outnya loj");
            //kalau tidak ada out..
            NSString *dateString = attendanceIn.time_attandance;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateString];
            NSDateFormatter *dateFormattersecond = [[NSDateFormatter alloc] init];
            [dateFormattersecond setDateFormat:@"HH:mm"];
            NSString *stringDate = [dateFormattersecond stringFromDate:dateFromString];
            _lblJamCekIn.text = stringDate;
            
            //            NSLog(@"image foto nya adalah : %@",);
            _imageViewCekIn.image = [UIImage imageWithData:attendanceIn.imagefotdata];
            
            SPStore *store = [SPStore MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"idstore == %@",attendanceIn.storeId]];
            
            storeid = store.idstore;
            _fieldTempatBekerja.text = store.name;
            
            _fieldTempatBekerja.enabled = false;
            
            self.btnCheckIn.enabled =false;
            self.btnCheckOut.enabled =true;
            
        }
    }
    else{
        
        NSLog(@"blum ada attendance untuk hari itu ");
        //jika blum ada attendance in sama sekali
        _btnCheckIn.enabled = true;
        _btnCheckOut.enabled = false;
        _fieldTempatBekerja.enabled = true;
        
        NSString *displayString = [NSDate stringFromDate:now withFormat:[NSDate timeFormatString]];
        
        storeid = [[NSString alloc]init];
        typeFoto = [[NSString alloc]init];
        
        NSArray *arraystore = [SPStore MR_findAll];
        
        datastores = [[NSMutableArray alloc]init];
        for (SPStore * store in arraystore) {
            [datastores addObject:store.name];
        }
        
        _waktuJamNow.text =   displayString;
        
        _lblTotalJamSkrang.text = @"00:00:00";
        _imageViewCekIn.image = NULL;
        _imageViewCekout.image = NULL;
    }
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
                     [self insertNetworkAttendanceIn:newID];
                 }
                 else{
                      [self writeImageData:self.imageViewCekout.image filename:path];
                     
                     NSString *newID = [[NSUUID UUID] UUIDString];
                     [self insertNetworkAttendanceOut:newID];
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

-(void)insertNetworkAttendanceOut:(NSString *)refID
{
    TrueTimeClient *client = [TrueTimeClient sharedInstance];
    
    NSDate *now = [[client referenceTime] now];
    
    NSLog(@"nilai date network out adalah adalah : %@",now);
    // Do any additional setup after loading the view
    NSString *displayString = [NSDate stringFromDate:now withFormat:[NSDate timestampFormatString]];
    NSString *functiondate = [NSDate stringFromDate:now withFormat:@"yyyy-MM-dd"];
    SPUser *user =[SPUser MR_findFirst];
    SPDataAttendanceIn *attendanceIn = [SPDataAttendanceIn MR_findFirstOrderedByAttribute:@"time_attandance" ascending:NO];;
    NSLog(@"data attendande oin adalah : %@ atau data attend %@",attendanceIn.idattendance,attendanceIn.time_attandance);
    NSDictionary *data =@{@"attandance_id":attendanceIn.idattendance,@"time_attandance":displayString,@"remark":@"attendanceout",@"refId":refID};
    
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doAttendanceOut:data imagedata:_fileData imageFileName:_fileName view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        NSLog(@"response attendance out  adalah: %@",responseObject);
        
        if (success) {
            
            [self insertLocalAttendanceOut:[data objectForKey:@"refId"] attendancetime:[data objectForKey:@"time_attandance"] typeAttendance:[data objectForKey:@"remark"] tanggal:functiondate attendanceid:attendanceIn.idattendance];
            
            NSString *dateString = [data objectForKey:@"time_attandance"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateString];
            NSDateFormatter *dateFormattersecond = [[NSDateFormatter alloc] init];
            [dateFormattersecond setDateFormat:@"HH:mm"];
            NSString *stringDate = [dateFormattersecond stringFromDate:dateFromString];
            
            self.lblJamCekOut.text = stringDate;
            
            [self initData];
            
        }
        else{
            
        }
        
    }];
}
-(void)insertNetworkAttendanceIn:(NSString*)refID{
    TrueTimeClient *client = [TrueTimeClient sharedInstance];
    
    NSDate *now = [[client referenceTime] now];
    
    NSLog(@"nilai date network in adalah : %@",now);
    // Do any additional setup after loading the view
    NSString *displayString = [NSDate stringFromDate:now withFormat:[NSDate timestampFormatString]];
    NSString *functiondate = [NSDate stringFromDate:now withFormat:@"yyyy-MM-dd"];
    NSDictionary *data =@{@"storeId":storeid,@"time_attandance":displayString,@"remark":@"attendancein",@"refId":refID};
    
    SPNetworkManager *network = [[SPNetworkManager alloc]init];
    
    [network doAttendanceIn:data imagedata:_fileData imageFileName:_fileName view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
       
        NSLog(@"response attendance in  adalah: %@",responseObject);
        if (![[responseObject objectForKey:@"error_description"] isEqualToString:@"Incorrect token"]) {
            
            [self insertLocalAttendanceIn:[data objectForKey:@"refId"] attendancetime:[data objectForKey:@"time_attandance"] typeAttendance:[data objectForKey:@"remark"] tanggal:functiondate attendanceID:[responseObject objectForKey:@"attandance_id"]];
            
            NSString *dateString = [data objectForKey:@"time_attandance"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateString];
            NSDateFormatter *dateFormattersecond = [[NSDateFormatter alloc] init];
            [dateFormattersecond setDateFormat:@"HH:mm"];
            NSString *stringDate = [dateFormattersecond stringFromDate:dateFromString];
            
            self.lblJamCekIn.text = stringDate;
            
            [self initData];
            
        }
        else{
            
        }
        
    }];
    
}
-(void)insertLocalAttendanceIn:(NSString*)refID
              attendancetime:  (NSString *)timepost
            typeAttendance:  (NSString *)type
                tanggal:  (NSString *)tanggalin
                attendanceID:  (NSString *)idattendance{
   
    
    NSLog(@"nilai id nya  : %@",refID );
    SPDataAttendanceIn *data = [SPDataAttendanceIn MR_createEntity];

    SPUser *user = [SPUser MR_findFirst];
    data.refId = refID;
    data.idattendance =idattendance;
    data.imagefotdata = _fileData;
    data.photo = _filePath;
    data.userId =user.userId;
    data.storeId = storeid;
    data.tanggal = tanggalin;
    data.time_attandance =timepost;
    data.remark =type;
     [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
}

-(void)insertLocalAttendanceOut:(NSString*)refID
                attendancetime:  (NSString *)timepost
                typeAttendance:  (NSString *)type
                       tanggal:  (NSString *)tanggalin
                        attendanceid:  (NSString *)idattendance{
    
    
    NSLog(@"nilai id nya output  : %@",refID );
    SPDataAttendanceOut *data = [SPDataAttendanceOut MR_createEntity];
    
    SPUser *user = [SPUser MR_findFirst];
    data.refId = refID;
    data.attandance_id =idattendance;
    data.imagefotdata = _fileData;
    data.foto = _filePath;
    data.userId =user.userId;
    data.tanggal = tanggalin;
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
