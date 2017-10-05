//
//  ChannelBtnView.h
//  dmyTagPage
//
//  Created by dmy on 2017/10/4.
//  Copyright © 2017年 dmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelBtn : UIButton
- (void)buttonWithData:(NSString *)title group:(NSString*) group tag:(int)tag;
-(void)setCloseVisible:(BOOL)visible;
-(void)resetTarget:(NSString*) group;

@end
