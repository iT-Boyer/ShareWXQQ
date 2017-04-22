//
//  AppDelegate.m
//  ShareSDKDemo
//
//  Created by huoshuguang on 2017/4/22.
//  Copyright © 2017年 PBBReader. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

#define __TencentPBBAppid_  @"100569483"     //100569483
#define __ShareSDKAppKey_   @"597719dbceea"  //597719dbceea

NSString *const shareSDKAppKey = @"1a131fa890c30";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupShareSDK];
    return YES;
}

#pragma mark - 初始化SDK并且初始化第三方平台
-(void)setupShareSDK
{
    
    //    只需要QQ找回时，这些不必设置
    [ShareSDK registerApp:shareSDKAppKey
          activePlatforms:@[ @(SSDKPlatformTypeWechat),
                             @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType) {
                     //
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class]
                                        tencentOAuthClass:[TencentOAuth class]];
                             break;
                         default:
                             break;
                     }
                     
                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                     //
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             //                      //微信登陆使用此appID
                             [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                                   appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                             //微信小程序使用此appID
                             //                      [appInfo SSDKSetupWeChatByAppId:@"wxd930ea5d5a258f4f"
                             //                                            appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                             break;
                         case SSDKPlatformTypeQQ:
                             [appInfo SSDKSetupQQByAppId:@"100371282"
                                                  appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                                authType:SSDKAuthTypeBoth];
                             break;
                         default:
                             break;
                     }
                 }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
