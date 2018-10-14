/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : tp5

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-10-14 16:42:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tp5_admins`
-- ----------------------------
DROP TABLE IF EXISTS `tp5_admins`;
CREATE TABLE `tp5_admins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '管理员昵称',
  `picture` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '管理员头像',
  `password` varchar(120) COLLATE utf8_unicode_ci NOT NULL DEFAULT '87d9bb400c0634691f0e3baaf1e2fd0d' COMMENT '管理员登录密码',
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态标识',
  `content` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '世界上没有两片完全相同的叶子！' COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tp5_admins
-- ----------------------------
INSERT INTO `tp5_admins` VALUES ('2', 'test', '/cms/images/user.png', '87d9bb400c0634691f0e3baaf1e2fd0d', '2', '2018-02-11 21:02:43', '2018-02-11 21:02:43', '1', '世界上没有两片完全相同的叶子！');
INSERT INTO `tp5_admins` VALUES ('3', 'admin', '/cms/images/user.png', '87d9bb400c0634691f0e3baaf1e2fd0d', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43', '1', '世界上没有两片完全相同的叶子！');

-- ----------------------------
-- Table structure for `tp5_admin_roles`
-- ----------------------------
DROP TABLE IF EXISTS `tp5_admin_roles`;
CREATE TABLE `tp5_admin_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '角色称呼',
  `nav_menu_ids` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '权限下的菜单ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态标识',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tp5_admin_roles
-- ----------------------------
INSERT INTO `tp5_admin_roles` VALUES ('1', '终级管理员', '10|14|11|13|1|2|3|4|5|6|7|8|34|35|36|37|38|39|', '2018-02-11 21:02:43', '2018-02-11 21:02:43', '1');
INSERT INTO `tp5_admin_roles` VALUES ('2', '初级管理员', '1|2|3|5', '2018-02-11 21:02:43', '2018-02-11 21:02:43', '1');

-- ----------------------------
-- Table structure for `tp5_articles`
-- ----------------------------
DROP TABLE IF EXISTS `tp5_articles`;
CREATE TABLE `tp5_articles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Article 主键',
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '作者ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `list_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序标识 越大越靠前',
  `content` text COLLATE utf8_unicode_ci NOT NULL COMMENT '文章内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tp5_articles
-- ----------------------------
INSERT INTO `tp5_articles` VALUES ('1', '讲个笑话：苹果为了“保护你” 让你手机变卡了', '1', '2018-02-11 21:02:42', '2018-02-11 21:02:42', '2', '曾长时间使用过苹果产品的人都会有一个感性的认识，产品用的久了就容易变卡，应用的使用不太顺畅，这种现象在如付费支付、户外定位等急切情况下会令人非常焦急。');
INSERT INTO `tp5_articles` VALUES ('2', '放不下的是手机，感受不到的是生活', '2', '2018-02-11 21:02:43', '2018-02-11 21:02:43', '3', '早晨醒来第一件事情便是解锁手机,瞄一眼朋友圈和工作群组的更新消息,手机电量少于30%就开始焦虑恐慌,偶尔和老友涮火锅,吃到一半抱着手机出去回电话,回桌发现涮好的肥牛早就凉了');
INSERT INTO `tp5_articles` VALUES ('3', '魔术97-111不敌鹈鹕 惨遭七连败', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43', '6', '开场后，第32秒，佩顿在朗多投篮时犯规，送给鹈鹕2次罚球机会。第1分35秒，考辛斯妙传，朱-霍勒迪三分远投命中。第7分28秒，佩顿手滑丢球，被考辛斯抢断。鹈鹕对篮板发起疯狂进攻，本节共抢下16个篮板，包括6个前场篮板，其中戴维斯一人就贡献4个篮板球。');

-- ----------------------------
-- Table structure for `tp5_article_points`
-- ----------------------------
DROP TABLE IF EXISTS `tp5_article_points`;
CREATE TABLE `tp5_article_points` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID 标识',
  `article_id` int(11) DEFAULT NULL COMMENT '文章标识',
  `view` int(11) NOT NULL DEFAULT '0' COMMENT '文章浏览量',
  `keywords` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '关键词',
  `picture` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '文章配图',
  `abstract` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '文章摘要',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '删除标记',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tp5_article_points
-- ----------------------------
INSERT INTO `tp5_article_points` VALUES ('1', '1', '2', '', '/home/images/article_1.jpg', '曾长时间使用过苹果产品的人都会有一个感性的认识，产品用的久了就容易变卡，应用的使用不太顺畅，这种现象在如付费支付、户外定位等急切情况下会令人非常焦急。', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_article_points` VALUES ('2', '2', '12', '', '/home/images/article_2.jpg', '早晨醒来第一件事情便是解锁手机,瞄一眼朋友圈和工作群组的更新消息,手机电量少于30%就开始焦虑恐慌', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_article_points` VALUES ('3', '3', '2', '', '/home/images/article_3.jpg', '北京时间12月23日，NBA常规赛继续进行，新奥尔良鹈鹕客场挑战奥兰多魔术，魔术97-111不敌鹈鹕，惨遭七连败。', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43');

-- ----------------------------
-- Table structure for `tp5_comments`
-- ----------------------------
DROP TABLE IF EXISTS `tp5_comments`;
CREATE TABLE `tp5_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL DEFAULT '0' COMMENT '文章ID',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `reply_id` int(11) NOT NULL DEFAULT '0' COMMENT '所回复的评论ID,0表示原始评论',
  `content` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '评论内容',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tp5_comments
-- ----------------------------
INSERT INTO `tp5_comments` VALUES ('1', '1', '2', '0', '这是一个神奇的世界，你是个神奇的人！', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_comments` VALUES ('2', '1', '1', '1', '嗯，你说的对！', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_comments` VALUES ('3', '2', '2', '0', '我们啊，其实都一样', '2018-02-11 21:02:43', '2018-02-11 21:02:43');

-- ----------------------------
-- Table structure for `tp5_customer`
-- ----------------------------
DROP TABLE IF EXISTS `tp5_customer`;
CREATE TABLE `tp5_customer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `c_name` varchar(50) NOT NULL COMMENT '用户名称',
  `passwd` varchar(50) NOT NULL COMMENT '用户密码',
  `phone` varchar(15) NOT NULL DEFAULT '0',
  `is_vip` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '1 是会员 ',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  PRIMARY KEY (`id`),
  KEY `c_name` (`c_name`,`passwd`) USING BTREE,
  KEY `is_vip` (`is_vip`) USING BTREE,
  KEY `phone` (`phone`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp5_customer
-- ----------------------------
INSERT INTO `tp5_customer` VALUES ('4', '2323', '5cef00bc95c9512fd0736040314b9b99', '2324', '0', '1539408963');
INSERT INTO `tp5_customer` VALUES ('3', 'test', 'test', '139177777', '0', '0');
INSERT INTO `tp5_customer` VALUES ('5', '111', '8d76bb1fb3434ad1cd70229f0c67b70d', '111', '0', '1539409054');
INSERT INTO `tp5_customer` VALUES ('6', '111', '8d76bb1fb3434ad1cd70229f0c67b70d', '111', '0', '1539409068');
INSERT INTO `tp5_customer` VALUES ('7', '111', '8d76bb1fb3434ad1cd70229f0c67b70d', '111', '0', '1539409104');
INSERT INTO `tp5_customer` VALUES ('8', '2323', '5cef00bc95c9512fd0736040314b9b99', '2324', '0', '1539409139');
INSERT INTO `tp5_customer` VALUES ('9', 'est', '87d9bb400c0634691f0e3baaf1e2fd0d', '1234567', '0', '1539409840');
INSERT INTO `tp5_customer` VALUES ('10', '2324', '5cef00bc95c9512fd0736040314b9b99', '2324', '0', '1539410121');
INSERT INTO `tp5_customer` VALUES ('11', '2324', '5cef00bc95c9512fd0736040314b9b99', '2324', '0', '1539410129');
INSERT INTO `tp5_customer` VALUES ('20', '123', '6fd742a61bd034804c00c49b18045020', '123', '0', '1539411270');
INSERT INTO `tp5_customer` VALUES ('21', '124', 'a0076a7b0cf30b204f640372e8cc6500', '124', '0', '1539411361');
INSERT INTO `tp5_customer` VALUES ('22', '125', 'f25e592b47da0bf698e81452140946ff', '125', '0', '1539411949');
INSERT INTO `tp5_customer` VALUES ('23', '13718900001', '661e5285defc77980dcc2f4225237f07', '13718900001', '0', '1539413093');
INSERT INTO `tp5_customer` VALUES ('24', '前台注册', '78664190a2e474475b3887fe50f58568', '15914572199', '0', '1539433034');

-- ----------------------------
-- Table structure for `tp5_game`
-- ----------------------------
DROP TABLE IF EXISTS `tp5_game`;
CREATE TABLE `tp5_game` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '商品标题',
  `desc` text COMMENT '商品描述',
  `down_url` varchar(255) NOT NULL COMMENT '游戏下载的url',
  `img` text COMMENT '图片路径，多个用逗号隔开',
  `is_del` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，默认否，1是',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `is_del` (`is_del`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp5_game
-- ----------------------------
INSERT INTO `tp5_game` VALUES ('1', 'game1', 'game1game1', '#', '/cms/images/icon/role.png', '1', '1539351368');
INSERT INTO `tp5_game` VALUES ('2', '4354666666667', '4354666666667', '#', '/upload/20181012\\b1b0d037049aee1038373369cc3ba993.jpg', '1', '1539351368');
INSERT INTO `tp5_game` VALUES ('3', '23wr666', 'asdfadsf', '#', '/cms/images/icon/nav_default.png', '1', '1539351978');
INSERT INTO `tp5_game` VALUES ('4', 'dadfadsf', 'adsfasdf', '#', '/upload/20181012\\d7a11277135a0166b35c54c23881968d.jpg', '1', '1539353254');
INSERT INTO `tp5_game` VALUES ('5', '萌萌哒的宠物1', '超高的画质,萌萌哒的宠物,上百关精致的关卡,全新的玩法,给你带来激爽刺激的俄罗斯方块之旅!', '#', '/upload/20181013\\18ebf60df3d7e6d99638ba121f69fb62.jpg', '0', '1539354759');
INSERT INTO `tp5_game` VALUES ('6', '天天打豆豆', '《天天打豆豆》是一款全新的休闲产品,快来体验企鹅们欢乐的打豆豆游戏吧。', '#', '/upload/20181013\\5ee261bdc8870dcdc8b4a21260bca1ef.png', '0', '1539354789');
INSERT INTO `tp5_game` VALUES ('7', '史诗级跑酷游戏', '史诗级跑酷游戏——《悟空！救我》,完美还原《西游记》经典故事,重新演绎齐天大圣的绝技——七十二变,还有众多神奇宝贝等你来体验!', '#', '/upload/20181013\\162cdc7c6e23ee3899431c84c98c22f3.png', '0', '1539391622');

-- ----------------------------
-- Table structure for `tp5_goods`
-- ----------------------------
DROP TABLE IF EXISTS `tp5_goods`;
CREATE TABLE `tp5_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '商品标题',
  `desc` text COMMENT '商品描述',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '商品状态，默认1上架，0为下架',
  `img` text COMMENT '图片路径，多个用逗号隔开',
  `is_top` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否置顶，默认不是，1为置顶',
  `price` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品价格',
  `game_id` varchar(50) NOT NULL DEFAULT '0' COMMENT '商品管理的游戏id,多个用逗号隔开',
  `is_del` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，默认否，1是',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `status` (`status`) USING BTREE,
  KEY `is_top` (`is_top`) USING BTREE,
  KEY `game_id` (`game_id`) USING BTREE,
  KEY `is_del` (`is_del`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp5_goods
-- ----------------------------
INSERT INTO `tp5_goods` VALUES ('1', '1111', '1111', '1', '', '1', '10.00', '6,1,5', '1', '1539356200');
INSERT INTO `tp5_goods` VALUES ('2', '商品111-改', '商品111', '0', '/upload/20181012\\f0521606bc929ccca2e97328efc19ff6.jpg', '0', '12323.00', '6', '0', '1539356474');
INSERT INTO `tp5_goods` VALUES ('3', '234343-改', '333333', '1', '/upload/20181013\\bceef8daf9d7ec17539b02d5bd5ef0fe.jpg', '1', '2.00', '6,1,5', '0', '1539357109');
INSERT INTO `tp5_goods` VALUES ('4', '商品111--改', '商品111', '1', '/upload/20181013\\29b05b40ee9f1cf6e8356dd06fe4cb41.jpg', '1', '12323.00', '6,1,5', '0', '1539357855');
INSERT INTO `tp5_goods` VALUES ('5', 'youoo', 'youoo', '1', '/upload/20181014\\81d702966e625e8b8eb4a44375a741ea.png', '1', '12.00', '5,6', '0', '1539477866');
INSERT INTO `tp5_goods` VALUES ('6', '3yoyo', '3yoyo', '1', '/upload/20181014\\8ae8b597e010f35cb1102798d1a24d46.png', '1', '12.00', '5,6,7', '0', '1539477985');

-- ----------------------------
-- Table structure for `tp5_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `tp5_migrations`;
CREATE TABLE `tp5_migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of tp5_migrations
-- ----------------------------
INSERT INTO `tp5_migrations` VALUES ('1', '2014_10_12_000000_create_users_table', '1');
INSERT INTO `tp5_migrations` VALUES ('2', '2017_12_25_111038_create_articles_table', '1');
INSERT INTO `tp5_migrations` VALUES ('3', '2017_12_26_063736_create_comments_table', '1');
INSERT INTO `tp5_migrations` VALUES ('4', '2018_01_01_115202_create_nav_menus_table', '1');
INSERT INTO `tp5_migrations` VALUES ('5', '2018_01_09_074013_create_article_points_table', '1');
INSERT INTO `tp5_migrations` VALUES ('6', '2018_01_09_075218_create_today_words_table', '1');
INSERT INTO `tp5_migrations` VALUES ('7', '2018_01_28_081729_create_admin_roles_table', '1');
INSERT INTO `tp5_migrations` VALUES ('8', '2018_01_28_081817_create_admins_table', '1');
INSERT INTO `tp5_migrations` VALUES ('9', '2018_02_07_105721_create_sessions_table', '1');

-- ----------------------------
-- Table structure for `tp5_nav_menus`
-- ----------------------------
DROP TABLE IF EXISTS `tp5_nav_menus`;
CREATE TABLE `tp5_nav_menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'navMenu 主键',
  `namez` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父级菜单ID',
  `action` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'action地址（etc:admin/home）',
  `icon` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '自定义图标样式',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态，1：正常，-1：删除',
  `list_order` tinyint(4) NOT NULL DEFAULT '0' COMMENT '排序标识，越大越靠前',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tp5_nav_menus
-- ----------------------------
INSERT INTO `tp5_nav_menus` VALUES ('9', '根级菜单', '0', '', '/cms/images/icon/menu_icon.png', '1', '0', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('1', '菜单管理', '0', '', '/cms/images/icon/menu_icon.png', '1', '2', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('2', '列表', '1', 'cms/menu/index', '/cms/images/icon/menu_list.png', '1', '0', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('3', '前台管理', '0', '', '/cms/images/icon/desktop.png', '0', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('4', '今日赠言', '3', 'cms/todayWord/index', '/cms/images/icon/diplom.png', '0', '0', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('5', '列表', '3', 'cms/article/index', '/cms/images/icon/adaptive.png', '0', '0', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('6', '管理员', '0', '', '/cms/images/icon/manage.png', '1', '0', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('7', '管理员列表', '6', 'cms/admin/index', '/cms/images/icon/admin.png', '1', '0', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('8', '角色列表', '6', 'cms/admin/role', '/cms/images/icon/role.png', '1', '0', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('10', '会员管理', '0', '', '/upload/20181012\\9cfd7da3f8e5be81ffe3cd285264be49.jpg', '1', '10', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('11', '商品管理', '0', '', '/upload/20181012\\403e894c27521e6b941073dfd05b586b.jpg', '1', '8', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('13', '订单管理', '0', '', '/upload/20181012\\b21144533bdb9f932a9e4b6177a29bc3.jpg', '1', '7', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('14', '列表', '10', 'cms/customer/index', '/cms/images/icon/nav_default.png', '1', '0', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_nav_menus` VALUES ('35', '列表', '11', 'cms/goods/index', '/cms/images/icon/nav_default.png', '1', '0', '2018-10-12 15:21:23', '2018-10-12 15:21:23');
INSERT INTO `tp5_nav_menus` VALUES ('34', '列表', '13', 'cms/order/index', '/cms/images/icon/nav_default.png', '1', '0', '2018-10-12 15:19:39', '2018-10-12 15:19:39');
INSERT INTO `tp5_nav_menus` VALUES ('36', '游戏管理', '0', '', '/upload/20181012\\e025e07a3a8027af2e58e60bba1b7150.jpg', '1', '9', '2018-10-12 21:09:07', '2018-10-12 21:09:07');
INSERT INTO `tp5_nav_menus` VALUES ('37', '列表', '36', 'cms/game/index', '/cms/images/icon/nav_default.png', '1', '0', '2018-10-12 21:13:27', '2018-10-12 21:13:27');
INSERT INTO `tp5_nav_menus` VALUES ('38', '添加', '36', 'cms/game/add', '/cms/images/icon/nav_default.png', '1', '0', '2018-10-13 08:45:12', '2018-10-13 08:45:12');
INSERT INTO `tp5_nav_menus` VALUES ('39', '添加', '11', 'cms/goods/add', '/cms/images/icon/nav_default.png', '1', '0', '2018-10-13 09:09:21', '2018-10-13 09:09:21');

-- ----------------------------
-- Table structure for `tp5_order`
-- ----------------------------
DROP TABLE IF EXISTS `tp5_order`;
CREATE TABLE `tp5_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL DEFAULT '0' COMMENT '订单号',
  `gid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `phone` varchar(20) NOT NULL DEFAULT '0' COMMENT '手机号',
  `c_name` varchar(30) NOT NULL COMMENT '用户名',
  `status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态，0未付款，1已付款',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单时间',
  `pay_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '付款时间',
  `pay_money` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单金额',
  `is_del` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '该记录是否删除，0未删除，1已删除',
  PRIMARY KEY (`id`),
  KEY `order_sn` (`order_sn`) USING BTREE,
  KEY `gid` (`gid`,`is_del`,`status`) USING BTREE,
  KEY `phone` (`phone`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp5_order
-- ----------------------------
INSERT INTO `tp5_order` VALUES ('1', '1111111', '1', '1565789', '2222', '1', '1539344024', '1539344024', '21.00', '1');
INSERT INTO `tp5_order` VALUES ('2', '222222', '1', '111111', '3435', '0', '1539344024', '1539344024', '22.00', '0');
INSERT INTO `tp5_order` VALUES ('3', '111111132', '1', '3456780', '565778', '0', '1539344024', '1539344024', '33.00', '0');
INSERT INTO `tp5_order` VALUES ('4', '23234234', '3', '1321234', '4444', '0', '1539360000', '0', '23.00', '0');

-- ----------------------------
-- Table structure for `tp5_today_words`
-- ----------------------------
DROP TABLE IF EXISTS `tp5_today_words`;
CREATE TABLE `tp5_today_words` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '摘句内容，不要太长',
  `from` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '出处',
  `picture` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '插图',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态，1：正常，-1：删除',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tp5_today_words
-- ----------------------------
INSERT INTO `tp5_today_words` VALUES ('1', '谁的青春不迷茫，其实我们都一样！', '谁的青春不迷茫', '/home/images/ps.jpg', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_today_words` VALUES ('2', '想和你重新认识一次 从你叫什么名字说起', '你的名字', '/home/images/ps2.png', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_today_words` VALUES ('3', '我是一只雁，你是南方云烟。但愿山河宽，相隔只一瞬间.', '秦时明月', '/home/images/ps3.png', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_today_words` VALUES ('4', '人老了的好处，就是可失去的东西越来越少了.', '哈尔的移动城堡', '/home/images/ps4.png', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_today_words` VALUES ('5', '到底要怎么才能证明自己成长了 那种事情我也不知道啊 但是只要那一抹笑容尚存 我便心无旁骛 ', '声之形', '/home/images/ps5.png', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_today_words` VALUES ('6', '你觉得被圈养的鸟儿为什么无法自由地翱翔天际？是因为鸟笼不是属于它的东西', '东京食尸鬼', '/home/images/ps6.png', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
INSERT INTO `tp5_today_words` VALUES ('7', '我手里拿着刀，没法抱你。我放下刀，没法保护你', '死神', '/home/images/ps7.png', '1', '2018-02-11 21:02:43', '2018-02-11 21:02:43');
