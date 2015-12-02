//
//  ImageSizeDownloader.h
//  微博开发
//
//  Created by Ibokan on 15/12/1.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageSizeDownLoader : UIView
/**
 拷贝自 ：http://blog.csdn.net/li6185377/article/details/26225799
 */

/**
 获取网络图片的Size, 先通过文件头来获取图片大小
 如果失败 会下载完整的图片Data 来计算大小 所以最好别放在主线程
 如果你有使用SDWebImage就会先看下 SDWebImage有缓存过改图片没有
 支持文件头大小的格式 png、gif、jpg   http://www.cocoachina.com/bbs/read.php?tid=165823
 */

+(CGSize)downloadImageSizeWithURL:(id)imageURL;

@end
