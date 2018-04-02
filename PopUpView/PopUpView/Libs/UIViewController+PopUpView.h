//
//  UIViewController+PopUpView.h
//  PopUpView
//
//  Created by ECOOP on 2018/3/30.
//  Copyright © 2018年 ECOOP－09. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PopUpView)


/**
   调用该方法即弹出视图

 @param view 下方弹出视图
 */
- (void)popUpView:(UIView *)view;


/**
   手动设置隐藏弹框
 */
- (void)hideView;




/**
    ⚠️注意：
          内部默认缩小背景原视图为控制器的self.view，若需修改，可自行添加参数view修改内部代码
 */
@end


