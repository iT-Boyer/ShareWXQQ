//
//  QQApiRequestHandler.h
//  ShareWXQQ
//
//  Created by pengyucheng on 21/04/2017.
//  Copyright © 2017 PBBReader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QQApiRequestHandler;

typedef void(^TCApiRequestDoneHandler)(QQApiRequestHandler *editCtrl);
typedef void(^TCApiRequestCancelHandler)(QQApiRequestHandler *editCtrl);

@interface QQApiRequestHandler : NSObject



@property (nonatomic, strong) TCApiRequestDoneHandler editDoneHandler;
@property (nonatomic, strong) TCApiRequestCancelHandler editCancelHandler;
@property (retain, nonatomic) UIViewController *parentCtrl;

- (void)modalIn:(UIViewController*)parentCtrl withDoneHandler:(TCApiRequestDoneHandler)doneHandler cancelHandler:(TCApiRequestCancelHandler)cancelHandler animated:(BOOL)animated;

@end
