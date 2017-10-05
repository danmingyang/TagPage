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
        
        [btn buttonWithData:self.upBtnDataArr[i] group:@"up" tag:i];
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
         ChannelBtn *btn = [[ChannelBtn alloc] initWithFrame:CGRectMake((j%self.btnNumber)*btnW+(j%self.btnNumber)*10, b*btnH + b*10 +  [self.upFranmeArr[self.upFranmeArr.count-1] CGRectValue].origin.y+compileLabel.frame.size.height*2, btnW, btnH)];
        [btn buttonWithData:self.belowBtnDataArr[j] group:@"below" tag:j];
        [self.backgroundView addSubview:btn];

        
        [self.belowFranmeArr addObject:[NSValue valueWithCGRect:btn.frame]];
        [self.belowBtnArr addObject:btn];
    }
    
    [self addObserverAction];
}


//编辑
-(void)compileBtn:(UIButton *)btn{
    if (btn.selected){
        NSMutableArray *upBtnText = [NSMutableArray array];
        [self.upBtnArr enumerateObjectsUsingBlock:^(ChannelBtn *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            for (UIImageView *militaryFork in obj.subviews){
                if([militaryFork isKindOfClass:[UIImageView class]]){
                    militaryFork.hidden = YES;
                }
            }
            [upBtnText addObject:obj.titleLabel.text];
        }];
        if (self.dataBlock) {
            self.dataBlock(upBtnText);
        }
    }else{
        [self.upBtnArr enumerateObjectsUsingBlock:^(ChannelBtn *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            for (UIImageView *militaryFork in obj.subviews) {
                if ([militaryFork isKindOfClass:[UIImageView class]]) {
                    militaryFork.hidden = NO;
                }
            }
        }];
    }
    
    btn.selected = !btn.selected;
}

-(void)addObserverAction{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLongPressGestures:) name:k_observer_long_press object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickUpBtn:) name:k_observer_click_up object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickDownBtn:) name:k_observer_click_below object:nil];

}

