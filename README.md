 # 前言
- 基于fluetter开发的linjiashop app版本，使用flutter 1.9.6 版本构建
## 功能模块
linjiashop包含了后台管理功能和手机端商城业务功能
- 商城功能
    - 首页
    - 发现
    - 购物车
    - 登录注册
    - 我的订单

## 技术选型
- 核心框架：flutter 1.9.6
- 数据存储：shared_preferences
- 屏幕适配：flutter_screenutil
- 路由管理：fluro
- 顶部状态栏：flutter_statusbarcolor
- 网络请求：dio
- 事件广播：event_bus
- 刷新控件：flutter_easyrefresh
- 左滑删除：flutter_slidable
- toast：fluttertoast

## 目录说明
- linjiashop-admin PC端后台管理的前端网页
- linjiashop-admin-api PC端后台管理的api服务
- linjiashop-mobile 手机商城的前端网页
- linjiashop-mobile-api 手机端商城的api服务
- linjiashop-core 基础模块，包括工具类，dao，service，bean等内容
- linjiashop-generator 代码生成模块,主要生成后台管理的前后端代码,配合IDEA 代码生成插件[webflash-generator](https://plugins.jetbrains.com/plugin/12648-webflash-generator)使用效果更好
## 运行效果图
- 手机端：
![手机端](doc/mobile.gif)
- 后台管理：
![后台管理](doc/admin.gif)
## 技术交流
- QQ群：254059156
- 微信：myenilu,添加请备注：邻家小铺