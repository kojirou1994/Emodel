//
//  MainViewController.m
//  e-Model
//
//  Created by 魏众 on 15/7/20.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "MainViewController.h"
#import "Header.h"
#import "MainCollectionViewCell.h"
@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_buttonTitleArray;
    UIView *_headerView;
    UIView *_modelCardView;
    UICollectionView *_collectionView;
    UIScrollView *_scrollView1;
    UIScrollView *_scrollView2;
    int _currentIndex;
    UIImageView *_imageView1;
    UIImageView *_imageView2;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _buttonTitleArray = @[@"女模",@"男模",@"童模",@"外籍女模",@"外籍男模",@"大龄模特"];
    //左边的item
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"seachBar_button"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    //右边的item
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"download_button"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    //选项卡
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"头像",@"模卡"]];
    _segment.tintColor = [UIColor colorWithRed:1.0f green:0.2f blue:0.7f alpha:1.0];
    _segment.frame = CGRectMake(0, 0, 120, 30);
    _segment.selectedSegmentIndex = 0;
    [_segment addTarget:self action:@selector(segmentChanged) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segment;
    // scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 375, 667)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(375 * 2, 667 );
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    _scrollView1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, 375, 554)];
    _scrollView1.delegate = self;
    _scrollView1.contentSize = CGSizeMake(375 * 6, 554 );
    _scrollView1.pagingEnabled = YES;
    _scrollView1.showsHorizontalScrollIndicator = NO;
    _scrollView1.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:_scrollView1];
    _scrollView2 = [[UIScrollView alloc]initWithFrame:CGRectMake(375, 40, 375, 554)];
    _scrollView2.delegate = self;
    _scrollView2.contentSize = CGSizeMake(375 * 6, 554 );
    _scrollView2.pagingEnabled = YES;
    _scrollView2.showsHorizontalScrollIndicator = NO;
    _scrollView2.backgroundColor = [UIColor yellowColor];
    [_scrollView addSubview:_scrollView2];
    for (int i = 0; i<2; i++) {
//        _segment.selectedSegmentIndex = i;
        if (i == 0) {
            UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
            [_scrollView addSubview:toolbar];
            _imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10,35, 50, 3)];
            _imageView1.backgroundColor = [UIColor colorWithRed:1.0f green:0.2f blue:0.7f alpha:1.0];
            [toolbar addSubview:_imageView1];
            for (int p=0; p<6; p++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(10+(60*p), 5, 50, 30);
                button.tag = p;
                button.backgroundColor = [UIColor clearColor];
                [button setTitle:_buttonTitleArray[p] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont  systemFontOfSize:12];
                [button addTarget:self action:@selector(modelCardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [toolbar addSubview:button];
                UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
                _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(375*p, 0, 375, 554) collectionViewLayout:layout];
                _collectionView.dataSource = self;
                _collectionView.delegate = self;
                _collectionView.backgroundColor = [UIColor whiteColor];
                [_collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
                [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];

                [_scrollView1 addSubview:_collectionView];
                
            }
        }
        else
        {
            UIToolbar *toolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(375, 0, 375, 40)];
            [_scrollView addSubview:toolbar1];
            _imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 35, 50, 3)];
            _imageView2.backgroundColor = [UIColor colorWithRed:1.0f green:0.2f blue:0.7f alpha:1.0];
            [toolbar1 addSubview:_imageView2];
            for (int j=0; j<6; j++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(10+(60*j), 5, 50, 30);
                button.tag = j;
                button.backgroundColor = [UIColor clearColor];
                [button setTitle:_buttonTitleArray[j] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont  systemFontOfSize:12];
                [button addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [toolbar1 addSubview:button];
                UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
                _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(375*j, 0, 375, 554) collectionViewLayout:layout];
                _collectionView.dataSource = self;
                _collectionView.delegate = self;
                _collectionView.backgroundColor = [UIColor whiteColor];
                [_collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
                [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
                
                [_scrollView2 addSubview:_collectionView];


            }
        }
    }
    
}
//搜索按钮
- (void)leftItemClick
{
    SeachViewController *search = [[SeachViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}
//上传按钮
- (void)rightItemClick
{
    
}

- (void)segmentChanged
{
    NSLog(@"当前选中了第 %ld 个",_segment.selectedSegmentIndex);
    NSInteger i = _segment.selectedSegmentIndex;
    [_scrollView setContentOffset:CGPointMake(self.view.frame.size.width * i, 0) animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int i = scrollView.contentOffset.x / 375;
//    _segment.selectedSegmentIndex = i;
    _imageView1.frame = CGRectMake(10+(60*i), 35, 50, 3);
    _imageView2.frame = CGRectMake(10+(60*i), 35, 50, 3);
    
}
- (void)modelCardButtonClick:(UIButton *)button
{
    NSLog(@"________%ld_______",button.tag);
    [_scrollView1 setContentOffset:CGPointMake(375 * button.tag, 0) animated:YES];
    _imageView1.center = CGPointMake(button.center.x, _imageView1.center.y);
}
- (void)headButtonClick:(UIButton *)button
{
    NSLog(@"________%ld_______",button.tag);
    [_scrollView2 setContentOffset:CGPointMake(375 * button.tag, 0) animated:YES];
    _imageView2.center = CGPointMake(button.center.x, _imageView2.center.y);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 30;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"cell";
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    if (!cell)
    {
        NSLog(@"无法创建CollectionViewCell时打印, 自定义的cell就不可能进来.");
    }

    cell.backgroundColor = [UIColor redColor];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = self.view.frame.size.width/3-20 ;
    return CGSizeMake(width, 140);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 5, 10);
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
