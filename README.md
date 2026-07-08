# 华夏美食地图 🍽️

![Java](https://img.shields.io/badge/Java-17+-red?style=flat-square&logo=java)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-green?style=flat-square&logo=spring)
![MySQL](https://img.shields.io/badge/MySQL-8.0.33-blue?style=flat-square&logo=mysql)
![License](https://img.shields.io/badge/License-MIT-orange?style=flat-square)

一个基于 Spring Boot 框架开发的智能化食品与餐厅点餐管理应用，集成了现代 Web 开发技术栈、用户认证权限隔离、数据持久化以及 AI 智能助手支持。项目采用前后端分离架构，创新性地结合了 Apache ECharts 中国地图，让食客在"在线漫游全国美食地图"的过程中完成挑菜、点餐、打分评价与 AI 咨询。

## ✨ 核心功能

### 🗺️ 沉浸式地域文化点餐
- **ECharts 地图交互**：悬浮品鉴交互，实时展示省份招牌名菜、菜系与价格
- **动态地图聚焦**：点击省份自动放大，底部平滑展开美食卡片栏
- **智能卡片滑动**：支持鼠标惯性拖拽、触底自动巡航、悬停精准停驻

### 🛒 电商交易完整闭环
- **购物车管理**：实时增减菜品份数，多项小计自动计算
- **订单引擎**：并发处理，自动生成时间戳流水号，完成库存扣减与明细记录
- **评价中心**：食客可对菜品打分并发表图文心得反馈

### 👨‍💼 后台运营管理（RBAC权限体系）
- **用户管理**：查看全站注册会员，一键禁用/启用账号
- **菜品管理**：新菜品上架录入、实时库存调整、价格更新
- **营业监控**：实时业务状态跟踪、销售数据统计

### 🤖 AI 智能客服（DeepSeek 集成）
- **智能点餐导购**：根据口味偏好、预算、就餐人数自动推荐菜品组合
- **全能客服答疑**：回答营业时间、运费计算、订单问题等
- **高可用降级**：网络异常时自动切换至本地规则算法，确保 100% 可用性

## 🛠️ 技术栈

### 后端
- **框架**：Spring Boot 3.x + Spring Security
- **数据库**：MySQL 8.0.33 + MyBatis Plus 3.5.5
- **安全**：BCrypt 密码加密、JWT 认证、权限隔离
- **构建**：Apache Maven
- **AI 接入**：DeepSeek API

### 前端
- **页面**：HTML5 + CSS3 + ES6 JavaScript（原生）
- **可视化**：Apache ECharts 5.x（中国地图）
- **设计**：玻璃拟态（Glassmorphism）+ 暗夜星空蓝 & 鎏金黄色系

## 🚀 快速启动

### 前置要求
- JDK 17 或更高版本
- MySQL 8.0.33+
- Maven 3.6+
- IntelliJ IDEA（推荐）或其他 Java IDE

### 第一步：初始化数据库
```bash
# 1. 打开 MySQL 管理工具（Navicat/DataGrip/MySQL Workbench）
# 2. 创建数据库：restaurant_system（字符集 utf8mb4，排序规则 utf8mb4_general_ci）
# 3. 执行 SQL 脚本
mysql -u root -p restaurant_system < db/restaurant_system.sql
```

### 第二步：打开项目并同步依赖
```bash
# 使用 IntelliJ IDEA
# File → Open → 选择项目根目录 → OK
# 等待 Maven 自动下载依赖（首次 1-3 分钟）
# File → Project Structure → 确保 JDK 17+ 和语言级别正确
```

### 第三步：配置数据库和 AI 密钥
编辑 `src/main/resources/application.yml`：
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/restaurant_system?useSSL=false&serverTimezone=UTC
    username: root  # 修改为你的 MySQL 用户名
    password: your_password  # 修改为你的 MySQL 密码
    driver-class-name: com.mysql.cj.jdbc.Driver

deepseek:
  api-key: sk-your-api-key  # 可选，不填则使用本地规则兜底
```

### 第四步：运行应用
```bash
# IntelliJ IDEA：打开 src/main/java/org/example/Main.java，点击运行按钮
# 或命令行：
mvn spring-boot:run
```

### 第五步：访问系统
打开浏览器访问：**http://localhost:8080**

## 👤 测试账号

| 身份 | 用户名 | 密码 | 体验内容 |
|------|--------|------|---------|
| 管理员 | `admin` | `123456` | 后台管理面板、用户管理、菜品管理 |
| 普通食客 | `sun` 或 `zhangsan` | `123456` | 地图探索、点餐、评价、AI 客服咨询 |

## 📁 项目结构

```
main/
├── db/
│   ├── init.sql                     # 基础数据库脚本
│   └── restaurant_system.sql        # 完整系统结构与初始数据
├── pom.xml                          # Maven 依赖配置
├── src/main/
│   ├── java/org/example/
│   │   ├── Main.java                # Spring Boot 主启动类
│   │   ├── common/                  # 全局通用组件
│   │   ├── config/                  # 核心配置（安全、AI 等）
│   │   ├── controller/              # RESTful API 控制层
│   │   ├── dto/                     # 数据传输对象
│   │   ├── entity/                  # 数据库实体映射
│   │   ├── mapper/                  # 数据访问接口 & SQL
│   │   └── service/                 # 业务逻辑实现
│   └── resources/
│       ├── application.yml          # 全局配置文件
│       ├── mapper/                  # MyBatis XML 映射
│       └── static/                  # 前端资源
│           ├── css/style.css        # 全站样式表
│           ├── data/china.json      # ECharts 地理数据
│           ├── images/dishes/       # 菜品图库
│           ├── js/api.js            # 网络请求封装
│           ├── pages/               # 业务子模块页面
│           └── index.html           # 主页
└── README.md
```

## 💡 开发小贴士

### 1️⃣ 避免内置浏览器端口冲突
⚠️ **不要**点击编辑器右上角的内置浏览器预览按钮，IDEA 内置浏览器使用 63342 端口会导致后端接口 404。请使用系统浏览器访问 `http://localhost:8080`。

### 2️⃣ 前端热更新
修改 `src/main/resources/static/` 下的代码后：
```bash
# IDEA 快捷键：Ctrl + F9（自动编译到 target）
# 浏览器：Ctrl + F5（强制清空缓存刷新）
# 无需重启 Java 后端！
```

### 3️⃣ 端口占用处理
遇到 `Port 8080 was already in use` 错误？
```bash
# 方案一：IDEA 控制台点击停止按钮后重新启动
# 方案二：修改 application.yml
server:
  port: 8081  # 改为其他端口
```

## 🔑 AI 功能配置

### 获取 DeepSeek API Key
1. 访问 [DeepSeek 官网](https://platform.deepseek.com)
2. 注册开发者账号
3. 在 API 控制台创建新的 Secret Key
4. 复制密钥到 `application.yml` 的 `deepseek.api-key` 字段

### 本地降级
如果不配置 API Key 或网络异常，系统会自动切换至本地随机推荐算法，业务功能不受影响。

## 🎯 命令行启动

无需 IDE，使用 Maven 直接打包运行：
```bash
# 编译打包
mvn clean package -DskipTests

# 运行 JAR
java -jar target/food-1.0-SNAPSHOT.jar

# 访问
# http://localhost:8080
```

## 👥 小组成员与分工

| 成员 | 负责模块 | 占比 |
|------|---------|------|
| 栾羽 | 前端编写、交互优化、静态资源、项目 PPT | 30% |
| 孙洪茹 | 后端架构、用户认证、菜品查询、点餐逻辑 | 35% |
| 杨梦琪 | 购物车、通知系统、评价模块、特色数据 | 35% |

## 📝 常见问题

**Q: 如何在 Linux/命令行环境运行？**
```bash
mvn clean package -DskipTests
java -jar target/food-1.0-SNAPSHOT.jar
```

**Q: 没有配置 DeepSeek Key 会怎样？**
系统自动切换至本地规则算法，不影响任何业务功能。

**Q: 如何修改默认端口？**
编辑 `application.yml` 中的 `server.port` 字段。

**Q: 如何重置密码？**
直接修改 MySQL 数据库中的密码字段（预设测试账号密码均为 `123456`）。

## 📄 许可证

MIT License

## 🤝 反馈与贡献

欢迎提交 Issue 和 Pull Request！

---

**最后更新**：2026 年 7 月 | **项目版本**：1.0