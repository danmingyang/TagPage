//
//  ChannelView.h
//  dmyTagPage
//
//  Created by dmy on 2017/10/4.
//  Copyright © 2017年 dmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelView : UIView
//上边数组
@property (nonatomic,strong) NSArray *upBtnDataArr;
//下边数组
@property (nonatomic,strong) NSArray *belowBtnDataArr;
//每行个数
@property (nonatomic,assign) int btnNumber;
//按钮字体大小
@property (nonatomic, assign) CGFloat btnTextFont;
//返回调整好的标签数组
@property (nonatomic,copy) void(^dataBlock) (NSMutableArray <NSString *>*dataArr);

@end
