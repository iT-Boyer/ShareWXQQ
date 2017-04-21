//
//  SendMessageToWXReq+requestWithTextOrMediaMessage.m
//  ShareWXQQ
//
//  Created by pengyucheng on 21/04/2017.
//  Copyright © 2017 PBBReader. All rights reserved.
//

#import "SendMessageToWXReq+requestWithTextOrMediaMessage.h"

@implementation SendMessageToWXReq (requestWithTextOrMediaMessage)

+(SendMessageToWXReq *)requestWithText:(NSString *)text
                        orMediaMessage:(WXMediaMessage *)message
                                 bText:(BOOL)bText
                               InScene:(enum WXScene)scene
{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = bText;
    req.scene = scene;
    if (bText)
    {
        req.text = text;
    }
    else
    {
        req.message = message;
    }
    return req;
}

@end
