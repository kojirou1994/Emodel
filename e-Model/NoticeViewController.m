//
//  NoticeViewController.m
//  e-Model
//
//  Created by 魏众 on 15/7/21.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
#import "NoticeDetailViewController.h"
#import "MyNoticeViewController.h"
@interface NoticeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISegmentedControl *_segment;
    UIScrollView *_scrollView;
    NSMutableArray *_imageArray;
}
@end

@implementation NoticeViewController
-(void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _imageArray = [[NSMutableArray alloc]initWithObjects:@"1.png",@"2.png", nil];

    _segment = [[UISegmentedControl alloc] initWithItems:@[@"通告广场",@"我的通告"]];
    _segment.tintColor = [UIColor colorWithRed:1.0f green:0.2f blue:0.7f alpha:1.0];
    _segment.frame = CGRectMake(0, 0, 120, 30);
    _segment.selectedSegmentIndex = 0;
    [_segment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segment;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,667-49)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 0;
    [tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"noticeCell"];
    tableView.rowHeight = 100;
    [self.view addSubview:tableView];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(rightItemClick)];
    rightItem.tintColor = [UIColor colorWithRed:1.0f green:0.2f blue:0.7f alpha:1.0];
    self.navigationItem.rightBarButtonItem = rightItem;
//    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 375, 554)];
//    _scrollView.delegate = self;
//    _scrollView.contentSize = CGSizeMake(375 * 2, 667-64 );
//    _scrollView.pagingEnabled = YES;
//    _scrollView.showsHorizontalScrollIndicator = NO;
//    [self.view addSubview:_scrollView];
    //右边的item
    //    for (int i = 0; i<2; i++) {
//        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i*375, 0, self.view.frame.size.width,667-49)];
//        tableView.delegate = self;
//        tableView.dataSource = self;
//        tableView.tag = i;
//        [tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"noticeCell"];
//        tableView.rowHeight = 100;
//        [_scrollView addSubview:tableView];
//    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        return 150;
    }else
    {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 150)];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:headerView.frame];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(375 * 2, 150 );
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i<2; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*375, 0, 375, 150)];
        NSString* imageName = [NSString stringWithFormat:@"%d.png",i];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
    }
    [headerView addSubview:scrollView];
    return headerView;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noticeCell"];
    if (cell!=nil) {
        [cell removeFromSuperview];
    }
    cell.photoImageView.backgroundColor = [UIColor redColor];
    cell.photoImageView.clipsToBounds = YES;
    cell.photoImageView.layer.cornerRadius = 40;
    cell.photoImageView.image = [UIImage imageNamed:@"123.png"];
    cell.titleLabel.text = @"皮草拍摄外拍50件";
    cell.dateLabel.text = @"7月10日上午";
    cell.stateLabel.text = @"报名中";
    cell.priceLabel.text = @"80元一件";
    cell.AreaLabel.text = @"杭州基地拍摄";
    [cell.photoImageView addSubview:cell.imageLabel];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0) {
        MyNoticeViewController *mvc = [[MyNoticeViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mvc animated:NO];
    }else{
        NoticeDetailViewController *dvc = [[NoticeDetailViewController alloc]init];
        [self.navigationController pushViewController:dvc animated:NO];
    }
    
}
- (void)rightItemClick
{
    
}
- (void)segmentChanged:(UISegmentedControl *)segment
{
//    NSLog(@"当前选中了第 %ld 个",_segment.selectedSegmentIndex);
//    NSInteger i = _segment.selectedSegmentIndex;
//    [_scrollView setContentOffset:CGPointMake(self.view.frame.size.width * i, 0) animated:YES];
    if (segment.selectedSegmentIndex == 0) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,667-49)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 0;
        [tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"noticeCell"];
        tableView.rowHeight = 100;
        [self.view addSubview:tableView];

        }else{
        UITableView *tabelView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-49)];
        tabelView1.delegate = self;
        tabelView1.dataSource = self;
        tabelView1.tag = 1;
        [tabelView1 registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"noticeCell"];
        tabelView1.rowHeight = 100;
        [self.view addSubview:tabelView1];

    }
}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    int i = scrollView.contentOffset.x / 375;
//    _segment.selectedSegmentIndex = i;
//}

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
