//
//  ChatViewController.m
//  e-Model
//
//  Created by 魏众 on 15/8/5.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "ChatViewController.h"
#import "UIImageView+WebCache.h"
@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_bubbleArray;
    UIView *_inputView;
    UITextField *_textField;
}
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, retain)NSArray *headImageURLArray;
@property (nonatomic, retain)NSMutableDictionary *unreadDictionary;
@end

@implementation ChatViewController

static NSString *cellIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = [NSString stringWithFormat:@"与%@交谈中",self.userName];
    // 数组用来装 所有的气泡
    _bubbleArray = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-40)];
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    //拖动表格 键盘下去
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    // 注册单元格用什么类型 已经重用标示符
    // 告诉系统帮我创建单元格的时候 用哪种类型
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_tableView];
    _inputView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height+26, self.view.frame.size.width, 40)];
    [self.view addSubview:_inputView];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 40)];
    imageView.image = [UIImage imageNamed:@"chatinputbg.png"];
    [_inputView addSubview:imageView];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, 260, 30)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.clipsToBounds = YES;
    _textField.layer.cornerRadius = 10;
    [_inputView addSubview:_textField];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(275, 5, 50, 30);
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:1.0f green:0.2f blue:0.7f alpha:1.0] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_inputView addSubview:button];
    UIButton *addbtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    addbtn.frame = CGRectMake(335, 5, 30, 30);
    addbtn.tintColor = [UIColor colorWithRed:1.0f green:0.2f blue:0.7f alpha:1.0];
    [_inputView addSubview:addbtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveUp:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveDown) name:UIKeyboardWillHideNotification object:nil];
    [self showUnreadChatInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showUnreadChatInfo) name:@"newInfo" object:nil];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}
#pragma mark -
#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bubbleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *bubbleView = [_bubbleArray objectAtIndex:indexPath.row];
    return bubbleView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 出列一个可以重用的单元格,如果又可以重用的,那么就直接重用,如果没有,系统会按照你注册时填写的类型帮你创建一个
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 如果有老的  就把老的气泡移除掉
    [[cell viewWithTag:10] removeFromSuperview];
    
    UIView *bubbleView = [_bubbleArray objectAtIndex:indexPath.row];
    [cell addSubview:bubbleView];
    
    return cell;
}

- (void)sendButtonClick:(UIButton *)button
{
    //发送聊天信息
    
    if ([_textField.text isEqualToString:@""] || _textField.text == nil)
    {
        return;
    }
    
    // 拼接内容
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM-dd HH:mm:ss"];
    
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    NSString *string = [NSString stringWithFormat:@"在%@说:\n%@",dateString,_textField.text];
    NSLog(@"string   %@",string);
    
    
//    [ZYHttpManager sendChatRequestWithFriendName:self.userName chatInfo:string completionBlock:^(BOOL isSuccessed, NSString *errorMessage)
//     {
//         if (isSuccessed)
//         {
//             [self showChatInfo:string isSelf:YES];
//             // 清空字符串
//             _textField.text = @"";
//         }
//         else
//         {
//             SHOWALERT(errorMessage)
//         }
//     }];

}


// 显示上个界面传过来  以及 在有新消息的时候及时显示 的未读消息
- (void)showUnreadChatInfo
{
    // 从大字典中 获取 当前聊天的这个人所发来的未读消息
    NSMutableArray *unreadArray = [self.unreadDictionary objectForKey:self.userName];
    
    for (NSString *string in unreadArray)
    {
        [self showChatInfo:string isSelf:NO];
    }
    
    // 显示之后就清空掉
    [unreadArray removeAllObjects];
}
// 把 文字  显示到表中
- (void)showChatInfo:(NSString *)chatInfo isSelf:(BOOL)isSelf
{
    // 1,根据所说的话 去创建气泡 view
    UIView *bubbleView = [self creatBubbleWithChatInfo:chatInfo isSelf:isSelf];
    
    // 2,把气泡这个view 放数组中
    [_bubbleArray addObject:bubbleView];
    
    // 3,刷新表
    [_tableView reloadData];
    
    // 4,滚到最后一行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_bubbleArray.count - 1 inSection:0];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
// 创建气泡view
- (UIView *)creatBubbleWithChatInfo:(NSString *)chatInfo isSelf:(BOOL)isSelf
{
    // 计算文字的高度
    CGRect rect = [chatInfo boundingRectWithSize:CGSizeMake(160, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    float height = ceilf(rect.size.height);
    
    // label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(isSelf ? 10 : 60, 15, 160, height)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = chatInfo;
    label.numberOfLines = 0;
    
    // imageView
    NSString *imageName = isSelf ? @"bubbleSelf" : @"bubble";
    UIImage *oldImage = [UIImage imageNamed:imageName];
    
    // 可拉伸的图片
    UIImage *newImage = [oldImage stretchableImageWithLeftCapWidth:25 topCapHeight:20];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(isSelf ? 0 : 50, 5, 180, height + 20)];
    imageView.image = newImage;
    
    // 头像
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(isSelf ? 185 : 5, 5, 40, 40)];

    [headImageView sd_setImageWithURL:[NSURL URLWithString:isSelf ? self.headImageURLArray[0] : self.headImageURLArray[1]] placeholderImage:[UIImage imageNamed:@"head"]];
    headImageView.layer.cornerRadius = 20;
    headImageView.clipsToBounds = YES;
    
    // 最外层的容器view
    UIView *bubbleView = [[UIView alloc] initWithFrame:CGRectMake(isSelf ? 90 : 0, 0, 230, height + 30)];
    bubbleView.tag = 10;
    return bubbleView;
}
// 点击键盘上return键  让输入框结束编辑
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    
    
    
    
    return YES;
}

// 系统在给我们发通知的时候 会传一个参数过来
- (void)moveUp:(NSNotification *)notification
{
    NSLog(@"上去");
    
    //要调整view的位置
    // 需要知道不同输入时键盘的高度
    
    NSDictionary *dict = notification.userInfo;
    NSLog(@"dict   %@",dict);
    
    // 数组 或者 字典中  只能放对象
    // 基本数据类型或者结构体 怎么放到数组(字典)中呢?
    // NSNumber  把基本数据类型 转化为 对象
    // NSValue   把结构体 转化为 对象
    NSValue *value = [dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         _inputView.frame = CGRectMake(0, rect.origin.y - 40, 375, 40);
         _tableView.frame = CGRectMake(0, 0, 375, rect.origin.y - 40);
         
         // 让表变小的同时 滚动到最后一行
         
         //  至少有一个单元格的时候 才滚动 ,没有单元格不需要滚动
         if (_bubbleArray.count > 0)
         {
             NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_bubbleArray.count - 1 inSection:0];
             [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
         }
         
     } completion:nil];
}

- (void)moveDown
{
    NSLog(@"下来");
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         _inputView.frame = CGRectMake(0, 627, 375, 40);
         _tableView.frame = CGRectMake(0, 0, 375, 667 - 40);
     } completion:nil];
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
