//
//  ViewController.m
//  ShareSDKDemo
//
//  Created by huoshuguang on 2017/4/22.
//  Copyright © 2017年 PBBReader. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
///国内平台

///分组
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    //平台
    NSArray *_platforemArray;
    NSArray * _overseasPlatforemArray;
    NSBundle *_uiBundle;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _platforemArray = @[
                        @(SSDKPlatformSubTypeQQFriend),
                        @(SSDKPlatformSubTypeWechatSession)
                        ];
    
    _overseasPlatforemArray = @[@(SSDKPlatformTypeFacebook),
                                @(SSDKPlatformTypeFacebookMessenger)];
    
    // Do any additional setup after loading the view, typically from a nib.
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame
                                              style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    ///
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ShareSDKUI" ofType:@"bundle"];
    _uiBundle = [NSBundle bundleWithPath:bundlePath];}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_platforemArray count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return @" 国内平台";
            break;
        case 1:
            return @"  海外平台";
            break;
            
        default:
            return nil;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    id obj = nil;
    switch (indexPath.section)
    {
        case 0:
            obj = _platforemArray[indexPath.row];
            break;
        case 1:
            obj = _overseasPlatforemArray[indexPath.row];
            break;
        default:
            break;
    }
    if([obj isKindOfClass:[NSString class]])
    {
        NSString *titel = obj;
        cell.textLabel.text = titel;
        cell.imageView.image = nil;
    }
    if ([obj isKindOfClass:[NSNumber class]])
    {
        //title
        NSInteger platformType = [obj integerValue];
        NSString *platformTypeName = [NSString stringWithFormat:@"ShareType_%zi",platformType];
        /// 本地化：ShareSDKUI.bundle包中的Base.lproj打开 本地化对照表：ShareSDKUI_Localizable.strings，以此本地化
        cell.textLabel.text = NSLocalizedStringWithDefaultValue(platformTypeName, @"ShareSDKUI_Localizable", _uiBundle, platformTypeName, nil);
        //icon
        NSString *iconImageName = [NSString stringWithFormat:@"Icon_simple/sns_icon_%ld.png",(long)platformType];
        UIImage *icon = [UIImage imageWithContentsOfFile:[_uiBundle pathForResource:(iconImageName) ofType:nil]];
        cell.imageView.image = icon;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    return cell;
}

#pragma mark - tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id obj = nil;
    switch (indexPath.section) {
        case 0:
            obj = _platforemArray[indexPath.row];
            break;
        case 1:
            obj = _overseasPlatforemArray[indexPath.row];
            break;
    }
    NSInteger platformType = [obj integerValue];
    NSString *platformTypeName = [NSString stringWithFormat:@"ShareType_%zi",platformType];
    NSString *platformName = NSLocalizedStringWithDefaultValue(platformTypeName, @"ShareSDKUI_Localizable", _uiBundle, platformTypeName, nil);
    platformName = [platformName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *viewControllerName = [NSString stringWithFormat:@"MOB%@ViewController",platformName];
    Class viewControllerClass = NSClassFromString(viewControllerName);
    if (viewControllerClass)
    {
        UIViewController *viewController = [[viewControllerClass alloc] init];
//        [self presentViewController:viewController animated:YES completion:nil];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}








#pragma mark - 获取ShareSDKUI中的资源文件
-(void)localizedStringContent:(NSString *)key imageDir:(NSString *)dir localTable:(NSString *)tbl
{
    if (_uiBundle == nil)
    {
        NSString *uiPath = [[NSBundle mainBundle] pathForResource:@"ShareSDKUI" ofType:@"bundle"];
        _uiBundle = [NSBundle bundleWithPath:uiPath];
    }
    //本地化文本
    NSString *text = NSLocalizedStringWithDefaultValue(key, tbl, _uiBundle, key, nil);
    //icon
//    NSString *iconImageName = [NSString stringWithFormat:@"%@/sns_icon_%ld.png",dir,(long)platformType];
//    UIImage *icon = [UIImage imageWithContentsOfFile:[_uiBundle pathForResource:(iconImageName) ofType:nil]];
    
}
@end
