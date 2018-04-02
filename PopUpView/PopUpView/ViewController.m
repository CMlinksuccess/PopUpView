//
//  ViewController.m
//  PopUpView
//
//  Created by ECOOP on 2018/3/30.
//  Copyright © 2018年 ECOOP－09. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+PopUpView.h"

@interface ViewController ()

@property (nonatomic, assign)BOOL isPop;

@property (nonatomic, strong)UIView *botView1;

@property (nonatomic, strong)UIView *botView2;

@property (nonatomic, strong)UIView *botView3;

@end

@implementation ViewController

-(UIView *)botView1{
    if (_botView1 == nil) {
        _botView1 = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 300)];
        _botView1.backgroundColor = [UIColor redColor];
    }
    return _botView1;
}

-(UIView *)botView2{
    if (_botView2 == nil) {
        _botView2 = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 300)];
        _botView2.backgroundColor = [UIColor greenColor];
    }
    return _botView2;
}

-(UIView *)botView3{
    if (_botView3 == nil) {
        _botView3 = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 300)];
        _botView3.backgroundColor = [UIColor blueColor];
    }
    return _botView3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //三个弹框按钮
    for (NSInteger i = 1; i <= 3; i ++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(150, 150 * i , 100, 50)];
        [btn setTitle:[NSString stringWithFormat:@"弹框%ld",(long)i] forState:UIControlStateNormal];
        btn.tag = 10000 + i;
        btn.backgroundColor = [UIColor blackColor];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    
    //三个页面的关闭按钮
    for (NSInteger i = 1; i <= 3; i ++) {
        
        UIButton *cancle = [[UIButton alloc] initWithFrame:CGRectMake(60 * i, 0, 60, 60)];
        [cancle setTitle:@"关闭" forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 1: [self.botView1 addSubview:cancle];
                break;
            case 2: [self.botView2 addSubview:cancle];
                break;
            case 3: [self.botView3 addSubview:cancle];
                break;
            default:
                break;
        }
        
    }
}


- (void)click:(UIButton *)btn{
    
    UIView *view = nil;
    switch (btn.tag - 10000) {
        case 1:
            view = self.botView1;
            break;
        case 2:
            view = self.botView2;
            break;
        case 3:
            view = self.botView3;
            break;
        default:
            break;
    }
    [self popUpView:view];
    self.isPop = YES;
    [self setNeedsStatusBarAppearanceUpdate];

}

//设置状态栏
-(BOOL)prefersStatusBarHidden{
    return self.isPop;
}

//重写hideView方法添加隐藏状态栏
-(void)hideView{
    [super hideView];
    self.isPop = NO;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
