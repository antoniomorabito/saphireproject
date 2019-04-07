//
//  SPTermsOfAgg.h
//  SapphireProject
//
//  Created by mac on 18/03/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNetworkManager.h"
NS_ASSUME_NONNULL_BEGIN
@interface SPTermsOfAgg : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webViewTerms;

@property(strong,nonatomic)NSString *dataterms;
@end

NS_ASSUME_NONNULL_END
