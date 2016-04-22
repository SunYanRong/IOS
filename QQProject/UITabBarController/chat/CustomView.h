//
//  CustomView.h
//  QQProject
//
//  Created by MAC on 16/1/1.
//  Copyright © 2016年 SYR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "People.h"
#import "LianXiRenViewController.h"
@interface CustomView : UIView
@property (nonatomic,strong)NSMutableArray *arr;
- (id)initWithFrame:(CGRect)frame withPeople:(People *)p;
@end
