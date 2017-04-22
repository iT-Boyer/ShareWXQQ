### 冲突：
官方SDK 与 ShareSDK 集成在同一个Project中，不同的target时：
当使用如下引入方式时，会出现冲突问题： 
```objc
#import <WXApi.h>
```
解决办法，将包的位置写完即可,如下：
```objc
#import <WechatOpenSDK/WXApi.h>
```
其他相关API引入，也要保证引入的是全路径。
