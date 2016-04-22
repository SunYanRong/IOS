//
//  CustomView.m
//  QQProject
//
//  Created by MAC on 16/1/1.
//  Copyright © 2016年 SYR. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView
- (id)initWithFrame:(CGRect)frame withPeople:(People *)p{
    self = [super init];
 
    if (self) {
        if (p.isMe) {
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(width - 60, 10, 50, 50)];
     
            headerImageView.image = _arr[1];
            
            headerImageView.layer.cornerRadius = 25;
            headerImageView.clipsToBounds = YES;
            [self addSubview:headerImageView];
            UIImageView *chatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(width - headerImageView.bounds.size.width - 220, headerImageView.bounds.size.height - 70, 220, p.textSize.height + 80)];
            chatImageView.image = [UIImage imageNamed:@"right.png"];
            [self addSubview:chatImageView];
            
            UILabel *chatLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, chatImageView.bounds.size.width - 80, chatImageView.bounds.size.height - 40)];
            chatLabel.text = p.text;
            chatLabel.numberOfLines = 0;
            chatLabel.font = [UIFont systemFontOfSize:17];
            [chatImageView addSubview:chatLabel];
            
        }else {
            
            UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 50, 50)];
            headerImageView.image = [UIImage imageNamed:@"13.png"];
            headerImageView.layer.cornerRadius = 25;
            headerImageView.clipsToBounds = YES;
            [self addSubview:headerImageView];
            UIImageView *chatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, headerImageView.bounds.size.height - 70, 220, p.textSize.height + 80)];
            
            chatImageView.image = [UIImage imageNamed:@"9.png"];
            [self addSubview:chatImageView];
            
            UILabel *chatLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, chatImageView.bounds.size.width - 80, chatImageView.bounds.size.height - 40)];
            chatLabel.text = p.text;
            chatLabel.numberOfLines = 0;
            chatLabel.font = [UIFont systemFontOfSize:17];
            [chatImageView addSubview:chatLabel];
            
            
        }
        
        
    }

    return self;





}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
