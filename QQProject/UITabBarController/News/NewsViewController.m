//
//  NewsViewController.m
//  QQProject
//
//  Created by MAC on 15/12/30.
//  Copyright © 2015年 SYR. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate> {
    NSMutableArray     *_textArr;
    NSMutableArray     *_detialArr;
    NSMutableArray    *_timeArr;
    NSMutableArray     *_dianHuaArr;
    NSMutableArray     *_zongArr;
    UIScrollView *_scrollView;
    UISegmentedControl *_segMent;
    UITableView *_tableView;
    
    CGFloat width;
    CGFloat height;
}




@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     width =[UIScreen mainScreen].bounds.size.width;
     height = [UIScreen mainScreen].bounds.size.height;
   
    _segMent = [[UISegmentedControl alloc]initWithItems:@[@"消息",@"电话"]];
    _segMent.frame = CGRectMake(85, 30, 150, 30);
    _segMent.layer.cornerRadius = 15;
    _segMent.clipsToBounds = YES;
    _segMent.selectedSegmentIndex = 0;
    _segMent.layer.borderColor = [UIColor blueColor].CGColor;
    _segMent.layer.borderWidth = 1;
    
    [_segMent addTarget:self action:@selector(segmentedClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segMent];
    [self createNewsTableView];
    
   
    
    
}
#pragma mark - 消息tableView 的创建
- (void)createNewsTableView {
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, width, height-70-50)];
    [self.view addSubview:_scrollView];
    for (int i = 0; i<2; i++) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(width *i, 0, width, _scrollView.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tag = i+100;
       
//        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToDo:)];
//        longPress.minimumPressDuration = 1.0;
//        [_tableView addGestureRecognizer:longPress];
 [_scrollView addSubview:_tableView];

    }
    
    _scrollView.contentSize = CGSizeMake(width *2, height - 70 -50);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _textArr = @[@"群助手",@"我的电脑",@"QQ手游",@"兴趣号",@"QQ悄悄聊",@"QQ团队"].mutableCopy;
    _detialArr = @[@"支持正版",@"[图片]",@"注册大礼，赶快领取",@"智联招聘",@"查看匿名消息",@"QQ达人的分享"].mutableCopy;
    _timeArr = @[@"20:20",@"21:20",@"08:20",@"20:20",@"09:20",@"20:45"].mutableCopy;
    _dianHuaArr = @[@"电话黄页",@"通讯录"].mutableCopy;
 
}
#pragma mark - 长按按钮
//- (void)longPressToDo:(UILongPressGestureRecognizer *)gesture {
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        CGPoint point =[gesture locationInView:_tableView];
//        NSIndexPath *indesPath = [_tableView indexPathForRowAtPoint:point];
//        if (indesPath == nil) {
//            return;
//        }
//        _tableView.editing = YES;
// 
//        
//    }
//
//   
//
//}


#pragma mark - 多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 100) {
        return _textArr.count;
    }else{
        if (section == 0) {
            return _dianHuaArr.count;
        }else {
        
            return 1;
        }
  }
    
}

#pragma mark - cell的创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"0"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"0"];
    }
    if (tableView.tag == 100) {
        cell.textLabel.text = _textArr[indexPath.row];
        cell.detailTextLabel.text = _detialArr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"xiaoxi%ld.png",indexPath.row + 1]];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(280,0,40,40)];
        label.text = _timeArr[indexPath.row];
        label.font = [UIFont systemFontOfSize:10];
        [cell.contentView addSubview:label];

    }else {
        if (indexPath.section == 0) {
            cell.textLabel.text = _dianHuaArr[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"dianhua%ld.png",indexPath.row + 1]];
        }else {
        
            cell.imageView.image = [UIImage imageNamed:@"41.png"];
  
        }
       
}
    
        return cell;

}

#pragma mark - 删除 置顶按钮
- (nullable NSArray<UITableViewRowAction *>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewRowAction *deleteBtn = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    [_textArr removeObjectAtIndex:indexPath.row];
//    [_detialArr removeObjectAtIndex:indexPath.row];
//    [_timeArr removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    tableView.editing = NO;
    
}];
    UITableViewRowAction *topBtn = [UITableViewRowAction rowActionWithStyle: UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [_textArr exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
     
        NSIndexPath *fristIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:fristIndexPath];
        tableView.editing = NO;
    }];
    return @[deleteBtn,topBtn];


}



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
#pragma mark - 选中某行某列的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
         tableView.editing = YES;
    }else {
    
    
    }
       }
#pragma mark - 自定义表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (101 == tableView.tag) {
        if (0 == section) {
          UIView  *view= [[UIView alloc]initWithFrame:CGRectMake(0, 70, width, 50)];
            view.backgroundColor = [UIColor grayColor];
            UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, width - 10, 40)];
            textField.backgroundColor = [UIColor whiteColor];
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.text = @"🔍搜索";
            textField.textAlignment = NSTextAlignmentCenter;
            textField.delegate = self;
            [view addSubview:textField];
            return view;
    }
    
    }
    return nil;
  
}
#pragma mark - 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        return 80;
    }else {
        if (indexPath.section == 0) {
            return 80;
        }else{
            return 200;
            
        }
        
    }
    
}
#pragma mark - 区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 101) {
        if (0 == section) {
            return 50;
        }else{
            return 40;
        }
        
}
    return 0;
}
#pragma mark - 区头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (101 == tableView.tag) {
        if (1 == section) {
            return @"通话记录";
        }
    }
    return nil;
}
#pragma mark - scrollView与选项卡同步
- (void)segmentedClick:(UISegmentedControl *)segment {
    if (segment.selectedSegmentIndex == 0) {
        
        _scrollView.contentOffset = CGPointMake(0, 0);
    }else {
    
    _scrollView.contentOffset = CGPointMake(width, 0);
    }
    

}
#pragma mark - 选项卡与scrollView同步
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 320) {
        _segMent.selectedSegmentIndex = 1;
    }else {
    _segMent.selectedSegmentIndex = 0;
    }

}
#pragma mark - 区头个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (101 == tableView.tag) {
        return 2;
    }
    return 1;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
textField.text = @"";
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
