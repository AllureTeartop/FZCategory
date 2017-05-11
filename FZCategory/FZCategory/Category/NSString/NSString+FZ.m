//
//  NSString+FZ.m
//  FZCategory
//
//  Created by Florence on 2017/5/11.
//  Copyright © 2017年 AllureTeartop. All rights reserved.
//

#import "NSString+FZ.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (FZ)
#pragma mark ------ 判断字符串是否为空 --------
-(BOOL)fz_isEmpty{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
#pragma mark ----- 字符串转NSURL ----------
- (NSURL *)fz_url{
    return [NSURL URLWithString:self];
}

#pragma mark ------ MD5加密 --------
-(NSString*)fz_md532bitLower{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];

}
-(NSString*)fz_md532bitUper{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}
#pragma mark ------ base64编码 -------
-(NSString *)fz_base64EncodeString{
    //1.先转换为二进制数据
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //2.对二进制数据进行base64编码,完成之后返回字符串
    return [data base64EncodedStringWithOptions:0];
}

-(NSString *)fz_base64DecodeString{
    //注意:该字符串是base64编码后的字符串
    //1.转换为二进制数据(完成了解码的过程)
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    //2.把二进制数据在转换为字符串
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
#pragma mark ----- url编码 --------
-(NSString *)fz_urlEncodeString{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

-(NSString *)fz_urlDecodeString{
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)self,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;

}
#pragma mark ------- 字符串转NSData --------
-(NSData *)fz_dataValue{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
#pragma mark ------- 字符串转json -----------
-(NSString *)fz_JSONString{
    
    NSMutableString *s = [NSMutableString stringWithString:self];
    
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    
    return [NSString stringWithString:s];
}
#pragma mark ------- 字符串转时间（多久之前）--------
-(NSString *)fz_currentTimeString{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:self];
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    //    timeInterval = timeInterval - 60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
}
#pragma mark ----- 判断是否是中文 -------
-(BOOL)fz_isChinese{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
#pragma mark ------- 去除字符串所有的空格 --------
- (NSString *)fz_removeSpace{
    
    if (self.fz_isEmpty) {
      return @"";
    }else{
    
        return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    }
}
#pragma mark ----- 大写第一个字符 -------
- (NSString *)fz_firstCharUpper{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].uppercaseString];
    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}
#pragma mark ----- 小写第一个字符 -------
- (NSString *)fz_firstCharLower
{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].lowercaseString];
    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}

