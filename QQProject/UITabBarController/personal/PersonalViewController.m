//
//  PersonalViewController.m
//  QQProject
//
//  Created by MAC on 16/1/1.
//  Copyright © 2016年 SYR. All rights reserved.
//

#import "PersonalViewController.h"
#import "ChatViewController.h"
#import "LianXiRenViewController.h"
#import "CustomView.h"
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource> {
    CGFloat _width;
    CGFloat _height;
    NSArray     *_leftTextArr;
    NSArray     *_userArr;
 
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PersonalViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"个人资料";
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _width =[UIScreen mainScreen].bounds.size.width;
    _height = [UIScreen mainScreen].bounds.size.height;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = [self createHeaderTable];
    _leftTextArr = @[@"账号消息",@"个性签名",@"手机信息",@"专享特权",@"QQ空间"];
 
}
#pragma mark - 自定义表头
- (UIView *)createHeaderTable {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 220)];
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, 140)];
    topImageView.image = [UIImage imageNamed:@"1.jpg"];
    [view addSubview:topImageView];
  
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 150, 60, 60)];
    switch (_indexPath.section) {
        case 0:
            image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",_indexPath.row]];
            break;
        case 1:
            image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",_indexPath.row + 5]];
            break;
        case 2:
            image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",_indexPath.row + 9]];
            break;
        case 3:
            image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",_indexPath.row + 14]];
            break;

            
        default:
            break;
    }
    
    image.layer.cornerRadius = 30;
    image.clipsToBounds = YES;
    [view addSubview:image];
    
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(80, 140, 200, 70)];
    lable.text = [NSString stringWithFormat:@"      %@\n年龄   性别  地址",_nameLabel];
    lable.adjustsFontSizeToFitWidth = YES;
    lable.numberOfLines = 0;
    [view addSubview:lable];
    return view;




}

#pragma mark - 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _leftTextArr.count;

}
#pragma mark - cell的创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"0"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0"];
    }
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 34)];
    leftLabel.text = _leftTextArr[indexPath.row];
    leftLabel.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:leftLabel];
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;



}


#pragma mark - 发送消息的点击事件
- (IBAction)senderBtnClick:(UIButton *)sender {
    ChatViewController *chatVC = [[ChatViewController alloc]init];
    chatVC.nameStr = _nameLabel;

    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark - QQ电话的点击事件
- (IBAction)QQBtnClick:(UIButton *)sender {
    
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
