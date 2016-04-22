//
//  ChatViewController.m
//  QQProject
//
//  Created by MAC on 16/1/1.
//  Copyright © 2016年 SYR. All rights reserved.
//

#import "ChatViewController.h"
#import "CustomView.h"
#import "People.h"
#import "LianXiRenViewController.h"
@interface ChatViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    CGFloat _width;
    CGFloat _height;
    UIToolbar *_toolBar;
    UITextField *_textField;
    UITableView *_tableView;
    NSMutableArray   *_textArr;
    
}

@end

@implementation ChatViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.title = _nameStr;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"< 消息" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
 
}
- (void)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _textArr = @[].mutableCopy;
    
    [self createTableView];
    [self createBottomToolBar];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeKeyBoard:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
#pragma mark - 通知方法
- (void)changeKeyBoard:(NSNotification *)notifi{
    NSDictionary *dic = notifi.userInfo;
    CGRect rect = [dic[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    if (_toolBar.frame.origin.y < _height -70) {
        _toolBar.frame = CGRectMake(0, _height - 70, _width, _toolBar.bounds.size.height);
        _tableView.frame = CGRectMake(0, 64, _width, _height - 70);
    }else {
    
    _toolBar.frame = CGRectMake(0, rect.origin.y - 70 , _width, _toolBar.bounds.size.height);
        _tableView.frame = CGRectMake(0, 64, _width, _height - 70 - rect.size.height);
    }
    
    
}



#pragma mark - tableView初始化
- (void)createTableView {
    _width =[UIScreen mainScreen].bounds.size.width;
    _height = [UIScreen mainScreen].bounds.size.height;
   _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height - 70) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

}
#pragma mark - 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _textArr.count;
}
#pragma mark - cell的创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    People *p = _textArr[indexPath.row];
    NSArray *arr = cell.contentView.subviews;
    for (UIView *view in  arr) {
        [view removeFromSuperview];
    }
    CustomView *customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100) withPeople:p];
    [cell.contentView addSubview:customView];
    return cell;

}

#pragma mark - toolBar的创建
- (void)createBottomToolBar {
     _toolBar= [[UIToolbar alloc]initWithFrame:CGRectMake(0, _height - 70, _width, 70)];
    [self.view addSubview:_toolBar];
    _toolBar.backgroundColor = [UIColor greenColor];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, 240, 50)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.delegate = self;
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:_textField];
    UIButton *senderBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    senderBtn.frame = CGRectMake(260, 10, 60, 50);
    [senderBtn setTitle:@"发送" forState:UIControlStateNormal];
    [senderBtn addTarget:self action:@selector(senderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:senderBtn];
    _toolBar.items = @[item1,item2];
    

}
#pragma mark - 发送按钮的点击事件
- (void)senderBtnClick:(UIButton *)sender{
    People *p = [[People alloc]init];
    p.isMe = arc4random()%2 ? YES : NO;
    p.text = _textField.text;
    CGRect rect = [p.text boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    p.textSize = rect.size;
    [_textArr addObject:p];
    [_tableView reloadData];
   
 
    NSIndexPath *path = [NSIndexPath indexPathForRow:_textArr.count - 1 inSection:0];
    [_tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
_textField.text = @"";


}

#pragma mark - 行高的设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    People *p = _textArr[indexPath.row];
    return p.textSize.height + 100;

}




- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
