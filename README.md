# 华夏美食地图

![Java](https://img.shields.io/badge/Java-17+-red?style=flat-square&logo=java)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-green?style=flat-square&logo=spring)
![MySQL](https://img.shields.io/badge/MySQL-8.0.33-blue?style=flat-square&logo=mysql)
![License](https://img.shields.io/badge/License-MIT-orange?style=flat-square)

## 项目名称

华夏美食地图 — 智能化食品与餐厅点餐管理应用

---

## 项目简介

"华夏美食地图"是一个基于 Spring Boot 框架开发的智能化食品与餐厅点餐管理应用。该项目集成了现代 Web 开发技术栈，提供用户认证、权限隔离、数据持久化以及前沿的 AI 智能助手支持。

项目采用前后端分离架构，后端采用 RESTful API 设计，前端使用 HTML5、CSS3 和原生 JavaScript 构建响应式沉浸界面。系统创新性地结合了 Apache ECharts 中国地图，让食客在"在线漫游全国美食地图"的过程中完成挑菜、点餐、打分评价与 AI 咨询。

核心优势：
- 沉浸式地域文化点餐体验
- 完整的电商交易闭环
- RBAC 权限管理与后台运营
- DeepSeek AI 智能客服
- 数据持久化与权限隔离

---

## 技术栈

### 后端技术
| 技术 | 版本 | 用途 |
|------|------|------|
| Spring Boot | 3.x | 核心应用框架 |
| MyBatis Plus | 3.5.5 | ORM 持久层框架 |
| MySQL | 8.0.33 | 关系型数据库 |
| Spring Security | 最新 | 系统安全与认证 |
| BCrypt | - | 密码加密算法 |
| Apache Maven | 3.6+ | 项目依赖管理与构建 |
| DeepSeek API | - | 大语言模型 AI 服务 |

### 前端技术
| 技术 | 版本 | 用途 |
|------|------|------|
| HTML5 | 最新 | 页面结构 |
| CSS3 | 最新 | 样式表与响应式设计 |
| JavaScript (ES6) | 原生 | 交互逻辑与 DOM 操作 |
| Apache ECharts | 5.x | 中国地图交互可视化 |

### 设计风格
- 主题：玻璃拟态（Glassmorphism）设计
- 配色：暗夜星空蓝 + 鎏金黄色系搭配

---

## 运行环境

### 系统要求
- 操作系统：Windows 10+ / macOS 10.15+ / Linux（Ubuntu 18.04+）
- Java 版本：JDK 17 或更高版本
- 数据库：MySQL 8.0.33+
- 构建工具：Apache Maven 3.6+
- IDE：IntelliJ IDEA（推荐）或其他 Java IDE

### 网络环境
- 网络连接正常（用于 Maven 下载依赖、DeepSeek API 调用）
- 推荐国内网络代理，加快 Maven 依赖下载
- DeepSeek API（可选，不配置时使用本地规则兜底）

### 硬件建议
- 处理器：Intel i5 或同等级别
- 内存：8GB 或以上
- 磁盘：2GB 以上空闲空间

---

## 启动步骤

### 第一步：初始化 MySQL 数据库

1. 打开 MySQL 数据库管理工具
   - 推荐工具：Navicat 17、DataGrip、MySQL Workbench 或 MySQL Command Line

2. 创建数据库
   ```sql
   CREATE DATABASE restaurant_system 
   CHARACTER SET utf8mb4 
   COLLATE utf8mb4_general_ci;
   ```

3. 执行初始化脚本
   - 找到项目根目录下的 `db/restaurant_system.sql` 文件
   - 用 MySQL 工具打开该文件并执行
   - 脚本会自动创建 9 张核心业务表，并内置中国传统名菜数据与默认测试账号

   ```bash
   mysql -u root -p restaurant_system < db/restaurant_system.sql
   ```

### 第二步：在 IDEA 中打开项目并同步 Maven

1. 打开项目
   - 启动 IntelliJ IDEA
   - 点击菜单栏 File → Open...
   - 选择项目根目录 `main` 文件夹，点击 OK

2. 同步 Maven 依赖
   - IDEA 会自动识别 `pom.xml` 并下载依赖
   - 首次加载可能需要 1-3 分钟，请确保网络畅通

3. 配置 JDK 版本
   - 点击菜单栏 File → Project Structure...
   - 在 Project SDK 中选择 JDK 17 或更高版本
   - 在 Language level 中设置为 17 或以上
   - 点击 Apply 并确认

### 第三步：配置本地数据库连接与 AI 密钥

1. 打开配置文件
   - 在 IDEA 左侧目录树中找到 `src/main/resources/application.yml`

2. 配置数据库连接
   ```yaml
   spring:
     datasource:
       url: jdbc:mysql://localhost:3306/restaurant_system?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
       username: root           # 改为你的 MySQL 用户名
       password: your_password  # 改为你的 MySQL 密码
       driver-class-name: com.mysql.cj.jdbc.Driver
   ```

3. 配置 DeepSeek API（可选）
   ```yaml
   deepseek:
     api-key: sk-your-api-key  # 可选，申请后填入
   ```
   - 如不填写或保持默认的 `sk-placeholder`，系统会自动切换为本地规则算法兜底，不影响任何业务功能

### 第四步：运行主启动类

1. 定位启动类
   - 在 IDEA 左侧项目文件树中，展开目录找到 `src/main/java/org/example/Main.java`

2. 运行应用
   - 打开 `Main.java` 文件
   - 点击类名左侧的绿色 Run 图标，选择 Run 'Main.main()'
   - 或使用快捷键 Shift + F10 运行

3. 查看启动日志
   - 观察 IDEA 底部的控制台输出
   - 当看到以下日志说明启动成功：
     ```
     Tomcat started on port(s): 8080 (http) with context path ''
     Started Main in X.XXX seconds (JVM running for X.XXX)
     ```

### 第五步：浏览器访问系统

1. 打开浏览器
   - 在地址栏输入：http://localhost:8080
   - 按 Enter 键访问系统

2. 系统已就绪
   - 你将看到华夏美食地图的首页
   - 可使用下文的测试账号进行登录体验

---

## 测试账号

系统内置了以下默认测试账号，可直接登录体验不同权限视图：

| 账号身份 | 用户名 | 登录密码 | 登录后自动化体验 |
| :--- | :--- | :--- | :--- |
| 管理员 (Admin) | `admin` | `123456` | 自动识别权限，登录成功后跳转至后台管理面板，并在所有页面顶部点亮专属管理后台入口。可访问用户管理、菜品管理、库存监控等功能 |
| 普通食客 (User) | `sun` | `123456` | 登录成功后跳转至地图探索首页，体验全国美食点餐、味觉胶片滑动、下订单及 AI 客服咨询。支持菜品评价与订单查询 |
| 普通食客 (User) | `zhangsan` | `123456` | 同上，另一个测试食客账号 |

---

## 主要功能

### 第一个功能：沉浸式地域文化点餐（ECharts 联动）

功能描述：
系统实现了悬浮品鉴交互，当鼠标悬停在中国地图任意省份时，立即可视化浮窗展示该省招牌名菜缩略图、菜系与价格。

核心特性：
- 实时地图悬停：悬停显示省份美食信息卡片
- 地图自动聚焦：点击省份后地图自动放大聚焦
- 味觉胶片滑动：底部平滑展开美食卡片栏
- 智能卡片交互：支持鼠标惯性拖拽滑动、触底自动反向往复巡航、悬停时精准停驻

### 第二个功能：电商交易与点餐闭环

功能描述：
完整的从浏览菜品、加入购物车、下单到支付的全流程电商交易体系。

核心特性：
- 购物车管理：实时增减菜品份数、多项小计自动计算、未登录状态下自动拦截与跳转保护
- 订单引擎：并发订单处理、自动生成时间戳唯一流水号、依次完成扣减实体库存、记录明细、触发系统消息轮询通知
- 评价中心：订单完成后食客可对每一道菜进行打分、支持发表图文心得评价、评价数据实时展示

### 第三个功能：后台运营与 RBAC 权限管理

功能描述：
为权限用户提供全面的运营工具，实现角色级权限隔离。

核心特性：
- 用户管理：查看全站注册会员列表、支持一键禁用或启用违规账号、用户信息统计
- 菜品管理：新菜品上架录入、实时库存调整、价格动态更新、菜品分类管理
- 业务监控：营业状态实时监控、销售数据统计、订单动态跟踪

---

## AI 功能说明

### 核心概述

本项目深度集成了 DeepSeek 大语言模型，具备真正的双轨决策智能客服逻辑。前端请求发送至后端后，系统会自动进行 AI 知识库与规则的上下文注入，再调用大模型 API 返回格式化建议。

### 应用场景

#### 场景一：智能点餐导购
- 用户输入：口味偏好、预算、就餐人数等条件
- AI 处理：自动遍历底层实际库存
- 输出建议：科学菜品搭配组合 + 推荐理由
- 示例：
  ```
  用户："我喜欢川菜，预算 200 块，3 个人"
  AI 回复："为您推荐三道川菜组合...
  - 麻辣水煮鱼（经典川菜，麻辣适中）
  - 宫保鸡丁（香辣鲜美，口感丰富）
  - 榴莲糯米球（甜品收尾，清爽解腻）
  预计总价 198 元，非常适合三人聚餐！"
  ```

#### 场景二：全能客服答疑
- 功能：客服模型严格遵守预设的门店规章知识库
- 能力：精确回答营业与打烊时间、计算外卖运费、处理待制作订单退款问题、解答常见用户问题
- 示例：
  ```
  用户："你们什么时候关门？"
  AI 回复："本店营业时间为 10:00-22:00，
  周末延迟到 23:00 关门。
  今天距离关闭还有 2 小时，
  欢迎继续点餐！"
  ```

#### 场景三：高可用无感降级
- 触发条件：网络异常无法连接 DeepSeek API、未配置 API Key（默认值 sk-placeholder）、API 配额耗尽
- 降级策略：秒级切换至本地随机洗牌与规则算法兜底
- 用户体验：完全无感，系统 100% 稳定运行

### 配置方式

#### 方式一：使用 DeepSeek API（推荐）
```yaml
deepseek:
  api-key: sk-xxxxxxxxxxxxxxx  # 填入你的 API Key
```

#### 方式二：本地规则兜底（默认）
```yaml
deepseek:
  api-key: sk-placeholder  # 保持默认或不填
```

### 获取 DeepSeek API Key

1. 访问 DeepSeek 官网 (https://platform.deepseek.com)
2. 注册开发者账号
3. 登录后进入 API 控制台
4. 创建新的 API Secret Key
5. 将密钥复制到 `application.yml` 的 `deepseek.api-key` 字段

---

## 小组成员分工

### 项目团队信息

本项目由三名成员协作完成，分工明确，各司其职：

| 成员姓名 | 负责模块 | 主要工作内容 | 工作占比 |
| :--- | :--- | :--- | :--- |
| 栾羽 | 前端编写与交互优化 | 前端页面编写、交互逻辑优化、完善静态资源与主页逻辑、制作项目答辩 PPT | 30% |
| 孙洪茹 | 后端核心架构与用户管理 | 后端整体架构设计、用户认证与权限管理、菜品与分类查询、点餐主业务逻辑、订单明细处理 | 35% |
| 杨梦琪 | 后端业务拓展与功能完善 | 购物车记录与计算、站内轮询通知系统、食客评价模块、省份特色美食数据维护 | 35% |

### 成员分工特点

- 协作高效：后端两名成员紧密配合，在架构和业务拓展上无缝衔接
- 前后端平衡：前端占比 30%，后端占比 70%，符合项目的业务逻辑复杂度
- 覆盖完整：从数据库设计、API 开发、UI/UX 到项目交付全覆盖

---

## 项目目录结构

```
main/
├── db/
│   ├── init.sql                     # 基础数据库脚本
│   └── restaurant_system.sql        # 完整系统结构与初始数据备份
├── pom.xml                          # Maven 项目依赖清单
├── src/main/
│   ├── java/org/example/
│   │   ├── Main.java                # Spring Boot 后端主启动类
│   │   ├── common/                  # 全局通用组件（常量、工具类）
│   │   ├── config/                  # 核心配置（安全、数据源、AI 配置等）
│   │   ├── controller/              # 控制层 RESTful API 接口
│   │   ├── dto/                     # 请求参数封装传输对象
│   │   ├── entity/                  # 数据库表映射实体类
│   │   ├── mapper/                  # 数据访问接口与定制 SQL
│   │   └── service/                 # 核心业务逻辑接口与实现类
│   └── resources/
│       ├── application.yml          # 全局核心配置文件
│       ├── mapper/                  # 复杂多表联合查询 XML 映射文件
│       └── static/                  # 前端静态资源根目录
│           ├── css/style.css        # 全站统一暗夜星空样式表
│           ├── data/china.json      # ECharts 中国地图矢量地理数据
│           ├── images/dishes/       # 全国名菜高清图库 & 占位图
│           ├── js/api.js            # 网络请求异步封装与异常拦截
│           ├── pages/               # 独立业务子模块页面
│           └── index.html           # 全站地标地图探索主页
└── README.md                        # 项目说明文档
```

---

## 开发与调试小贴士

### 第一个建议：避免内置浏览器端口冲突

重要提示：请勿点击编辑器右上角的浮动小浏览器图标预览 HTML。
- IDEA 内置浏览器使用的是内置 63342 端口
- 这会导致后端接口和静态资源返回 404 错误
- 解决方案：务必使用系统浏览器访问 http://localhost:8080

### 第二个建议：静态资源热更新

修改了 `src/main/resources/static/` 下的前端代码或放入新图片后：

```bash
第一步：在 IDEA 中按快捷键编译到 target 目录
Ctrl + F9

第二步：在浏览器中强制清空缓存刷新
Ctrl + F5

结果：立刻看到改动，无需重启 Java 后端！
```

优势：大幅提升前端开发效率，避免频繁重启 Java 应用

### 第三个建议：端口占用处理

若遇到 `Port 8080 was already in use` 错误：

方案一：停止旧进程
- 在 IDEA 底部的控制台点击红色停止按钮
- 关闭之前启动的进程后重新启动

方案二：修改端口
- 编辑 `src/main/resources/application.yml`
- 修改 `server.port` 字段：
  ```yaml
  server:
    port: 8081  # 改为其他可用端口
  ```

---

## 命令行启动指南

### 场景：无需 IDE，直接使用 Maven 启动

```bash
第一步：编译并打包项目
mvn clean package -DskipTests

第二步：查看生成的 JAR 文件
ls -la target/food-1.0-SNAPSHOT.jar

第三步：运行 JAR 包
java -jar target/food-1.0-SNAPSHOT.jar

第四步：访问系统
打开浏览器，输入 http://localhost:8080
```

### 常用 Maven 命令

```bash
仅编译，不打包
mvn clean compile

执行单元测试
mvn test

清理之前的构建产物
mvn clean

查看项目依赖树
mvn dependency:tree
```

---

## 常见问题 (FAQ)

### Q1: 如何在 Linux/命令行环境下打包与启动？

答：如果你不使用 IDEA，可以在控制台执行标准 Maven 指令：

```bash
编译并打包
mvn clean package -DskipTests

运行 JAR 包
java -jar target/food-1.0-SNAPSHOT.jar
```

### Q2: 如何获取 DeepSeek API Key？

答：
1. 访问 DeepSeek 官网 (https://platform.deepseek.com)
2. 注册开发者账号
3. 登录后进入 API 控制台
4. 创建新的 Secret Key
5. 将其替换到 `application.yml` 的 `deepseek.api-key` 字段中

### Q3: 没有配置 DeepSeek API Key 会怎样？

答：系统会自动切换至本地规则算法兜底，不影响任何业务功能。所有 AI 客服、点餐导购等功能都能正常使用，只是使用的是规则推荐而非大模型推荐。

### Q4: 如何重置或修改登录密码？

答：
1. 使用 MySQL 客户端连接数据库
2. 查询 `user` 表
3. 密码字段通常是 BCrypt 加密存储
4. 可以通过生成新的 BCrypt 密码哈希值来更新

```sql
查看用户列表
SELECT id, username, password FROM user;

重置为默认密码 123456 的哈希值
注意：这是一个示例 BCrypt 哈希，需要自己生成
UPDATE user SET password = '$2a$10$...' WHERE username = 'sun';
```

### Q5: Maven 依赖下载太慢怎么办？

答：配置国内镜像加速（以阿里云为例）：

1. 找到 Maven 配置文件 `~/.m2/settings.xml`
2. 在 `<mirrors>` 标签中添加：
   ```xml
   <mirror>
     <id>aliyun</id>
     <mirrorOf>central</mirrorOf>
     <name>Aliyun Maven Mirror</name>
     <url>https://maven.aliyun.com/repository/public</url>
   </mirror>
   ```
3. 重新运行 Maven 命令

---

## 许可证

MIT License

---

## 贡献与反馈

欢迎提交 Issue 和 Pull Request！

如有问题或建议，请通过以下方式联系：
- 提交 GitHub Issue
- Pull Request

---

最后更新：2026 年 7 月 8 日
项目版本：1.0
开发团队：栾羽 | 孙洪茹 | 杨梦琪