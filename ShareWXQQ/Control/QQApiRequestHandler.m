//
//  QQApiRequestHandler.m
//  ShareWXQQ
//
//  Created by pengyucheng on 21/04/2017.
//  Copyright © 2017 PBBReader. All rights reserved.
//

#import "QQApiRequestHandler.h"

@implementation QQApiRequestHandler


- (void)modalIn:(UIViewController*)parentCtrl
withDoneHandler:(TCApiRequestDoneHandler)doneHandler
  cancelHandler:(TCApiRequestCancelHandler)cancelHandler
       animated:(BOOL)animated

{
    self.editDoneHandler = doneHandler;
    self.editCancelHandler = cancelHandler;
    self.parentCtrl = parentCtrl;
}
@end
