//
//  WZJScrollView.m
//  aiqiyi
//
//  Created by 魏志军 on 2018/3/20.
//  Copyright © 2018年 魏志军. All rights reserved.
//

#import "WZJScrollView.h"

@interface WZJScrollView ()<UIScrollViewDelegate>
{
    UIScrollView *lunboScrollView;
    UIImageView *leftImageView;
    UIImageView *middleImageView;
    UIImageView *rightImageView;
    NSTimer *timer;
    UIPageControl *pageControl;
    
    NSInteger currentIndex;
    NSInteger count;
    
}

@end
@implementation WZJScrollView
static const int viewNumber = 3;
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        currentIndex = 0;
        
    }
    return self;
}

- (void)setImageArr:(NSArray *)imageArr
{
    _imageArr = imageArr;
    count = _imageArr.count;
    [self creatScrollView];
    [self creatTimer];
    [self creatpageControl];
}
- (void)creatpageControl
{
    
}
- (void)creatScrollView
{
    lunboScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    lunboScrollView.pagingEnabled = YES;
    lunboScrollView.bounces = YES;
    lunboScrollView.backgroundColor = [UIColor redColor];
    lunboScrollView.showsVerticalScrollIndicator = NO;
    lunboScrollView.showsHorizontalScrollIndicator = NO;
    lunboScrollView.delegate = self;
    lunboScrollView.contentSize = CGSizeMake(viewNumber*self.frame.size.width, self.frame.size.height);
    [self addSubview:lunboScrollView];
    
    leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    leftImageView.image = [UIImage imageNamed:_imageArr[count -1]];
    
    middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
    middleImageView.image = [UIImage imageNamed:_imageArr[0]];
    rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    rightImageView.image = [UIImage imageNamed:_imageArr[1]];
    [lunboScrollView addSubview:leftImageView];
    [lunboScrollView addSubview:middleImageView];
    [lunboScrollView addSubview:rightImageView];
    
    //设置偏移量
    lunboScrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    
    
}
- (void)creatTimer
{
    __weak typeof(self)weakself = self;
   timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    timer = [NSTimer timerWithTimeInterval:2.f repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakself timerAction];
    }];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)timerAction
{
        [lunboScrollView scrollRectToVisible:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:YES];
}

- (void)invalidateTimer
{
    [timer invalidate];
    timer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 2*self.frame.size.width) {
        //滑到最右边的时候
        currentIndex++;
        //重置内容
        [self resetImage];
    }else if (scrollView.contentOffset.x == 0)
    {
        if (currentIndex == 0) {
            currentIndex = count -1;
        }else
        {
            currentIndex--;
            
        }
        [self resetImage];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 2*self.frame.size.width) {
        //滑到最右边的时候
        currentIndex++;
        //重置内容
        [self resetImage];
    }

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //准备拖动时定时器失效
    
    [self invalidateTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //停止拖动的时候，定时器生效
    [self creatTimer];
}
- (void)resetImage
{
    if (currentIndex == 0)
    {
        leftImageView.image = [UIImage imageNamed:_imageArr[(count-1)%count]];
    }else
    {
    leftImageView.image = [UIImage imageNamed:_imageArr[(currentIndex-1)%count]];
    }
    
    middleImageView.image = [UIImage imageNamed:_imageArr[(currentIndex)%count]];
    
    rightImageView.image = [UIImage imageNamed:_imageArr[(currentIndex+1)%count]];
    lunboScrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    
}
@end
