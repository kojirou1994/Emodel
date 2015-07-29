//
//  MainViewController.m
//  e-Model
//
//  Created by 魏众 on 15/7/20.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "MainViewController.h"
#import "Header.h"
@interface MainViewController ()
{
    NSArray *_buttonTitleArray;
    UIView *_headerView;
    UIView *_modelCardView;
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
    if (_segment.selectedSegmentIndex == 0)
    {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 375, 554)];
        _headerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_headerView];
        UIToolbar *toolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
        toolbar1.backgroundColor = [UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0];
        [_headerView addSubview:toolbar1];
//        _buttonTitleArray = @[@"女模",@"男模",@"童模",@"外籍女模",@"外籍男模",@"大龄模特"];
        for (int i = 0;i<6;i++){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10+(60*i), 5, 50, 30);
            button.tag = i;
            button.backgroundColor = [UIColor clearColor];
            [button setTitle:_buttonTitleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont  systemFontOfSize:12];
            [button addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [toolbar1 addSubview:button];
        }
    }
    [_segment addTarget:self action:@selector(segmentChanged) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segment;
    // scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(320 * 2, 480 - 64 - 49);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    
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
    NSLog(@"当前选中了第 %d 个",_segment.selectedSegmentIndex);
    
    int i = _segment.selectedSegmentIndex;
        [_scrollView setContentOffset:CGPointMake(320 * i, -64) animated:YES];
    if (i == 1) {
     
        _modelCardView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 375, 554)];
        _modelCardView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_modelCardView];
        UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
        [_modelCardView addSubview:toolbar];
        for (i=0; i<6; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10+(60*i), 5, 50, 30);
            button.tag = i;
            button.backgroundColor = [UIColor clearColor];
            [button setTitle:_buttonTitleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont  systemFontOfSize:12];
            [button addTarget:self action:@selector(modelCardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [toolbar addSubview:button];
        }
    }
    else
    {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 375, 554)];
        _headerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_headerView];
        UIToolbar *toolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
        [_headerView addSubview:toolbar1];
        for (i=0; i<6; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10+(60*i), 5, 50, 30);
            button.tag = i;
            button.backgroundColor = [UIColor clearColor];
            [button setTitle:_buttonTitleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont  systemFontOfSize:12];
            [button addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [toolbar1 addSubview:button];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int i = scrollView.contentOffset.x / 320;
    _segment.selectedSegmentIndex = i;
    if (i == 1) {
        UIView *modelCardView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 375, 554)];
        modelCardView.backgroundColor = [UIColor redColor];
        [self.view addSubview:modelCardView];
    }
}
- (void)modelCardButtonClick:(UIButton *)button
{
    switch (button.tag) {
        case 0:
        {
            UIView *womanView = [[UIView alloc]initWithFrame:_headerView.frame];
            womanView.backgroundColor = [UIColor blueColor];
            [_headerView addSubview:womanView];
        }
            break;
            
        default:
            break;
    }
}
- (void)headButtonClick:(UIButton *)button
{
    
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
