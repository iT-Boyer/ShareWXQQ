//
//  WXApiRequestHandler.h
//  ShareWXQQ
//
//  Created by pengyucheng on 21/04/2017.
//  Copyright © 2017 PBBReader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SendMessageToWXReq+requestWithTextOrMediaMessage.h"
@interface WXApiRequestHandler : NSObject


+ (BOOL)sendFileData:(NSData *)fileData
       fileExtension:(NSString *)extension
               Title:(NSString *)title
         Description:(NSString *)description
          ThumbImage:(UIImage *)thumbImage
             InScene:(enum WXScene)scene;

@end
