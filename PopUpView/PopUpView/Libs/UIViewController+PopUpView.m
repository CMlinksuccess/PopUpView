//
//  UIViewController+PopUpView.m
//  PopUpView
//
//  Created by ECOOP on 2018/3/30.
//  Copyright © 2018年 ECOOP－09. All rights reserved.
//

#import "UIViewController+PopUpView.h"
#import <objc/runtime.h>

#define Scale        0.90        //0~1
#define AnimateTime  0.30        //动画时长
#define ViewTag      101010100   //内部tag基数，请勿冲突


@implementation UIViewController (PopUpView)

-(void)popUpView:(UIView *)view{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    view.tag = ViewTag + 2;
    CGRect frame = view.frame;
    frame.origin.y = window.bounds.size.height;
    view.frame = frame;
    [window addSubview:view];
    [self showView:YES];
}


- (void)hideView{
    
    [self showView:NO];
    
}

- (void)showView:(BOOL)isShow {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *bgView = [window viewWithTag:ViewTag + 1];
    UIView *bottomView = [window viewWithTag:ViewTag + 2];
    if (isShow) {
        if (bgView == nil) {
            
            bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            bgView.backgroundColor = [UIColor grayColor];
            bgView.alpha = 0.3;   //调整遮罩透明度
            bgView.tag = ViewTag + 1;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
            [bgView addGestureRecognizer:tap];
        }
        
        [UIView animateWithDuration:AnimateTime animations:^{
            bgView.userInteractionEnabled = NO;
            [window addSubview:bgView];
            [window addSubview:bottomView];
            CATransform3D transform = CATransform3DIdentity;
            transform.m24 = -0.3/1000.0;  //调整动画弹性
            self.view.layer.transform = CATransform3DScale(transform, Scale, Scale, 1.0);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:AnimateTime animations:^{
                bottomView.transform = CGAffineTransformMakeTranslation(0, -bottomView.frame.size.height);
                CATransform3D transform = CATransform3DIdentity;
                self.view.layer.transform = CATransform3DScale(transform, Scale, Scale, 1);
                bgView.userInteractionEnabled = YES;
            }];
        }];
    }else{
        [UIView animateWithDuration:AnimateTime animations:^{
            [bgView removeFromSuperview];
            self.view.layer.transform = CATransform3DIdentity;
            bottomView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            bottomView.tag = 0;
        }];
        
    }
    
}



@end
