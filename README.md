背景

之前有写过使用[Python实现提醒iOS描述文件有效期](https://morganwang.cn/2024/04/19/Mac扫描iOS描述文件/#more)，这篇文章介绍一下使用SwiftUI通过Mac APP实现提醒描述文件有效期。

<!--more-->



## 实现

原理是：


打开描述文件所在的文件夹，遍历读取文件内容，过滤掉后缀不为`.mobileprovision`的文件，然后读取文件内容（这里不需要再存储为其他格式，因为可以直接读取内容），从文件中读取指定的字段，然后根据`ExpirationDate`字段判断是否过期。

想要实现的功能：
- 不同有效期期显示不同颜色——已完成
- 筛选过期的、临近过期的、正常的描述文件——已完成
- 添加到期提醒到日历——已完成
- 筛选同一个 BundleID 重复的描述文件——<font color="orange">未完成</font>
- 一键删除所有过期的描述文件——已完成


代码放在了[ScanProfileInfo](https://github.com/mokong/ScanProfileInfo)，感兴趣的下载运行即可。


样式如下：
![](https://raw.githubusercontent.com/mokong/BlogImages/main/ScanProfileInfo-1.jpg)
![](https://raw.githubusercontent.com/mokong/BlogImages/main/ScanProfileInfo-2.jpg)
![](https://raw.githubusercontent.com/mokong/BlogImages/main/ScanProfileInfo-3.jpg)
![](https://raw.githubusercontent.com/mokong/BlogImages/main/ScanProfileInfo-4.jpg)
![](https://raw.githubusercontent.com/mokong/BlogImages/main/ScanProfileInfo-5.jpg)
