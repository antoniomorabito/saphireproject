//
//  SPHomeVC.m
//  SapphireProject
//
//  Created by mac on 26/12/18.
//  Copyright © 2018 telkom. All rights reserved.
//

#import "SPHomeVC.h"

@interface SPHomeVC ()

@end

@implementation SPHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //Set Main Cell in Collection View
    [self.collectionView registerNib:[UINib nibWithNibName:@"SPHomeCell" bundle:nil] forCellWithReuseIdentifier:@"menucell"];
    
    [self.collectionView reloadData];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark : Collection View Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    
    
}

- (SPHomeMenuCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SPHomeMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menucell" forIndexPath:indexPath];
    
    //Add your cell Values here
    
    return cell;
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




