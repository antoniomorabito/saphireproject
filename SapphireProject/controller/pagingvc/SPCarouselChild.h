//
//  SPCarouselChild.h
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
@interface SPCarouselChild : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property(nonatomic)NSInteger pageIndex;
@property (weak, nonatomic) IBOutlet UILabel *headerMap;

@property (strong,nonatomic)NSString *imageBack;
@property (strong,nonatomic)NSString *headerString;
@end
