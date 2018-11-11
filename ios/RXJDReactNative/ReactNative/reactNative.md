
# 修改记录

1、 /bundle/...     、 /App/ReactNative/...
2、`AppDelegate`  .h  .m    2处修改



## 注意(导入后，记得工程要将`此文件`从编译包含文件中删除)
1、 bundle 导入  不需要 `copy xx need`
asstes  导入 `create folder xx` (这么导入的好处，就是文件夹内部文件的增减都会自动处理，我们可以不用收到再次导入等操作)

2、导入后，`ReactNative` 目录里面都是乱的，需要排序

3、删除 bundle->assets->`node_modules`  (RN 导航栏，是自定义的，图片是在images里面， so 不要插件自带的图片了)

这个已经写成 脚本了。  `packageiOSDebug.sh`  、  `packageiOSRelease.sh`

------------------------------------------------------------------------------------------------------------------------------------------------

##  提交代码 注意

### 先提交 app 代码，再提交 ReactNative 的js 代码

#### 1、 拉取代码
#### 2、  /bin/sh packageiOSDebug.sh  运行RN打包
#### 3、 status 、 ADD   、commit  、push

#### 4、 提交YLReactNative 项目  js代码


