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

### URL scheme
LSApplicationQueriesSchemes在ios9之后改变了URLScheme 的用法

### 制定APP打开文件类型
Uniform type identifiers(UTIs)提供了在整个系统里面标识数据的一个统一的方式，比如documents(文档)、pasteboard data(剪贴板数据)和bundles(包)。
