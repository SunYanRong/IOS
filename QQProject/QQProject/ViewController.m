//
//  ViewController.m
//  QQProject
//
//  Created by MAC on 15/12/30.
//  Copyright © 2015年 SYR. All rights reserved.
//

#import "ViewController.h"
#import "RegisterByVoiceCallViewController.h"
#import "DengLuViewController.h"
@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIButton *dengLuBtn;
@property (weak, nonatomic) IBOutlet UIButton *yongHuButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDengLuJieMian];
}
- (void)initDengLuJieMian{
    self.navigationController.navigationBarHidden = YES;
    _imageView.frame = CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height);
    _dengLuBtn.frame = CGRectMake(30, self.view.bounds.size.height, 102, 103);
    _dengLuBtn.layer.cornerRadius = 10;
    _dengLuBtn.clipsToBounds = YES;
    _dengLuBtn.layer.borderColor = [UIColor grayColor].CGColor;
    _dengLuBtn.layer.borderWidth = 3;
    _yongHuButton.frame = CGRectMake(self.view.bounds.size.width - 132, self.view.bounds.size.height, 102, 43);
    _yongHuButton.layer.cornerRadius = 10;
    _yongHuButton.clipsToBounds = YES;
    
    
    [UIView animateWithDuration:0.2 animations:^{
        _imageView.frame = CGRectMake(0, -30, self.view.bounds.size.width, self.view.bounds.size.height);
        _dengLuBtn.frame = CGRectMake(30, self.view.bounds.size.height - 70, 102, 43);
        _yongHuButton.frame = CGRectMake(self.view.bounds.size.width - 132, self.view.bounds.size.height - 70, 102, 43);
        
    }];
 
}
#pragma mark - 新用户按钮的点击事件
- (IBAction)newUserBtnClick:(UIButton *)sender {
    RegisterByVoiceCallViewController *regVC = [[RegisterByVoiceCallViewController alloc]init];
    [self.navigationController pushViewController:regVC animated:YES];
}
#pragma mark - 登录按钮的点击事件
- (IBAction)enterBtnClick:(UIButton *)sender {
    DengLuViewController *dengLuVC = [[DengLuViewController alloc]init];
    self.view.window.rootViewController = dengLuVC;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
