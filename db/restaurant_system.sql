/*
 Navicat Premium Dump SQL

 Source Server         : restaurant_system
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : restaurant_system

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 07/07/2026 18:15:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '购物车项ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `dish_id` bigint NOT NULL COMMENT '菜品ID',
  `quantity` int NOT NULL DEFAULT 1 COMMENT '数量',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_dish`(`user_id` ASC, `dish_id` ASC) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购物车表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜品ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜品名称',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜品简介',
  `price` decimal(10, 2) NOT NULL COMMENT '价格',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片URL(相对路径)',
  `category_id` bigint NULL DEFAULT NULL COMMENT '所属分类ID',
  `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所属省份',
  `taste_tags` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '口味标签(逗号分隔)',
  `side_dishes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '配菜信息(逗号分隔)',
  `stock` int NOT NULL DEFAULT 999 COMMENT '库存',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-下架, 1-上架',
  `sales_count` int NOT NULL DEFAULT 0 COMMENT '销量',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_province`(`province` ASC) USING BTREE,
  INDEX `idx_category`(`category_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dish
-- ----------------------------
INSERT INTO `dish` VALUES (1, '麻婆豆腐', '麻辣鲜香，豆腐嫩滑，经典川菜代表', 28.00, '/images/dishes/mapo-tofu.jpg', 1, '四川', '麻,辣,鲜香', '肉末,葱花,花椒', 999, 1, 120, '2026-07-06 22:40:14', '2026-07-06 22:40:14');
INSERT INTO `dish` VALUES (2, '宫保鸡丁', '鸡肉嫩滑，花生酥脆，酸甜微辣', 38.00, '/images/dishes/kung-pao-chicken.jpg', 1, '四川', '甜,酸,鲜香', '花生粒,葱段,干辣椒', 999, 1, 150, '2026-07-06 22:40:14', '2026-07-06 22:40:14');
INSERT INTO `dish` VALUES (3, '白切鸡', '皮黄肉白，原汁原味，蘸料鲜美', 48.00, '/images/dishes/white-cut-chicken.jpg', 2, '广东', '清淡,鲜香', '姜葱蘸料,香菜', 999, 1, 98, '2026-07-06 22:40:14', '2026-07-06 22:40:14');
INSERT INTO `dish` VALUES (4, '烧鹅', '外皮酥脆，肉质鲜嫩多汁', 68.00, '/images/dishes/roast-goose.jpg', 2, '广东', '鲜香,甘香', '酸梅酱,黄瓜', 999, 1, 85, '2026-07-06 22:40:14', '2026-07-07 18:07:25');
INSERT INTO `dish` VALUES (5, '糖醋鲤鱼', '外焦里嫩，酸甜可口，造型优美', 58.00, '/images/dishes/sweet-sour-carp.jpg', 3, '山东', '酸甜,酥脆', '葱花,姜末,香菜', 999, 1, 76, '2026-07-06 22:40:14', '2026-07-07 18:07:41');
INSERT INTO `dish` VALUES (6, '九转大肠', '色泽红润，口感丰富，五味俱全', 58.00, '/images/dishes/braised-intestines.jpg', 3, '山东', '甘香,鲜,鲜香', '葱花,姜片,香菜', 999, 1, 62, '2026-07-06 22:40:14', '2026-07-07 18:07:46');
INSERT INTO `dish` VALUES (7, '狮子头', '肉质鲜嫩，汤汁浓郁，入口即化', 45.00, '/images/dishes/lion-head.jpg', 4, '江苏', '鲜香,清淡', '青菜,香菇,马蹄', 999, 1, 90, '2026-07-06 22:40:14', '2026-07-06 22:40:14');
INSERT INTO `dish` VALUES (8, '松鼠鳜鱼', '刀工精湛，酸甜酥脆，形似松鼠', 88.00, '/images/dishes/squirrel-mandarin.jpg', 4, '江苏', '酸甜,酥脆', '松子,番茄酱', 999, 1, 55, '2026-07-06 22:40:14', '2026-07-06 22:40:14');
INSERT INTO `dish` VALUES (9, '西湖醋鱼', '鱼肉鲜嫩，醋香浓郁，酸甜适口', 68.00, '/images/dishes/west-lake-fish.jpg', 5, '浙江', '酸甜,鲜香', '姜末,葱花', 999, 1, 70, '2026-07-06 22:40:14', '2026-07-06 22:40:14');
INSERT INTO `dish` VALUES (10, '东坡肉', '肥而不腻，酥烂可口，酒香浓郁', 58.00, '/images/dishes/dongpo-pork.jpg', 5, '浙江', '甘香,鲜,浓郁', '青菜,荷叶', 999, 1, 82, '2026-07-06 22:40:14', '2026-07-06 22:40:14');
INSERT INTO `dish` VALUES (11, '佛跳墙', '浓郁荤香，汤汁浓厚，营养丰富', 188.00, '/images/dishes/buddha-jumps-wall.jpg', 6, '福建', '鲜香,浓郁,清淡', '鲍鱼,海参,花菇,鱼翅', 999, 1, 41, '2026-07-06 22:40:14', '2026-07-06 22:40:14');
INSERT INTO `dish` VALUES (12, '剁椒鱼头', '鲜辣浓郁，鱼肉嫩滑，湘菜经典', 78.00, '/images/dishes/chopped-pepper-fish.jpg', 7, '湖南', '辣,鲜香,浓郁', '剁椒,姜片,葱花', 999, 1, 88, '2026-07-06 22:40:14', '2026-07-06 22:40:14');
INSERT INTO `dish` VALUES (13, '臭鳜鱼', '闻着臭吃着香，鱼肉鲜嫩入味', 68.00, '/images/dishes/stinky-mandarin.jpg', 8, '安徽', '咸鲜,微辣,浓郁', '辣椒,姜片,香菜', 999, 1, 57, '2026-07-06 22:40:14', '2026-07-06 22:40:14');
INSERT INTO `dish` VALUES (14, '北京烤鸭', '皮酥肉嫩，色泽红润，享誉世界', 128.00, '/images/dishes/beijing-duck.jpg', 9, '北京', '鲜香,酥脆', '饼皮,甜面酱,黄瓜丝,葱丝', 999, 1, 110, '2026-07-06 22:40:14', '2026-07-06 22:40:14');
INSERT INTO `dish` VALUES (15, '肉夹馍', '汤鲜味浓，腊汁浓郁，西北经典', 35.00, '/images/dishes/pita-bread-soaked.jpg', 10, '陕西', '鲜香,浓郁,甘香', '香菜,蒜末,香菜,辣椒', 999, 1, 95, '2026-07-06 22:40:14', '2026-07-06 22:40:14');
INSERT INTO `dish` VALUES (16, '龙井虾仁', '虾仁滑嫩，茶香清新，色泽淡雅', 88.00, '/images/dishes/longjing-shrimp.jpg', 5, '浙江', '清淡,鲜香,甘香', '龙井茶叶,葱段', 999, 1, 65, '2026-07-07 14:03:20', '2026-07-07 14:03:20');
INSERT INTO `dish` VALUES (17, '宋嫂鱼羹', '汤鲜味美，鱼嫩羹滑，南宋名菜', 42.00, '/images/dishes/song-sao-soup.jpg', 5, '浙江', '鲜香,清淡,微酸', '笋丝,香菇,火腿丝', 999, 1, 55, '2026-07-07 14:03:20', '2026-07-07 14:03:20');
INSERT INTO `dish` VALUES (18, '干炸响铃', '腐皮卷炸至金黄，外酥里嫩', 36.00, '/images/dishes/fried-tofu-roll.jpg', 5, '浙江', '酥脆,鲜香', '甜面酱,葱花', 999, 1, 49, '2026-07-07 14:03:20', '2026-07-07 14:03:20');
INSERT INTO `dish` VALUES (19, '荷叶粉蒸肉', '肉香与荷香融合，软糯不腻', 52.00, '/images/dishes/lotus-leaf-steamed-pork.jpg', 5, '浙江', '鲜香,清淡,甘香', '荷叶,米粉,姜片', 999, 1, 61, '2026-07-07 14:03:20', '2026-07-07 14:03:20');
INSERT INTO `dish` VALUES (20, '桂花糖藕', '藕片软糯，桂香清甜，甜品代表', 28.00, '/images/dishes/osmanthus-lotus-root.jpg', 5, '浙江', '香甜,软糯', '桂花,糯米,冰糖', 999, 1, 91, '2026-07-07 14:03:20', '2026-07-07 14:03:20');
INSERT INTO `dish` VALUES (21, '霉干菜扣肉', '肉烂味浓，霉干菜吸饱油脂，下饭神器', 48.00, '/images/dishes/preserved-vegetable-pork.jpg', 5, '浙江', '咸香,浓郁,微甜', '霉干菜,姜片,冰糖', 999, 1, 75, '2026-07-07 14:03:20', '2026-07-07 14:03:20');
INSERT INTO `dish` VALUES (22, '嘉兴粽子', '浙江端午特色，咸甜两派皆有', 12.00, '/images/dishes/jiaxing-zongzi.jpg', 5, '浙江', '咸香/香甜', '五花肉/豆沙,粽叶,糯米', 999, 1, 120, '2026-07-07 14:03:20', '2026-07-07 14:03:20');
INSERT INTO `dish` VALUES (23, '片儿川', '杭州经典汤面，鲜爽开胃', 22.00, '/images/dishes/pian-er-chuan.jpg', 5, '浙江', '鲜香,清淡,微咸', '雪菜,笋片,瘦肉片', 999, 1, 110, '2026-07-07 14:03:20', '2026-07-07 14:03:20');
INSERT INTO `dish` VALUES (32, '水煮鱼', '麻辣鲜香，鱼肉嫩滑，热油激香', 68.00, '/images/dishes/boiled-fish.jpg', 1, '四川', '麻,辣,鲜香', '豆芽,干辣椒,花椒', 999, 1, 95, '2026-07-07 15:23:36', '2026-07-07 15:23:36');
INSERT INTO `dish` VALUES (33, '回锅肉', '肥而不腻，酱香浓郁，下饭神器', 42.00, '/images/dishes/huiguo-rou.jpg', 1, '四川', '咸香,微甜,鲜香', '青蒜,豆瓣酱,姜片', 999, 1, 88, '2026-07-07 15:23:36', '2026-07-07 15:23:36');
INSERT INTO `dish` VALUES (34, '鱼香肉丝', '鱼香味浓，酸甜辣平衡，肉丝滑嫩', 36.00, '/images/dishes/yuxiang-rousi.jpg', 1, '四川', '甜,酸,辣,鲜香', '木耳,胡萝卜,泡椒', 999, 1, 76, '2026-07-07 15:23:36', '2026-07-07 15:23:36');
INSERT INTO `dish` VALUES (35, '夫妻肺片', '麻辣爽口，红油飘香，凉拌经典', 45.00, '/images/dishes/fuqi-feipian.jpg', 1, '四川', '麻,辣,鲜香', '牛杂,花生碎,香菜', 999, 1, 62, '2026-07-07 15:23:36', '2026-07-07 15:23:36');
INSERT INTO `dish` VALUES (36, '担担面', '麻辣鲜香，面条筋道，川味小吃', 18.00, '/images/dishes/dandan-noodles.jpg', 1, '四川', '麻,辣,鲜香', '芽菜,花生碎,葱花', 999, 1, 110, '2026-07-07 15:23:36', '2026-07-07 15:23:36');
INSERT INTO `dish` VALUES (37, '冰粉', '冰凉清甜，解辣神器，四川甜品', 12.00, '/images/dishes/bingfen.jpg', 1, '四川', '香甜,冰凉', '红糖,山楂,葡萄干', 999, 1, 130, '2026-07-07 15:23:36', '2026-07-07 15:23:36');
INSERT INTO `dish` VALUES (38, '叉烧饭', '蜜汁香甜，肥瘦相间，粤式快餐', 32.00, '/images/dishes/chashao-fan.jpg', 2, '广东', '香甜,咸香', '米饭,青菜,蜜汁', 999, 1, 105, '2026-07-07 15:24:00', '2026-07-07 15:24:00');
INSERT INTO `dish` VALUES (39, '云吞面', '汤鲜味美，云吞饱满，面条弹牙', 25.00, '/images/dishes/wonton-noodles.jpg', 2, '广东', '鲜香,清淡', '鲜虾,云吞皮,韭黄', 999, 1, 92, '2026-07-07 15:24:00', '2026-07-07 15:24:00');
INSERT INTO `dish` VALUES (40, '双皮奶', '奶香浓郁，嫩滑香甜，粤式甜品', 22.00, '/images/dishes/shuangpi-nai.jpg', 2, '广东', '香甜,嫩滑', '牛奶,蛋清,白糖', 999, 1, 140, '2026-07-07 15:24:00', '2026-07-07 15:24:00');
INSERT INTO `dish` VALUES (41, '煲仔饭', '锅巴香脆，腊味飘香，粤式主食', 38.00, '/images/dishes/bozai-fan.jpg', 2, '广东', '咸香,鲜香', '腊味,青菜,酱油', 999, 1, 78, '2026-07-07 15:24:00', '2026-07-07 15:24:00');
INSERT INTO `dish` VALUES (42, '潮汕牛肉丸', '弹牙劲道，汤鲜味美，潮汕特色', 45.00, '/images/dishes/chaoshan-niurouwan.jpg', 2, '广东', '鲜香,弹牙', '牛骨汤,芹菜,香菜', 999, 1, 66, '2026-07-07 15:24:00', '2026-07-07 15:24:00');
INSERT INTO `dish` VALUES (43, '杨枝甘露', '酸甜清爽，果香浓郁，港式甜品', 28.00, '/images/dishes/yangzhi-ganlu.jpg', 2, '广东', '酸甜,清爽', '芒果,西柚,椰奶', 999, 1, 125, '2026-07-07 15:24:00', '2026-07-07 15:24:00');
INSERT INTO `dish` VALUES (44, '葱烧海参', '葱香浓郁，海参软糯，鲁菜名菜', 128.00, '/images/dishes/cong-shao-haishen.jpg', 3, '山东', '鲜香,浓郁', '葱段,海参,酱油', 999, 1, 45, '2026-07-07 15:24:24', '2026-07-07 15:24:24');
INSERT INTO `dish` VALUES (45, '德州扒鸡', '肉质酥烂，脱骨入味，山东特产', 42.00, '/images/dishes/dezhou-paji.jpg', 3, '山东', '咸香,酥烂', '香料,葱花,香菜', 999, 1, 80, '2026-07-07 15:24:24', '2026-07-07 15:24:24');
INSERT INTO `dish` VALUES (46, '油焖大虾', '色泽红亮，虾肉鲜嫩，酸甜咸香', 68.00, '/images/dishes/youmen-daxia.jpg', 3, '山东', '酸甜,咸香', '大虾,番茄酱,姜片', 999, 1, 72, '2026-07-07 15:24:24', '2026-07-07 15:24:24');
INSERT INTO `dish` VALUES (47, '把子肉', '肥而不腻，入口即化，济南名吃', 35.00, '/images/dishes/bazi-rou.jpg', 3, '山东', '咸香,浓郁', '五花肉,酱油,辣椒', 999, 1, 95, '2026-07-07 15:24:24', '2026-07-07 15:24:24');
INSERT INTO `dish` VALUES (48, '煎饼果子', '香脆可口，酱香浓郁，山东小吃', 10.00, '/images/dishes/jianbing-guozi.jpg', 3, '山东', '咸香,酥脆', '面糊,鸡蛋,葱花', 999, 1, 151, '2026-07-07 15:24:24', '2026-07-07 15:24:24');
INSERT INTO `dish` VALUES (49, '拔丝地瓜', '香甜酥脆，拔丝效果，鲁菜甜品', 22.00, '/images/dishes/basi-digua.jpg', 3, '山东', '香甜,酥脆', '地瓜,白糖,芝麻', 999, 1, 110, '2026-07-07 15:24:24', '2026-07-07 15:24:24');
INSERT INTO `dish` VALUES (50, '扬州炒饭', '粒粒分明，配料丰富，鲜香可口', 28.00, '/images/dishes/yangzhou-fan.jpg', 4, '江苏', '鲜香,清淡', '米饭,火腿,青豆', 999, 1, 102, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (51, '大煮干丝', '刀工精细，汤鲜味美，清淡爽口', 32.00, '/images/dishes/dazhu-gansi.jpg', 4, '江苏', '鲜香,清淡', '干丝,虾仁,鸡汤', 999, 1, 68, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (52, '水晶肴肉', '晶莹剔透，鲜香酥烂，镇江名菜', 38.00, '/images/dishes/shuijing-yaorou.jpg', 4, '江苏', '鲜香,酥烂', '猪肉,香料,醋', 999, 1, 74, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (53, '鸭血粉丝汤', '鲜香浓郁，粉丝滑嫩，南京小吃', 22.00, '/images/dishes/yaxue-fensi.jpg', 4, '江苏', '鲜香,浓郁', '鸭血,粉丝,鸭肝', 999, 1, 115, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (54, '蟹黄汤包', '皮薄馅足，汤汁鲜美，靖江特色', 45.00, '/images/dishes/xiehuang-tangbao.jpg', 4, '江苏', '鲜香,浓郁', '蟹黄,猪肉,皮冻', 999, 1, 52, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (55, '桂花糖芋苗', '香甜软糯，桂香浓郁，南京甜品', 18.00, '/images/dishes/guihua-tangyumiao.jpg', 4, '江苏', '香甜,软糯', '芋苗,桂花,红糖', 999, 1, 135, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (56, '沙县拌面', '酱香浓郁，面条筋道，福建小吃', 10.00, '/images/dishes/shaxian-banmian.jpg', 5, '福建', '咸香,鲜香', '花生酱,葱花,香菜', 999, 1, 160, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (57, '土笋冻', '晶莹剔透，鲜香爽口，闽南特色', 25.00, '/images/dishes/tusun-dong.jpg', 5, '福建', '鲜香,清爽', '土笋,醋,芥末', 999, 1, 38, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (58, '姜母鸭', '姜香浓郁，鸭肉鲜嫩，秋冬滋补', 58.00, '/images/dishes/jiangmu-ya.jpg', 5, '福建', '鲜香,浓郁', '生姜,鸭肉,米酒', 999, 1, 65, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (59, '海蛎煎', '外酥里嫩，鲜香可口，闽南小吃', 32.00, '/images/dishes/haili-jian.jpg', 5, '福建', '鲜香,酥脆', '海蛎,鸡蛋,蒜苗', 999, 1, 90, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (60, '扁食汤', '皮薄馅足，汤鲜味美，福建馄饨', 18.00, '/images/dishes/bianshi-tang.jpg', 5, '福建', '鲜香,清淡', '猪肉,扁食皮,葱花', 999, 1, 120, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (61, '烧肉粽', '咸香软糯，馅料丰富，泉州特色', 15.00, '/images/dishes/shaorou-zong.jpg', 5, '福建', '咸香,软糯', '糯米,五花肉,香菇', 999, 1, 105, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (62, '四果汤', '冰凉清爽，酸甜可口，福建甜品', 12.00, '/images/dishes/siguo-tang.jpg', 5, '福建', '酸甜,冰凉', '石花膏,绿豆,仙草', 999, 1, 146, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (63, '毛氏红烧肉', '肥而不腻，色泽红亮，酱香浓郁', 48.00, '/images/dishes/maoshi-hongshaorou.jpg', 6, '湖南', '咸香,浓郁', '五花肉,冰糖,辣椒', 999, 1, 95, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (64, '小炒黄牛肉', '鲜辣爽口，牛肉滑嫩，下饭神器', 52.00, '/images/dishes/xiaochao-huangniurou.jpg', 6, '湖南', '辣,鲜香', '黄牛肉,泡椒,香菜', 999, 1, 82, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (65, '臭豆腐', '外酥里嫩，闻臭吃香，长沙小吃', 15.00, '/images/dishes/choudoufu.jpg', 6, '湖南', '香辣,酥脆', '豆腐,辣椒,蒜蓉', 999, 1, 150, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (66, '口味虾', '麻辣鲜香，虾肉饱满，夜宵爆款', 68.00, '/images/dishes/kouwei-xia.jpg', 6, '湖南', '麻,辣,鲜香', '小龙虾,紫苏,辣椒', 999, 1, 70, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (67, '糖油粑粑', '香甜软糯，外脆里糯，长沙甜品', 8.00, '/images/dishes/tangyou-baba.jpg', 6, '湖南', '香甜,软糯', '糯米,白糖,芝麻', 999, 1, 130, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (68, '湘西腊肉', '咸香浓郁，烟熏风味，湖南特产', 42.00, '/images/dishes/xiangxi-larou.jpg', 6, '湖南', '咸香,烟熏', '腊肉,蒜片,辣椒', 999, 1, 60, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (69, '擂辣椒皮蛋', '香辣爽口，皮蛋软糯，下饭菜', 22.00, '/images/dishes/leila-jiao-pidan.jpg', 6, '湖南', '辣,鲜香', '辣椒,皮蛋,蒜蓉', 999, 1, 100, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (70, '黄山炖鸽', '汤鲜味美，鸽肉鲜嫩，滋补名菜', 88.00, '/images/dishes/huangshan-dunge.jpg', 7, '安徽', '鲜香,清淡', '鸽子,黄山笋,枸杞', 999, 1, 42, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (71, '李鸿章大杂烩', '食材丰富，汤汁浓郁，徽菜代表', 58.00, '/images/dishes/lihongzhang-dazahui.jpg', 7, '安徽', '鲜香,浓郁', '鸡肉,猪肚,香菇', 999, 1, 65, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (72, '毛豆腐', '发酵风味，鲜香浓郁，徽州小吃', 25.00, '/images/dishes/mao-doufu.jpg', 7, '安徽', '鲜香,浓郁', '豆腐,辣椒,葱花', 999, 1, 90, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (73, '无为板鸭', '皮黄肉嫩，烟熏鲜香，安徽特产', 45.00, '/images/dishes/wuwei-banya.jpg', 7, '安徽', '咸香,烟熏', '鸭子,香料,醋', 999, 1, 72, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (74, '绩溪炒面', '筋道爽口，酱香浓郁，安徽小吃', 18.00, '/images/dishes/jixi-chaomian.jpg', 7, '安徽', '咸香,鲜香', '面条,青菜,肉丝', 999, 1, 110, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (75, '合肥辣糊汤', '香辣浓郁，食材丰富，早餐必备', 10.00, '/images/dishes/hefei-lahutang.jpg', 7, '安徽', '辣,鲜香', '千张,木耳,辣椒', 999, 1, 140, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (76, '墨子酥', '香甜酥脆，芝麻浓郁，安徽甜品', 22.00, '/images/dishes/mozi-su.jpg', 7, '安徽', '香甜,酥脆', '芝麻,白糖,面粉', 999, 1, 105, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (77, '炸酱面', '酱香浓郁，面条筋道，北京小吃', 22.00, '/images/dishes/zhajiang-mian.jpg', 8, '北京', '咸香,浓郁', '面条,炸酱,黄瓜丝', 999, 1, 130, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (78, '卤煮火烧', '汤汁浓郁，食材丰富，老北京味', 35.00, '/images/dishes/luzhu-huoshao.jpg', 8, '北京', '咸香,浓郁', '猪肠,肺头,火烧', 999, 1, 85, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (79, '爆肚', '口感脆嫩，麻酱鲜香，北京小吃', 42.00, '/images/dishes/baodu.jpg', 8, '北京', '鲜香,麻香', '牛肚,麻酱,香菜', 999, 1, 68, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (80, '艾窝窝', '软糯香甜，馅料丰富，宫廷小吃', 15.00, '/images/dishes/aiwowo.jpg', 8, '北京', '香甜,软糯', '糯米,豆沙,芝麻', 999, 1, 120, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (81, '驴打滚', '香甜软糯，豆香浓郁，老北京甜品', 18.00, '/images/dishes/lv-dagun.jpg', 8, '北京', '香甜,软糯', '黄豆面,红豆沙,糯米', 999, 1, 145, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (82, '豆汁儿', '酸香独特，养胃饮品，老北京特色', 10.00, '/images/dishes/douzhi-er.jpg', 8, '北京', '酸香,独特', '绿豆,焦圈,咸菜', 999, 1, 55, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (83, '麻豆腐', '咸香微酸，豆香浓郁，老北京小吃', 20.00, '/images/dishes/ma-doufu.jpg', 8, '北京', '咸香,微酸', '绿豆,羊油,辣椒', 999, 1, 70, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (84, '凉皮', '酸辣爽口，筋道爽滑，陕西小吃', 12.00, '/images/dishes/liangpi.jpg', 9, '陕西', '酸辣,清爽', '面筋,黄瓜丝,辣椒油', 999, 1, 150, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (85, 'biangbiang面', '面条宽厚，油泼鲜香，陕西名面', 25.00, '/images/dishes/biangbiang-mian.jpg', 9, '陕西', '香辣,鲜香', '面条,油泼,葱花', 999, 1, 110, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (86, '甑糕', '香甜软糯，枣香浓郁，陕西甜品', 18.00, '/images/dishes/zeng-gao.jpg', 9, '陕西', '香甜,软糯', '糯米,红枣,芸豆', 999, 1, 135, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (87, '葫芦头泡馍', '汤鲜味美，肠嫩馍香，西安特色', 40.00, '/images/dishes/hulutou-paomo.jpg', 9, '陕西', '鲜香,浓郁', '猪大肠,馍块,粉丝', 999, 1, 65, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (88, '油糕', '外酥里甜，香甜酥脆，陕西小吃', 10.00, '/images/dishes/you-gao.jpg', 9, '陕西', '香甜,酥脆', '面粉,红糖,芝麻', 999, 1, 125, '2026-07-07 15:33:28', '2026-07-07 15:33:28');
INSERT INTO `dish` VALUES (89, '荞面饸饹', '筋道爽口，酸辣鲜香，陕北特色', 16.00, '/images/dishes/qiaomian-hele.jpg', 9, '陕西', '酸辣,筋道', '荞麦面,辣椒油,香菜', 999, 1, 90, '2026-07-07 15:33:28', '2026-07-07 15:33:28');

-- ----------------------------
-- Table structure for dish_category
-- ----------------------------
DROP TABLE IF EXISTS `dish_category`;
CREATE TABLE `dish_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类描述',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序序号',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dish_category
-- ----------------------------
INSERT INTO `dish_category` VALUES (1, '川菜', '麻辣鲜香,百菜百味', 1, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (2, '粤菜', '清淡鲜美,原汁原味', 2, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (3, '鲁菜', '咸鲜为主,火候精湛', 3, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (4, '淮扬菜', '刀工精细,口味平和', 4, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (5, '浙菜', '清鲜爽脆,精致细腻', 5, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (6, '闽菜', '鲜香清淡,汤菜讲究', 6, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (7, '湘菜', '香辣浓郁,风味独特', 7, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (8, '徽菜', '咸鲜微辣,重油重色', 8, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (9, '京菜', '融合八方,讲究排场', 9, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (10, '陕菜', '古朴粗犷,面食见长', 10, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `user_id` bigint NOT NULL COMMENT '接收用户ID',
  `order_id` bigint NULL DEFAULT NULL COMMENT '关联订单ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '通知标题',
  `message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '通知内容',
  `is_read` tinyint NOT NULL DEFAULT 0 COMMENT '是否已读: 0-未读, 1-已读',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_read`(`user_id` ASC, `is_read` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统通知表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notification
-- ----------------------------
INSERT INTO `notification` VALUES (1, 4, 1, '🍽️ 上菜通知', '您的订单(202607071446467974)已上菜，祝您用餐愉快！', 1, '2026-07-07 14:47:16');
INSERT INTO `notification` VALUES (2, 1, 2, '🍽️ 上菜通知', '您的订单(202607071450471112)已上菜，祝您用餐愉快！', 1, '2026-07-07 14:51:04');
INSERT INTO `notification` VALUES (3, 4, 3, '🍽️ 上菜通知', '您的订单(202607071611542551)已上菜，祝您用餐愉快！', 1, '2026-07-07 16:12:34');

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `dish_id` bigint NOT NULL COMMENT '菜品ID',
  `dish_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜品名称(快照)',
  `dish_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜品图片(快照)',
  `price` decimal(10, 2) NOT NULL COMMENT '单价(快照)',
  `quantity` int NOT NULL COMMENT '数量',
  `subtotal` decimal(12, 2) NOT NULL COMMENT '小计',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES (1, 1, 1, '麻婆豆腐', '/images/dishes/mapo-tofu.jpg', 28.00, 1, 28.00, '2026-07-07 14:46:47');
INSERT INTO `order_item` VALUES (2, 2, 1, '麻婆豆腐', '/images/dishes/mapo-tofu.jpg', 28.00, 1, 28.00, '2026-07-07 14:50:47');
INSERT INTO `order_item` VALUES (3, 2, 3, '白切鸡', '/images/dishes/white-cut-chicken.jpg', 48.00, 1, 48.00, '2026-07-07 14:50:47');
INSERT INTO `order_item` VALUES (4, 3, 14, '北京烤鸭', '/images/dishes/beijing-duck.jpg', 128.00, 1, 128.00, '2026-07-07 16:11:54');
INSERT INTO `order_item` VALUES (5, 3, 11, '佛跳墙', '/images/dishes/buddha-jumps-wall.jpg', 188.00, 1, 188.00, '2026-07-07 16:11:54');
INSERT INTO `order_item` VALUES (6, 4, 1, '麻婆豆腐', '/images/dishes/mapo-tofu.jpg', 28.00, 1, 28.00, '2026-07-07 16:16:51');
INSERT INTO `order_item` VALUES (7, 5, 15, '羊肉泡馍', '/images/dishes/pita-bread-soaked.jpg', 35.00, 1, 35.00, '2026-07-07 16:18:04');
INSERT INTO `order_item` VALUES (8, 6, 3, '白切鸡', '/images/dishes/white-cut-chicken.jpg', 48.00, 1, 48.00, '2026-07-07 16:18:38');
INSERT INTO `order_item` VALUES (9, 7, 15, '羊肉泡馍', '/images/dishes/pita-bread-soaked.jpg', 35.00, 1, 35.00, '2026-07-07 16:23:23');
INSERT INTO `order_item` VALUES (10, 8, 5, '糖醋鲤鱼', '/images/dishes/sweet-sour-carp.jpg', 58.00, 1, 58.00, '2026-07-07 16:38:14');
INSERT INTO `order_item` VALUES (11, 9, 48, '煎饼果子', '/images/dishes/jianbing-guozi.jpg', 10.00, 1, 10.00, '2026-07-07 17:11:28');
INSERT INTO `order_item` VALUES (12, 10, 62, '四果汤', '/images/dishes/siguo-tang.jpg', 12.00, 1, 12.00, '2026-07-07 17:27:02');

-- ----------------------------
-- Table structure for order_t
-- ----------------------------
DROP TABLE IF EXISTS `order_t`;
CREATE TABLE `order_t`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `total_price` decimal(12, 2) NOT NULL COMMENT '总价',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态: 0-待支付, 1-已支付, 2-已确认, 3-已完成, 4-已取消',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_no`(`order_no` ASC) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_order_no`(`order_no` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_t
-- ----------------------------
INSERT INTO `order_t` VALUES (1, '202607071446467974', 4, 28.00, 3, NULL, '2026-07-07 14:46:47', '2026-07-07 14:46:47');
INSERT INTO `order_t` VALUES (2, '202607071450471112', 1, 76.00, 3, NULL, '2026-07-07 14:50:47', '2026-07-07 14:50:47');
INSERT INTO `order_t` VALUES (3, '202607071611542551', 4, 316.00, 3, NULL, '2026-07-07 16:11:54', '2026-07-07 16:11:54');
INSERT INTO `order_t` VALUES (4, '202607071616511118', 4, 28.00, 1, NULL, '2026-07-07 16:16:51', '2026-07-07 16:16:51');
INSERT INTO `order_t` VALUES (5, '202607071618042823', 4, 35.00, 1, NULL, '2026-07-07 16:18:04', '2026-07-07 16:18:04');
INSERT INTO `order_t` VALUES (6, '202607071618385252', 4, 48.00, 1, NULL, '2026-07-07 16:18:38', '2026-07-07 16:18:38');
INSERT INTO `order_t` VALUES (7, '202607071623235672', 4, 35.00, 1, NULL, '2026-07-07 16:23:23', '2026-07-07 16:23:23');
INSERT INTO `order_t` VALUES (8, '202607071638140002', 1, 58.00, 0, NULL, '2026-07-07 16:38:14', '2026-07-07 16:38:14');
INSERT INTO `order_t` VALUES (9, '202607071711288057', 4, 10.00, 1, NULL, '2026-07-07 17:11:28', '2026-07-07 17:11:28');
INSERT INTO `order_t` VALUES (10, '202607071727013690', 4, 12.00, 1, NULL, '2026-07-07 17:27:02', '2026-07-07 17:27:02');

-- ----------------------------
-- Table structure for province_feature
-- ----------------------------
DROP TABLE IF EXISTS `province_feature`;
CREATE TABLE `province_feature`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `province_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '省份名称',
  `cuisine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜系名称',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省份美食简介',
  `preview_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省份预览图',
  `recommend_dish_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '推荐菜品ID列表(逗号分隔)',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-隐藏, 1-显示',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `province_name`(`province_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '省份特色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of province_feature
-- ----------------------------
INSERT INTO `province_feature` VALUES (1, '四川', '川菜', '天府之国,麻辣鲜香,百菜百味', NULL, '1,2', 1, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (2, '广东', '粤菜', '食在广州,清淡鲜美,原汁原味', NULL, '3,4', 1, 2, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (3, '山东', '鲁菜', '孔孟之乡,咸鲜为主,火候精湛', NULL, '5,6', 1, 3, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (4, '江苏', '淮扬菜', '江南水乡,刀工精细,口味平和', NULL, '7,8', 1, 4, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (5, '浙江', '浙菜', '西湖美景,清鲜爽脆,精致细腻', NULL, '9,10', 1, 5, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (6, '福建', '闽菜', '山海相融,鲜香清淡,汤菜讲究', NULL, '11', 1, 6, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (7, '湖南', '湘菜', '无辣不欢,香辣浓郁,风味独特', NULL, '12', 1, 7, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (8, '安徽', '徽菜', '徽州味道,咸鲜微辣,重油重色', NULL, '13', 1, 8, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (9, '北京', '京菜', '帝都风味,融合八方,讲究排场', NULL, '14', 1, 9, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (10, '陕西', '陕菜', '三秦大地,古朴粗犷,面食见长', NULL, '15', 1, 10, '2026-07-06 20:28:07', '2026-07-06 20:28:07');

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `dish_id` bigint NOT NULL COMMENT '菜品ID',
  `order_id` bigint NULL DEFAULT NULL COMMENT '关联订单ID',
  `rating` tinyint NOT NULL COMMENT '评分(1-5)',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评价内容',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_dish`(`dish_id` ASC) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_order`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评价表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review
-- ----------------------------
INSERT INTO `review` VALUES (1, 4, 1, 1, 5, '很好吃，推荐', '2026-07-07 14:49:06');
INSERT INTO `review` VALUES (2, 1, 14, 3, 5, '好吃，美味', '2026-07-07 16:36:30');
INSERT INTO `review` VALUES (3, 1, 11, 3, 4, '性价不不太高，但是好吃', '2026-07-07 16:36:50');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码(BCrypt加密)',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像URL',
  `role` tinyint NOT NULL DEFAULT 0 COMMENT '角色: 0-普通用户, 1-管理员',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$5Uej1EpX7aU3871TuzYXtOHgLCr1MJ2jDzl0QTIaAkjECZc7nqUj.', '管理员', '13800000000', NULL, 1, 1, '2026-07-06 20:28:07', '2026-07-06 20:45:37');
INSERT INTO `user` VALUES (2, 'zhangsan', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '张三', '13800000001', NULL, 0, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `user` VALUES (3, 'lisi', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '李四', '13800000002', NULL, 0, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `user` VALUES (4, 'sun', '$2a$10$vlmrFTMjuURySDGbeVZ.8e9.kEVDu8Z/wH/neIarHhyEJo4PCQ9Oi', 'sun', '156000000', NULL, 0, 1, '2026-07-06 20:45:14', '2026-07-06 20:45:14');

SET FOREIGN_KEY_CHECKS = 1;
