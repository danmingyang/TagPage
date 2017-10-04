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
    
    [self setCloseVisible:NO];
    
    [self addSubview:militaryFork];
    
    
    return self;
}

- (void)buttonWithData:(NSString *)title group:(NSString*) group
{
    [self setTitle:title forState:UIControlStateNormal];
    if([group isEqualToString:@"below"]){
        //@selector 有参数加: 没有不加
        [self addTarget:self action:@selector(clickDownBtn) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self addTarget:self action:@selector(clickUpBtn) forControlEvents:UIControlEventTouchUpInside];
        
        //添加长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(handleLongPressGestures:)];
        longPress.numberOfTouchesRequired = 1;
        longPress.allowableMovement = 100.0f;
        longPress.minimumPressDuration = 1.0;
        [self addGestureRecognizer:longPress];
        
    }
    return ;
}

-(void)setCloseVisible:(BOOL)visible{
    if (militaryFork){
        militaryFork.hidden = !visible;
    }
}

-(void)clickDownBtn{
    
}

-(void)clickUpBtn{
    
}

-(void)handleLongPressGestures:(UILongPressGestureRecognizer *)paramSender{
    
}

@end
