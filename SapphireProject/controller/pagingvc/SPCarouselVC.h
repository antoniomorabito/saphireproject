//
//  SPCarouselVC.h
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
#import "SPCarouselChild.h"
@interface SPCarouselVC : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *paging;
@property (strong,nonatomic)NSString *kategori;
@property (strong,nonatomic)NSString *tags;
@property (strong,nonatomic)NSArray *datas;
- (void)changePage:(SPCarouselChild *)card;
@end
