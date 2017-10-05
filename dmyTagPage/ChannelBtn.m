//
//  ChannelBtnView.m
//  dmyTagPage
//
//  Created by dmy on 2017/10/4.
//  Copyright © 2017年 dmy. All rights reserved.
//

#import "ChannelBtn.h"

@interface ChannelBtn()
{
    UIImageView *militaryFork;
}
- (void)setCloseVisible:(BOOL) visible;

@end

@implementation ChannelBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithRed:215/255.0f green:215/255.0f blue:215/255.0f alpha:1.0].CGColor;
    self.backgroundColor = [UIColor whiteColor];
    self.frame = frame;
    self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    militaryFork = [[UIImageView alloc]init];
    CGFloat militaryForkWH = self.frame.size.width*0.25;
    militaryFork.layer.masksToBounds = YES;
    militaryFork.layer.cornerRadius = militaryForkWH/2;
    militaryFork.frame = CGRectMake(self.frame.size.width-militaryForkWH+2, -2, militaryForkWH, militaryForkWH);
    militaryFork.image = [UIImage imageNamed:@"close"];
    militaryFork.hidden = YES;
        
    [self addSubview:militaryFork];
    
    
    return self;
}

- (void)buttonWithData:(NSString *)title group:(NSString*) group tag:(int) tag
{
    [self setTitle:title forState:UIControlStateNormal];
    self.tag = tag;
    
    if([group isEqualToString:@"below"]){
        //@selector 有参数加: 没有不加
        [self addTarget:self action:@selector(clickDownBtn) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self addTarget:self action:@selector(clickUpBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [self addLongPress];
    }
    return ;
}
-(void)addLongPress{
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(handleLongPressGestures:)];
    longPress.numberOfTouchesRequired = 1;
    longPress.allowableMovement = 100.0f;
    longPress.minimumPressDuration = 1.0;
    [self addGestureRecognizer:longPress];
}
-(void)resetTarget:(NSString*) group{
    if([group isEqualToString:@"below"]){
        [self removeTarget:self action:@selector(clickUpBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [self removeGestureRecognizer:self.gestureRecognizers[0]];
        
        [self addTarget:self action:@selector(clickDownBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        [self removeTarget:self action:@selector(clickDownBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [self addLongPress];
        [self addTarget:self action:@selector(clickUpBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}
-(void)clickDownBtn{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:10];
    //向词典中动态添加数据
    [dictionary setObject:[NSString stringWithFormat: @"%ld", (long)self.tag] forKey:@"btn_tag"];
    [[NSNotificationCenter defaultCenter] postNotificationName:k_observer_click_below object:nil userInfo: dictionary];
}

-(void)clickUpBtn{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:10];
    //向词典中动态添加数据
    [dictionary setObject:[NSString stringWithFormat: @"%ld", (long)self.tag] forKey:@"btn_tag"];
      [[NSNotificationCenter defaultCenter] postNotificationName:k_observer_click_up object:nil userInfo: dictionary];
}

-(void)handleLongPressGestures:(UILongPressGestureRecognizer *)paramSender{
    UIView *view = paramSender.view;
    NSInteger state = paramSender.state;
    CGPoint location = [paramSender locationInView:paramSender.view.superview];

    NSLog(@"ssssss:%ld" , state);
    NSLog(@"tag:%ld" , view.tag);

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:10];
    //向词典中动态添加数据
    [dictionary setObject:@"up" forKey:@"btn_group"];
    [dictionary setObject:[NSString stringWithFormat: @"%ld", (long)view.tag] forKey:@"btn_tag"];
    [dictionary setObject:[NSString stringWithFormat: @"%ld", (long)state] forKey:@"btn_state" ];
    [dictionary setObject:[NSValue valueWithCGPoint:location] forKey:@"btn_location"];
    

    [[NSNotificationCenter defaultCenter] postNotificationName:k_observer_long_press object:nil userInfo: dictionary];
}

@end
