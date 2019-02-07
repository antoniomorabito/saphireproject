



//
//  SPCarouselVC.m
//  SapphireProject
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 telkom. All rights reserved.
//

#import "SPCarouselVC.h"

@interface SPCarouselVC ()
@property (strong, nonatomic) UIPageViewController *pageVC;
@property(strong,nonatomic)NSMutableArray *arrayPins;
@property(nonatomic)NSInteger index;
@end

@implementation SPCarouselVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *data = [NSArray arrayWithObjects:@"imageone",@"imagetwo" ,@"imagethree",nil];
    
    if (data.count >0) {
        self.arrayPins = [[NSMutableArray alloc]initWithArray:data];
        
        
        
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageVC.dataSource = self;
        _pageVC.delegate = self;
        
        [self.paging setNumberOfPages:self.arrayPins.count];
        
        
SPCarouselChild *carousel = [[UIStoryboard storyboardWithName:@"SPCarousel" bundle:nil] instantiateViewControllerWithIdentifier:@"carouselPage"];
        
        NSString *tourImage = [self.arrayPins objectAtIndex:0];
        carousel.pageIndex = 0;
//        carousel.headerString =
        carousel.imageBack = tourImage;
        
        
        [_pageVC setViewControllers:@[carousel] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        [self addChildViewController:_pageVC];
        [self.view insertSubview:_pageVC.view atIndex:0];
        _pageVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [_pageVC didMoveToParentViewController:self];
        // Do any additional setup after loading the view.
        self.view.gestureRecognizers = _pageVC.gestureRecognizers;
        UIGestureRecognizer* tapRecognizer = nil;
        for (UIGestureRecognizer* recognizer in _pageVC.gestureRecognizers) {
            if ( [recognizer isKindOfClass:[UITapGestureRecognizer class]] ) {
                tapRecognizer = recognizer;
                break;
            }
        }
        
        if ( tapRecognizer ) {
            [self.view removeGestureRecognizer:tapRecognizer];
            [_pageVC.view removeGestureRecognizer:tapRecognizer];
        }
        
        
        for (UIView *view in _pageVC.view.subviews ) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scroll = (UIScrollView *)view;
                scroll.delegate = self;
            }
        }
        
    }
}
#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[SPCarouselChild class]]) {
        NSUInteger index = ((SPCarouselChild *)viewController).pageIndex;
        if (index == 0) {
            return nil;
        }
        
        index--;
        return [self viewControllerAtIndex:index];
    }
    else
    {
        return nil;
    }
    
    
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ( [ gestureRecognizer isKindOfClass:[ UITapGestureRecognizer class ] ] )
    {
        return NO;
    }
    return YES;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    if ([viewController isKindOfClass:[SPCarouselChild class]])
    {
        NSUInteger index = ((SPCarouselChild *)viewController).pageIndex;
        if (index == [self.arrayPins count]) {
            return nil;
        }
        index++;
        return [self viewControllerAtIndex:index];
    }
    else
    {
        return  nil;
    }
    
}

- (SPCarouselChild *)viewControllerAtIndex:(NSUInteger)index
{
    if (index == [self.arrayPins count]) {
        return nil;
    }
    SPCarouselChild  *carousel = [[UIStoryboard storyboardWithName:@"SPCarousel" bundle:nil] instantiateViewControllerWithIdentifier:@"carouselPage"];
    
    NSString *tourImage = [self.arrayPins objectAtIndex:index];
    carousel.pageIndex = index;
    carousel.imageBack = tourImage;
    
    return carousel;
}

- (void)pageViewController:(UIPageViewController *)viewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"transisiton work");
    if (!completed){return;}
    UIViewController *currentViewController = viewController.viewControllers[0];
    if ([currentViewController isKindOfClass:[SPCarouselChild class]]) {
        SPCarouselChild *vc = (SPCarouselChild *)currentViewController;
        
        [self.paging setCurrentPage:vc.pageIndex];
    }
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
