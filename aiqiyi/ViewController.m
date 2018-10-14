//
//  ViewController.m
//  aiqiyi
//
//  Created by 魏志军 on 2018/3/20.
//  Copyright © 2018年 魏志军. All rights reserved.
//

#import "ViewController.h"
#import "WZJScrollView.h"
#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})


//状态栏高度
#define HitoStatusHeight [UIApplication sharedApplication].statusBarFrame.size.height
//导航栏高度
#define HitoNavHeight 44
//顶部高度
#define HitoTopHeight (HitoStatusHeight+HitoNavHeight)
//底部高度
#define TabbarHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
//iPhoneX安全区域高度
#define HitoSafeAreaHeight (HitoStatusHeight>20?34:0)
//底部高度
#define HitoBottomHeight (49+HitoSafeAreaHeight)
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (@available(iOS 11.0, *)) {
        WZJScrollView *wzj = [[WZJScrollView alloc] initWithFrame:CGRectMake(0, HitoStatusHeight,[UIScreen mainScreen].bounds.size.width, 200)];
        wzj.imageArr = @[@"0",@"1",@"2",@"3",@"4"];
        [self.view addSubview:wzj];
    } else {
        // Fallback on earlier versions
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
