//
//  PhotoGrid.m
//  PhotoBrowser
//
//  Created by 李震 on 16/8/22.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import "LZPhotoGrid.h"
#import "UIImageView+WebCache.h"
#import "EPhotoBrowser.h"

@interface LZPhotoGrid ()<EPhotoBrowserDelegate>

@end

@implementation LZPhotoGrid

#pragma mark - 1、初始化控件------
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加9个子控件
        [self setUpAllChildView];
    }
    return self;
}

// 添加9个子控件
- (void)setUpAllChildView
{
    for (int i = 0; i < 9; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.userInteractionEnabled = YES;
        imageV.tag = i;
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        [self addSubview:imageV];
    }
}

#pragma mark - 点击图片的时候调用
- (void)tap:(UITapGestureRecognizer *)tap
{
    
    UIImageView *tapView = (UIImageView *)tap.view;
    EPhotoBrowser *browserVc = [[EPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self; // 原图的父控件
    browserVc.imageCount = _picUrls.count; // 图片总数
    browserVc.currentImageIndex = (int)tapView.tag;
    browserVc.delegate = self;
    
    [[self findViewController] presentViewController:browserVc animated:NO completion:nil];
}

#pragma mark - photobrowser代理方法
- (UIImage *)photoPlaceholderImageForIndex:(NSInteger)index
{
    UIImageView * imageView = (UIImageView *)self.subviews[index];
    return imageView.image;
}

- (NSURL *)photoHighQualityImageURLForIndex:(NSInteger)index
{
    return [NSURL URLWithString:_picUrls[index]];
}

- (UIViewController *)findViewController
{
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

- (void)setPicUrls:(NSArray *)picUrls{
    _picUrls = picUrls;
    NSInteger count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        UIImageView *imageV = self.subviews[i];
        if (i < _picUrls.count) { // 显示
            imageV.hidden = NO;
            [imageV sd_setImageWithURL:[NSURL URLWithString:_picUrls[i]]];
        }else{
            imageV.hidden = YES;
        }
    }
}

#pragma mark -- 计算尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 100;
    CGFloat h = 100;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _picUrls.count == 4 ? 2 : 3;
    // 计算显示出来的imageView
    for (int i = 0; i < _picUrls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
