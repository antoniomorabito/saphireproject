//
//  SPPrivacy.h
//  SapphireProject
//
//  Created by mac on 18/03/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface SPPrivacy : UIViewController<UIWebViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webViewPrivacy;
@property(strong,nonatomic)NSString *dataprivacy;
@end

NS_ASSUME_NONNULL_END