#pragma mark ----- 判断是否是手机号 --------
- (BOOL)fz_isMobile
{
    return [self validWithRegex:@"^(0|86|17951)?(13[0-9]|15[0-9]|17[0678]|18[0-9]|14[57])[0-9]{8}$"];
}
#pragma mark ----- 判断是否是身份证 --------
- (BOOL)fz_isIdentityCard{
    return [self chk18PaperId:[self uppercaseString]];
}
#pragma mark ----- 判断是否是URL --------
- (BOOL)fz_isURL{
    return [self validWithRegex:@"^((http)|(https))+:[^\\s]+\\.[^\\s]*$"];
}
#pragma mark ----- 判断是否是邮箱 --------
- (BOOL)fz_isEMail{
    return [self validWithRegex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}
#pragma mark ----- 判断是否是IP --------
- (BOOL)fz_isIPAddress{
    if ([self validWithRegex:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"]) {
        
        NSArray *components = [self componentsSeparatedByString:@"."];
        
        for (NSString *s in components) {
            
            if (s.integerValue > 255) {
                
                return NO;
            }
        }
        
        return YES;
    }
    
    return NO;
}
#pragma mark ---- other ---------
- (BOOL)chk18PaperId:(NSString *)sPaperId
{
    //  判断位数
    
    if ([sPaperId length] != 15 && [sPaperId length] != 18) {
        
        return NO;
    }
    
    NSString *carid = sPaperId;
    
    long lSumQT = 0;
    
    //  加权因子
    
    int R[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
    
    //  校验码
    
    unsigned char sChecker[11] = {'1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    //  将15位身份证号转换成18位
    
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    
    if ([sPaperId length] == 15) {
        
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        
        const char *pid = [mString UTF8String];
        
        for (int i = 0; i <= 16; i++) {
            
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        
        [mString insertString:string_content atIndex:[mString length]];
        
        carid = mString;
    }
    
    //  判断地区码
    
    NSString *sProvince = [carid substringToIndex:2];
    
    if (![self areaCode:sProvince]) {
        
        return NO;
    }
    
    //  判断年月日是否有效
    
    //  年份
    
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    
    //  月份
    
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    
    //  日
    
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setTimeZone:localZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01", strYear, strMonth, strDay]];
    
    if (!date) {
        
        return NO;
    }
    
    const char *PaperId = [carid UTF8String];
    
    //检验长度
    
    if (18 != strlen(PaperId)) {
        
        return - 1;
    }
    
    //校验数字
    
    for (int i = 0; i < 18; i++) {
        
        if (!isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i)) {
            
            return NO;
        }
    }
    
    //验证最末的校验码
    
    for (int i = 0; i <= 16; i++) {
        
        lSumQT += (PaperId[i] - 48) * R[i];
    }
    
    if (sChecker[lSumQT % 11] != PaperId[17]) {
        
        return NO;
    }
    
    return YES;
}
- (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger)value2;
{
    return [str substringWithRange:NSMakeRange(value1, value2)];
}
- (BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"北京" forKey:@"11"];
    
    [dic setObject:@"天津" forKey:@"12"];
    
    [dic setObject:@"河北" forKey:@"13"];
    
    [dic setObject:@"山西" forKey:@"14"];
    
    [dic setObject:@"内蒙古" forKey:@"15"];
    
    [dic setObject:@"辽宁" forKey:@"21"];
    
    [dic setObject:@"吉林" forKey:@"22"];
    
    [dic setObject:@"黑龙江" forKey:@"23"];
    
    [dic setObject:@"上海" forKey:@"31"];
    
    [dic setObject:@"江苏" forKey:@"32"];
    
    [dic setObject:@"浙江" forKey:@"33"];
    
    [dic setObject:@"安徽" forKey:@"34"];
    
    [dic setObject:@"福建" forKey:@"35"];
    
    [dic setObject:@"江西" forKey:@"36"];
    
    [dic setObject:@"山东" forKey:@"37"];
    
    [dic setObject:@"河南" forKey:@"41"];
    
    [dic setObject:@"湖北" forKey:@"42"];
    
    [dic setObject:@"湖南" forKey:@"43"];
    
    [dic setObject:@"广东" forKey:@"44"];
    
    [dic setObject:@"广西" forKey:@"45"];
    
    [dic setObject:@"海南" forKey:@"46"];
    
    [dic setObject:@"重庆" forKey:@"50"];
    
    [dic setObject:@"四川" forKey:@"51"];
    
    [dic setObject:@"贵州" forKey:@"52"];
    
    [dic setObject:@"云南" forKey:@"53"];
    
    [dic setObject:@"西藏" forKey:@"54"];
    
    [dic setObject:@"陕西" forKey:@"61"];
    
    [dic setObject:@"甘肃" forKey:@"62"];
    
    [dic setObject:@"青海" forKey:@"63"];
    
    [dic setObject:@"宁夏" forKey:@"64"];
    
    [dic setObject:@"新疆" forKey:@"65"];
    
    [dic setObject:@"台湾" forKey:@"71"];
    
    [dic setObject:@"香港" forKey:@"81"];
    
    [dic setObject:@"澳门" forKey:@"82"];
    
    [dic setObject:@"国外" forKey:@"91"];
    
    if (![dic objectForKey:code]) {
        
        return NO;
    }
    
    return YES;
}
- (BOOL)validWithRegex:(NSString *)regex
{
    if (!self || !self.length) {
        
        return false;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject:self]) {
        
        return false;
    }
    
    return true;
}

@end
