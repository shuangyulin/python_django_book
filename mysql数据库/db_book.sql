/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : db_book

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2019-10-24 12:31:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_group_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can view log entry', '1', 'view_logentry');
INSERT INTO `auth_permission` VALUES ('5', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can view permission', '2', 'view_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('11', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('12', 'Can view group', '3', 'view_group');
INSERT INTO `auth_permission` VALUES ('13', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('14', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('16', 'Can view user', '4', 'view_user');
INSERT INTO `auth_permission` VALUES ('17', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('18', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('19', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('20', 'Can view content type', '5', 'view_contenttype');
INSERT INTO `auth_permission` VALUES ('21', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('22', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('23', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('24', 'Can view session', '6', 'view_session');
INSERT INTO `auth_permission` VALUES ('25', 'Can add 管理员', '7', 'add_admin');
INSERT INTO `auth_permission` VALUES ('26', 'Can change 管理员', '7', 'change_admin');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete 管理员', '7', 'delete_admin');
INSERT INTO `auth_permission` VALUES ('28', 'Can view 管理员', '7', 'view_admin');
INSERT INTO `auth_permission` VALUES ('29', 'Can add 图书类别', '8', 'add_booktype');
INSERT INTO `auth_permission` VALUES ('30', 'Can change 图书类别', '8', 'change_booktype');
INSERT INTO `auth_permission` VALUES ('31', 'Can delete 图书类别', '8', 'delete_booktype');
INSERT INTO `auth_permission` VALUES ('32', 'Can view 图书类别', '8', 'view_booktype');
INSERT INTO `auth_permission` VALUES ('33', 'Can add 图书信息', '9', 'add_book');
INSERT INTO `auth_permission` VALUES ('34', 'Can change 图书信息', '9', 'change_book');
INSERT INTO `auth_permission` VALUES ('35', 'Can delete 图书信息', '9', 'delete_book');
INSERT INTO `auth_permission` VALUES ('36', 'Can view 图书信息', '9', 'view_book');

-- ----------------------------
-- Table structure for `auth_user`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_user_groups`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_user_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `django_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for `django_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('9', 'Book', 'book');
INSERT INTO `django_content_type` VALUES ('8', 'BookType', 'booktype');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('7', 'Index', 'admin');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for `django_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'BookType', '0001_initial', '2019-10-23 16:25:20.559031');
INSERT INTO `django_migrations` VALUES ('2', 'Book', '0001_initial', '2019-10-23 16:25:20.633729');
INSERT INTO `django_migrations` VALUES ('3', 'Book', '0002_auto_20190907_1447', '2019-10-23 16:25:20.790853');
INSERT INTO `django_migrations` VALUES ('4', 'Book', '0003_auto_20190907_1450', '2019-10-23 16:25:20.869061');
INSERT INTO `django_migrations` VALUES ('5', 'Book', '0004_auto_20190908_1625', '2019-10-23 16:25:20.940749');
INSERT INTO `django_migrations` VALUES ('6', 'Index', '0001_initial', '2019-10-23 16:25:20.997901');
INSERT INTO `django_migrations` VALUES ('7', 'contenttypes', '0001_initial', '2019-10-23 16:25:21.098168');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0001_initial', '2019-10-23 16:25:21.480184');
INSERT INTO `django_migrations` VALUES ('9', 'admin', '0001_initial', '2019-10-23 16:25:22.161958');
INSERT INTO `django_migrations` VALUES ('10', 'admin', '0002_logentry_remove_auto_add', '2019-10-23 16:25:22.317199');
INSERT INTO `django_migrations` VALUES ('11', 'admin', '0003_logentry_add_action_flag_choices', '2019-10-23 16:25:22.333745');
INSERT INTO `django_migrations` VALUES ('12', 'contenttypes', '0002_remove_content_type_name', '2019-10-23 16:25:22.466614');
INSERT INTO `django_migrations` VALUES ('13', 'auth', '0002_alter_permission_name_max_length', '2019-10-23 16:25:22.536740');
INSERT INTO `django_migrations` VALUES ('14', 'auth', '0003_alter_user_email_max_length', '2019-10-23 16:25:22.613384');
INSERT INTO `django_migrations` VALUES ('15', 'auth', '0004_alter_user_username_opts', '2019-10-23 16:25:22.657501');
INSERT INTO `django_migrations` VALUES ('16', 'auth', '0005_alter_user_last_login_null', '2019-10-23 16:25:22.726562');
INSERT INTO `django_migrations` VALUES ('17', 'auth', '0006_require_contenttypes_0002', '2019-10-23 16:25:22.738593');
INSERT INTO `django_migrations` VALUES ('18', 'auth', '0007_alter_validators_add_error_messages', '2019-10-23 16:25:22.755136');
INSERT INTO `django_migrations` VALUES ('19', 'auth', '0008_alter_user_username_max_length', '2019-10-23 16:25:22.839932');
INSERT INTO `django_migrations` VALUES ('20', 'auth', '0009_alter_user_last_name_max_length', '2019-10-23 16:25:22.906408');
INSERT INTO `django_migrations` VALUES ('21', 'auth', '0010_alter_group_name_max_length', '2019-10-23 16:25:22.984405');
INSERT INTO `django_migrations` VALUES ('22', 'auth', '0011_update_proxy_permissions', '2019-10-23 16:25:23.012979');
INSERT INTO `django_migrations` VALUES ('23', 'sessions', '0001_initial', '2019-10-23 16:25:23.067122');

-- ----------------------------
-- Table structure for `django_session`
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for `t_admin`
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `username` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_book`
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book` (
  `barcode` varchar(20) NOT NULL,
  `bookName` varchar(20) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `count` int(11) NOT NULL,
  `publishDate` varchar(20) NOT NULL,
  `publish` varchar(20) NOT NULL,
  `bookPhoto` varchar(80) NOT NULL,
  `bookDesc` longtext NOT NULL,
  `bookFile` varchar(100) NOT NULL,
  `bookTypeObj` int(11) NOT NULL,
  PRIMARY KEY (`barcode`),
  KEY `t_Book_bookTypeObj_7d2d8a28_fk_t_BookType_bookTypeId` (`bookTypeObj`),
  CONSTRAINT `t_Book_bookTypeObj_7d2d8a28_fk_t_BookType_bookTypeId` FOREIGN KEY (`bookTypeObj`) REFERENCES `t_booktype` (`bookTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_book
-- ----------------------------
INSERT INTO `t_book` VALUES ('TS001', 'php网站编程入门', '35.50', '12', '2019-10-09', '人民教育出版社', 'img/1.jpg', '<p>这是一个编程入门书籍</p>', 'file/php.txt', '1');
INSERT INTO `t_book` VALUES ('TS002', '中国近代史', '39.90', '10', '2019-10-01', '科技大学出版社', 'img/2.jpg', '<p><span style=\"font-family: tahoma, arial, 宋体, sans-serif; font-size: 36px;\">中国近代史（1840---1919）（第四版） +&nbsp; 中国近代史（1919&mdash;1949）&nbsp;&nbsp;</span></p>', 'file/jindaishi.txt', '2');
INSERT INTO `t_book` VALUES ('TS003', 'Python项目开发案例集锦', '45.50', '18', '2019-10-09', '吉林大学出版社', 'img/3.jpg', '<ul id=\"J_AttrUL\" style=\"margin: 0px; padding: 0px 20px 18px; list-style: none; zoom: 1; border-top: 1px solid #ffffff; color: #404040; font-family: tahoma, arial, 微软雅黑, sans-serif; font-size: 12px;\">\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"Python项目开发案例集锦\" data-spm-anchor-id=\"a220o.1000855.0.i0.3e5e6b66KmRlws\">产品名称：Python项目开发案例集锦</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;9787569244403\">ISBN编号:&nbsp;9787569244403</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;Python项目开发案例集锦\">书名:&nbsp;Python项目开发案例集锦</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;殷丽爽\">作者:&nbsp;殷丽爽</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;128.00元\">定价:&nbsp;45.50元</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;Python项目开发案例集锦\">书名:&nbsp;Python项目开发案例集锦</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;否\">是否是套装:&nbsp;否</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;吉林大学出版社\">出版社名称:&nbsp;吉林大学出版社</li>\r\n</ul>', 'file/NoFile.jpg', '1');

-- ----------------------------
-- Table structure for `t_booktype`
-- ----------------------------
DROP TABLE IF EXISTS `t_booktype`;
CREATE TABLE `t_booktype` (
  `bookTypeId` int(11) NOT NULL AUTO_INCREMENT,
  `bookTypeName` varchar(40) NOT NULL,
  `days` int(11) NOT NULL,
  PRIMARY KEY (`bookTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_booktype
-- ----------------------------
INSERT INTO `t_booktype` VALUES ('1', '计算机类', '30');
INSERT INTO `t_booktype` VALUES ('2', '历史类', '25');
