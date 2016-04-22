//
//  DongTaiViewController.m
//  QQProject
//
//  Created by MAC on 15/12/30.
//  Copyright © 2015年 SYR. All rights reserved.
//

#import "DongTaiViewController.h"
#import "InternetViewController.h"
@interface DongTaiViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    CGFloat _width;
    CGFloat _height;
    NSArray    *_textArr;
    NSArray    *_imageArr;
    NSArray    *_internetArr;
}

@end


@implementation DongTaiViewController
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//       self.navigationController.navigationBarHidden = YES;
//    
//}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
      self.navigationController.navigationBarHidden = YES;
}
//    [self.navigationController.navigationBar sendSubviewToBack:self.view];
//   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:  UIBarButtonSystemItemOrganize target:self action:@selector(goback:)];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:  UIBarButtonSystemItemOrganize target:self action:@selector(goback:)];
//
//    
//}
- (void)goback:(UIBarButtonItem *)sender{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createTableView];
    
}
#pragma mark - 行数

- (void)createTableView {
    _width =[UIScreen mainScreen].bounds.size.width;
    _height = [UIScreen mainScreen].bounds.size.height;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, _width, _height -100) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableHeaderView = [self createHeaderView];
    _textArr = @[@"游戏",@"音乐",@"附近的群",@"腾讯新闻"];
    _imageArr = @[[UIImage imageNamed:@"game.png"],[UIImage imageNamed:@"music.png"],[UIImage imageNamed:@"fujin.png"],[UIImage imageNamed:@"tengxun.png"]];
    _internetArr = @[@"www.3g.game.com",@"www.3g.yinyue.com"];
}

#pragma mark - 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
#pragma mark - cell的创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"l"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"l"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = _textArr[indexPath.row];
        cell.imageView.image = _imageArr[indexPath.row];
    }else {
        cell.textLabel.text = _textArr[indexPath.row + 2];
        cell.imageView.image = _imageArr[indexPath.row + 2];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}
#pragma mark - 自定义表头
- (UIView *)createHeaderView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 160)];
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, _width-10, 40)];
    textField.text = @"🔍搜索";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor lightGrayColor];
    textField.delegate = self;
    [view addSubview:textField];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(35 + i%3*100,45,  50, 55);
        button.backgroundColor = [UIColor whiteColor];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"found%d.png",i]] forState:UIControlStateNormal];
        [view addSubview:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30 + i%3*100, 105, 60, 30)];
        NSArray *arr = @[@"好友动态",@"附近",@"兴趣部落"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.text = arr[i];
        [view addSubview:label];
    }
    
    return view;
}
#pragma mark - 上面三个button的点击事件
- (void)buttonClick:(UIButton *)sender {
    
    
    self.navigationController.navigationBarHidden = NO;
    InternetViewController *internetVC = [[InternetViewController alloc]init];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [internetVC.view addSubview:webView];
     [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.3g.qq.com"]]];
    [self.navigationController pushViewController:internetVC animated:YES];
   
}

#pragma mark - 区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

#pragma mark - 区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
#pragma mark - 行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

#pragma mark - textField的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.text = @"";
    return YES;
    
}

#pragma mark - 选中某行某列的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InternetViewController *internetVC = [[InternetViewController alloc]init];
//    NSLog(@"%@",internetVC.view.backgroundColor);
//   internetVC.view.backgroundColor = [UIColor redColor];
//     NSLog(@"%@",internetVC.view.backgroundColor);
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [internetVC.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:internetVC animated:YES];
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
