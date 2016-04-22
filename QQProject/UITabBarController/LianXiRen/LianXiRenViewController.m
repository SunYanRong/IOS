//
//  LianXiRenViewController.m
//  QQProject
//
//  Created by MAC on 15/12/30.
//  Copyright © 2015年 SYR. All rights reserved.
//

#import "LianXiRenViewController.h"
#import "PersonalViewController.h"
#import "ChatViewController.h"
@interface LianXiRenViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {
    NSMutableArray   *_titleArr;
    NSMutableArray   *_friendArr;
    NSMutableArray  *_familyArr;
    NSMutableArray  *_classmateArr;
    NSMutableArray   *_otherArr;
    NSMutableArray   *_xinQingArr;
    NSMutableArray  *_stateArr;
    
    UITableView *_tableView;
    
    CGFloat _width;
    CGFloat _height;
    
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@end

@implementation LianXiRenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _width =[UIScreen mainScreen].bounds.size.width;
    _height = [UIScreen mainScreen].bounds.size.height;
    
    

    [self createMiddleTableView];
}

#pragma mark - textField 的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.text = @"";
    return YES;
    
}
#pragma mark - tableView 的创建
- (void)createMiddleTableView {
    _titleArr = @[@"我的好友",@"我的家人",@"大学同学",@"陌生人"].mutableCopy;
    _friendArr = @[@"Top",@"Box",@"John",@"Lily",@"Mary"].mutableCopy;
    _familyArr = @[@"春儿",@"冰儿",@"雪儿",@"天儿"].mutableCopy;
    _classmateArr = @[@"马云",@"范冰冰",@"马建林",@"刘诗诗",@"唐嫣"].mutableCopy;
    _otherArr = @[@"Jobs"].mutableCopy;
    _xinQingArr = @[@"2016 又是新的一年",@"新的一年，好好奋斗",@"一不小心，一年又过去了",@"元旦快乐",@"ƒƒƒƒƒ今天运势真好",@"快要过年了",@"Happy NewYear",@"又有新电影了",@"柯南终于更新了",@"hello word!",@"2016 又是新的一年",@"新的一年，好好奋斗",@"一不小心，一年又过去了",@"元旦快乐",@"ƒƒƒƒƒ今天运势真好",@"快要过年了",@"Happy NewYear",@"又有新电影了",@"柯南终于更新了",@"hello word!"].mutableCopy;
    _stateArr = @[@"NO",@"NO",@"NO",@"NO"].mutableCopy;
    _addButton.layer.cornerRadius = 11;
    _addButton.clipsToBounds = YES;
    _deleteBtn.layer.cornerRadius = 11;
    _addButton.clipsToBounds = YES;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, _width, _height - 100) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView];

    
    _tableView.tableHeaderView = [self createHeaderView];
    
}
#pragma mark - 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *str = _stateArr[section];
    if ([str isEqualToString:@"YES"]) {
        switch (section) {
            case 0:
                return _friendArr.count;
                break;
            case 1:
                return _familyArr.count;
                break;
            case 2:
                return _classmateArr.count;
                break;
            case 3:
                return _otherArr.count;
                break;
            default:
                return 0;
                break;
        }

    }else {
        return 0;
    }
   }
#pragma mark - cell的创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"0"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"0"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = _friendArr[indexPath.row];
        cell.detailTextLabel.text = _xinQingArr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",indexPath.row]];
       
    }else if(indexPath.section == 1){
        cell.textLabel.text = _familyArr[indexPath.row];
        cell.detailTextLabel.text = _xinQingArr[indexPath.row + _friendArr.count];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",indexPath.row + _friendArr.count]];

    }else if(indexPath.section == 2){
        cell.textLabel.text = _classmateArr[indexPath.row];
        cell.detailTextLabel.text = _xinQingArr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",indexPath.row + _familyArr.count + _friendArr.count]];
    }else {
    
        cell.textLabel.text = _otherArr[indexPath.row];
        cell.detailTextLabel.text = @"😢😊";
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",indexPath.row + _familyArr.count + _friendArr.count + _classmateArr.count]];
    }
  
    
    cell.imageView.layer.cornerRadius = 22;
    cell.imageView.clipsToBounds = YES;
    return cell;
}


#pragma mark - 返回多少区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
       return _titleArr.count;
}


#pragma mark - 区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
    
}
#pragma mark - 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 40)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 60, 40);
    [button setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = section +100;
    [view addSubview:button];
    NSString *str = _stateArr[section];
    if ([str isEqualToString:@"NO"]) {
        button.transform = CGAffineTransformMakeRotation(0);
    } else {
         button.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(button.bounds.size.width + 10, 0, _width - button.bounds.size.width - 10, 40)];
    label.text = _titleArr[section];
    
    [view addSubview:label];
    return view;
}
#pragma mark - 区头button的点击事件
- (void)buttonClick:(UIButton *)sender {
    NSString *str = _stateArr[sender.tag - 100];
    if ([str isEqualToString:@"NO"]) {
        [_stateArr replaceObjectAtIndex:sender.tag - 100 withObject:@"YES"];
    } else {
        [_stateArr replaceObjectAtIndex:sender.tag - 100 withObject:@"NO"];
    }
    [_tableView reloadData];
}
#pragma mark - 自定义表头
- (UIView *)createHeaderView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 140)];
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, _width-10, 40)];
    textField.text = @"🔍搜索";
     textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor lightGrayColor];
    textField.delegate = self;
    [view addSubview:textField];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(20 + i%4*80, 50, 40, 50);
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"buddy%d.png",i]] forState:UIControlStateNormal];
        [view addSubview:button];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15 + i%4*80, 95, 50, 30)];
        NSArray *arr = @[@"新朋友",@"特别关心",@"群组",@"公众号"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.text = arr[i];
        [view addSubview:label];
    }
    UILabel *QQLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, _width, 20)];
    QQLabel.text = @"QQ好友";
    [view addSubview:QQLabel];
    return view;
}
#pragma mark - 点击某一行触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
       
      PersonalViewController *personalVC = [[PersonalViewController alloc]init];
    personalVC.indexPath = indexPath;
    switch (indexPath.section) {
        case 0:
            personalVC.nameLabel = _friendArr[indexPath.row];
            
            break;
        case 1:
            personalVC.nameLabel = _familyArr[indexPath.row];
            break;
        case 2:
            personalVC.nameLabel = _classmateArr[indexPath.row];
            break;
        case 3:
            personalVC.nameLabel = _otherArr[indexPath.row];
            break;
        default:
            break;
    }
   
    NSLog(@"%@",personalVC.nameLabel);
    
        [self.navigationController pushViewController:personalVC animated:YES];

}

#pragma mark - cell的移动
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
   
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;

}
#pragma mark - 添加button的点击事件
- (IBAction)addButtonClick:(UIButton *)sender {

        sender.selected = !sender.selected;
        if (sender.selected) {
            _tableView.editing = YES;
        }else {
            _tableView.editing = NO;
       
        }
    
}
#pragma mark - cell的编辑风格
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleInsert;


}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        switch (indexPath.section) {
            case 0:
                [_friendArr insertObject:@"冰冰" atIndex:indexPath.row];
                [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
                break;
            case 1:
                [_familyArr insertObject:@"冰冰" atIndex:indexPath.row];
                [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
                break;
            case 2:
                [_classmateArr insertObject:@"冰冰" atIndex:indexPath.row];
                [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
                break;
            case 3:
                [_otherArr insertObject:@"冰冰" atIndex:indexPath.row];
                [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
                break;


            default:
                break;
        }
    }


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
