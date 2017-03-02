//
//  JBTopDatePickBar.m
//  YiXueChe
//
//  Created by Bob on 16/12/22.
//  Copyright © 2016年 HaiHong. All rights reserved.
//

#import "JBTopDatePickBar.h"
#import "DateTools.h"
#import "XFDaterView.h"
@interface JBTopDatePickBar()<XFDaterViewDelegate>{
    XFDaterView*dater;
}

@property (nonatomic, retain) UIButton *leftBtn;
@property (nonatomic, retain) UIButton *rightBtn;
@property (nonatomic, retain) UILabel *centerLB;
@end

@implementation JBTopDatePickBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:71/255.0 green:173/255.0 blue:230/255.0 alpha:1];
        self.currentDate = [NSDate date];
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, width*0.2, height);
        [_leftBtn setTitle:@"前一天" forState:UIControlStateNormal];
        [self addSubview:_leftBtn];
        [_leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];

        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(width*0.8, 0, width*0.2, height);
        [_rightBtn setTitle:@"后一天" forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
        [_rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];

        _centerLB = [[UILabel alloc]initWithFrame:CGRectMake(width*0.2, 0, 0.6*width, height)];
        _centerLB.text = [self.currentDate formattedDateWithFormat:@"YYYY-MM-dd"];
        _centerLB.textAlignment = 1;
        _centerLB.textColor = [UIColor whiteColor];
        [self addSubview:_centerLB];
        _centerLB.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerClick)];
        [_centerLB addGestureRecognizer:tap];

        dater=[[XFDaterView alloc]initWithFrame:CGRectZero];
        dater.delegate=self;
        [dater setSelectYear:(int)self.currentDate.year
                       month:(int)self.currentDate.month
                         day:(int)self.currentDate.day
                    animated:YES];

    }
    return self;
}


- (void)leftClick
{
    self.currentDate  = [self.currentDate dateBySubtractingDays:1];
    [dater setSelectYear:(int)self.currentDate.year
                   month:(int)self.currentDate.month
                     day:(int)self.currentDate.day
                animated:YES];
    if ([_delegate respondsToSelector:@selector(JBTopDatePickBarDidSelectedDate:withDate:)]) {
        [_delegate JBTopDatePickBarDidSelectedDate:self withDate:self.currentDate];
    }
}

- (void)rightClick
{
    self.currentDate  = [self.currentDate dateByAddingDays:1];
    [dater setSelectYear:(int)self.currentDate.year
                   month:(int)self.currentDate.month
                     day:(int)self.currentDate.day
                animated:YES];
    if ([_delegate respondsToSelector:@selector(JBTopDatePickBarDidSelectedDate:withDate:)]) {
        [_delegate JBTopDatePickBarDidSelectedDate:self withDate:self.currentDate];
    }

}

- (void)centerClick
{
    [dater showInView:[[UIApplication sharedApplication].delegate window] animated:YES];

}

- (void)setCurrentDate:(NSDate *)currentDate
{
    _currentDate = currentDate;
    _centerLB.text = [currentDate formattedDateWithFormat:@"YYYY-MM-dd"];

}


#pragma mark - delegate
- (void)daterViewDidClicked:(XFDaterView *)daterView{
    self.currentDate = [NSDate dateWithYear:dater.year month:dater.month day:dater.day];
    if ([_delegate respondsToSelector:@selector(JBTopDatePickBarDidSelectedDate:withDate:)]) {
        [_delegate JBTopDatePickBarDidSelectedDate:self withDate:self.currentDate];
    }
}
- (void)daterViewDidCancel:(XFDaterView *)daterView{

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
