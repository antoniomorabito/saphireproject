//
//  SPProfileVC.m
//  SapphireProject
//
//  Created by mac on 22/01/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPProfileVC.h"

@interface SPProfileVC ()

@end

@implementation SPProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datas =[[NSMutableArray alloc]initWithObjects:@"Change Password",@"Term Of Service",@"Privacy Policy",@"Log Out", nil];
    
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
    
    SPUser *user = [SPUser MR_findFirst];
    
    _lblName.text = user.name;
    
    self.imageBackground.userInteractionEnabled = YES;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",user.photo]];
    [_imageBackground sd_setImageWithURL:url
                   placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
                            options:SDWebImageRefreshCached];
    
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    
    tapGesture1.numberOfTapsRequired = 1;
    
    [tapGesture1 setDelegate:self];
    
    [_imageBackground addGestureRecognizer:tapGesture1];
    // Do any additional setup after loading the view.
}
- (void) tapGesture: (id)sender
    {
        self.fdTake = [[FDTakeController alloc] init];
        self.fdTake.delegate = self;
        [self.fdTake takePhotoOrChooseFromLibrary];
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        self.imageBackground.image = nil;
        [self.imageBackground setImage:photo];
        
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
                     _fileName = path;
                     //                 NSLog(@"check the datae : %@",_fileData);
                     //                 _filePath =@"tst";
                     [self writeImageData:self.imageBackground.image filename:path];
                     
                     
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
        
        SPNetworkManager *networkmanager = [[SPNetworkManager alloc ]init];
        
        NSLog(@"file path nya : %@",_filePath);
        
    
        [networkmanager doUpdatePicture:nil
        imagedata:_fileData imageFileName:_fileName view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
        
        }];
        //    NSLog(@"image yang akan di post ke peladen : %@",_filePath);
        
        
    }
- (NSString *)documentsPathForFileName:(NSString *)name
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        
        return [documentsPath stringByAppendingPathComponent:name];
    }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *data = [self.datas objectAtIndex:indexPath.row];
    
    if ([data isEqualToString:@"Change Password"]) {
      
        [SPMessageUtility customInputDialog:@"Saphire" message:@"Ganti Password" placeholder:@"Masukan password baru anda" viewController:self completiH:^(BOOL success, NSString *value) {
           
            SPNetworkManager *network =[[SPNetworkManager alloc]init
                                        ];
            
            [network doUpdatePassword:@{@"password":value} view:self.view completionHandler:^(BOOL success, id responseObject, NSError *error) {
               
                NSLog(@"nilai change passw : %@",responseObject);
            }];
            
        }];
    }
    else if ([data isEqualToString:@"Term Of Service"]) {
        
    }
    else if ([data isEqualToString:@"Privacy Policy"]) {
        
    }
    else if ([data isEqualToString:@"Log Out"]) {
        
        
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"SPAuthentication" bundle:nil]instantiateViewControllerWithIdentifier:@"login"];
        
        [SPUser MR_truncateAll];
        [self presentViewController:vc animated:YES completion:nil];
    }
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString *data = [self.datas objectAtIndex:indexPath.row];
    SPProfileCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
    
    cell.lblName.text = data;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}



@end
