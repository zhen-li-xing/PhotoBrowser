//
//  ViewController.m
//  PhotoBrowser
//
//  Created by 李震 on 2018/6/25.
//  Copyright © 2018年 李震. All rights reserved.
//

#import "ViewController.h"
#import "LZPhotoGrid.h"

@interface ViewController ()

@property (nonatomic,weak)LZPhotoGrid * photosView;

@property (nonatomic,strong)NSArray * picUrls;

@property (nonatomic,strong)NSMutableArray * selections;

@property (nonatomic,strong)NSMutableArray * photos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LZPhotoGrid *photosView = [[LZPhotoGrid alloc] init];
    [self.view addSubview:photosView];
    _photosView = photosView;
    
    _photosView.picUrls = self.picUrls;
    
    CGFloat photosX = 10;
    CGFloat photosY = 100;
    CGSize photosSize = [self photosSizeWithCount:(int)_picUrls.count];
    _photosView.frame = (CGRect){{photosX,photosY},photosSize};
    _photosView.backgroundColor = [UIColor grayColor];
    
}

- (CGSize)photosSizeWithCount:(int)count
{
    // 获取总列数
    int cols = count == 4 ? 2 : 3;
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    int rols = (count - 1) / cols + 1;
    CGFloat photoWH = 100;
    CGFloat w = cols * photoWH + (cols - 1) * 10;
    CGFloat h = rols * photoWH + (rols - 1) * 10;
    return CGSizeMake(w, h);
}

- (NSArray *)picUrls{
    _picUrls = @[@"http://c.hiphotos.bdimg.com/album/w%3D2048/sign=10a72dd37af40ad115e4c0e3631413df/f7246b600c338744f1243597500fd9f9d62aa073.jpg",
                 @"http://pic23.nipic.com/20120901/7341593_111221480000_2.jpg",
//                 @"http://www.4j4j.cn/upload/pic/20121031/261e39e216.jpg",
//                 @"http://www.bz55.com/uploads/allimg/140403/137-140403145U3.jpg",
                 @"http://a2.att.hudong.com/21/96/300000944056128089967362411_950.jpg",
                 @"http://pic25.nipic.com/20121205/5955207_182136452000_2.jpg",
                 @"http://img3.redocn.com/tupian/20151014/weimeikatongdongmantu_5095808.jpg",
                 @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1307/30/c0/23934263_1375169304679.jpg",
                 @"http://att2.citysbs.com/fz/bbs_attachments/2010/month_1002/middle_1002031225cd908311aa3f2124.jpg"
                 ];
    
    return _picUrls;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
