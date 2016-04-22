//
//  DengLuViewController.m
//  QQProject
//
//  Created by MAC on 15/12/30.
//  Copyright © 2015年 SYR. All rights reserved.
//

#import "DengLuViewController.h"
#import "NewsViewController.h"
#import "LianXiRenViewController.h"
#import "DongTaiViewController.h"

@interface DengLuViewController (){
   
}

@property (weak, nonatomic) IBOutlet UITextField *zhangHaoTextField;
@property (weak, nonatomic) IBOutlet UITextField *miMaTextField;

@end

@implementation DengLuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}
#pragma mark - 登录按钮的点击事件
- (IBAction)loginButtonClick:(UIButton *)sender {
    if ([_zhangHaoTextField.text isEqualToString:@""] && [_miMaTextField.text isEqualToString:@""]) {
        UITabBarController *tabBarControl = [[UITabBarController alloc]init];
        NewsViewController *newsVC = [[NewsViewController alloc]init];
        newsVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"消息" image:[UIImage imageNamed:@"tab_recent_press@3x.png"] tag:100];
        LianXiRenViewController *lianXiVC = [[LianXiRenViewController alloc]init];
        lianXiVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"联系人" image:[UIImage imageNamed:@"tab_buddy_press@3x.png"] tag:101];
        DongTaiViewController *dongTaiVC = [[DongTaiViewController alloc]init];
        
        dongTaiVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"动态" image:[UIImage imageNamed:@"tab_buddy_press@3x.png"] tag:102];
        tabBarControl.viewControllers = @[newsVC,lianXiVC,dongTaiVC];
       UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:tabBarControl];
        nav.navigationBarHidden = YES;
        self.view.window.rootViewController = nav;
    }else {
        [self initMiddleAlertController];
       }
    
 }
#pragma mark - 警示框的初始化
- (void)initMiddleAlertController{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"账号不存在" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *enterBtn = [UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:nil];
    [alertController addAction:enterBtn];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - 忘记密码按钮的点击事件
- (IBAction)forgetButtonClick:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *duanXin = [UIAlertAction actionWithTitle:@"短信验证" style: UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    [alertController addAction:duanXin];
    
    UIAlertAction *youXiang = [UIAlertAction actionWithTitle:@"邮箱验证" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:youXiang];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancle];
    [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - 新用户按钮的点击事件
- (IBAction)newUserButtonClick:(UIButton *)sender {
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
