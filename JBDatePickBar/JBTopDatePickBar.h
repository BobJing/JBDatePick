//
//  JBTopDatePickBar.h
//  YiXueChe
//
//  Created by Bob on 16/12/22.
//  Copyright © 2016年 HaiHong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JBTopDatePickBar;

@protocol JBTopDatePickBarDelegate <NSObject>

- (void)JBTopDatePickBarDidSelectedDate:(JBTopDatePickBar *)pickBar withDate:(NSDate *)date;

@end
@interface JBTopDatePickBar : UIView


@property (nonatomic, retain) NSDate *currentDate;
@property (nonatomic, assign) id<JBTopDatePickBarDelegate> delegate;
@end