-(void) handleLongPressGestures:(id)sender{
    //如果不是编辑状态
    if (!self.compileBtn.selected) {
        return;
    }
    static  CGRect viewFrame;

    NSString *btn_tag = [[sender userInfo] objectForKey:@"btn_tag"];
    ChannelBtn *view = [self.upBtnArr objectAtIndex:[btn_tag intValue]-1];

    NSInteger btn_state = [[[sender userInfo] objectForKey:@"btn_state"] integerValue];
    NSValue *btn_location = [[sender userInfo] objectForKey:@"btn_location"];
    CGPoint location = [btn_location CGPointValue];
    
    if (btn_state == UIGestureRecognizerStateBegan){
        [self.backgroundView insertSubview:view atIndex:self.backgroundView.subviews.count-1];
        viewFrame = view.frame;
        CGAffineTransform transform = CGAffineTransformScale(view.transform, 1.2f, 1.2f);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.0f];
        [view setTransform:transform];
        [UIView commitAnimations];
    }
    
    if (btn_state == UIGestureRecognizerStateChanged){
        view.center = location;
        for (int i = 0;i < self.upBtnArr.count; i++){
            ChannelBtn *btn = self.upBtnArr[i];
            if (btn == view)continue;
            if (CGRectContainsPoint(btn.frame, location)){
                [self.upBtnArr removeObject:view];
                [self.upBtnArr insertObject:view atIndex:i];
                [UIView animateWithDuration:0.3 animations:^{
                    [self.upBtnArr enumerateObjectsUsingBlock:^(ChannelBtn *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if(obj != view){
                            obj.frame = [self.upFranmeArr[idx] CGRectValue];
                        }else{
                            viewFrame = [self.upFranmeArr[idx] CGRectValue];
                        }
                    }];
                }];
                break;
            }
        }
    }
    
    if(btn_state == UIGestureRecognizerStateEnded){
        view.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.3 animations:^{
//            view.frame = viewFrame;
        }];
    }
}
-(void)clickUpBtn:(id)sender{
    NSString *btn_tag = [[sender userInfo] objectForKey:@"btn_tag"];
    ChannelBtn *btn = [self.upBtnArr objectAtIndex:[btn_tag intValue]];
    for (UIImageView *militaryFork in btn.subviews) {
        if ([militaryFork isKindOfClass:[UIImageView class]]) {
            militaryFork.hidden = YES;
        }
    }
    
    [btn resetTarget:@"below"];
    
    [self.upBtnArr removeObject:btn];
    [self.upFranmeArr removeObjectAtIndex:self.upFranmeArr.count-1];
    [self.belowBtnArr insertObject:btn atIndex:0];
    [UIView animateWithDuration:0.3 animations:^{
        [self.upBtnArr enumerateObjectsUsingBlock:^(ChannelBtn *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.frame = self.upFranmeArr[idx].CGRectValue;
        }];
    }];
    [self.belowFranmeArr removeAllObjects];
    [UIView animateWithDuration:0.3 animations:^{
        [self.belowBtnArr enumerateObjectsUsingBlock:^(ChannelBtn *obj, NSUInteger j, BOOL * _Nonnull stop) {
            int b = ((int)j/self.btnNumber);
            obj.frame = CGRectMake((j%self.btnNumber)*btnW+(j%self.btnNumber)*10, b*btnH + b*10 +  [self.upFranmeArr[self.upFranmeArr.count-1]CGRectValue].origin.y+100, btnW, btnH);
            [self.belowFranmeArr addObject:[NSValue valueWithCGRect:obj.frame]];
            [self resetBtnTag];
        }];
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.channelLabel.frame = CGRectMake(0, CGRectGetMaxY(self.upFranmeArr[self.upFranmeArr.count-1].CGRectValue), self.channelLabel.frame.size.width, self.channelLabel.frame.size.height);
    }];
    
}
-(void)clickDownBtn:(id)sender{
    NSString *btn_tag = [[sender userInfo] objectForKey:@"btn_tag"];
    ChannelBtn *btn = [self.belowBtnArr objectAtIndex:[btn_tag intValue]];
    if (self.compileBtn.selected) {
        for (UIImageView *militaryFork in btn.subviews) {
            if ([militaryFork isKindOfClass:[UIImageView class]]) {
                militaryFork.hidden = NO;
            }
        }
    }
    [btn resetTarget:@"up"];
    
    [self.belowFranmeArr removeObjectAtIndex:self.belowFranmeArr.count-1];
    [self.belowBtnArr removeObject:btn];
    [self.upBtnArr addObject:btn];
    int i = (int)self.upBtnArr.count-1;
    int a = ((int)i/self.btnNumber);
    [UIView animateWithDuration:0.3 animations:^{
        btn.frame =  CGRectMake((i%self.btnNumber)*btnW+(i%self.btnNumber)*10, a*btnH + a*10, btnW, btnH);
        //NSValue valueWithCGRect
        //NSValue包装CGRect结构
        [self.upFranmeArr addObject:[NSValue valueWithCGRect:btn.frame]];
        self.channelLabel.frame = CGRectMake(0, CGRectGetMaxY(self.upFranmeArr[self.upFranmeArr.count-1].CGRectValue), self.channelLabel.frame.size.width, self.channelLabel.frame.size.height);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        //enumerateObjectsUsingBlock 遍历数组元素
        [self.belowBtnArr enumerateObjectsUsingBlock:^(ChannelBtn *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            int b = ((int)idx/self.btnNumber);
            CGRect btnFrame = self.belowFranmeArr[idx].CGRectValue;
            obj.frame = CGRectMake(btnFrame.origin.x,  b*btnH + b*10 +  [self.upFranmeArr[self.upFranmeArr.count-1]CGRectValue].origin.y+100, btnFrame.size.width, btnFrame.size.height);
            
            [self resetBtnTag];

        }];
    }];
    
}


-(void)resetBtnTag{
    for (int i = 0; i < self.upBtnArr.count; i ++) {
        ChannelBtn *btn = self.upBtnArr[i];
        btn.tag = i;
    }
    for (int i = 0; i < self.belowBtnArr.count; i ++) {
        ChannelBtn *btn = self.belowBtnArr[i];
        btn.tag = i;
    }
}

@end




















