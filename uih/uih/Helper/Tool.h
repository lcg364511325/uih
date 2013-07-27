//
//  Tool.h
//  
//
//  Created by wangjun on 12-3-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Tool.h"
#import "ApiError.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import <CommonCrypto/CommonCryptor.h>


@interface Tool : NSObject


+ (void)clearWebViewBackground:(UIWebView *)webView;

+ (void)doSound:(id)sender;

+ (void)playAudio:(BOOL)isAlert;

+ (NSString *)intervalSinceNow: (NSString *) theDate;

+ (int)getDaysCount:(int)year andMonth:(int)month andDay:(int)day;


+ (NSString *)getAppClientString:(int)appClient;

+ (void)ReleaseWebView:(UIWebView *)webView;


+ (UIColor *)getBackgroundColor;
+ (UIColor *)getCellBackgroundColor;
+ (UIColor *)getseparatorColor;

+ (int)getTextViewHeight:(UITextView *)txtView andUIFont:(UIFont *)font andText:(NSString *)txt;

//重复性判断
+ (NSString *)getHTMLString:(NSString *)html;

+ (void)showHUD:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud;

+ (UIImage *) scale:(UIImage *)sourceImg toSize:(CGSize)size;

+ (CGSize)scaleSize:(CGSize)sourceSize;

+ (NSString *)getOSVersion;

+ (void)ToastNotification:(NSString *)text andView:(UIView *)view andLoading:(BOOL)isLoading andIsBottom:(BOOL)isBottom;

+ (NSDate *)NSStringDateToNSDate:(NSString *)string;

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

+ (UIImage *) headbg;


@end
