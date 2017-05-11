//
//  UIImage+FZ.h
//  FZCategory
//
//  Created by Florence on 2017/5/11.
//  Copyright © 2017年 AllureTeartop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FZ)

/**
 根据颜色生成图片

 @param color 颜色
 @return 图片
 */
+(UIImage *)imageWithColor:(UIColor *)color;
/**
 根据颜色生成图片

 @param color 颜色
 @param frame size
 @return 图片
 */
+(UIImage *)imageWithColor:(UIColor *)color withFrame:(CGRect)frame;
/**
 改变图片尺寸

 @param newSize 新的尺寸
 @return 新图片
 */
- (UIImage*)imageWithscaledToSize:(CGSize)newSize;
/**
 改变图片的大小（KB）

 @param KB kb
 @return 压缩后的图片
 */
- (NSData *)resizeImageWithKB:(CGFloat )KB;
/**
 修改大小 消除白边  图片最大 1242 * 2208  5.5寸

 @return 图片
 */
- (UIImage *)scaleAndRotateImage;








@end
