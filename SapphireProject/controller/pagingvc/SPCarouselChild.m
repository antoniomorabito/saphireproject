//
//  SPCarouselChild.m
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPCarouselChild.h"

@interface SPCarouselChild ()

@end

@implementation SPCarouselChild

- (void)viewDidLoad {
    [super viewDidLoad];
//    [_backgroundImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/tour-image/load/%@",kCABaseURL,_imageBack]]
//                        placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [self.backgroundImage setImage:[UIImage imageNamed:_imageBack]];
//    self.headerMap.text = [NSString stringWithFormat:@"%@",_headerString];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
