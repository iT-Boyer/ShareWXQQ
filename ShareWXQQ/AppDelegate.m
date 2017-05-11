//
//  AppDelegate.m
//  ShareWXQQ
//
//  Created by pengyucheng on 21/04/2017.
//  Copyright © 2017 PBBReader. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WXApi registerApp:@"wxd930ea5d5a258f4f" enableMTA:YES];
    //[WXApi registerApp:@"wx49b46f184e65e4de"];
    [[TencentOAuth alloc] initWithAppId:@"100569483" andDelegate:self];
    return YES;
}

    // 其他方式打开，选择后APP后调用
-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation
{
    NSLog(@"weixinweixinweixinweixin");
    //qq回调
    BOOL weixin = [WXApi handleOpenURL:url delegate:self];
    BOOL qq = [TencentOAuth HandleOpenURL:url];
    if (weixin) {
        //
        NSLog(@"weixinweixinweixinweixin");
        return weixin;
    }
    
    if (qq) {
        //
        NSLog(@"qqqqqqqqqqqq");
        return qq;
    }
    return weixin;
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

#pragma mark - weixin  分享回调方法 ：iOS9之后废弃了application:handleOpenURL:代理方法
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    NSLog(@"weixinweixinweixinweixin");
    BOOL weixin = [WXApi handleOpenURL:url delegate:self];
    BOOL qq = [TencentOAuth HandleOpenURL:url];
    if (weixin) {
        //
        NSLog(@"weixinweixinweixinweixin");
    }
    
    if (qq) {
        //
        NSLog(@"qqqqqqqqqqqq");
    }
    
    
    return YES;
}
    
    
    
    
    

///onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
-(void)onReq:(BaseReq *)req
{
    
}

///如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
-(void)onResp:(BaseResp *)resp
{
    
}

///需要注意的是，SendMessageToWXReq的scene成员，如果scene填WXSceneSession，那么消息会发送至微信的会话内。如果scene填WXSceneTimeline，那么消息会发送至朋友圈。如果scene填WXSceneFavorite,那么消息会发送到“我的收藏”中。scene默认值为WXSceneSession。

@end
