//
//  ChannelView.m
//  dmyTagPage
//
//  Created by dmy on 2017/10/4.
//  Copyright © 2017年 dmy. All rights reserved.
//

#import "ChannelView.h"
#import "ChannelBtn.h"

@interface ChannelView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) NSMutableArray *upBtnArr;
@property (nonatomic, strong) NSMutableArray *belowBtnArr;

@property (nonatomic, strong) NSMutableArray <NSValue*>*upFranmeArr;
@property (nonatomic, strong) NSMutableArray <NSValue*>*belowFranmeArr;

@property (nonatomic, weak) UILabel *channelLabel;
@property (nonatomic, weak) UIButton *compileBtn;

@end

@implementation ChannelView
static CGFloat btnW;
static CGFloat btnH;

-(NSMutableArray *)upBtnArr{
    if(!_upBtnArr){
        _upBtnArr = [NSMutableArray array];
    }
    return _upBtnArr;
}

-(NSMutableArray *)belowBtnArr{
    if(!_belowBtnArr){
        _belowBtnArr = [NSMutableArray array];
    }
    return _belowBtnArr;
}


-(NSMutableArray *)upFranmeArr{
    if (!_upFranmeArr) {
        _upFranmeArr = [NSMutableArray array];
    }
    return _upFranmeArr;
}

-(NSMutableArray *)belowFranmeArr{
    if (!_belowFranmeArr) {
        _belowFranmeArr = [NSMutableArray array];
    }
    return _belowFranmeArr;
}

//即将被添加到父视图上的时候会调用
-(void)willMoveToSuperview:(UIView *)newSuperview{
    if (self.btnNumber == 0) {
        self.btnNumber = 4;
    }
    
    btnW = (self.frame.size.width-20-(self.btnNumber-1)*10)/self.btnNumber;
    btnH = btnW/2;
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.scrollView.backgroundColor = [UIColor colorWithRed:244/255.0f green:245/255.0f blue:246/255.0f alpha:1.0f];
    [self addSubview:self.scrollView];
    
    UILabel *compileLabel = [[UILabel alloc] init];
    compileLabel.text = @"我的频道";
    compileLabel.font = [UIFont systemFontOfSize:15.0f];
    compileLabel.frame = CGRectMake(10, 0, 100, 50);
    [self.scrollView addSubview:compileLabel];
    
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.frame = CGRectMake(10, compileLabel.frame.size.height, self.frame.size.width-20, ((self.upBtnDataArr.count+self.belowBtnDataArr.count)/self.btnNumber)*btnH+10*((self.upBtnDataArr.count+self.belowBtnDataArr.count)/self.btnNumber)+100 + btnH);
    [self.scrollView addSubview:self.backgroundView];
    
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, CGRectGetMaxY(self.backgroundView.frame) + btnH);
    
    UIButton *compileBtn = [[UIButton alloc] init];
    [compileBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [compileBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [compileBtn addTarget:self action:@selector(compileBtn:) forControlEvents:UIControlEventTouchUpInside];
    [compileBtn setTitle:@"完成" forState:UIControlStateSelected];
    compileBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    compileBtn.frame = CGRectMake(self.scrollView.frame.size.width-60, 0, 50, 50);
    [self.scrollView addSubview:compileBtn];
    self.compileBtn = compileBtn;
    
    for(int i = 0; i < self.upBtnDataArr.count; i++){
        int a = (i/self.btnNumber);
        ChannelBtn *btn = [[ChannelBtn alloc] initWithFrame:CGRectMake((i%self.btnNumber)*btnW+(i%self.btnNumber)*10, a*btnH + a*10, btnW, btnH)];
        
        [btn buttonWithData:self.upBtnDataArr[i] group:@"up"];
        [self.backgroundView addSubview:btn];

        [self.upFranmeArr addObject:[NSValue valueWithCGRect:btn.frame]];
        [self.upBtnArr addObject:btn];
    }
    UILabel *channelLabel = [[UILabel alloc]init];
    channelLabel.text = @"频道推荐";
    channelLabel.font = compileLabel.font;
    channelLabel.frame = CGRectMake(0, CGRectGetMaxY(self.upFranmeArr[self.upFranmeArr.count-1].CGRectValue), self.backgroundView.frame.size.width, 100-btnH);
    [self.backgroundView addSubview:channelLabel];
    self.channelLabel = channelLabel;
    
    for(int j = 0; j < self.belowBtnDataArr.count; j++){
        int b = (j/self.btnNumber);
         ChannelBtn *btn = [[ChannelBtn alloc] initWithFrame:CGRectMake((j%self.btnNumber)*btnW+(j%self.btnNumber)*10, b*btnH + b*10 +  [self.upFranmeArr[self.upFranmeArr.count-1]CGRectValue].origin.y+compileLabel.frame.size.height*2, btnW, btnH)];
        [btn buttonWithData:self.belowBtnDataArr[j] group:@"below"];
        [self.backgroundView addSubview:btn];

        
        [self.belowFranmeArr addObject:[NSValue valueWithCGRect:btn.frame]];
        [self.belowBtnArr addObject:btn];
    }
}


//编辑
-(void)compileBtn:(UIButton *)btn{
}

@end




















