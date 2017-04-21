//
//  SendMessageToWXReq+requestWithTextOrMediaMessage.h
//  ShareWXQQ
//
//  Created by pengyucheng on 21/04/2017.
//  Copyright © 2017 PBBReader. All rights reserved.
//

#import "WXApiObject.h"

/// 扩展增加便利方法
@interface SendMessageToWXReq (requestWithTextOrMediaMessage)

+(SendMessageToWXReq *)requestWithText:(NSString *)text
                        orMediaMessage:(WXMediaMessage *)message
                                 bText:(BOOL)bText
                               InScene:(enum WXScene)scene;

@end
