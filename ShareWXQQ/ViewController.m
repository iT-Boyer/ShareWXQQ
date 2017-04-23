//
//  ViewController.m
//  ShareWXQQ
//
//  Created by pengyucheng on 21/04/2017.
//  Copyright © 2017 PBBReader. All rights reserved.
//

#import "ViewController.h"
#import "WXApiRequestHandler.h"
#import "QQApiRequestHandler.h"
#import "TencentOpenAPI/QQApiInterface.h"
#import <QuickLook/QuickLook.h>

@interface ViewController ()<QLPreviewControllerDataSource>
{
    //需要使用全局变量，否则会因对象提早释放报错：UIDocumentInteractionController has gone away prematurely
    UIDocumentInteractionController *_shareDocument;
    NSArray *preFileURLs;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *imageURL = [[NSBundle mainBundle] URLForResource:@"res5thumb" withExtension:@"png"];
    NSURL *infoURL = [[NSBundle mainBundle] URLForResource:@"Info" withExtension:@"plist"];
    preFileURLs = @[imageURL,infoURL];
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


///图片分享到QQ
-(IBAction)shareQQ:(id)sender
{
    NSLog(@"QQ开始分享。。。");
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"res5thumb.png"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    QQApiImageObject* img = [QQApiImageObject objectWithData:data
                                            previewImageData:data
                                                       title:@"dddddd"
                                                 description:@"dddddd"];
            img.shareDestType = ShareDestTypeQQ;
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];

    [[QQApiRequestHandler alloc] modalIn:self withDoneHandler:^(QQApiRequestHandler *editCtrl) {
        //
        
    } cancelHandler:nil animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPITIMNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装TIM" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        case EQQAPITIMNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            
            break;
        }
        case EQQAPIVERSIONNEEDUPDATE:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"当前QQ版本太低，需要更新" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case ETIMAPIVERSIONNEEDUPDATE:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"当前QQ版本太低，需要更新" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}


#pragma mark - document分享

-(IBAction)shareByDocumentAPI:(id)sender
{

    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"Info" withExtension:@"plist"];
    _shareDocument = [UIDocumentInteractionController interactionControllerWithURL:filePath];
    _shareDocument.delegate = self;
    UIButton *rectBut = (UIButton *)sender;
    [_shareDocument presentOpenInMenuFromRect:rectBut.frame inView:self.view animated:YES];
}

#pragma 交互代理
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}
/**
 *  文件分享面板退出时调用
 */
- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller
{
    NSLog(@"dismiss");
}

/**
 *  文件分享面板弹出的时候调用
 */
- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller
{
    NSLog(@"WillPresentOpenInMenu");
    
}

/**
 *  当选择一个文件分享App的时候调用
 */
- (void)documentInteractionController:(UIDocumentInteractionController *)controller
        willBeginSendingToApplication:(nullable NSString *)application
{
    //例如选择微信时，会打印：begin send : com.tencent.xin
    NSLog(@"begin send : %@", application);
}


#pragma mark - QuickLook
-(IBAction)QuickLook:(id)sender
{
    QLPreviewController *preView = [[QLPreviewController alloc] init];
    preView.dataSource = self;
    [self presentViewController:preView animated:YES completion:nil];
}


/**
 这里我返回的PreviewItems的数量为1，就是一次加载一个文件，这里可以是多个文件的数组个数，也就是某个本地路径下的多个文件，大家可以自己实现下。

 @param controller 当前浏览器控制器
 @return 一次浏览文件的个数，返回Url数组的文件个数
 */
-(NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return preFileURLs.count;
}

/**
 其实NSURL的分类遵循了QLPreviewItem协议，这里可以返回一个Url数组。这就是预览多个文件时的数据源方法，注意：以上两个方法是@required的，必须需要实现的。

 @param controller 当前预览控制器
 @param index 当前预览的第几个文件
 @return 一个文件URL，当在浏览多个文件时，则可返回Url数组
 */
-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return preFileURLs[index];
}

@end
