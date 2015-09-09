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
#import "AFHTTPRequestOperationManager.h"
#import "UserIDBC.h"
#import "UserID/UserIDDataModels.h"
#import "taskDataModels.h"
#import "tasktask.h"
#import "UIImageView+WebCache.h"
#import "taskData.h"

@interface NoticeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISegmentedControl *_segment;
    UIScrollView *_scrollView;
    NSMutableArray *_imageArray;
    NSMutableArray *array;
    NSMutableArray *_arr;
    NSMutableArray *_Arr;
    tasktask *task;
    tasktask *task1;
    
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
    NSLog(@";;;;;;;;;%@;;;;;;;;;",self.userId);
    [self GETinformation];
    _imageArray = [[NSMutableArray alloc]initWithObjects:@"1.png",@"2.png", nil];

    _segment = [[UISegmentedControl alloc] initWithItems:@[@"通告广场",@"我的通告"]];
    _segment.tintColor = [UIColor colorWithRed:1.0f green:0.2f blue:0.7f alpha:1.0];
    _segment.frame = CGRectMake(0, 0, 120, 30);
    _segment.selectedSegmentIndex = 0;
    [_segment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segment;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *url = [NSString stringWithFormat:@"http://10.0.1.11/task"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"-------  %@",operation.responseString);
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
                //            NSLog(@"_____%@222222222222",arr);
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,667-49)];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tag = 0;
            [tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"noticeCell"];
            tableView.rowHeight = 100;
            [self.view addSubview:tableView];

            task = [[tasktask alloc]initWithDictionary:dict];
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"+++++++  %@",error);
        }];

//    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,667-49)];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    tableView.tag = 0;
//    [tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"noticeCell"];
//    tableView.rowHeight = 100;
//    [self.view addSubview:tableView];
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
    if (tableView.tag == 0) {
        return task.data.count;

    }else{
        return task1.data.count;
    }
    
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
    }if (tableView.tag == 0) {
        cell.photoImageView.backgroundColor = [UIColor redColor];
        cell.photoImageView.clipsToBounds = YES;
        cell.photoImageView.layer.cornerRadius = 40;
        [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[[task.data objectAtIndex:indexPath.row] valueForKey:@"imgUri"]]];
        cell.titleLabel.text = [[task.data objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.dateLabel.text = [[task.data objectAtIndex:indexPath.row] valueForKey:@"workTime"];
        cell.stateLabel.text = @"报名中";
        cell.priceLabel.text = [[task.data objectAtIndex:indexPath.row] valueForKey:@"price"];;
        cell.AreaLabel.text = [[task.data objectAtIndex:indexPath.row] valueForKey:@"address"];
        [cell.photoImageView addSubview:cell.imageLabel];
    }else{
        cell.photoImageView.backgroundColor = [UIColor redColor];
        cell.photoImageView.clipsToBounds = YES;
        cell.photoImageView.layer.cornerRadius = 40;
        [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[[task1.data objectAtIndex:indexPath.row] valueForKey:@"imgUri"]]];
        cell.titleLabel.text = [[task1.data objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.dateLabel.text = [[task1.data objectAtIndex:indexPath.row] valueForKey:@"workTime"];
        cell.stateLabel.text = @"已报名";
        cell.priceLabel.text = [[task1.data objectAtIndex:indexPath.row] valueForKey:@"price"];;
        cell.AreaLabel.text = [[task1.data objectAtIndex:indexPath.row] valueForKey:@"address"];
        [cell.photoImageView addSubview:cell.imageLabel];

    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0) {
        MyNoticeViewController *mvc = [[MyNoticeViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        mvc.title = [[task.data objectAtIndex:indexPath.row]valueForKey:@"title"];
        taskData *data = [task.data objectAtIndex:indexPath.row];
        NSLog(@".........%@",data);
        mvc.id = data.dataIdentifier;
        NSLog(@"%@",mvc.id);
        [self.navigationController pushViewController:mvc animated:NO];
    }else{
//        NoticeDetailViewController *dvc = [[NoticeDetailViewController alloc]init];
//        dvc.title = [[task1.data objectAtIndex:indexPath.row]valueForKey:@"title"];
//        taskData *data1 = [task1.data objectAtIndex:indexPath.row];
//        dvc.id = data1.dataIdentifier;
//        [self.navigationController pushViewController:dvc animated:NO];
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
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *url = [NSString stringWithFormat:@"http://10.0.1.11/task"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"-------  %@",operation.responseString);
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
            //            NSLog(@"_____%@222222222222",arr);
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,667-49)];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tag = 0;
            [tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"noticeCell"];
            tableView.rowHeight = 100;
            [self.view addSubview:tableView];
            
            task = [[tasktask alloc]initWithDictionary:dict];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"+++++++  %@",error);
        }];

        }else{
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *url = [NSString stringWithFormat:@"http://10.0.1.11/user/%@/taskinfo",self.userId];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
            [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"-------  %@",operation.responseString);
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
                //            NSLog(@"_____%@222222222222",arr);
                UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,667-49)];
                tableView.delegate = self;
                tableView.dataSource = self;
                tableView.tag = 1;
                [tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"noticeCell"];
                tableView.rowHeight = 100;
                tableView.separatorStyle = UITableViewCellAccessoryNone;
                [self.view addSubview:tableView];
                
                task1 = [[tasktask alloc]initWithDictionary:dict];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"+++++++  %@",error);
            }];

    }
}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    int i = scrollView.contentOffset.x / 375;
//    _segment.selectedSegmentIndex = i;
//}
- (void)GETinformation
{
//    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
//    NSString *url = [NSString stringWithFormat:@"http://api.emwcn.com/user"];
//    manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    [manager1 GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //        NSLog(@"-------  %@ -----------",operation.responseString);
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
//        NSArray *array222 = [dict objectForKey:@"data"];
//        //        NSLog(@"___++++%ld++++____",array222.count);
//        for (NSArray *arr in array222) {
//            array = [[NSMutableArray alloc]initWithCapacity:0];
//            //            NSLog(@"____%@_++++++______",dict);
//            //            EMWUser *user = [EMWUser parseUserWithDictionary:dict];
//            [array addObject:arr];
//            [_Arr addObject:array];
//            NSLog(@"------%@=======",array);
//            NSLog(@"+++++++%@+++++++",[array objectAtIndex:0]);
//            AFHTTPRequestOperationManager *manager2 = [AFHTTPRequestOperationManager manager];
//            NSString *url1 = [NSString stringWithFormat:@"http://api.emwcn.com/user/%@",[array objectAtIndex:0]];
//            manager2.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//            [manager2 GET:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
//             {
//                 NSLog(@"-------  %@ 646656565",operation.responseString);
//                 NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
//                 
//                 task = [[taskInfotask alloc]initWithDictionary:dict1];
//                 [_arr addObject:task];
//                 NSLog(@"_______%@_______",_arr);
////                 NSLog(@"--==%@==---",baseBc.data.);
////                 NSLog(@"--++%lf==",baseBc.data.businessInfo.inPrice);
////                 NSLog(@"-----------%@-------------",baseBc.data.baseInfo.nickName);
//                 UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,667-49)];
//                 tableView.delegate = self;
//                 tableView.dataSource = self;
//                 tableView.tag = 0;
//                 [tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"noticeCell"];
//                 tableView.rowHeight = 100;
//                 [self.view addSubview:tableView];
//             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                 NSLog(@"+++++++  %@+++++++++++",error);
//             }];
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"+++++++  %@+++++++++++",error);
//    }];
    
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
