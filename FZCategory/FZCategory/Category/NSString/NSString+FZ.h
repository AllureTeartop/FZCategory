//
//  NSString+FZ.h
//  FZCategory
//
//  Created by Florence on 2017/5/11.
//  Copyright © 2017年 AllureTeartop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FZ)

/**
 字符串是否为空

 @return yes or no
 */
-(BOOL)fz_isEmpty;
/**
 转换为NSURL

 @return NSURL对象
 */
- (NSURL *)fz_url;

/**
 MD5 32位 小写加密

 @return 加密后的字符串
 */
-(NSString *)fz_md532bitLower;

/**
 MD5 32位 大写加密

 @return 加密后的字符串
 */
-(NSString *)fz_md532bitUper;

/**
 对字符串进行base64进行字符串编码

 @return 编码后的字符串
 */
-(NSString *)fz_base64EncodeString;
/**
 对base64编码过的字符串解码

 @return 解码后的字符串
 */
-(NSString *)fz_base64DecodeString;
/**
 对url进行Encode（我们经常会看到url字符串中含有一些特殊功能的特殊字符，或者中文字符
 ，作为参数用GET方式传递时，需要用urlencode处理下）

 @return 编码后的字符串
 */
-(NSString *)fz_urlEncodeString;
/**
 对url进行Decode解码
 
 @return 解码后的字符串
 */
-(NSString *)fz_urlDecodeString;

/**
 字符串转换为data

 @return data
 */
-(NSData *)fz_dataValue;

/**
 将字符串转换为json字符串

 @return json字符串
 */
-(NSString *)fz_JSONString;
/**
 将时间字符串转化为(几分钟前，几小时前)这种格式

 @return 转化后的时间
 */
-(NSString *)fz_currentTimeString;
/**
 是否是中文

 @return yes or no
 */
-(BOOL)fz_isChinese;

/**
 去除字符串所有的空格

 @return 去除空格的字符串
 */
- (NSString *)fz_removeSpace;
/**
 大写第一个字符

 @return 修饰后的字符串
 */
- (NSString *)fz_firstCharUpper;
/**
 小写第一个字符
 
 @return 修饰后的字符串
 */
- (NSString *)fz_firstCharLower;
/**
 判断手机号

 @return 是/不是
 */
- (BOOL)fz_isMobile;
/**
 判断身份证号

 @return 是/不是
 */
- (BOOL)fz_isIdentityCard;
/**
 判断URL

 @return 是/不是
 */
- (BOOL)fz_isURL;
/**
 判断EMail

 @return 是/不是
 */
- (BOOL)fz_isEMail;
/**
 判断IP

 @return 是/不是
 */
- (BOOL)fz_isIPAddress;







@end
