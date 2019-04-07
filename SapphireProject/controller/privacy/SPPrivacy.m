//
//  SPPrivacy.m
//  SapphireProject
//
//  Created by mac on 18/03/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPPrivacy.h"

@interface SPPrivacy ()

@end

@implementation SPPrivacy

- (void)viewDidLoad {
    [super viewDidLoad];
self.webViewPrivacy.userInteractionEnabled = YES;
    self.webViewPrivacy.delegate = self;
    
    NSString *embedHTML =[NSString stringWithFormat: @"<html><head></head><body>%@</body></html>",_dataprivacy];
    
    self.webViewPrivacy.scrollView.delegate = self;
    [self.webViewPrivacy loadHTMLString: embedHTML baseURL: nil];

    // Do any additional setup after loading the view.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSCachedURLResponse *urlResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:webView.request];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) urlResponse.response;
    NSInteger statusCode = httpResponse.statusCode;
    if (statusCode > 399) {
        NSError *error = [NSError errorWithDomain:@"HTTP Error" code:httpResponse.statusCode userInfo:@{@"response":httpResponse}];
        // Forward the error to webView:didFailLoadWithError: or other
    }
    else {
        // No HTTP error
        
        NSLog(@"response : %@",httpResponse);
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"ERROR : %@",error);
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
