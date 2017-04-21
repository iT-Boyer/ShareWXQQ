//
//  ViewController.m
//  ShareWXQQ
//
//  Created by pengyucheng on 21/04/2017.
//  Copyright © 2017 PBBReader. All rights reserved.
//

#import "ViewController.h"
#import "WXApiRequestHandler.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)shareSDK:(id)sender
{
    NSLog(@"开始分享----");
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSData *infoData = [NSData dataWithContentsOfFile:filePath];
    [WXApiRequestHandler sendFileData:infoData
                        fileExtension:@"plist"
                                Title:@"wenjianinfo.plist"
                          Description:@"微信贡献"
                           ThumbImage:[UIImage imageNamed:@"res5thumb.png"]
                              InScene:WXSceneSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
