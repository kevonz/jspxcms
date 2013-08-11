/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : jspxcms

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2013-08-11 16:04:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cms_action_mark`
-- ----------------------------
DROP TABLE IF EXISTS `cms_action_mark`;
CREATE TABLE `cms_action_mark` (
  `f_actionmark_id` int(11) NOT NULL,
  `f_ftype` varchar(50) NOT NULL COMMENT '外表标识',
  `f_fid` int(11) NOT NULL COMMENT '外表ID',
  `f_mark` varchar(50) NOT NULL COMMENT '标记(cookie,ip或userid)',
  `f_is_userid` char(1) NOT NULL DEFAULT '0' COMMENT '是否用户ID',
  PRIMARY KEY (`f_actionmark_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动标记表';

-- ----------------------------
-- Records of cms_action_mark
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_admin`
-- ----------------------------
DROP TABLE IF EXISTS `cms_admin`;
CREATE TABLE `cms_admin` (
  `f_admin_id` int(11) NOT NULL,
  `f_rank` int(11) NOT NULL DEFAULT '0' COMMENT '等级',
  PRIMARY KEY (`f_admin_id`),
  CONSTRAINT `fk_cms_admin_user` FOREIGN KEY (`f_admin_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of cms_admin
-- ----------------------------
INSERT INTO `cms_admin` VALUES ('0', '1');
INSERT INTO `cms_admin` VALUES ('1', '0');

-- ----------------------------
-- Table structure for `cms_admin_role`
-- ----------------------------
DROP TABLE IF EXISTS `cms_admin_role`;
CREATE TABLE `cms_admin_role` (
  `f_role_id` int(11) NOT NULL,
  `f_admin_id` int(11) NOT NULL,
  PRIMARY KEY (`f_role_id`,`f_admin_id`),
  KEY `fk_cms_adminrole_admin` (`f_admin_id`),
  CONSTRAINT `fk_cms_adminrole_admin` FOREIGN KEY (`f_admin_id`) REFERENCES `cms_admin` (`f_admin_id`),
  CONSTRAINT `fk_cms_adminrole_role` FOREIGN KEY (`f_role_id`) REFERENCES `cms_role` (`f_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与角色关联表';

-- ----------------------------
-- Records of cms_admin_role
-- ----------------------------
INSERT INTO `cms_admin_role` VALUES ('1', '1');

-- ----------------------------
-- Table structure for `cms_attribute`
-- ----------------------------
DROP TABLE IF EXISTS `cms_attribute`;
CREATE TABLE `cms_attribute` (
  `f_attribute_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_number` varchar(20) NOT NULL COMMENT '编码',
  `f_name` varchar(50) NOT NULL COMMENT '名称',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  `f_is_with_image` char(1) NOT NULL DEFAULT '0' COMMENT '是否包含图片',
  `f_image_width` int(11) DEFAULT NULL COMMENT '图片宽度',
  `f_image_height` int(11) DEFAULT NULL COMMENT '图片高度',
  PRIMARY KEY (`f_attribute_id`),
  KEY `fk_cms_attribute_site` (`f_site_id`),
  CONSTRAINT `fk_cms_attribute_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='属性表';

-- ----------------------------
-- Records of cms_attribute
-- ----------------------------
INSERT INTO `cms_attribute` VALUES ('1', '1', 'focus', '焦点', '0', '1', '424', '290');
INSERT INTO `cms_attribute` VALUES ('2', '1', 'bignews', '头条', '1', '1', '50', '50');
INSERT INTO `cms_attribute` VALUES ('3', '1', 'marquee', '滚动', '2', '1', '95', '70');
INSERT INTO `cms_attribute` VALUES ('4', '1', 'recommend', '推荐', '3', '0', null, null);

-- ----------------------------
-- Table structure for `cms_comment`
-- ----------------------------
DROP TABLE IF EXISTS `cms_comment`;
CREATE TABLE `cms_comment` (
  `f_comment_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_creator_id` int(11) NOT NULL COMMENT '创建人',
  `f_auditor_id` int(11) DEFAULT NULL COMMENT '审核人',
  `f_ftype` varchar(50) NOT NULL COMMENT '外表标识',
  `f_fid` int(11) NOT NULL COMMENT '外表ID',
  `f_creation_date` datetime NOT NULL COMMENT '评论时间',
  `f_audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `f_score` int(11) NOT NULL DEFAULT '0' COMMENT '得分',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '0:未审核;1:已审核;2:屏蔽',
  `f_text` longtext,
  `f_ip` varchar(100) NOT NULL DEFAULT '127.0.0.1' COMMENT 'IP地址',
  PRIMARY KEY (`f_comment_id`),
  KEY `fk_cms_comment_site` (`f_site_id`),
  KEY `fk_cms_comment_auditor` (`f_auditor_id`),
  KEY `fk_cms_comment_creator` (`f_creator_id`),
  CONSTRAINT `fk_cms_comment_auditor` FOREIGN KEY (`f_auditor_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_comment_creator` FOREIGN KEY (`f_creator_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_comment_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Records of cms_comment
-- ----------------------------
INSERT INTO `cms_comment` VALUES ('6', '1', '0', null, 'Info', '54', '2013-08-03 09:06:10', null, '0', '0', 'agreg', '0:0:0:0:0:0:0:1');

-- ----------------------------
-- Table structure for `cms_comment_scoreuser`
-- ----------------------------
DROP TABLE IF EXISTS `cms_comment_scoreuser`;
CREATE TABLE `cms_comment_scoreuser` (
  `f_comment_id` int(11) NOT NULL,
  `f_user_id` int(11) NOT NULL,
  PRIMARY KEY (`f_comment_id`,`f_user_id`),
  KEY `fk_cms_comment_user` (`f_user_id`),
  CONSTRAINT `fk_cms_comment_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_user_comment` FOREIGN KEY (`f_comment_id`) REFERENCES `cms_comment` (`f_comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论与用户关联表';

-- ----------------------------
-- Records of cms_comment_scoreuser
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_global`
-- ----------------------------
DROP TABLE IF EXISTS `cms_global`;
CREATE TABLE `cms_global` (
  `f_global_id` int(11) NOT NULL,
  `f_port` int(11) DEFAULT NULL COMMENT '服务端口号',
  `f_context_path` varchar(255) DEFAULT NULL COMMENT '上下文路径',
  `f_version` varchar(50) NOT NULL COMMENT 'jspxcms版本号',
  PRIMARY KEY (`f_global_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='全局表';

-- ----------------------------
-- Records of cms_global
-- ----------------------------
INSERT INTO `cms_global` VALUES ('1', '8080', '/jspxcms', '1.0.0');

-- ----------------------------
-- Table structure for `cms_global_custom`
-- ----------------------------
DROP TABLE IF EXISTS `cms_global_custom`;
CREATE TABLE `cms_global_custom` (
  `f_global_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_globcust_global` (`f_global_id`),
  CONSTRAINT `fk_cms_globcust_global` FOREIGN KEY (`f_global_id`) REFERENCES `cms_global` (`f_global_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='全局自定义表';

-- ----------------------------
-- Records of cms_global_custom
-- ----------------------------
INSERT INTO `cms_global_custom` VALUES ('1', 'sys_flashAllowedExtensions', '');
INSERT INTO `cms_global_custom` VALUES ('1', 'sys_videoAllowedExtensions', '');
INSERT INTO `cms_global_custom` VALUES ('1', 'sys_videoDeniedExtensions', '');
INSERT INTO `cms_global_custom` VALUES ('1', 'sys_linkDeniedExtensions', '');
INSERT INTO `cms_global_custom` VALUES ('1', 'sys_imageAllowedExtensions', '');
INSERT INTO `cms_global_custom` VALUES ('1', 'sys_imageDeniedExtensions', '');
INSERT INTO `cms_global_custom` VALUES ('1', 'sys_linkAllowedExtensions', '');
INSERT INTO `cms_global_custom` VALUES ('1', 'sys_flashDeniedExtensions', '');

-- ----------------------------
-- Table structure for `cms_info`
-- ----------------------------
DROP TABLE IF EXISTS `cms_info`;
CREATE TABLE `cms_info` (
  `f_info_id` int(11) NOT NULL,
  `f_creator_id` int(11) NOT NULL COMMENT '创建者',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_node_id` int(11) NOT NULL COMMENT '节点',
  `f_publish_date` datetime NOT NULL COMMENT '发布日期',
  `f_priority` tinyint(4) NOT NULL DEFAULT '0' COMMENT '优先级',
  `f_is_with_image` char(1) NOT NULL DEFAULT '0' COMMENT '是否包含图片',
  `f_views` int(11) NOT NULL DEFAULT '0' COMMENT '浏览总数',
  `f_downloads` int(11) NOT NULL DEFAULT '0' COMMENT '下载总数',
  `f_comments` int(11) NOT NULL DEFAULT '0' COMMENT '评论总数',
  `f_status` char(1) NOT NULL DEFAULT 'A' COMMENT '状态(0:发起者;1-9:审核中;A:已终审;B:草稿;C:投稿;D:退稿;Z:归档)',
  `f_p1` tinyint(4) DEFAULT NULL COMMENT '自定义1',
  `f_p2` tinyint(4) DEFAULT NULL COMMENT '自定义2',
  `f_p3` tinyint(4) DEFAULT NULL COMMENT '自定义3',
  `f_p4` tinyint(4) DEFAULT NULL COMMENT '自定义4',
  `f_p5` tinyint(4) DEFAULT NULL COMMENT '自定义5',
  `f_p6` tinyint(4) DEFAULT NULL COMMENT '自定义6',
  PRIMARY KEY (`f_info_id`),
  KEY `fk_cms_info_node` (`f_node_id`),
  KEY `fk_cms_info_site` (`f_site_id`),
  KEY `fk_cms_info_user_creator` (`f_creator_id`),
  CONSTRAINT `fk_cms_info_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`),
  CONSTRAINT `fk_cms_info_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_info_user_creator` FOREIGN KEY (`f_creator_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息表';

-- ----------------------------
-- Records of cms_info
-- ----------------------------
INSERT INTO `cms_info` VALUES ('24', '1', '1', '42', '2013-03-18 01:40:28', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('25', '1', '1', '42', '2013-03-18 01:43:00', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('26', '1', '1', '42', '2013-03-18 01:44:25', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('27', '1', '1', '39', '2013-03-18 01:46:31', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('28', '1', '1', '42', '2013-03-18 08:02:31', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('29', '1', '1', '44', '2013-03-18 08:05:49', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('30', '1', '1', '44', '2013-03-18 08:24:13', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('31', '1', '1', '44', '2013-03-18 08:38:20', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('32', '1', '1', '44', '2013-03-18 08:43:42', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('33', '1', '1', '43', '2013-03-18 08:51:10', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('34', '1', '1', '43', '2013-03-18 09:03:03', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('35', '1', '1', '43', '2013-03-18 09:04:05', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('36', '1', '1', '43', '2013-03-18 09:04:57', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('37', '1', '1', '39', '2013-03-18 09:06:26', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('38', '1', '1', '39', '2013-03-18 09:07:16', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('39', '1', '1', '39', '2013-03-18 09:11:20', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('40', '1', '1', '45', '2013-03-18 13:09:08', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('43', '1', '1', '38', '2013-03-19 00:55:52', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('44', '1', '1', '38', '2013-03-19 01:02:32', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('45', '1', '1', '38', '2013-03-19 01:06:31', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('46', '1', '1', '38', '2013-03-19 01:09:43', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('47', '1', '1', '40', '2013-03-19 01:16:20', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('48', '1', '1', '40', '2013-03-19 01:17:39', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('49', '1', '1', '40', '2013-03-19 01:20:15', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('50', '1', '1', '40', '2013-03-19 01:23:30', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('52', '1', '1', '41', '2013-03-19 01:31:00', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('53', '1', '1', '41', '2013-03-19 01:32:45', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('54', '1', '1', '41', '2013-03-19 01:36:50', '0', '0', '10', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('55', '1', '1', '41', '2013-03-19 01:38:50', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('64', '1', '1', '45', '2013-03-18 13:09:41', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('66', '1', '1', '46', '2013-03-21 00:51:40', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('67', '1', '1', '46', '2013-03-21 00:52:42', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('68', '1', '1', '46', '2013-03-21 00:54:19', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('69', '1', '1', '46', '2013-03-21 00:55:22', '0', '0', '20', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('70', '1', '1', '45', '2013-04-04 01:31:04', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('71', '1', '1', '45', '2013-04-07 15:13:21', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);
INSERT INTO `cms_info` VALUES ('72', '1', '1', '45', '2013-04-07 15:13:51', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `cms_info_attribute`
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_attribute`;
CREATE TABLE `cms_info_attribute` (
  `f_infoattr_id` int(11) NOT NULL,
  `f_info_id` int(11) NOT NULL COMMENT '信息',
  `f_attribute_id` int(11) NOT NULL COMMENT '属性',
  `f_image` varchar(255) DEFAULT NULL COMMENT '属性图片',
  PRIMARY KEY (`f_infoattr_id`),
  KEY `fk_cms_infoattr_attribute` (`f_attribute_id`),
  KEY `fk_cms_infoattr_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infoattr_attribute` FOREIGN KEY (`f_attribute_id`) REFERENCES `cms_attribute` (`f_attribute_id`),
  CONSTRAINT `fk_cms_infoattr_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息与属性关联表';

-- ----------------------------
-- Records of cms_info_attribute
-- ----------------------------
INSERT INTO `cms_info_attribute` VALUES ('292', '24', '1', '/uploads/1/image/public/201303/20130319062500_y3wb9h.jpg');
INSERT INTO `cms_info_attribute` VALUES ('293', '24', '2', null);
INSERT INTO `cms_info_attribute` VALUES ('294', '31', '1', '/uploads/1/image/public/201303/20130319062532_e4swxf.jpg');
INSERT INTO `cms_info_attribute` VALUES ('295', '36', '4', null);
INSERT INTO `cms_info_attribute` VALUES ('296', '34', '4', null);
INSERT INTO `cms_info_attribute` VALUES ('297', '33', '3', '/uploads/1/image/public/201303/20130318090142_wqk540.jpg');
INSERT INTO `cms_info_attribute` VALUES ('298', '33', '4', null);
INSERT INTO `cms_info_attribute` VALUES ('299', '55', '3', '/uploads/1/image/public/201303/20130319013832_fclut6.jpg');
INSERT INTO `cms_info_attribute` VALUES ('300', '54', '2', null);
INSERT INTO `cms_info_attribute` VALUES ('301', '54', '3', '/uploads/1/image/public/201303/20130319013604_sofolh.jpg');
INSERT INTO `cms_info_attribute` VALUES ('302', '53', '3', '/uploads/1/image/public/201303/20130319013238_m0ec3s.jpg');
INSERT INTO `cms_info_attribute` VALUES ('303', '52', '3', '/uploads/1/image/public/201303/20130319013347_7r1ulg.jpg');
INSERT INTO `cms_info_attribute` VALUES ('304', '52', '4', null);
INSERT INTO `cms_info_attribute` VALUES ('305', '46', '2', null);
INSERT INTO `cms_info_attribute` VALUES ('306', '46', '3', '/uploads/1/image/public/201303/20130319010927_vcanw2.jpg');
INSERT INTO `cms_info_attribute` VALUES ('307', '45', '3', '/uploads/1/image/public/201303/20130319010606_4bmb91.jpg');
INSERT INTO `cms_info_attribute` VALUES ('308', '45', '4', null);
INSERT INTO `cms_info_attribute` VALUES ('309', '44', '3', '/uploads/1/image/public/201303/20130319010042_m2u3ab.jpg');
INSERT INTO `cms_info_attribute` VALUES ('310', '44', '4', null);
INSERT INTO `cms_info_attribute` VALUES ('311', '43', '1', '/uploads/1/image/public/201303/20130319062425_2c9ht9.jpg');
INSERT INTO `cms_info_attribute` VALUES ('312', '43', '3', '/uploads/1/image/public/201303/20130319005548_uivpg4.jpg');
INSERT INTO `cms_info_attribute` VALUES ('313', '43', '4', null);
INSERT INTO `cms_info_attribute` VALUES ('314', '49', '3', '/uploads/1/image/public/201303/20130319011948_hebrvi.jpg');
INSERT INTO `cms_info_attribute` VALUES ('315', '49', '4', null);
INSERT INTO `cms_info_attribute` VALUES ('316', '48', '2', null);
INSERT INTO `cms_info_attribute` VALUES ('317', '48', '4', null);
INSERT INTO `cms_info_attribute` VALUES ('318', '39', '3', '/uploads/1/image/public/201303/20130318091105_d9ymqp.jpg');
INSERT INTO `cms_info_attribute` VALUES ('319', '39', '4', null);
INSERT INTO `cms_info_attribute` VALUES ('323', '38', '2', null);
INSERT INTO `cms_info_attribute` VALUES ('324', '38', '3', '/uploads/1/image/public/201303/20130318090801_qrqex9.jpg');
INSERT INTO `cms_info_attribute` VALUES ('325', '38', '4', null);
INSERT INTO `cms_info_attribute` VALUES ('326', '37', '3', '/uploads/1/image/public/201303/20130318091208_muyl4o.jpg');
INSERT INTO `cms_info_attribute` VALUES ('327', '37', '4', null);
INSERT INTO `cms_info_attribute` VALUES ('328', '27', '4', null);

-- ----------------------------
-- Table structure for `cms_info_buffer`
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_buffer`;
CREATE TABLE `cms_info_buffer` (
  `f_info_id` int(11) NOT NULL,
  `f_views` int(11) NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `f_downloads` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  `f_comments` int(11) NOT NULL DEFAULT '0' COMMENT '评论次数',
  `f_involveds` int(11) NOT NULL DEFAULT '0' COMMENT '评论参与人数',
  PRIMARY KEY (`f_info_id`),
  CONSTRAINT `fk_cms_infobuffer_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息缓冲表';

-- ----------------------------
-- Records of cms_info_buffer
-- ----------------------------
INSERT INTO `cms_info_buffer` VALUES ('28', '3', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('37', '2', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('39', '2', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('43', '1', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('45', '1', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('48', '2', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('49', '2', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('50', '1', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('52', '2', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('53', '1', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('54', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('67', '1', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('68', '1', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('69', '6', '0', '0', '0');

-- ----------------------------
-- Table structure for `cms_info_clob`
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_clob`;
CREATE TABLE `cms_info_clob` (
  `f_info_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` longtext COMMENT '值',
  KEY `fk_cms_infoclob_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infoclob_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息大字段表';

-- ----------------------------
-- Records of cms_info_clob
-- ----------------------------
INSERT INTO `cms_info_clob` VALUES ('24', 'text', '<p style=\"text-indent: 2em\">&nbsp;</p>\r\n<center>\r\n	<p><img alt=\"\" src=\"/uploads/1/image/public/201303/20130318013715_9pmpu3.jpg\" style=\"width: 550px; height: 507px\" /></p>\r\n	<p>图为王胜俊与周强</p>\r\n</center>\r\n<p style=\"text-indent: 2em\">本站北京3月17日电 今天，最高人民法院召开领导干部大会，宣布中共中央关于最高人民法院党组书记调整的决定。王胜俊、沈跃跃、万鄂湘、周强出席会议并分别讲话。会议由最高人民法院党组副书记、常务副院长沈德咏主持。</p>\r\n<p style=\"text-indent: 2em\">第十二届全国人民代表大会第一次会议选举王胜俊、万鄂湘同志为全国人大常委会副委员长，周强同志为最高人民法院院长。</p>\r\n<p style=\"text-indent: 2em\">中组部常务副部长沈跃跃宣布了中共中央关于最高人民法院党组书记的任免决定。中央决定，周强同志任最高人民法院党组书记，王胜俊同志不再担任最高人民法院党组书记职务。</p>\r\n<p style=\"text-indent: 2em\">沈跃跃说，5年来，在党中央领导下，最高人民法院党组一班人在王胜俊同志带领下，忠实履行宪法和法律赋予的神圣职责，充分发挥审判职能作用，认真贯彻宽严相济刑事政策，依法惩处刑事犯罪，推进社会矛盾化解；创新能动司法理念，积极服务经济发展，妥善审理各类民事、行政案件，加大执行工作力度，切实保障民生；积极推进司法体制和工作机制改革，不断提高审判工作的科学化、规范化和制度化水平；深入开展学习实践科学发展观、创先争优和&ldquo;人民法官为人民&rdquo;等主题教育实践活动，努力践行&ldquo;公正、廉洁、为民&rdquo;司法核心价值观，大力加强全国法院系统干部队伍建设，为维护社会公平正义、促进经济社会发展、推进法治国家建设发挥了重要作用，作出了突出贡献。</p>\r\n<p style=\"text-indent: 2em\">沈跃跃指出，周强同志政治上强，坚决贯彻执行党的路线方针政策，自觉与党中央保持高度一致。周强同志担任过中央国家机关和地方重要领导职务，积累了比较丰富的领导经验。他思维敏捷，视野开阔，组织领导和宏观决策能力比较强，有改革创新精神，注意结合实际创造性地开展工作。相信他一定会在党中央的正确领导下，团结带领最高人民法院党组一班人，紧紧依靠法院系统广大干警，勤奋工作，开拓创新，推动人民法院工作在现有的基础上不断取得新的成绩。</p>\r\n<p style=\"text-indent: 2em\">沈跃跃指出，万鄂湘作为国际法知名专家理论政策水平比较高，组织领导能力比较强，视野开阔，思路清晰，坚持围绕中心、服务大局，坚持司法为民、化解社会矛盾，分管的海事海商审判等各项工作都取得了显著成绩。</p>\r\n<p style=\"text-indent: 2em\">沈跃跃强调，这次最高人民法院领导班子变动，是全国法院系统政治生活中的一件大事。人民法院作为国家的审判机关，肩负着维护社会公平正义、促进经济社会发展、构建社会主义和谐社会的重大责任，面临艰巨繁重的任务，党和人民对人民法院工作寄予厚望。我们要增强做好新形势下人民法院工作的责任感和使命感，深入研究新情况、解决新问题，不断提高法院工作水平，不断提升法院队伍的素质形象和司法公信力。</p>\r\n<p style=\"text-indent: 2em\">王胜俊对周强担任最高人民法院党组书记、院长表示热烈祝贺。他动情地说，五年来，在党中央的坚强领导和全国人大的有力监督下，我和大家携手并肩、共同奋斗，立足中国国情和法院工作实际，妥善应对人民法院工作面临的挑战和考验，认真谋划人民司法事业发展大计，为推动人民法院工作科学发展作出了不懈努力。王胜俊向风雨同舟、同甘共苦的各位院领导、全院干警及离退休老领导、老同志以及全国法院33万干警表示感谢。</p>\r\n<p style=\"text-indent: 2em\">王胜俊说，党的十八大对全面推进依法治国作出重大部署，既对人民法院工作提出了新的更高的要求，也为人民司法事业发展带来了新的机遇。我坚信，在党中央的正确领导下，在以周强同志为班长的最高人民法院党组带领下，在33万法院干警的共同努力下，在社会各界的大力支持下，人民法院一定能够在全面推进依法治国、全面建成小康社会中发挥越来越重要的作用，人民司法事业一定能够迎来更加辉煌灿烂的明天。</p>\r\n<p style=\"text-indent: 2em\">万鄂湘表示，在最高法院工作的13年里，心中充满感慨和温暖。从一名学者到最高法院的大法官，经历了许多，也学到了许多。一个法律人的完美梦想就是一生与法相随：从学法、教法、用法、司法到立法，环环相接，这是最完美的人生轨迹。我有幸能有这样的人生轨迹，得益于中国共产党领导的多党合作制度，得益于实施依法治国战略的伟大时代。司法机关与立法机关的工作紧密相连，在新的工作岗位上，我会一直关注国家的司法事业，全力支持司法体制改革。衷心祝愿人民法院的工作不断进步完善，再创新的辉煌。</p>\r\n<p style=\"text-indent: 2em\">周强表示，王胜俊同志长期从事政法领导工作，政治立场坚定，理论水平高，实践经验丰富，领导能力突出，工作作风扎实，担任最高人民法院院长的五年，是我国人民法院事业与时俱进、开创新局的五年，不仅为我们留下一系列好思路、好作风、好经验，而且培养带出了一支素质优良、忠诚可靠的干部队伍。这是我们进一步做好人民法院工作的坚实基础和宝贵财富，我们一定要倍加珍惜，继续发扬光大。</p>\r\n<p style=\"text-indent: 2em\">周强说，十二届全国人大一次会议选举我为最高人民法院院长，中央决定我担任最高人民法院党组书记，我深感责任重大、使命神圣。我一定要勤奋学习，学习理论，向实践学习，向人民群众学习，向各位老领导学习，向同志们学习；一定要恪尽职守，依法履职，扎实工作，严于律己，决不辜负党中央的信任，决不辜负人民的重托，决不辜负同志们的期望。</p>\r\n<p style=\"text-indent: 2em\">周强指出，党的十八大作出了全面推进依法治国新的战略部署，对新形势下做好人民法院工作提出了新的更高的要求。习近平总书记在党的十八大之后就平安中国、法治中国建设作出了一系列重要指示，提出了明确要求，为人民法院工作指明了方向。我们一定要在以习近平同志为总书记的党中央坚强领导下，深入贯彻落实党的十八大精神和刚刚闭幕的全国&ldquo;<!--keyword--><a class=\"a-tips-Article-QQ\" href=\"http://news.qq.com/zt2012/2012lh/index.htm\" target=\"_blank\"><!--/keyword-->两会<!--keyword--></a><!--/keyword-->&rdquo;精神，深入贯彻落实习近平总书记的一系列重要讲话精神，接好人民法院事业的&ldquo;接力棒&rdquo;，保持工作连续性，紧紧依靠最高人民法院党组一班人和全院干警，紧紧依靠全国法院33万干警，坚持人民法院长期以来形成的好传统，尤其是这五年来积累的新经验，继承创新，扎实工作，始终围绕落实习近平总书记提出的努力让人民群众在每一个司法案件中都感受到公平正义的要求，突出抓好司法为民、公正司法、司法改革、队伍建设、基层基础等工作，不断把人民法院工作推向前进，为全面建成小康社会、夺取中国特色社会主义伟大事业新胜利提供更加有力的司法保障。</p>\r\n<p style=\"text-indent: 2em\">沈德咏表示，中央关于最高人民法院主要负责同志调整的决定，我们完全拥护。在党中央的坚强领导下，在各位领导同志的关心支持下，在以周强同志为班长的最高人民法院党组带领下，人民法院工作一定能够取得新的更大的成绩，一定能够为全面推进依法治国、全面建成小康社会作出新的更大的贡献。</p>\r\n<p style=\"text-indent: 2em\">最高人民法院在京院领导，部分离退休老领导，中组部有关部门负责同志，湖南省委有关领导同志，最高人民法院机关和直属事业单位局级干部参加了会议。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('25', 'text', '<p>自上世纪90年代起，伴随着经济的快速增长，中国年度国防开支一度保持两位数增幅。2010年增幅降到7.5%，2011年后又再次保持两位数的增幅。2013年中国国防预算增长10.7%，总额7202亿元，低于去年军费11.2%的增幅。</p>\r\n<p>　　每年<!--keyword--><a class=\"a-tips-Article-QQ\" href=\"http://news.qq.com/zt2012/2012lh/index.htm\" target=\"_blank\"><!--/keyword-->两会<!--keyword--></a><!--/keyword-->期间，外媒紧盯并担忧中国军费开支似乎已成&ldquo;例牌&rdquo;，今年亦不例外。现在，近邻日本对中国军费尤为&ldquo;上心&rdquo;。</p>\r\n<p>　　日本首相安倍晋三3月6日在参院全体会议上就2013年度中国国防经费同比增加10.7%一事表示，&ldquo;中国缺乏透明度的军力增强是包括我国在内的地区共同的关切事项。&rdquo;那么中国国防开支增长的原因何在？又触动了谁的&ldquo;神经&rdquo;？</p>\r\n<p>　　●南方日报驻京记者 杨春 策划统筹 戎明昌 殷剑锋</p>\r\n<p><strong>　　军费增长只是在&ldquo;补课&rdquo;</strong></p>\r\n<p>　　&ldquo;好像中国每年都需要向外界解释为什么我们要加强国防建设，为什么我们要增加军费。&rdquo;3月4日，新任全国人大新闻发言人傅莹在回应路透社记者有关中国军费的提问时似乎都有些&ldquo;无奈&rdquo;了。</p>\r\n<p>　　根据官方公布数据，2011年中国国防预算为6011亿元人民币，比上年预算执行数约增加676亿元，增长12.7%；2012年国防预算为6702.74亿元人民币，比上年预算执行数增加676.04亿元人民币，增长11.2%；2013年国防预算增长10.7%，总额7202亿元，低于去年军费11.2%的增幅。</p>\r\n<p>　　相比之下，美国仍是全球军费开支最多的国家。2012年，美国军费开支就占到了全球份额的45.3%。2013年美国国防预算总额为6310亿美元，其中5522亿美元用于基础预算，885亿美元用于正在进行的全球作战。</p>\r\n<p>　　日本1月29日正式对外公布了2013年度防卫预算案概要。日本2013国防预算为47500亿日元，折算美元约522亿。如傅莹所说：&ldquo;像中国这么大一个国家，如果不能保卫自己的安全，这对世界来说不会是一个好消息。&rdquo;</p>\r\n<p>　　外界对中国军费增长的&ldquo;担忧&rdquo;似乎也结合了全球军费萎缩的背景。英国具有影响力的智库国际战略研究所近日发布了纵览全球军情年度报告《军事平衡2013》。数据显示，2012年全球军费总额较上一年减少2.05%，连续两年萎缩，2011年减少1.5%。</p>\r\n<p>　　由于亚洲经济的上升以及欧洲国家普遍实行财政紧缩政策，亚洲国家军费开支首次超过了欧洲国家，从2011年到2012年上升4.94%，总额达2874亿美元。</p>\r\n<p>　　报告推算，从国别看，中国军费开支很可能在21世纪20年代至40年代的某一时期反超美国。不过，由于中国经济发展的变化，报告猜测&ldquo;像过去那样增加军费开支也并不轻松&rdquo;。</p>\r\n<p>　　国防大学教授李大光告诉记者，从90年代起我国军费的投入增长只是在&ldquo;补课&rdquo;。因为此前更长一段时间虽然中国经济开始进入高速发展轨道，但军费的投入并没有及时增长。但不管是增长还是下降，这些调整都符合当前我国发展和国防安全的需要。</p>\r\n<p>　<strong>　军费占GDP比</strong></p>\r\n<p><strong>　　远低于安全区间</strong></p>\r\n<p>　　中国长期坚持防御性的国防政策，这与中国总的和平发展大方向相一致。即使是在&ldquo;补偿性&rdquo;增长的情况下，中国的国防支出也低于很多国家。</p>\r\n<p>　　自冷战结束后美国、英国、法国、德国、俄罗斯等世界主要国家军费占GDP的比例保持在2%&mdash;4%之间。按照国防经济学术界的观点，军费占GDP的比例在2%&mdash;4%之间，是比较安全的比例区间。</p>\r\n<p>　　中国的这一比例远远低于2%，2012年中国军费仅占GDP的1.28%。而美国2013年的国防支出占其GDP超过4%，日本国防预算占GDP约5.1%。</p>\r\n<p>　　据了解，中国国防费用主要由人员的生活费、训练维持费和装备费这三部分组成，包括新型武器在内的所有武器装备的研究、实验、采购、维修、运输和储存费用也都包含在每年公布的国防费预算内。</p>\r\n<p>　　&ldquo;军费开支和国民生产总值挂钩，目前中国经济持续平稳快速发展，增加装备建设、军事训练、人才培养都要跟上，适度增加国防开支是很正常的。随着物价上涨，战士和官兵的生活水平、津贴待遇要相应提升，此外科研、人才方面的费用也会增加。&rdquo;李大光说。</p>\r\n<p>　　日本《外交学者》杂志网站3月12日发表的文章指出，&ldquo;与整体经济规模相比，中国的军费开支是均衡、可持续的。&rdquo;英国《金融时报》网站近日也刊文认为，中国国防支出增速其实在放缓，如剔除通胀因素，中国的军事支出增长看上去更不明显。</p>\r\n<p>　　李大光表示，综合中国人口数量、土地面积、海岸线长度等众多因素，和西方一些国家相比，中国的国防投入还是相对较低的。只要看看西方一些国家的军费开支情况，就可以知道中国军费的增长水平并不应该被某些国家拿来炒作或者说三道四。</p>\r\n<p>　<strong>　军力发展跟上</strong></p>\r\n<p><strong>　　经济发展无可厚非</strong></p>\r\n<p>　　一些国家常常指责中国军力发展缺乏&ldquo;透明度&rdquo;，称中国军费实际开支远高于公开数字。然而正好相反，正如傅莹所说，&ldquo;中国的国防预算，施行严格的财政拨款制度。&rdquo;</p>\r\n<p>　　近年来，中国政府按照预算法和国防法，不断提高军费透明度，每年国防费预算都纳入国家预算草案，由全国人大审查批准，按规定程序下达各级、各部门执行，并且接受国家和军队审计部门监督。</p>\r\n<p>　　李大光表示，中国的军事战略也一直是明确的，就是积极防御。中国军队的行动是透明的、友善的和符合国际法的。从1998年以来，中国政府每两年都发表一份国防白皮书，详细介绍中国国防费投入规模和使用方向。2007年中国政府正式参加<span class=\"infoMblog\"><a class=\"a-tips-Article-QQ\" href=\"http://t.qq.com/WorldFoodProgramme#pref=qqcom.keyword\" rel=\"WorldFoodProgramme\" reltitle=\"联合国\" target=\"_blank\">联合国</a></span>军费透明制度，每年向联合国提交军费开支报告，根本不存在所谓&ldquo;隐性军费&rdquo;问题。</p>\r\n<p>　　此外，中国国防部还建立了发言人制度，开通了网站。中国有限的军事力量完全是为了维护国家主权和领土完整。可以说，中国&ldquo;积极防御&rdquo;的国防安全战略决定了无论是否增长军费都不会对任何国家构成威胁。</p>\r\n<p>　　&ldquo;中国作为全球第二大经济体，军力发展跟上经济发展无可厚非。正如中共中央总书记、国家主席习近平今年1月底强调的，走和平发展道路是符合时代发展潮流和中国根本利益作出的战略抉择。坚持走和平发展道路，但决不能放弃我们的正当权益，决不能牺牲国家核心利益。&rdquo;复旦大学教授<span class=\"infoMblog\"><a class=\"a-tips-Article-QQ\" href=\"http://t.qq.com/shfw102#pref=qqcom.keyword\" rel=\"shfw102\" reltitle=\"冯玮\" target=\"_blank\">冯玮</a></span>说。</p>\r\n<p>　　傅莹表示，在国际安全事务当中，中国开始发挥比较大的积极作用。联合国安理会五个常任理事国中，中国向联合国的各项维和活动所派出的维和人员是最多的，中国已经有了一个成系统的培训、派出维和人员的条件和能力。中国海军的护航编队长期在亚丁湾巡航，也得到了广泛赞誉。随着中国的发展和自身能力的提高，参与国际事务，为世界和平作出贡献的能力只会越来越强。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('26', 'text', '<p style=\"text-indent: 2em\">16日下午，人民大会堂北门通道，报道全国<!--keyword--><a class=\"a-tips-Article-QQ\" href=\"http://news.qq.com/zt2012/2012lh/index.htm\" target=\"_blank\"><!--/keyword-->两会<!--keyword--></a><!--/keyword-->的媒体记者&ldquo;长枪短炮&rdquo;地严守这条&ldquo;部长通道&rdquo;，等待采访一位位可能从这里进入人民大会堂参加会议的各部部长。</p>\r\n<p style=\"text-indent: 2em\">十二届全国人大一次会议16日下午在人民大会堂举行第六次全体会议，决定国务院副总理、国务委员等国务院其他组成人员的人选。相比于前两天，&ldquo;部长通道&rdquo;上的记者数量明显增加。不少记者聊天时都说，这里将见证接续与告别。</p>\r\n<p style=\"text-indent: 2em\"><strong>打分</strong></p>\r\n<p style=\"text-indent: 2em\"><strong>人民大会堂共传出四声惊叹</strong></p>\r\n<p style=\"text-indent: 2em\">昨天会议的第一项是根据国务院总理李克强的提名，决定国务院副总理、国务委员、各部部长等人选。听到提名名单，二楼的一些记者开始打电话进行现场连线，凤凰卫视的<span class=\"infoMblog\"><a class=\"a-tips-Article-QQ\" href=\"http://t.qq.com/lvqiuluwei#pref=qqcom.keyword\" rel=\"lvqiuluwei\" reltitle=\"闾丘露薇\" target=\"_blank\">闾丘露薇</a></span>就是其中一位。在听到周小川这个名字时，记者区传出惊叹声。一直追问的答案揭晓：周小川将留任。他成为历经4届政府，担任央行行长时间最长的人。</p>\r\n<p style=\"text-indent: 2em\">由于是表决票，代表们可以表示赞成，可以表示反对，也可以表示弃权。&ldquo;这得票多少，也能看出是对这位部长的打分和期许。&rdquo;同在二楼的某代表团工作人员对部长们的选票进行了另外一种解读。</p>\r\n<p style=\"text-indent: 2em\">工作人员宣读第十二届全国人民代表大会环境与资源保护委员会主任委员、副主任委员、委员名单草案。</p>\r\n<p style=\"text-indent: 2em\">[王胜俊]现在付表决，请按表决器。[03-16 16:25]</p>\r\n<p style=\"text-indent: 2em\">[王胜俊]现在由工作人员宣读表决结果。[03-16 16:26]</p>\r\n<p style=\"text-indent: 2em\">[工作人员]赞成1969票，反对850票，弃权125票。宣读完毕。[03-16 16:26]</p>\r\n<p style=\"text-indent: 2em\">其他专门委员会表决投票情况：</p>\r\n<p style=\"text-indent: 2em\">民族委员会组成人员名单表决通过:赞成2883票，反对48票，弃权18票。</p>\r\n<p style=\"text-indent: 2em\">法律委员会成员名单表决通过：赞成2814票，反对105票，弃权27票。</p>\r\n<p style=\"text-indent: 2em\">内务司法委员会成员名单表决通过：赞成2766票，反对147票，弃权31票。</p>\r\n<p style=\"text-indent: 2em\">教育科学文化卫生委员会成员名单通过：赞成2574票，反对307票，弃权53票。</p>\r\n<p style=\"text-indent: 2em\">外事委员会成员名单表决通过：赞成2633票，反对258票，弃权55票。</p>\r\n<p style=\"text-indent: 2em\">华侨委员会成员名单表决通过：赞成2748票，反对154票，弃权45票。</p>\r\n<p style=\"text-indent: 2em\">农业与农村委员会成员名单表决通过:赞成2658票，反对228票，弃权59票。</p>\r\n<p style=\"text-indent: 2em\"><strong>宣读选举结果时，人民大会堂共传出四声惊叹，分别来自央行行长、住建部部长、环保部部长的选票结果，及全国人大常委会环境与资源保护委员会的表决结果，惊叹来自于他们的反对票。&ldquo;他们的压力要大呦！&rdquo;散会后，有代表议论着。</strong></p>\r\n<p style=\"text-indent: 2em\"><strong>徐绍史：</strong></p>\r\n<p style=\"text-indent: 2em\"><strong>从国土资源部到发改委&ldquo;责任很大&rdquo;</strong></p>\r\n<p style=\"text-indent: 2em\">14时37分，国土资源部部长徐绍史笑呵呵地站到了&ldquo;部长通道&rdquo;的话筒前。面对是否履新的追问，&ldquo;这个，要下午的会议才能知道。&rdquo;徐绍史打了一个太极。</p>\r\n<p style=\"text-indent: 2em\">话一转，徐绍史介绍，国土资源部建立了立体的监管网络，有卫星遥感地图和与之相配合的各种计算机应用系统；有12336中央省市县四级联网的举报网；每个季度有大型案件的挂牌督办；每年有违法违规的约谈问责。他说，通过这些措施能够很好地对全国国土资源开发利用情况进行监控。</p>\r\n<p style=\"text-indent: 2em\">对于与环保部进行的全国地下水普查，徐绍史介绍，国土资源部主要负责区域性的地下水的水量和水质的监控。&ldquo;但是这个网正在建设过程当中，它现在检测的点比较疏散，得不出一些准确的结论。&rdquo;他表示。</p>\r\n<p style=\"text-indent: 2em\">他透露，房屋登记、林地登记、草地登记和土地登记将整合到一个部门来管，&ldquo;这项工作将在两会之后研究推进。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">最后，徐绍史评价了过去几年的工作：在国土资源部打基础、摸家底方面做了两项重要的工作，一是搞了全国土地的第二次调查，二是搞了矿产资源的三项调查。一个部委的工作看上去是千头万绪，但是归结起来实际就三件事，业务、党务和队伍，把这三大块工作融合统筹，取得了比较好的成效。</p>\r\n<p style=\"text-indent: 2em\">16时14分，大会主持人王胜俊宣布：徐绍史为国家发改委主任。</p>\r\n<p style=\"text-indent: 2em\">16时33分，徐绍史以这个新身份出现在记者们面前。&ldquo;非常感谢中央的信任，也感谢代表们的信任，委以重任，我确实感到责任很大、压力也很大。&rdquo;徐绍史坦言。最后，他表示，好在在国家发改委有很好的工作基础，&ldquo;我将和同志们一起，恪尽职守，尽心尽力，做好工作。&rdquo;</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('27', 'text', '<p style=\"text-indent: 2em\">作为淘宝最知名的团购平台，2011年是聚划算的爆发年，而历经反腐门之后，重新出台的聚划算团购服务竞拍规则(俗称&ldquo;坑位费&rdquo;)出台至今就重创了不少中小商家。</p>\r\n<p style=\"text-indent: 2em\">据聚划算官网显示，其竞拍时间为每天上午10：00-11：00，竞拍起拍价为人民币1000元，单次加价幅度为100元及其整数倍，参与聚划算竞拍的卖家应在竞拍前在支付宝账户中冻结1000元保证金。看似门栏低的竞价规则，在一轮轮商家疯狂竞价之后，从几万飙升至几十万，外加聚划算要收的1%到3%不等的佣金，中小商家叫苦不迭。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;很多小卖家上了聚划算，但是卖了几十套、几百套的很多，付坑位费还不够。&rdquo;上海柔仕个人护理用品有限公司王文彬对《投资者报》记者说，&ldquo;聚划算流量是很大，但是类目细分的很厉害，分配给每个坑位的流量实际是有限的，其次聚划算的消费人群本身对价格敏感，如果价格比平时购买并无优势，消费者是不会买单的。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">公开数据显示，2012年聚划算全年交易额207.5亿，是2011年2.03倍，但是分散到各个参与活动卖家却不甚乐观，加上不断上涨的高昂坑位费也影响了单品促销效果。2012年6月，聚划算在上线了品牌团、本地生活，每个品牌团商家平均销售额200万左右/期，最高达到700万(3天)，但品牌团销售额占整个聚划算的30%。</p>\r\n<p style=\"text-indent: 2em\">而随着参与聚划算平台的卖家利润不断挤压，聚划算早已沦为商家劣质产品集散地。&ldquo;据我认识的将近500个卖家，为了保持利润，基本都是压缩成本，在材料上偷换。做饰品的，基本都是拿好的去质检，然后</p>\r\n<p style=\"text-indent: 2em\">用不好的材质去生产，聚划算基本都是问题产品。&rdquo;义乌市朵拓贸易有限公司电子商务韩姓总监对《投资者报》记者说。</p>\r\n<p style=\"text-indent: 2em\"><strong>聚划算成清仓专用</strong></p>\r\n<p style=\"text-indent: 2em\">&ldquo;现在的聚划算我的理解就是清库存才会去上。要不然有些商家竞价那么高，会愿意出的吗，而且谁也无法知道这个销量能否得到保障。&rdquo;上海简恋家居用品有限公司电子商务部运营主管陈明顿对《投资者报》记者感叹到。</p>\r\n<p style=\"text-indent: 2em\">2012年上半年，聚划算从原来免费的模式开始变为竞拍坑位。之前只要跟店小二合作就能开展团购，这导致了一定程度上的内部腐败，之后随着<!--keyword--><span><a class=\"a-tips-Article-QQ\" href=\"http://stockhtm.finance.qq.com/hk/ggcx/01688.htm\" target=\"_blank\"><!--/keyword--><font color=\"#00479d\"><font face=\"微软雅黑\">阿里巴巴<!--keyword--></font></font></a></span><!--/keyword-->反腐，把聚划算的游戏规则重新改写。不过，这个改写也屡遭诟病。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;以前行贿小二，跟小二商量，比如给一万，再拿几个点的提成，如果销量不好，就不需要付那么多的钱。跟之前比，当然是坑位费成本高，现在搞得跟赌博一样。&rdquo;上述韩姓总监愤慨到。</p>\r\n<p style=\"text-indent: 2em\">坑位费的水涨船高，挫败了中小商家，王文斌表示，现在的坑位费导致的是小卖家基本都处于观望的状态，当然对运营能力较强的大卖家而言，几乎没有影响。&ldquo;过去的坑位费大家都比较盲目，上什么都能赚钱，现在坑位费过高了，必须考虑投入产出，对商品销售做合理的预测。&rdquo;电子商务观察员鲁振旺对记者解释道。</p>\r\n<p style=\"text-indent: 2em\">收费竞拍坑位后，中小商家基本上不寄希望能赚钱，只是想处理自己推广不动的商品，而其实如果能做到清库存也不失为一件好事，但即使这样，也未必能如愿。如果上以前去聚划算是为了拉高销量，那现在的情境则完全会让商家绝望。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;不是说销量提升，是销量比原来降了三分之一多，个别类目也有降了一半多。&rdquo;对比竞拍之后的销量变化，上述韩姓总监如此说道。当然他不是最惨的，他认识的一个做化妆品的同行，做聚划算根本没有销量，最后被逼无奈只能自己在十一点刷了五百多单。</p>\r\n<p style=\"text-indent: 2em\">2011年6月开始在聚划算做的韩总监见证了淘宝卖家在这个平台上的流失。他的一个淘宝卖家群有575个淘宝店主，覆盖将近两千个店面，但现在还依然做聚划算的寥寥无几了，除了清库存以外，卖家基本不会再去做聚划算了，而他负责做的几个店早已对聚划算敬而远之。</p>\r\n<p style=\"text-indent: 2em\"><strong>平台急于变现堵死中小商家 </strong></p>\r\n<p style=\"text-indent: 2em\">利用聚划算打造爆款的模式已经过去了，而现在，若想要把库存变现金，聚划算定是好平台，尤其对于有运营能力的卖家，聚划算几乎可以完美解决库存管理难题。</p>\r\n<p style=\"text-indent: 2em\">目前，在淘宝上能给到的流量最多的入口依然是聚划算，而其他的入口几乎都没能转化那么多的存货，但现在单品销售数量跟以前差距太大，以前能上万销量出现的单品，现在已属罕见。</p>\r\n<p style=\"text-indent: 2em\">并且昂贵的坑位费，还有三个点的佣金，加上第一次上聚划算还必须要如淘宝仓库发货，而这里比卖家自行合作的快递价格平均一件多2块左右。</p>\r\n<p style=\"text-indent: 2em\">昂贵的成本，有限的入口，中小卖家生存艰难。&ldquo;之前聚划算是一个快速回笼资金，打造爆款的平台，大家爱之不及，现在只要有正常商业头脑的中小商家对聚划算也逐渐恢复到了正常的心态吧。&rdquo;王文斌说。</p>\r\n<p style=\"text-indent: 2em\">取消坑位费的呼声一直都很高。王文斌认为，&ldquo;淘宝可以转为提高销售提成的方式，这样卖家定价可以更低，且卖家也不存在上一次聚划算亏一次的情况。&rdquo;<a alt=\"点击进入腾讯首页\" bosszone=\"backqqcom\" href=\"http://www.qq.com/?pref=article\" id=\"backqqcom\" target=\"_blank\" title=\"点击进入腾讯首页\"><img height=\"16\" src=\"http://www.qq.com/favicon.ico\" width=\"16\" /></a></p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('28', 'text', '<p>中广网北京3月18日消息 据经济之声《天下财经》报道，因为两家美国公司起诉中国维C出口商联合抬升价格，美国布鲁克林联邦法院最近裁定，中国原料药龙头企业&mdash;&mdash;华北制药集团支付高达1.6亿美元赔偿金。这是中国制药企业第一次在美国反垄断诉讼中遭受处罚裁定。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('29', 'text', '<p>中新网3月18日电 据朝中社报道，朝鲜祖国统一民主主义战线中央委员会17日发表了《告全体朝鲜民族》呼吁书，称美国的&ldquo;挑衅&rdquo;令朝鲜半岛处在战争边缘，并呼吁全体朝鲜民族一致投入抗战，尽到作为民族一员的崇高使命和历史责任。</p>\r\n<p>呼吁书称，美韩&ldquo;关键决心&rdquo;、&ldquo;秃鹫&rdquo;联合军演令朝鲜半岛局势越过危险界线，互相交火的最坏的物理冲突局面已经在所难免。朝鲜半岛从来没有面临像今天这样严重的核战争危机。针对当前的形势，朝鲜军民一致奋起投入了&ldquo;歼敌的全面对决战&rdquo;。</p>\r\n<p>呼吁书表示，&ldquo;朝鲜民族不怕世上任何人，全球没有人能触犯朝鲜民族&rdquo;。&ldquo;在这最后的决一死战中朝鲜将得到的是民族最大的宿愿祖国统一，失去的只是军事分界线&rdquo;。</p>\r\n<p>呼吁书称，全面对决战是维护民族尊严和主权的全体朝鲜民族和美国之间的对决战。对决战中没有北方、南方和海外之分，也没有思想和理念、阶级和阶层、男女老少之别。</p>\r\n<p>呼吁书最后强调，朝鲜的核遏制力是民族主权和尊严的象征，也是捍卫民族的宝剑。&ldquo;对侵略集团，常识、理性、对话都讲不通，国际法也一文不值&rdquo;。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('30', 'text', '<p style=\"text-indent: 2em\">据美联社3月18日报道，瑞典智库斯德哥尔摩国际和平研究所(SIPRI)18日称，中国已取代英国成为世界第五大常规武器出口国。</p>\r\n<p style=\"text-indent: 2em\">SIPRI在报告中称，中国在过去5年(2008-2012)中武器出口总量增长了163%，国际军火市场占有份额从2%增至5%，同时排名也从之前的第八升至第五。</p>\r\n<p style=\"text-indent: 2em\">报告称，中国武器的最大买家来自巴基斯坦，其购买量占到中国常规武器总出口量的55%，紧随其后的是缅甸和孟加拉国，在中国武器出口中的占比分别为8%和7%。</p>\r\n<p style=\"text-indent: 2em\">针对国际社会对近年来中国武器出口的关注，中国国防部发言人耿雁生曾表示，中国在武器出口问题上，一直严格遵循三项原则：一是有助于接收国的正当防卫能力;二是不损害有关地区和世界的和平、安全与稳定;三是不干涉接收国的内政。耿雁生表示，中国严格遵守<span class=\"infoMblog      \"><a class=\"a-tips-Article-QQ\" href=\"http://t.qq.com/WorldFoodProgramme#pref=qqcom.keyword\" loaded=\"1\" rel=\"WorldFoodProgramme\" reltitle=\"联合国\" target=\"_blank\">联合国</a></span>有关决议，建立了一套完备的军品出口管制法规体系，武器出口都是合法的、负责任的。<a href=\"http://www.qq.com/?pref=article\" id=\"backqqcom\" target=\"_blank\" title=\"点击进入腾讯首页\"><img height=\"16\" src=\"http://www.qq.com/favicon.ico\" width=\"16\" /></a></p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('31', 'text', '<p style=\"text-align: center; text-indent: 2em\"><img alt=\"资料图：美军F-35战机进行投弹测试\" src=\"/uploads/1/image/public/201303/20130318083655_tp3mka.jpg\" /></p>\r\n<p style=\"text-align: center; text-indent: 2em\"><span style=\"font-size: 12px\">资料图：美军F-35战机进行投弹测试</span></p>\r\n<p style=\"text-indent: 2em\">中新网3月1日电 据日本新闻网报道，日本政府今日在总理大臣官邸召开安全保障会议，会议上决定日本国内企业可以参与研发制造下一代主力战机F-35零件。</p>\r\n<p style=\"text-indent: 2em\">日本政府认为，允许日本企业参与研发F-35战机有助于日本今后防卫产业。官房长官菅义伟在记者会上发表谈话说，日企参与研发制造F-35战机零件时，需在美国的严格管理下进行。</p>\r\n<p style=\"text-indent: 2em\">文章指出，一旦日本参与相关零件制造，以色列可能会大量进口该零件，无疑会助长国际纷争，此举违反了&ldquo;武器出口三原则&rdquo;。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('32', 'text', '<p style=\"text-indent: 2em\">据《温哥华太阳报》等多家加拿大媒体17日报道，在因华人众多被称为&ldquo;小香港&rdquo;的加拿大不列颠哥伦比亚省列治文市，当地市民抱怨该市&ldquo;中文招牌广告过多&rdquo;，并发起要求市府出台限制令的联名请愿活动，引起激烈争议。不少学者认为，政府对商家的招牌进行管制有&ldquo;文化歧视&rdquo;之嫌，违背加拿大各民族平等的政策。</p>\r\n<p style=\"text-indent: 2em\">报道称，两位居民花了8个月对该市中文店标进行取证，认为&ldquo;纯中文标语太多&rdquo;、&ldquo;对不懂中文者十分不便&rdquo;、&ldquo;会增加种族隔离和抹掉加拿大身份&rdquo;，称倘若政府不加管制，不久该市将&ldquo;完全看不到英文&rdquo;。列治文市人口不到20万，其中亚裔占60%以上，华裔比例高达43.6%，是亚洲以外华裔比例最高的城市。资料显示，在列治文市以汉语、粤语、闽南话等中国语言为母语的常住居民比例高达40.9%，首次超越英语为母语的居民，后者比例为36.5%。</p>\r\n<p style=\"text-indent: 2em\">有意见认为华裔应&ldquo;入乡随俗&rdquo;，融入主流社会。但另一派意见认为，列治文自1990年建市开始，华裔就是主角，而加拿大也是个尊重少数族裔的多元文化社会。该市政府官员16日称，商家用什么样的招牌和市场有关，政府采取强制行为不妥当。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('33', 'text', '<p style=\"text-align: center; text-indent: 2em\"><img alt=\"\" src=\"/uploads/1/image/public/201303/20130318085043_oos13e.jpg\" /></p>\r\n<p style=\"text-align: center; text-indent: 2em\"><span style=\"font-size: 12px\">事故现场照片（翻拍自案卷</span></p>\r\n<p text-indent:=\"\">在高速上失控撞<a class=\"a-tips-Article-QQ\" href=\"http://data.auto.qq.com/car_serial/186/index.shtml\" target=\"_blank\">捷达</a> ，捷达车内一家四口身亡。司机和死者家属都认为事故系爆胎造成，肇事人月底前将来京申诉；死者家属近期也将起诉锦湖公司索赔。</p>\r\n<p style=\"text-indent: 2em\">此前，司机曾起诉锦湖轮胎公司，并申请鉴定轮胎质量。虽然3份证人证言、5份公检法出具的法律文书均证实爆胎引发车祸，鉴定机构却避开质量问题，推翻生效文书，称&ldquo;车祸导致爆胎&rdquo;，导致司机败诉。</p>\r\n<p style=\"text-indent: 2em\">肇事司机的律师质疑鉴定结论&ldquo;太荒唐&rdquo;。鉴定机构对此回应，&ldquo;对鉴定有异议，让法院来找我&rdquo;。</p>\r\n<p style=\"text-indent: 2em\"><strong>突发祸事出车祸一家四口全部身亡</strong></p>\r\n<p style=\"text-indent: 2em\">2010年8月11日晚上，74岁的胡振兴老人接到电话：大女儿胡彦军一家出车祸了。</p>\r\n<p style=\"text-indent: 2em\">京沈高速上，一辆车失控冲过隔离栏到马路对面，撞上胡彦军的车子，她的捷达车随后起火。44岁的胡彦军、她43岁的丈夫、她20岁的大女儿和17岁的小女儿都被烧死。</p>\r\n<p style=\"text-indent: 2em\">老人在房山区长沟镇东甘池村的家中接受了记者采访。他说，他有四个子女，大女儿一直是他的骄傲。&ldquo;女婿开了个石板厂，经济上挺富裕。夫妻俩感情也好，也孝顺，每周都给我来电话。两个孩子，从小就爱在我身旁撒娇。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">老人说：&ldquo;那些天好难熬。早晨没等起床我就大哭一场，一整天眼泪围着眼眶转。猜测着事故的严重程度，我感觉床周围是万丈深渊，晚上靠安眠药才睡了半宿。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">他把头仰在沙发上，睁大了眼睛叹气。&ldquo;女婿事业心强，想转行做更大的生意。转产之前想去外地放松一下，就去北戴河了。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">&ldquo;俩孩子本来不想去，爹妈说光是大人没兴致，硬拉走了。玩了几天俩孩子觉得没意思，吵着要走，于是提前往回赶。谁承想&hellip;&hellip;&rdquo;</p>\r\n<p style=\"text-indent: 2em\"><strong>追忆经过15分钟行车逆转命运</strong></p>\r\n<p style=\"text-indent: 2em\">肇事司机苏琳是个1985年出生的兰州女孩。维权的不顺利已经让她对外界产生怀疑，坚持要求当面采访。3月8日晚，记者乘机飞抵兰州，次日上午与苏琳会面。</p>\r\n<p style=\"text-indent: 2em\">3月9日是个沙尘天，天色昏暗，路人戴着口罩来去匆匆。下午2点，一个一身黑衣的高个子女孩在朋友的陪同下，来到记者下榻的兰州航空大酒店一楼。这比约定的时间晚了一小时。苏琳不好意思地解释：为了多挣些钱，她周末也在加班，现在是请假出来的。</p>\r\n<p style=\"text-indent: 2em\">采访是在附近一家茶馆里进行的。苏琳拿着厚厚的茶水单看了很久，半天没说话。记者意会，随即主动选了一壶最便宜的茶水，并表示将会买单。苏琳的神色有些尴尬。她自嘲地说，车祸把她的命运逆转，她已经很久没过白领的生活了。</p>\r\n<p style=\"text-indent: 2em\">在北京读完大学，苏琳先在一家公司当白领，之后辞职经商。她说，出事前，她的生意挺红火。</p>\r\n<p style=\"text-indent: 2em\"><img alt=\"事故现场照片（翻拍自案卷\" src=\"/uploads/1/image/public/201303/20130318084927_1siuwe.jpg\" /></p>\r\n<p style=\"text-align: center; text-indent: 2em\"><span style=\"font-size: 12px\">事故现场照片（翻拍自案卷</span></p>\r\n<p style=\"text-indent: 2em\">细细地喝了一口茶，她说出了当年的梦想：努力工作多挣钱，将来把兰州的房子卖掉，在北京买房，把父母接过来一起生活。</p>\r\n<p style=\"text-indent: 2em\">命运的转变发生在2010年8月11日。当天上午，苏琳的生意合伙人、东北女孩刘由迪开着她的华晨骏捷回抚顺老家。苏琳的姨家也在抚顺，于是苏琳和父母搭上刘由迪的车去串亲戚。</p>\r\n<p style=\"text-indent: 2em\">苏琳说：&ldquo;我们一路走京沈高速。开到第一个服务站后休息了会儿。之后我说一个人开车太累，就把刘由迪换下来了。结果，开了15分钟就出事了。&rdquo;</p>\r\n<p style=\"text-indent: 2em\"><strong>多方证实接受讯问司机坚称爆胎致祸</strong></p>\r\n<p style=\"text-indent: 2em\">苏琳说，当时自己已有两年驾龄。虽然车不是自己的，但因为刘由迪和自己一起租房生活，自己平时经常开她的车，对性能很熟悉。</p>\r\n<p style=\"text-indent: 2em\">讯问笔录显示，苏琳始终供述是爆胎导致车辆失控。她对警方表示：&ldquo;当时的车速大约是100迈。突然不知道怎么回事，感觉车跑偏了。当时刘由迪喊车偏了，车就撞到左侧护栏上了，之后我就什么都不知道了。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">接受采访时，苏琳再次证实了这一点。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;当时我们都晕过去了。我爸第一个醒过来，把我们救了出去。我妈大腿股骨头粉碎性骨折，我左脚根骨粉碎性骨折、脊椎第三节骨折，胸腔有三根骨头断了。&rdquo;尽管已经时隔几年，但说到这里，苏琳还是有些激动，语速也快了起来。</p>\r\n<p style=\"text-indent: 2em\">苏琳说，大家从车里出来后，发现前面有辆白色捷达着火了。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;我爸打电话报了警。他想拿灭火器救火，但我们的车门已经打不开了。很快，那辆车的火势到了人没法接近的地步。&rdquo;她说。</p>\r\n<p style=\"text-indent: 2em\">苏琳说，她被送进医院、民警向她问话的时候，她才得知是自己的车撞了对方。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('34', 'text', '<p>6日晚，在昆明市白龙路一自助银行里，来取钱的刘老师站在柜员机前捣鼓了半天&mdash;&mdash;卡插不进去，他在柜员机上随便按了&ldquo;5000&rdquo;，谁知50张百元钞票就吐到了他面前。机器出了问题？他又按了&ldquo;5000&rdquo;，又有5000元吐到了手里。仔细一查，发现柜员机里原来已有一张银行卡，刘老师忙报了警。经过盘龙公安分局东华派出所民警的寻找，次日找到了卡的主人。</p>\r\n<p>　　6日当晚10点30分许，刘老师来到自助银行取款。掏出卡往自动存取款机上塞却塞不进。再塞，还是一样。难道柜员机出问题了？他试着输入了5000，按照柜员机提示按下&ldquo;取款&rdquo;，随着机器&ldquo;嗒嗒&rdquo;的声音，钞票盖打开，一沓钞票就在眼前。这是不是假钞呢？刘老师愣了一会，再试，又出来5000元。难道天上真会掉馅饼，经过一番检查，原来是柜员机里有一张银行卡。取出卡后，他用自己的卡进行了存取款&ldquo;试验&rdquo;，发现机器没问题，而是粗心人忘记取走银行卡。</p>\r\n<p>　　面对这个天上砸下的馅饼，刘老师没有犹豫，直接拨打110报警。当东华派出所民警赶到银行时，他把1万元现金和银行卡一并交给了警察，并请民警一定要找到失主。</p>\r\n<p>　　次日下午，在昆明开火锅店的刁女士接到东华派出所打来的电话，说她的银行卡和1万元现金被好心人拾到，请到派出所核实领取时，她很惊讶，自己的卡怎么会到了派出所？前一晚，火锅店打烊后，她将银行卡交给两名店员，带着当天的1万元营业款去银行存起来。10点半时，到了白龙路自助银行，一名店员站在旁边玩着手机，另一名数着钱。存款完成后，两人拿了凭条就离开了自助银行。</p>\r\n<p>　　15日下午，刁女士特地带着一封感谢信和一面锦旗，来到东华派出所，并从民警手中接过现金和银行卡。刁女士说：&ldquo;银行卡上有近10万元存款，也怪员工太粗心大意了，太感谢刘老师了！&rdquo;</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('35', 'text', '<p style=\"text-indent: 2em\">石家庄3月18日电(黄芳 姜蕾)因夜间小区便道上未设路灯，石家庄一市民骑电动车意外撞到某通信公司架设的电线杆而身体多处受伤。当地法院日前审结此案，并判决该通信公司和社区居委会承担连带责任，当事人张某共可获赔偿款1.5万余元。</p>\r\n<p style=\"text-indent: 2em\">审理该案的石家庄市桥东区法院18日向记者介绍了本案案情。据悉，2012年7月某日晚10时左右，张某骑电动车在石家庄市某小区内便道上行驶，由于天黑且该便道上没有路灯，撞到某通信公司所属的通信电杆的接线上，当即昏迷过去，被周围乘凉的群众及时拨打120送至医院，经医院诊断证明，此次事故造成张某：1、头面部外伤；2、脑震荡；3、鼻骨骨折；4、左颧骨骨折；5、颈前区皮肤及软组织挫伤等，并且其所骑的电动车也受到损坏。</p>\r\n<p style=\"text-indent: 2em\">为此，张某一纸诉状将电杆的所属单位某通信公司及对该小区负有物业管理责任的某居委会起诉至法院，要求支付其医疗费、误工费、陪护费、营养费、交通费、住院伙食补助费等共计21370.32元；诉讼费由二被告承担。</p>\r\n<p style=\"text-indent: 2em\">经桥东区人民法院审理查明，致原告张某受伤的小区系新建小区，小区内配套设施尚不完善，便道上没有设置路灯。张某非事发小区的居民，事发时原告系下班回家，其居住地与事发小区仅一墙之隔，事发小区南北均有大门，行人可随意通过，事故发生地点没有路灯。出事的拉线曾与此前也有过绊倒行人现象。小区居委会针对以前拉线绊伤行人事件也曾在小区内张贴通知，居委会曾派负责该项目的人员找到通信公司，就该拉线的安全问题告知该公司，但通信公司直至本次事故发生后才将拉线撤走，通信杆还在。</p>\r\n<p style=\"text-indent: 2em\">法院认为，原告受伤系其夜间骑行于事发小区时，被某通信公司设置的通信杆拉线绊倒所致，因该拉线杆设置在小区通行的便道上，无任何警示标志，且该拉线之前已绊倒过行人，通信公司并未采取任何安全措施，故通信公司对原告所受伤应承担相应的责任。被告某居委会作为对小区物业的管理单位，未在小区通行地段设置路灯，且明知拉线的存在会造成安全隐患，也未采取相关有效的警示措施，对张某受伤亦存在一定的过错，应与通信公司承担连带赔偿责任。而张某在穿行小区时，明知小区内无路灯，未尽到安全注意义务，故其本身也应承担一定的责任，结合本案案情，其应承担10%的责任。此外，二被告负担90%的赔偿责任，即15821.84元，并驳回张某的其他诉讼请求。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('36', 'text', '<p style=\"text-indent: 2em\">3月6日消息：据《劳动报》报道，这两天，上海部分区县的婚姻登记处变得&ldquo;闹猛&rdquo;了起来，前来办理的主要人群是离婚与开具单身证明的市民。记者采访了解到，为了规避房产&ldquo;国五条&rdquo;出台后20％的交易税率，少部分人试图通过&ldquo;假离婚&rdquo;来避税，从而造成离婚数量出现异样上涨。市民政局婚姻处昨日证实，部分区县离婚数量比平时增加2至3倍，最高的达到4至5倍。</p>\r\n<p style=\"text-indent: 2em\"><strong>离婚数量出现翻倍 </strong></p>\r\n<p style=\"text-indent: 2em\">&ldquo;平时离婚的人数也没这么多，这两天简直忙坏了。&rdquo;在浦东新区婚姻登记处，相关负责人告诉记者，相对于日常30对的离婚量而言，这两天几乎翻倍。</p>\r\n<p style=\"text-indent: 2em\">而来自闵行区婚姻登记中心的消息也显示，3月4日当天该区出现开单身证明排长队、离婚排长队的&ldquo;奇观&rdquo;。当日出具无婚姻记录证明182人，共510份；离婚受理51对，办结43对，均创单日受理新高。在采访中，多位工作人员向记者表示，在前来办理离婚的市民中，有些明显&ldquo;感觉不对&rdquo;。&ldquo;就是情绪上不正常，双方看上去不仅没有悲哀、沮丧或是愤怒的情绪，反而非常平静甚至挺开心。&rdquo;一位基层办理人员私下告诉记者，根据她们的办理经验，一眼就感觉这些申请者并不是真正属于感情破裂，以至于要结束婚姻。</p>\r\n<p style=\"text-indent: 2em\"><strong>购房需求写进缘由 </strong></p>\r\n<p style=\"text-indent: 2em\">多家区县婚姻登记机构负责人均分析认为，本周&ldquo;离婚潮&rdquo;的波动，与&ldquo;国五条&rdquo;出台差额20％交易税的政策不无关联。在前来办理离婚的人群中，甚至有市民吐露真言，在&ldquo;离婚缘由&rdquo;中写入了&ldquo;购房需求&rdquo;。</p>\r\n<p style=\"text-indent: 2em\">由于&ldquo;国五条&rdquo;的细则尚未出台，而按照上海目前的规定，满5年唯一住房免征差价20％个人所得税。因此，有专家指出，&ldquo;离婚潮&rdquo;的波动或与部分市民赶&ldquo;末班车&rdquo;有关。而在网络上，更是出现了多种所谓&ldquo;合理避税&rdquo;的渠道，其中有一条就指出，&ldquo;房东在卖出的时候，可以通过假离婚，让产证上减少一个人名，随后把一套房子做成满5年唯一，然后再卖房，这样税就不用交了。&rdquo;</p>\r\n<p style=\"text-indent: 2em\"><strong>风险极大不必盲从 </strong></p>\r\n<p style=\"text-indent: 2em\">对此，法律界人士指出，目前&ldquo;国五条&rdquo;政策尚未出台细则，出售家庭唯一住房的这种情况是否在征税范围之外仍不得而知，市民不必跟风。另外由于涉及到婚姻关系，发生纠纷的可能性比较大，实践中也很常见。尤其是过去&ldquo;假离婚&rdquo;中出现弄假成真的不在少数，万一假婚姻遇到真危机，其中一方则可能人财两空。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('37', 'text', '<p style=\"text-indent: 2em\">北京时间3月18日消息，据国外媒体报道，市场分析师当前普遍预计，在股价经历了连续下挫之后，<span onmouseover=\"ShowInfo(this,&quot;AAPL.OQ&quot;,&quot;200&quot;,&quot;-1&quot;,event);\"><a class=\"a-tips-Article-QQ\" href=\"http://stockhtm.finance.qq.com/astock/ggcx/AAPL.OQ.htm\" target=\"_blank\">苹果</a></span>可能会宣布把季度派息上调一半以上，来提振公司股价。</p>\r\n<p style=\"text-indent: 2em\">市场分析师当前平均预计，苹果将把季度派息提高56%，达到每股4.14美元。这一调整将让这家公司每年派息达到157亿美元。不过由此产生的年3.7%的股息率，将会超过86%派息的标准普尔500指数成份股。投资银行Piper Jaffray分析师基恩&middot;蒙斯特（Gene Munster）就此认为，苹果能够在动用海外利润的情况下，使用现有现金流完成派息。</p>\r\n<p style=\"text-indent: 2em\">面临着把持有的1371亿美元现金和投资中的大多数返还给股东这一压力的苹果首席执行官蒂姆&middot;库克（Tim Cook），在去年3月份宣布恢复派息，已经一项100亿美元的股票回购计划。随着增长速度的放缓及面临<span class=\"infoMblog\"><a class=\"a-tips-Article-QQ\" href=\"http://t.qq.com/samsungelectronicbj#pref=qqcom.keyword\" rel=\"samsungelectronicbj\" reltitle=\"三星电子\" target=\"_blank\">三星电子</a></span>等公司的激烈挑战，包括绿光资本的大卫&middot;埃因霍温（David Einhorn）等投资人，已经要求苹果把更多的现金返还给股东。</p>\r\n<p style=\"text-indent: 2em\">Topeka Capital Markets分析师布莱恩&middot;怀特（Brian White）就此表示，&ldquo;苹果贮备的现金有点太多。无论是什么样的熊市，这家公司也不需要这么多的现金。&rdquo;怀特在投资者报告中给予苹果股票&ldquo;买入&rdquo;评级，并将目标股价定为888美元。</p>\r\n<p style=\"text-indent: 2em\">苹果股价上周五在纳斯达克证券市场上涨2.6%，报收于443.66美元。自该公司股价在去年9月19日创出历史最高价至今，其股价累计跌幅已经达到了37%。标准普尔500指数同期的累计涨幅为6.8%。</p>\r\n<p style=\"text-indent: 2em\"><strong>返还现金</strong></p>\r\n<p style=\"text-indent: 2em\">许多公司都每年一次宣布对派息进行调整，随着距苹果去年3月19日宣布派息周年的即将来临，有关库克将会宣布什么计划的猜测逐渐增多。在经历了连续17年的不派息之后，库克在去年打破了苹果联合创始人史蒂夫&middot;乔布斯（Steve Jobs）保留现金的传统，开始向股东派发现金。</p>\r\n<p style=\"text-indent: 2em\">彭博社的统计数据显示，市场分析师当前平均预计，苹果季度派息将在3.31美元至5.30美元之间。</p>\r\n<p style=\"text-indent: 2em\">苹果表示，该公司一直就如何管理现金问题进行积极的讨论，并考虑股票回购和其它一些选择。苹果发言人史蒂夫&middot;道林（Steve Dowling）对于公司未来的派息和股票回购项目未置可否。</p>\r\n<p style=\"text-indent: 2em\">给予苹果股票&ldquo;买入&rdquo;评级的<span onmouseover=\"ShowInfo(this,&quot;ORCL.OQ&quot;,&quot;200&quot;,&quot;-1&quot;,event);\"><a class=\"a-tips-Article-QQ\" href=\"http://stockhtm.finance.qq.com/astock/ggcx/ORCL.OQ.htm\" target=\"_blank\">甲骨文</a></span>投资研究公司（Oracle Investment Research）首席市场策略家劳伦斯&middot;巴尔特（Laurence Balter）表示，苹果今年的现金余额将增加400亿美元至420亿美元，其中在美国将产生大约150亿美元的现金余额。这意味着不需要从海外拿回现金支付高额的税款，苹果便能够使用现金余额完成派息。</p>\r\n<p style=\"text-indent: 2em\"><strong>市值下滑</strong></p>\r\n<p style=\"text-indent: 2em\">巴尔特表示，&ldquo;这家公司的市值下滑了近3000亿美元。任何一家美国或跨国公司出现这种情况，如果其首席执行官还无所事事的话，铁定将被辞退。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">巴尔特预计，苹果可能宣布动用100亿美元进行一次性分红，并将季度派息提升至每股3.31美元。彭博社的统计数据显示，苹果2012财年的自由现金流为426亿美元，较上一年增加了28%。</p>\r\n<p style=\"text-indent: 2em\">持有苹果超过130万股股票的绿光资本，目前正敦促这家公司发行股息更高的优先股，从而把更多的现金返还给股东。绿光资本在上月举行的苹果股东大会中，成功的阻止了公司要求投资人批准停发优先股的决议。</p>\r\n<p style=\"text-indent: 2em\"><strong>返还资本</strong></p>\r\n<p style=\"text-indent: 2em\">苹果能够逐步增加其股息。彭博社预计，苹果能够把当前的季度派息增加13%，从每股2.65美元提升至3美元左右，让股息率达到2.7%。这一做法能够让苹果的股息率在同行中处于前列，仅次于<span onmouseover=\"ShowInfo(this,&quot;INTC.OQ&quot;,&quot;200&quot;,&quot;-1&quot;,event);\"><a class=\"a-tips-Article-QQ\" href=\"http://stockhtm.finance.qq.com/astock/ggcx/INTC.OQ.htm\" target=\"_blank\">英特尔</a></span>和<span onmouseover=\"ShowInfo(this,&quot;MSFT.OQ&quot;,&quot;200&quot;,&quot;-1&quot;,event);\"><a class=\"a-tips-Article-QQ\" href=\"http://stockhtm.finance.qq.com/astock/ggcx/MSFT.OQ.htm\" target=\"_blank\">微软</a></span>。彭博社的预期考虑到了其它大型科技公司的派息情况，以及苹果明年的每股收益和资产负债表中的现金数额。</p>\r\n<p style=\"text-indent: 2em\">巴克莱资本分析师本&middot;雷特兹（Ben Reitzes）表示，无论哪一种返回现金的方式，苹果都可以考虑举债完成，不需要动用海外的现金而支付高额的税款。在未来的三年时间里，苹果还能够把股票回购项目增加至300亿美元。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;如果苹果完全使用自己的资产负债表，该公司有潜力让资本回报率提升一倍，&rdquo;雷特兹就此表示。该分析师给予了苹果股票&ldquo;持有&rdquo;评级，并将目标股价定为530美元。</p>\r\n<p style=\"text-indent: 2em\"><strong>估值打折</strong></p>\r\n<p style=\"text-indent: 2em\">彭博社的统计数据显示，在过去十年绝大多数的时间享受高溢价之后，该公司当前的市盈率较标准普尔500指数成份股的平均市盈率低出34%。</p>\r\n<p style=\"text-indent: 2em\">该统计数据还显示，苹果股价近期的暴跌，也让苹果的动态市盈率自2002年1月以来首次低于微软。彭博社的同时据显示，苹果当前的市盈率约为10倍左右；已经跌出全球十大最有价值公司排行榜的微软，市盈率约为11倍。</p>\r\n<p style=\"text-indent: 2em\">多年来，苹果持有现金的问题一直招致投资人的口诛笔伐。1995年，受管理层变动及PC市场份额下滑的影响，苹果暂停了派息。在1997年乔布斯重返苹果时，这家公司已濒临破产。随着他成功的推出iPod、iPhone和iPad等产品，苹果的现金余额开始逐步增多。</p>\r\n<p style=\"text-indent: 2em\">虽然苹果在去年宣布派息及股票回购，旨在解决持有现金不断增加的问题，但许多投资人一直要求苹果做的更激进一些。</p>\r\n<p style=\"text-indent: 2em\"><strong>投资人推动</strong></p>\r\n<p style=\"text-indent: 2em\">苹果公司股东之一的Capital Advisors Inc.首席执行官吉斯&middot;歌德达德（Keith Goddard）表示，&ldquo;坦白的讲，我对苹果为什么在这一问题上反应这么迟钝感到迷惑。&rdquo;歌德达德认为，苹果有可能会在今年年底宣布派息或股票回购计划，不过最早会在4月份发布第二财季财报时对外宣布。</p>\r\n<p style=\"text-indent: 2em\">彭博社的统计数据显示，苹果的三大机构投资人目前持有公司约1.334亿股股票。季度每股派息3美元，意味着它们每年将获得16亿美元股息。分析师怀特表示，&ldquo;增加派息能够向股价提供安全网。苹果必须吸引新投资人。提高派息是吸引新投资人的方式之一。&rdquo;</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('38', 'text', '<p style=\"text-indent: 2em\">北京时间3月18日消息，据国外媒体报道，今天德国曼海姆地方法院宣布了对中国在德国的首次专利侵权诉讼的裁决结果，华为获得了对中兴的禁令，后者不再被允许在德国销售4G功能基站。</p>\r\n<p style=\"text-indent: 2em\">中兴获得了上诉法院下达的暂缓执行命令，但其更可能同意向华为支付版税。在德国提交的标准基本专利（SEP）诉讼中，华为虽然只有1起诉讼做出了裁决，但比三星更成功些，后者一直在起诉<span onmouseover=\"ShowInfo(this,&quot;AAPL.OQ&quot;,&quot;200&quot;,&quot;-1&quot;,event);\">苹果</span>，但在曼海姆的前三起诉讼都败诉，第四起诉讼暂缓审理（第五起诉讼是三星最可能获得赔偿的诉讼，但还未判决）。</p>\r\n<p style=\"text-indent: 2em\">诉讼中涉及的专利为专利号EP2273818有关&ldquo;导出密匙&rdquo;的专利，据悉是第四代移动通信标准&ldquo;长期演进&rdquo;（LTE）基础专利之一。华为赢得第1、7和 12项指控。法院的主审法官安德烈斯&middot;沃斯（Andreas Voss）和陪审法官伦巴赫和施密特裁定中兴停止销售这些基站及部件。</p>\r\n<p style=\"text-indent: 2em\">中兴可以对裁决提起上诉，但华为如果交了100万欧元（约合130万美元）保证金，在上诉期间可以强制执行。第7和12项指控是产品指控，即禁止出售或提供符合指控中所描述内容的设备，每违反1项可被判处蔑视法庭罪，最高可被罚款25万欧元（通常指的是发货给客户的每批次，而不是每件设备），或禁止经营最长六个月（在多次违反情况下最长两年）。</p>\r\n<p style=\"text-indent: 2em\">第1项指控是方法指控。只有在客户(在此案中指运营商）实际使用了中兴基站并在4G兼容模式下运行，才属于直接侵权。但如果他们仅在3G（UMTS）和GSM模式下使用，则不属于侵权。裁决为防止这种协助侵权，要求中兴做到在任何协议中&ldquo;明确和在突出位置表述&rdquo;客户需要从华为获得许可，只在客户（运营商）承诺向华为支付合同违约金5万欧元（或在多次侵权时每次最少支付2.5万欧元）。</p>\r\n<p style=\"text-indent: 2em\">今天的裁决证明了中国高科技行业存在创新。不过这也进一步表明，在曼海姆肯定可以赢得专利禁令，包括SEP专利。事实上，下周二<span onmouseover=\"ShowInfo(this,&quot;NOK.N&quot;,&quot;200&quot;,&quot;-1&quot;,event);\">诺基亚</span>很可能赢得在曼海姆对HTC的诉讼。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('39', 'text', '<p style=\"text-align: center; text-indent: 2em\"><img alt=\"\" src=\"/uploads/1/image/public/201303/20130318091017_f420oy.jpg\" /></p>\r\n<p style=\"text-indent: 2em\">北京时间3月18日消息，据国外媒体报道，夏普公司表示由于没有能够制定出<span onmouseover=\"ShowInfo(this,&quot;QCOM.OQ&quot;,&quot;200&quot;,&quot;-1&quot;,event);\"><a class=\"a-tips-Article-QQ\" href=\"http://stockhtm.finance.qq.com/astock/ggcx/QCOM.OQ.htm\" target=\"_blank\">高通</a></span>所规定的组装低能耗屏幕的方案，该公司将错失高通原计划于3月29日对夏普的第二轮投资。</p>\r\n<p style=\"text-indent: 2em\">芯片制造商高通于去年12月承诺向夏普投资1.2亿美元，并已支付一半金额。另外6千万美元的投资需在夏普完成智能手机和平板电脑屏幕的研发计划并能够投入生产的前提下支付。</p>\r\n<p style=\"text-indent: 2em\">同时高通规定夏普必须在其营业年的下半年获得营业利润，另外其净资产值也必须达到1千亿日元（约合10.5亿美元）。</p>\r\n<p style=\"text-indent: 2em\">夏普发言人中山美雪（Miyuki Nakayama）表示：&ldquo;财务上的目标并非此次高通延迟投资的原因。&rdquo;她还表示，高通对夏普的投资将会延迟至6月30日，在此之前夏普需满足高通设定的全部条件。</p>\r\n<p style=\"text-indent: 2em\">两家公司曾在去年12月对外表示，高通子公司Pixtronix将会和夏普一起合作以研发低能耗的铟镓锌氧化物（IGZO）显示器。</p>\r\n<p style=\"text-indent: 2em\">错失高通第二次投资将会为陷入资金困境的夏普公司增加更大的压力，目前夏普正在努力筹措资金以支付其在9月份到期的可转换债卷。另外，这家日本LCD面板制造商还未能够和台湾鸿海集团在新的谈判中达成协议，鸿海集团计划在3月26日之前购买夏普9.9%的股份，但双方的谈判很有可能无疾而终。</p>\r\n<p style=\"text-indent: 2em\"><span class=\"infoMblog\"><a class=\"a-tips-Article-QQ\" href=\"http://t.qq.com/samsungelectronicbj#pref=qqcom.keyword\" rel=\"samsungelectronicbj\" reltitle=\"三星电子\" target=\"_blank\">三星电子</a></span>公司本月同意向夏普投资1.1亿美元，而夏普则要向其出售3%的股份并承诺会向三星提供面板。夏普一直为<span onmouseover=\"ShowInfo(this,&quot;AAPL.OQ&quot;,&quot;200&quot;,&quot;-1&quot;,event);\"><a class=\"a-tips-Article-QQ\" href=\"http://stockhtm.finance.qq.com/astock/ggcx/AAPL.OQ.htm\" target=\"_blank\">苹果</a></span>的iPhoen5和iPad提供面板。</p>\r\n<p style=\"text-indent: 2em\">为了能够完成高通制定的财务目标，夏普的内部人士以及一些分析师表示他们希望夏普从其出售的资产和股票中获取足够的现金流和收益之后，采用发行股票筹资的方法以填补差额。</p>\r\n<p style=\"text-indent: 2em\">夏普还计划将其中国电视工厂出售给联想，将其墨西哥电视工厂出售给鸿海，并在和两家公司进行商谈。但夏普出售资产的能力不足，原因是在去年夏普已经抵押了其大部分的国内工厂和办公室以确保能从银行获得38亿美元的救济金。</p>\r\n<p style=\"text-indent: 2em\">信用评级公司给予夏普的&ldquo;垃圾&rdquo;评级也致使夏普在信用市场上的融资会较为困难。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('40', 'text', '<p>欢迎大家测试！</p>\r\n<p>&nbsp;</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('43', 'text', '<p style=\"text-align: center\"><img alt=\"\" src=\"/uploads/1/image/public/201303/20130319005332_lmwkqx.jpg\" style=\"width: 670px; height: 300px\" /></p>\r\n<p>近日，有明星经纪公司爆料，唱遍大小春晚的&ldquo;农业重金属组合&rdquo;凤凰传奇，出场费已经涨到了60万/场，若加上代言，2012年约有1亿进账。1亿这个数字也许略有夸张，但实际收入肯定也不会少。网友们一边感叹农业重金属的力量不可小觑，一边又开始琢磨这么多钱他们怎么分呢？凤凰传奇经纪人接受采访时表示，&ldquo;玲花和曾毅早就签好协议，收入一人一半&rdquo;，这样一来，网友又有疑问了&mdash;&mdash;负责RAP部分的曾毅除了&ldquo;嘿、吼、喔、哈、切克闹&rdquo;就没别的词儿，难道也能分一半？这钱挣得也太轻松了吧！</p>\r\n<div>[PageBreak][/PageBreak]</div>\r\n<p>其实在娱乐圈，像凤凰传奇这样的&ldquo;人气搭档&rdquo;并不少，有的情比金坚，有的钱字当头，有的好聚好散，也有的老死不再往来。为此，腾讯娱乐采访了多位圈中资深人士，为大家八一八人气搭档&ldquo;分钱&rdquo;那点事儿。</p>\r\n<div>[PageBreak][/PageBreak]</div>\r\n<p>至于近几年大火的凤凰传奇，也是五五分成么？按网友的话说：&ldquo;女的唱得声嘶力竭，男的出来切克闹几句就下去了，如果平分亿元年收入，会不会太不公平？&rdquo;</p>\r\n<p>&nbsp;对此，凤凰传奇经纪公司总经理徐明朝回应称，&ldquo;从演唱角度看，玲花确实是主唱，但是从组合角度看，这是一个整体，没有主次之分。早在成名之前，他俩就已签好合约，无论将来赚多少都对半分。&rdquo;</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('44', 'text', '<p style=\"text-align: center\"><img alt=\"\" src=\"/uploads/1/image/public/201303/20130319010122_cltj7p.jpg\" style=\"width: 680px; height: 380px\" /></p>\r\n<p>《贤妻》里，他们谈情说爱，激情四射；《隋唐演义》里，他们在马背上驰骋，英姿飒爽；新《笑傲江湖》里，他们携手畅游如花美景&hellip;&hellip;这些，都是你在电视机前看到的。在现实中，这些镜头如何完成可就是另一番光景了。</p>\r\n<p>　　 拍摄激情戏时，男演员为了防备生理反应，得穿三条厚内裤上阵；骑在马背上的，有可能只是骑了一个马头道具；最惨的是，夏天拍冬天戏，捂出一身汗斑，冬天拍夏天的戏，被淋八桶冰水&hellip;&hellip;腾讯娱乐记者独家探班横店各大剧组，暗访电视剧拍摄背后的故事。最后知道真相的你，会不会&ldquo;眼泪掉下来&rdquo;？</p>\r\n<p>　电视剧里，演员们都在适当的季节穿着适当的衣服，看不出任何破绽，但只有演员们知道其中的辛苦。原来，由于演员档期、场地布景、剧情设定等原因，演员们能拍当季的戏份已经成为了一种奢望。不少演员都经历过冬天要跳湖跳河，夏日则穿上重达二十斤的古装戏服骑马打仗。</p>\r\n<h4>\r\n	状况一：现实中是冬天 剧情里是夏季</h4>\r\n<h4>\r\n	寇振海被泼了八桶冰水</h4>\r\n<p style=\"text-align: center\"><img alt=\"\" src=\"/uploads/1/image/public/201303/20130319010200_cx0n08.jpg\" style=\"width: 280px; height: 170px\" /></p>\r\n<div class=\"fr transBox trans1\">\r\n	<p align=\"center\">皇阿玛一下戏，就把自己武装到了头部。</p>\r\n</div>\r\n<p>　　 在剧组跟演员们闲聊时，&ldquo;老戏骨&rdquo;寇振海告诉记者，曾经有一位演员在冬天的大东北拍夏季戏时，因为需要佩戴一副较重的耳饰，一场戏拍摄下来，这位演员的耳垂被冻成了&ldquo;乒乓球那么大&rdquo;，三个月之后才见好。他还回忆起自己有一年冬天在东北拍一场淋雨戏，&ldquo;我穿着裤衩跪在地上，前后淋了八桶冰水，泼到身上就跟刀子一样痛，但也得忍着。&rdquo;</p>\r\n<h4>\r\n	怎么避免口哈白气穿帮？嘴里含口冰水</h4>\r\n<p>　　而上身夏裝下身冬裝这样的装束在片场随处可见，因为拍反季节戏份而导致生病的状况更是见怪不怪。</p>\r\n<p>　　某剧组的场务表示，&ldquo;冬天靠运动很难产生剧情里要求的大汗淋漓效果，所以一般都是拿水壶往演员身上喷水。&rdquo;记者得知，为了避免水蒸气的出现，喷水壶里的水必须要是凉水。由于低温的缘故，演员们在冬天念台词时经常会口吐白气，为了避免穿帮，有演员透露冬天拍夏天的反季节戏份时，说话前都会含一口冰水，降温后再说话。</p>\r\n<p>　　 嘴里含着冰水，身上穿着单薄的夏衣，冬拍夏戏的演员们在拍戏时最爱的单品非暖宝宝（注：一次性发热贴片）莫属。&ldquo;我曾经见过有女演员因为身子太单薄，浑身上下都贴满了暖宝宝，连脚底都没有放过。&rdquo;一位长期跟组拍戏的工作人员同记者说道。</p>\r\n<h4>\r\n	状况二：现实中是夏日 剧情里是冬天</h4>\r\n<h4>\r\n	陆毅的戏服厚如两床棉被</h4>\r\n<p>　　 如果说冬天拍夏戏，可以通过贴暖宝宝来驱寒的话，那夏天拍冬戏的演员们就没那么好过了。</p>\r\n<p>　　 抵达横店后，记者去到了林志颖正在拍戏的剧组，虽然下午气温已有十五、六度，但为了营造出夏日午后烈阳的感觉，剧组用了四五盏4千瓦的照明灯打出&ldquo;人造阳光&rdquo;，一拍完戏，助理立刻递上吸汗纸巾给林志颖。</p>\r\n<p>　　 到了陆毅所在的剧组时，发现演员们要穿着裘皮戏服拍一整天戏。当天拍摄一场&ldquo;嘴仗&rdquo;戏，要拍六、七遍，剧组里大部分人都薄衣，包括站在陆毅旁边讲戏的导演，而演员们则全部身穿古装大服。一下戏，陆毅就飞快脱去戏服，跑到休息室去。</p>\r\n<p>　　 据剧组服装助理介绍，戏里一套戏服最轻的也有五、六斤，最重的有二十多斤，&ldquo;穿在身上就像穿了两床棉被&rdquo;，这句话逗翻了在场的人。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('45', 'text', '<p style=\"text-align: center; text-indent: 2em\"><img alt=\"\" src=\"/uploads/1/image/public/201303/20130319010512_e6pi7i.jpg\" style=\"width: 680px; height: 330px\" /></p>\r\n<p style=\"text-indent: 2em\">&ldquo;大家好，我是制片人杨幂。&rdquo;一身干练的黄色风衣，一句霸气外露的自我介绍，升级当了制片人的杨幂果然显现出女强人的气质。昨日，由其担任监制的都市时尚偶像剧《微时代之恋》在沪举行开机发布会，杨幂带着她钦点的男主角余文乐，以及她花费一年选出的八位新人齐齐亮相。腾讯网娱乐中心总监常斌到场助阵，宣布该剧官网正式落户腾讯娱乐。</p>\r\n<p style=\"text-indent: 2em\">在接受腾讯娱乐独家专访时，&ldquo;杨老板&rdquo;坦言自己这个初出茅庐的制片，在男友刘恺威(<span class=\"infoMblog\">微博</span>)(<span class=\"infoMblog\">微信号：hawicklaw</span>) 身上学到了很多东西。虽然这次她没有找刘恺威当男一号，但为了给女友的制片处女作保驾护航，刘恺威还全程跟随剧组前往巴厘岛，在片场化身超级助理和替身，打杂跑腿兼打气，让杨幂甜在心里。</p>\r\n<p style=\"text-indent: 2em\">虽说在事业上越做越大，杨幂却认为，自己离&ldquo;事业有成&rdquo;还很远。刘恺威年初已公开今年有迎娶杨幂的计划，她却不着急结婚，还想再谈谈恋爱。</p>\r\n<p style=\"text-indent: 2em\"><strong>&ldquo;事业有成&rdquo;离我很远 今年不着急结婚</strong></p>\r\n<p style=\"text-indent: 2em\"><span style=\"font-family: 楷体_GB2312\">腾讯娱乐：和林心如 (<span class=\"infoMblog\">微博</span>)、范冰冰(<span class=\"infoMblog\">微博</span>)等圈内&ldquo;演而优则制&rdquo;的女演员相比，你算是最年轻的一位女制片，为什么放着舒服的演员不当，要来挑制片重任？</span></p>\r\n<p style=\"text-indent: 2em\">杨幂：两三年前我没想过自己会拍电影，结果拍了，一年前我从没想过自己会当制片，现在也做了，我感谢每一个不可能的可能性发生在我身上。正好有一个机会摆在我面前，有人问我要不要做，我想，那就做吧。很多东西，我不一定完全有能力去做，好在身边有很多人帮我一起做，大家一起把梦想完成好，这是一个梦想照进现实的过程，我们都在努力！</p>\r\n<p style=\"text-indent: 2em\"><span style=\"font-family: 楷体_GB2312\">腾讯娱乐：有个情况挺有意思的，去年刘恺威担任制片人，邀请你做女主角的《盛夏晚晴天》去了法国拍，而你就去巴厘岛拍《微时代之恋》，是有心跟男友切磋还是别有苗头？</span></p>\r\n<p style=\"text-indent: 2em\">杨幂：我没有攀比的心思，正因为有《盛夏晚晴天》的班底和经验，才让我这次担任《微时代之恋》的制片非常顺手。如果他制片人做得成功，我当然为他开心，但我也有我的工作要做。我们在工作上是互相支持鼓励，也是相对独立的。</p>\r\n<p style=\"text-indent: 2em\"><span style=\"font-family: 楷体_GB2312\">腾讯娱乐：去年由刘恺威担任制片的《盛夏晚晴天》成绩喜人，他还筹备起第二部制片作品《一念向北》，你有向他取经吗？</span></p>\r\n<p style=\"text-indent: 2em\">杨幂：恺威是个很棒的制片人，我从他上耳濡目染学到了不少当制片人的经验，比如如何跟工作人员沟通，学会观察潜在的问题，现场遇到突发事件如何处理等等。但如果我碰到难题，自己能解决的还是想自己解决，毕竟遇到同一件事情，在别人那儿行得通的方法，在你这儿却未必合适。</p>\r\n<p style=\"text-indent: 2em\"><span style=\"font-family: 楷体_GB2312\">腾讯娱乐：为什么不找刘恺威主演，如果他演，一定愿意给你&ldquo;感情价&rdquo;的？</span></p>\r\n<p style=\"text-indent: 2em\">杨幂：为什么大家不会认为，他来，我不会给他更高的片酬？（笑）他有他自己的工作，我也会选择合适的人演剧中的角色，这次没有适合他的，等下次有了，我就找他。其实，我们不一定所有的事情都要绑在一起，当然我当制作人，他也会给我鼓励，为我加油。</p>\r\n<p style=\"text-indent: 2em\"><span style=\"font-family: 楷体_GB2312\">腾讯娱乐：身兼制片人和演员两职，应该挺辛苦吧，男友有没有来慰劳你？</span></p>\r\n<p style=\"text-indent: 2em\">杨幂：探过班，之前在巴厘岛的时候他有来帮忙。慰劳啊？他有来帮我演了一个后辈，因为有一场戏，和我对戏的演员没有在巴厘岛，我本来要和空气演戏，正好他在，就拉来搭了一场戏，不过还是会把他的镜头剪掉。</p>\r\n<p style=\"text-indent: 2em\"><span style=\"font-family: 楷体_GB2312\">腾讯娱乐：现在开起了工作室，还当了制片人，可说是&ldquo;事业有成&rdquo;了，想过结婚吗？</span></p>\r\n<p style=\"text-indent: 2em\">杨幂：&ldquo;事业有成&rdquo;这个词离我还挺远的，我还有很多东西没做到。我自身还有很多需要学习和补充的地方，还有很多专业知识是我不懂、也没有意识到的。而且，事业有成与结婚没什么关系，我会完全把工作与感情分开。</p>\r\n<p style=\"text-indent: 2em\"><span style=\"font-family: 楷体_GB2312\">腾讯娱乐：但是年初，刘恺威曾公开表示今年有迎娶你的计划，你今年没意向嫁他？</span></p>\r\n<p style=\"text-indent: 2em\">杨幂：没有，我想再谈谈恋爱吧，到现在我们其实都没吵过架。我们都希望能再相处一下，等我再成熟一些，但我想如果有一天走到那一步，应该就是这个人了。因为现在大家相处很好，磨合得也越来越有信心。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('46', 'text', '<p style=\"text-align: center; text-indent: 2em\"><img alt=\"\" src=\"/uploads/1/image/public/201303/20130319010844_jv4vfk.jpg\" style=\"width: 680px; height: 330px\" /></p>\r\n<p style=\"text-indent: 2em\">悬疑侦探电影《盲探》3月18日在香港会展中心举行新闻发布会。导演杜琪峰携编剧韦家辉，以及男女主角刘德华郑秀文(<span class=\"infoMblog\">微博</span>)一同亮相造势。该片主打刘德华郑秀文暌违十年&ldquo;再度牵手&rdquo;。而新闻发布会现场，刘德华与郑秀文搭肩搂腰风骚亮相，还被主持人戏称&ldquo;金童玉女&rdquo;。《盲探》目前暂定暑期档上映。并首度曝光一支重口味预告片，片中杀人镜头剪切凌厉，血腥、分尸、骸骨以及枪战场面也相当惊人。</p>\r\n<p style=\"text-indent: 2em\"><strong>华仔：不跟梁朝伟拼演技</strong></p>\r\n<p style=\"text-indent: 2em\">据华仔介绍，这次在《盲探》中他饰演的角色和以往相比反差很大，&ldquo;这次的角色完全不像是男主角的个性，他有点贪财，没有梦想还很现实，可能为了10块钱就去骗人。另外，他还是个吃货，每场戏都要不停吃东西。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">为了演好&ldquo;盲探&rdquo;，华仔透露自己戏前曾专门花费2个月时间去盲人训导中心培训，每天都要学习4、5个小时。当记者问及他饰演的&ldquo;盲探&rdquo;和梁朝伟在《听风者》中的盲人角色有何异同时，他谦虚地笑称梁朝伟是很好的演员，&ldquo;我没有研究他的那部电影，这次如果大家发现我演的和他有一样的地方，那就说明我和他演得一样好。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">此外，刘德华还透露，片中的&ldquo;盲探&rdquo;一角原本设定是一个失明的律师。&ldquo;2000年左右的时候，我曾经在报纸上看到过一个盲律师的故事，觉得很有意思想把它改编为电影。&rdquo;他解释说，&ldquo;但杜导觉得律师没有警察那么有张力，现在的故事也更有商业性。&rdquo;刘德华开玩笑说这几年自己一直想要和银河映像比拼剧本，但&ldquo;写了剧本也不敢拍，想当导演也不敢，因为他们的剧本太好了，简直不是一个正常人能想出来的。&rdquo;</p>\r\n<p style=\"text-indent: 2em\"><strong>十年重聚首 刘德华郑秀文更搭</strong></p>\r\n<p style=\"text-indent: 2em\">从《孤男寡女》、《瘦身男女》到《龙凤斗》，杜琪峰、韦家辉、刘德华、郑秀文时隔近10年再度重聚拍摄《盲探》。电影中，刘德华和郑秀文再演一对&ldquo;最佳拍档&rdquo;，一方是视网膜脱落的&ldquo;盲探&rdquo;，一方是有些单纯但身手灵敏的女警花。两人俨然福尔摩斯和华生，一起走上诡谲悬疑的探案之路。</p>\r\n<p style=\"text-indent: 2em\">对于第四次合作，两位主创都表示感触良多，华仔直言郑秀文变化不小，&ldquo;这些年她经历了很多事情，表演不像之前那么冲了，以前她付出8分就想要得到8分回报，现在付出的时候不会去想回报，不那么进取了。&rdquo;对此，郑秀文插嘴说&ldquo;不是不进取，是不那么计较了。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">郑秀文则回敬说：&ldquo;合作《盲探》两个人火花更大了，表演更开放了，对戏的时候就像打乒乓球一样，你来我往互相接招非常过瘾。&rdquo;</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('47', 'text', '<p style=\"text-indent: 2em\">在上周六武汉卓尔与北京国安的比赛中，主裁判王迪先后错判国安外援格隆禁区内假摔，接着又漏判给故意踢人的卓尔球员柯钊红牌。中国足协裁委会赛后确认，王迪两次判罚属严重错、漏判。王迪面临停哨3至6场的重罚。据悉，王迪通过抽签获本场比赛执法资格后，足协曾有人提议由经验丰富的老裁判取而代之，但提议未被采纳。抽签定哨能保证裁判选派公平，但由此引发的&ldquo;昏、嫩哨&rdquo;现象却屡禁不止，而除了加大失误裁判惩处力度外，中国足协似乎也找不到更好的办法。</p>\r\n<p style=\"text-indent: 2em\"><strong>足协曾担心王迪成&ldquo;定时炸弹&rdquo;</strong></p>\r\n<p style=\"text-indent: 2em\">新赛季中超开幕前，中国足协技术部、裁委会在香河基地完成了中超前6轮的裁判抽签仪式。按照内部工作流程，足协技术部在每轮联赛之前，都会请职业联赛部门对当轮裁判人选提意见。据了解，足协有关人士曾公开反对王迪执法武汉卓尔与北京国安的比赛，这是因为上赛季国安与辽足、2011赛季国安与深足比赛，王迪都曾漏判给国安点球。足协内部有人形容王迪，有可能成为比赛的&ldquo;定时炸弹&rdquo;，但这一建议最终被拒，其理由是，王迪是中国足协7名国际主裁中的一员，也是年轻裁判的佼佼者。而卓尔与国安的比赛是本轮一场重要比赛。一旦更换他，可能会在国内裁判界造成一些不良影响，同时也不利于年轻裁判的培养。然而提议的足协人士不幸言中。</p>\r\n<p style=\"text-indent: 2em\"><strong>王迪受罚难阻&ldquo;昏哨&rdquo;继续现身</strong></p>\r\n<p style=\"text-indent: 2em\">由于王迪错判造成了不小影响，裁委会昨天就形成了评议意见。一位足协人士透露，王迪判罚格隆禁区内假摔、漏判柯钊红牌都是严重的判罚失误，他将面临最低3 场、最高6场的处罚。王迪并非本赛季首位受内部处罚的裁判。执法中超首轮鲁能与阿尔滨比赛的前国际主裁陶然成、执法富力与辽足比赛的年轻主裁傅明、执法揭幕战恒大与申鑫的国际助理裁判穆宇新、国安与东亚比赛的助理裁判 王峰4 人，都因出现重大错、漏判被停赛3场。今年，裁委会对职业联赛裁判工作提出了新要求，管理制度及上岗考核，较往年也更为严格，国家级裁判张正平就因未通过体测而被直接降级。足协人士指出，&ldquo;从前两轮中超执法情况看，年龄并不是裁判员犯错误的主要因素。我们感觉裁判错漏判，最大的问题还在于态度。如果准备不足、对执法工作的自律不够，王迪之后很可能还会出现其他&lsquo;昏哨、嫩哨&rsquo;。&rdquo;</p>\r\n<p style=\"text-indent: 2em\"><strong>抽签定哨 足协纠结 裁判埋怨</strong></p>\r\n<p style=\"text-indent: 2em\">一位足协人士指出，王迪出现错漏判表面上看，是缘于裁判自身业务水平和临场应变能力不足，但其背后却反映出&ldquo;抽签定哨&rdquo;的呆板。有裁委会人士曾诉苦说，&ldquo;假球、黑哨丑闻曝出后，中国足协在裁判选用上承受了巨大压力，抽签起码保证了裁判选用公平。&rdquo;但从2010赛季起至今，类似王迪这样的&ldquo;嫩哨&rdquo;不止一个，同样在2010赛季被破格提拔为国际主裁的小张雷就因经不起实践考验，于第二年被取消国际执法资格；另一位争议&ldquo;嫩哨&rdquo;马宁也多次被裁委会临时取消中超执法机会。一系列事实证明，这些被中国足协寄予厚望的年轻裁判并未完全得到信任。同时，中国足协抽签后改派的举动反而引起裁判圈的不满。一位裁判专家曾这样抱怨，&ldquo;安排抽签，却不按抽签结果派裁判，抽中的裁判不用，对裁判自身的心理打击很大。与其如此，还不如按国际惯例，完全指派裁判。&rdquo;抽签定哨有无必要延续下去，中国足协也的确有必要深思熟虑一番。文/本报记者肖赧(<span class=\"infoMblog\">微博</span>)</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('48', 'text', '<p>3月18日体育专电（记者林德韧）NBA(<span class=\"infoMblog  \">微博</span>)官方18日公布了最新一期的实力榜，拿下22连胜的迈阿密热火队当之无愧地继续排在榜首，圣安东尼奥马刺队和俄克拉荷马雷鸣队分居二、三位。</p>\r\n<p>　　在击败多伦多猛龙队之后，热火队保住了自己的不败金身，东区冠军的位置已经基本锁定，现在剩下的唯一悬念就是热火队的连胜还能持续多久。</p>\r\n<p>　　此前排名实力榜第三的马刺队在上一周展现了稳定的表现，与此同时也赢得了与俄克拉荷马雷鸣队之间的强强对话，排名超越雷鸣队排在了第二位。状态起起伏伏的雷鸣队下降至第三。</p>\r\n<p>　　排名本榜单第四至第十位的队伍分别是：掘金队、灰熊队、快船队、步行者队、凯尔特人队、湖人队、网队。</p>\r\n<p>　　上一周的亮点是湖人队，&ldquo;紫金军团&rdquo;在常规赛末段打出高水准，战绩提升至36胜12负，距离西区第七的休斯敦火箭队仅差半场，实力榜排名也从上一期的第十一上升至第九。</p>\r\n<p>　　休斯敦火箭队在一场关键对决中大比分负于竞争对手金州勇士队，西区前八的位置不再牢靠，实力榜排名从第十下降至第十一。</p>\r\n<p>　　排名本榜单第十一至第三十位的球队分别是：火箭、尼克斯、老鹰、公牛、小牛、勇士、雄鹿、爵士、奇才、开拓者、猛龙、骑士、森林狼、国王、太阳、76人、黄蜂、活塞、魔术、山猫。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('49', 'text', '<p style=\"text-align: center; text-indent: 2em\"><img alt=\"\" src=\"/uploads/1/image/public/201303/20130319011912_nqvbjh.jpg\" style=\"width: 550px; height: 390px\" /></p>\r\n<p style=\"text-indent: 2em\">在上周六中超联赛卓尔与国安比赛下半时，卓尔球员柯钊暴踢国安外援马季奇的举动在足球界引起了不小反响。中国足协裁判委员会今天也出具报告提请纪律委员会对柯钊追罚。据了解，纪委会很可能将柯钊的犯规定性为暴力行为。由于他及其俱乐部认错态度良好，中国足协将按照底线处罚柯钊，柯钊面临停赛2场、1万元左右的追罚。</p>\r\n<p style=\"text-indent: 2em\">电视慢动作显示，柯钊连续3次踢中马季奇，结果当值主裁王迪仅仅向柯钊出示了1张黄牌。虽然汉军最终饮恨主场，但是俱乐部上下深明大义，俱乐部代表及柯钊本人也都通过微博等渠道向外界及被踢的马季奇道歉。中国足协今天上午在总结上轮职业联赛时，重点提到了此事。据悉，裁判委员会的报告上写明，柯钊的行为属于暴力行为，理应被纪律委员会追加处罚。不过，足协内部有人认为，柯钊并非恶意伤人，只是因为本队比分落后，加之比赛时间所剩无几，他心情急躁，行为失控。</p>\r\n<p style=\"text-indent: 2em\">今晚有消息显示，柯钊将面临停赛4场、罚款2万的处罚，但是从中国足协传来消息显示，纪律委员会今天并没有开会具体商议此事。目前此事还停留在听取各方意见的过程中。但可以肯定的是，柯钊被追罚在所难免。一位足协官员表示，&ldquo;鉴于柯钊认错态度不错，他也是初犯，协会不会加重处罚他，但这个行为依然性质很严重，被停赛2场的可能性最大。&rdquo;至于格隆，虽然国安已经上诉，但纪律委员会依据国际惯例维持原判，红牌停赛不变。纪律委员会预计于明后两天内作出最终处罚结果。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('50', 'text', '<p style=\"text-align: center\"><img alt=\"\" src=\"/uploads/1/image/public/201303/20130319012259_khrjth.jpg\" style=\"width: 550px; height: 299px\" /></p>\r\n<p>北京时间3月15日晚，欧足联在瑞士尼翁总部进行了本赛季欧冠(<span class=\"infoMblog\">微博</span> 专题) 1/4决赛对阵形势抽签。杀进八强的三支西甲(<span class=\"infoMblog\">微博</span> 专题) 球队中，皇马(<span class=\"infoMblog\">官方微博</span> 数据) 抽中土超劲旅加拉塔萨雷，巴萨(<span class=\"infoMblog \">官方微博</span> 数据) 遭遇法甲大鳄巴黎圣日耳曼(<span class=\"infoMblog\">微博</span> 数据) ，马拉加(<span class=\"infoMblog\">官方微博</span> 数据) 则要迎接德甲球队多特蒙德的挑战。以下是部分西班牙媒体评论。</p>\r\n<p>《马卡报》：&ldquo;皇马的抽签结果相对来说不错，4月3日，主帅穆里尼奥将在伯纳乌球场迎来他的几位老朋友，他们分别是德罗巴(<span class=\"infoMblog\">微博</span>)、斯内德(<span class=\"infoMblog\">微博</span>)和大阿尔滕托普，德罗巴是穆里尼奥执教切尔西(<span class=\"infoMblog   \">官方微博</span> 数据) 期间亲自召入的爱将，斯内德是穆里尼奥率领国际米兰夺取三冠王时的关键球员，大阿尔滕托普也曾在皇马效力，这几人帮助加拉塔萨雷战胜了沙尔克04晋级，但面对皇马，他们的运气恐怕就没这么好了，唯一要小心的是他们的前锋伊尔马兹，这位土耳其人目前和C罗(<span class=\"infoMblog\">微博</span> 数据) 并列欧冠最佳射手。&rdquo;</p>\r\n<p>《世界体育报》：&ldquo;巴塞罗那与巴黎圣日耳曼的较量将是一次王者之争，淘汰赛看实力也要看运气，两支球队曾在1994-95赛季有过交手，当时输球的一方是巴塞罗那，不过在1996-97赛季的欧洲优胜者杯决赛中，巴塞罗那在荷兰鹿特丹战胜了对手捧起冠军奖杯，当时为巴塞罗那进球的是罗纳尔多。&rdquo;</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('52', 'text', '<p style=\"text-indent: 2em\">尚德电力昨日宣布，公司已经收到3%可转债托管人的通知，即2013年3月15日到期的可转债仍有5.41亿<a class=\"a-tips-Article-QQ\" href=\"http://finance.qq.com/money/forex/index.htm\" target=\"_blank\">美元</a>的未支付金额，已经违约并要求尽快付款。该违约事件同时还导致尚德对包括国际金融公司和一些国内银行在内的其他债权人的交叉违约。</p>\r\n<p style=\"text-indent: 2em\">尚德电力也因此成为了中国大陆首家出现公司债务违约的企业。</p>\r\n<p style=\"text-indent: 2em\">公司表示，将继续努力进行重组，提高运营成本效率，保持与现有客户和供应商的良好关系，寻找其他的资金来源，以满足运营和债务偿还资金需求。</p>\r\n<p style=\"text-indent: 2em\">尚德电力的违约将有望引发债券持有人对公司的诉讼。尚德电力在上周宣布获得了63%债券持有人的同意，将把债务偿付时间延长两个月至5月15日，以便管理层着手进行债务重组。部分债权人拒绝接受这个方案，并组成一个团体威胁发起诉讼。</p>\r\n<p style=\"text-indent: 2em\">同时，尚德的声明显示其对国内银行也已出现违约。截至2011年末，尚德银行融资高达17亿美元，国内银行为尚德最主要的债权人，其中<span onmouseover=\"ShowInfo(this,&quot;00939&quot;,&quot;100&quot;,&quot;-1&quot;,event);\">建设银行</span>、国家开发银行、<span onmouseover=\"ShowInfo(this,&quot;03988&quot;,&quot;100&quot;,&quot;-1&quot;,event);\">中国银行</span>、<span onmouseover=\"ShowInfo(this,&quot;01288&quot;,&quot;100&quot;,&quot;-1&quot;,event);\">农业银行</span>等几家大行在尚德贷款较多，且大部分为无抵押的信用贷款。</p>\r\n<p style=\"text-indent: 2em\">据经济参考报(<span class=\"infoMblog\">微博</span>)报道，目前，尚德电力破产已成定局，具体的破产重组方案已获江苏省政府批准，将在20日左右出台。</p>\r\n<p style=\"text-indent: 2em\">从目前的情况来看，&ldquo;国资介入&rdquo;无疑是目前<span onmouseover=\"ShowInfo(this,&quot;STP.N&quot;,&quot;200&quot;,&quot;-1&quot;,event);\">无锡尚德</span>的唯一活路&ldquo;对于尚德电力来说，最好的选择将是为某些资产申请破产保护，并让国有力量进入该企业从而保护特定利益。当然，尚德电力不会全面破产，它的品牌将会一直存在&rdquo;。中国可再生能源协会副理事长孟宪淦指出。</p>\r\n<p style=\"text-indent: 2em\">无锡市国联发展(集团)有限公司(简称&ldquo;无锡国联&rdquo;)将有望接受和主导之后的重组工作，以母公司或者旗下产业投资基金的形式全面接管无锡尚德。据了解，无锡国联成立于1999年5月8日，是无锡市人民政府出资设立并授予国有资产投资主体资格的国有独资企业集团。</p>\r\n<p style=\"text-indent: 2em\">尚德电力由施正荣于 2001年创立，2006年，公司赴美上市，施正荣借此成为中国新首富，并引发了光伏产业一场声势浩大的造富运动。自去年以来，尚德的形势急转直下，截至今年3月份，该公司的负债总额已达到35.82亿美元，资产负债率已高达81.8%，市值从上市之初的49.22亿美元跌到如今的1.49亿美元。</p>\r\n<p style=\"text-indent: 2em\">3月4日，尚德电力发出公告称，施正荣辞去公司董事长职务，由王珊接替公司董事长一职。但是第二天施正荣就发出声明称，董事会撤除其董事长职务是非法无效的，并表示自己以在尚德的股权向银行担保并获取贷款。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('53', 'text', '<p>上世纪30年代，为利用美国技术建造新型军舰，苏联领导人特批从国库划拨50万美元的&ldquo;行政经费&rdquo;(在当时是一笔不小的数目)，供一家苏联外贸公司使用，以便打通美国高层关节。但这笔钱最终打了水漂，并连累不少人获罪，俄罗斯《权力》杂志日前刊文披露了这段秘闻。</p>\r\n<p>　　1924年，苏联在美国注册成立了阿姆外贸集团公司，专门从事苏美贸易。当时美苏尚未正式建交，阿姆外贸集团公司可以说垄断了两国的贸易活动。到了1933年，在苏联的要求下，同时也是为了迎合热心开拓苏联市场的美国工商界人士，美国新总统罗斯福正式承认苏联的合法性。</p>\r\n<p>　　当时，美国经济仍然萧条。美国商人都清楚，阿姆外贸集团公司的订单就是苏联政府的订单，意味着苏联政府的财政支持。但从另一个角度看，美国人认为，与这家公司签订合同就意味着与一个最敌对的国家开展贸易活动，所以特别警惕向该公司提供先进敏感的军事技术。鉴于此，莫斯科决定建立一个纯美国式的公司，找一个可靠的代理人。</p>\r\n<p>　　被选中的人叫卡尔普，一个有俄国血统的美国人。卡尔普出生在沙俄时期一个贫穷的裁缝家庭，1911年移居美国后，做过各种杂工，后做起石油生意。上世纪20年代末经济危机爆发后，卡尔普陷入困境，1933年，他不得不把自己的几个加油站低价处理。随后，他决定去莫斯科，看能否找到&ldquo;在俄罗斯赚美元&rdquo;的机会。正是在莫斯科，他结识了苏联对外贸易部官员，并受委托开始帮助苏联采购先进设备。</p>\r\n<p>　　但有不少人对卡尔普的能力表示怀疑。在1936年8月2日向时任苏联国防人民委员伏罗希洛夫的汇报中，苏联驻美国的军事参赞布尔津尤说：&ldquo;这个人(指卡尔普)行为举止欠稳妥，令人担忧。譬如，他到任何一个地方都随身携带虽说不是官方正式文件但都涉及我国采购设备的清单，甚至公开给一些有业务联系的企业和转售商看这些文件。这样做严重违反保密条款规定。总之，他一有机会就向人喋喋不休地介绍我国需求情况。&rdquo;这名参赞还提到卡尔普的特别背景苏联人民委员会主席莫洛托夫妻子热姆丘任娜的弟弟。</p>\r\n<p>　　尽管有人打了&ldquo;黑报告&rdquo;，卡尔普仍得到上面的信任。在与阿姆外贸集团公司达成划分采购权限的协议后，他顺利地完成了一些采购任务。卡尔普一有机会就向人们讲他与莫洛托夫的关系，并散布从苏联高层那儿得到的一些重要采购信息，去找他的客商很快便络绎不绝。卡尔普一下子成了一个&ldquo;神奇&rdquo;的商人。</p>\r\n<p>　　1937年5月14日，阿姆外贸集团公司董事会主席罗佐夫向莫斯科发去一份紧急密码文件。文件称：&ldquo;卡尔普今日向我报告，美国政府已拟订向我出售配置16英寸火炮系统战列舰以及火炮中央控制器的文件。为获得这份文件他需要50万美元用以补偿相关人士。&rdquo;莫斯科经过反复研究，决定做这个交易。</p>\r\n<p>　　苏联方面先划拨了30万美元，后来又增补了20万。这笔汇款的收款人一开始定为美国民主党全国委员会的一个重要人物以及总统的助手。此外，苏联人还想将这笔款项交到美国各部委员会负责军工技术产品审批事项的官员手中。事实上，这笔巨额资金最终到了罗斯福总统的儿子手里，为的是通过他将这笔钱送到罗斯福手中。</p>\r\n<p>　　没想到，卡尔普所办的事情被新闻界曝光了，连续几天美国各大新闻社、报刊都报道说苏联将在美国采购巨额军事装备，很多报刊不惜笔墨将该事件描绘成已经开始执行的订单。此外，在美国国务院办妥向苏联发运军事装备的批文后，涉及采购战列舰相关技术设备的麻烦越来越多。1937年11月3日，莫斯科接到报告说：&ldquo;卡尔普拿到的批文对采购战列舰专用的涡轮根本不起作用。<span onmouseover=\"ShowInfo(this,&quot;GE.N&quot;,&quot;200&quot;,&quot;-1&quot;,event);\">通用电气</span>作为海军部供应发动机的主要商家，根本不想接受我们的货物订单，而且还必须得到海军部的正式批文&hellip;&hellip;造船厂在媒体的一阵旋风式报道后，也想从苏联贸易代表处拿到战列舰设计费用&hellip;&hellip;&rdquo;</p>\r\n<p>　　据档案记载，莫斯科决定还是让卡尔普去做说客，并由苏联商贸代表特罗扬诺夫斯基约见美国总统。1937年11月27日，特罗扬诺夫斯基见到了罗斯福。据他事后向莫洛托夫报告，他向罗斯福抱怨美国海军部对苏方订单态度冷淡，罗斯福则表示会给负责海军事务的长官下指示，总统还建议直接在美国建船坞，并称会按照美国海军现役军舰标准为苏联设计建造战舰专用装甲钢板。</p>\r\n<p>　　事实上，这件事没有任何转机，在长时间的摩擦后，苏联人既没有得到驱逐舰，也没得到有关驱逐舰的任何技术设计图纸。经过苦口婆心的工作，美国人最后同意苏方带走有关建造战列舰的技术图纸。但苏联专家鉴定后表示，这些图纸完全不符合苏方的技术要求。</p>\r\n<p>　　1938年，美国国会成立了一个专门调查反美思潮的机构，卡尔普引起该机构的高度关注。他后来供出使用50万美元的细节，他本人从中擅自扣留了 10万美元。卡尔普的姐姐热姆丘任娜也未能幸免，1939年被控与&ldquo;人民公敌&rdquo;合作。1940年，阿姆外贸集团公司董事会主席罗佐夫被捕，被指控从事间谍活动，不断向卡尔普拨付苏共政治局决定的境外行政支出款项。1945年年底，美苏同盟关系名存实亡，这起让苏联人恼火的采购事件也被认为是源头之一。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('54', 'text', '<p style=\"text-indent: 2em\">北京时间3月19日凌晨消息，华尔街日报中国实时报栏目周一文章称，两名经济学家指出，美国房地产市场崩溃之前曾有过的三个警示性信号已经在中国出现，这意味着中国只有非常有限的时间来摆脱困境。</p>\r\n<p style=\"text-indent: 2em\">文章指出，在野村证券于上周六公布的一份报告中，经济学家张智威和陈家瑶指出，物业价格的上涨、杠杆化的快速积累和潜在增长率的下滑都可能导致系统性的危机。</p>\r\n<p style=\"text-indent: 2em\">这份报告引用凯斯席勒房价指数指出，美国的房价在2001年到2006年之间飙升了84%。而作为野村证券经济学家的张智威和陈家瑶对中国的官方指数提出了质疑，并认为这组数据指出的2004年到2012年之间主要大城市房价113%的&ldquo;良性增长&rdquo;并不准确。他们认为，这个数据过于宽泛，包括了全国范围内老旧和低品质的住房。与之相比，近期一份考虑到这种质量差异的学术报告认为，仅2004年到2009年之间，中国房价的涨幅就已经是250%。</p>\r\n<p style=\"text-indent: 2em\">张智威和陈家瑶在报告中写道，&ldquo;中国政府显然已经认识到房地产行业的风险，在过去多年推出了一系列逐渐收紧政策以控制物业价格的措施。市场的模式是，在紧缩政策推出之初下降，然后反弹，这意味着风险并没有得到缓解。&rdquo;依赖出售土地作为主要收入来源的地方政府可能在房地产开发商因为市场崩溃而受打击时遭受同等的重创。这些问题会轻易地在银行系统找到突破口&mdash;&mdash;估算显示，中国银行业14.1%的流通贷款发放给了地方政府的融资平台，6.2%授予了房地产开发商。</p>\r\n<p style=\"text-indent: 2em\">野村证券认为，中国还是有时间来避免系统性的金融危机，只要政府不畏惧马上启动政策紧缩。不过这一做法的代价将是2013年经济增长前景的受压制&mdash;&mdash;虽然最终的实际增长还是有望在2013年上半年达到8.1%，在下半年维持7.3%。报告强调，早期的紧缩可能引发可以控制的债务违约情况。</p>\r\n<p style=\"text-indent: 2em\">报告指出，另一个结果是继续目前的宽松政策，实现超过8%的2013年经济增长，然后面对可能在2014年初就出现了市场崩溃。而这种崩溃将会很快蔓延到整个系统，迫使政府介入对银行和地方政府进行救援，可能需要出售公共资产来解决混乱局面。</p>\r\n<p style=\"text-indent: 2em\">报告认为，最终导致中国出现危机可能性增加的因素是潜在增长率的下降。这并不是一个可以轻松计算的数字，它代表了经济在不产生额外通货膨胀情况下可以实现的最大增长速度。即使是最乐观的分析师也同意野村证券的判断，包括适龄劳动人口数量的萎缩等等因素都造成了这个指标的下降。这使得中国决策者刺激经济增长的回旋余地相比过去大大减少。</p>\r\n<p style=\"text-indent: 2em\">张智威和陈家瑶指出，&ldquo;金融危机通常跟随技术革命和所谓的经济奇迹，因为投资者和决策者开始过高估计经济的潜在增长能力。决策者可能错误解读潜在增长的结构性放缓，将它视作周期性的现象，并试图使用扩张性政策来刺激增长，这实际上为过热和最终痛苦的调整埋下了种子。&rdquo;</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('55', 'text', '<p style=\"text-indent: 2em\">针对日前有报道称&ldquo;中国<span onmouseover=\"ShowInfo(this,&quot;00763&quot;,&quot;100&quot;,&quot;-1&quot;,event);\">中兴通讯</span>股份有限公司在蒙古承建项目时涉嫌行贿，其管理人员已被蒙古国家反贪局逮捕&rdquo;，中兴公司18日接受《环球时报》记者采访时予以否认。</p>\r\n<p style=\"text-indent: 2em\">该报道称，本月13日，蒙古国家反贪局对中兴公司在当地的办事处、高管住处、私人汽车及车库进行搜查，将搜到的文件资料都带走，并将中兴高管羁押在监狱。</p>\r\n<p style=\"text-indent: 2em\">针对此事，中兴公司18日给《环球时报》发来声明称，作为在中国深港两地上市的国际化通信企业，中兴通讯一直以来秉持守法经营的理念。中兴通讯在蒙古的业务开展，与其他国家一样，完全符合行业国际惯例要求和所在国法律的规定。目前，我们的业务遍及全球140 多个国家的500多个运营商，有着近30年良好的行业经历。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('64', 'text', '');
INSERT INTO `cms_info_clob` VALUES ('66', 'text', '<p style=\"text-align: center\"><img alt=\"\" src=\"/uploads/1/image/public/201303/20130321005024_wikgfa.jpg\" style=\"width: 500px; height: 333px\" /></p>\r\n<p style=\"text-align: center\">老人手写&ldquo;感谢卡&rdquo; 一首感人的&ldquo;小诗&rdquo;</p>\r\n<p>女孩没让座，遭到一名老人揪头发殴打。另一群老人则举牌号召为年轻人让座。最近，发生在郑州的两则关于&ldquo;公交让座&rdquo;的新闻，引起社会各界热议。</p>\r\n<p>　　&ldquo;让座展示了郑州老人形象&rdquo;&ldquo;老年人让座，没必要&rdquo;、&ldquo;礼让年轻人的最好方式是乘车避开高峰期&rdquo;&hellip;&hellip;一时各种观点云集。</p>\r\n<p>　　对此，郑州公交四公司积极行动，专门开通&ldquo;老年乘客示范车&rdquo;，已试运行4天，预计将于明天正式运行，并在高峰时段加开老年人公交示范车。文明公交不仅需要规则，更需要公德。</p>\r\n<p>　　<strong>【一次目击】</strong></p>\r\n<p><strong>　　老人让座无人敢坐</strong></p>\r\n<p>　　昨天是此次老人让座行动的最后一天，早晨7时，6位老年人来到文化宫路与建设路交叉口附近一处公交站牌下，他们头戴红帽，手举红牌，上写&ldquo;给年轻人让座&rdquo;。这已经是他们连续第四天在此地号召老年人给年轻人让座。</p>\r\n<p>　　早晨7时20分，记者随两位老人坐上了1路公交车。老人上车后，立即有一名年轻男子和两名年轻女子起身让座，老人坐下后连声说&ldquo;谢谢&rdquo;，并向3名年轻人赠送小礼品一个印有&ldquo;共创文明郑州，争做文明市民&rdquo;字样的环保袋，3人很高兴地接过了礼品。</p>\r\n<p>　　车行至绿城广场站时，一位老人让座给一名年轻女子：&ldquo;姑娘，你坐吧！&rdquo;女子有些不知所措，连忙推辞。两人谦让一阵后，女子坚持不坐，老人也站在座位旁，此时车厢内站着约20名乘客，无一人敢坐下。</p>\r\n<p>　　<strong>【一个尝试】</strong></p>\r\n<p><strong>　　公交公司开通老年人&ldquo;专车&rdquo;</strong></p>\r\n<p>　　昨日上午9时许，记者在郑州陇海路与紫荆山路的一家大型超市门前随机采访了几名刚下公交的乘客。不少人认为，让来让去都是因为座太少，&ldquo;应当增加公交车数量。&rdquo;</p>\r\n<p>　　对此，郑州公交四公司进行了新的尝试开通老年人&ldquo;专车&rdquo;，目前已连续试运行4天，最早将于明天正式上线运行。</p>\r\n<p>　　昨日上午，记者来到郑州公交四公司，在公交调度室，调度员于建龙告诉记者，他们在52路公交线路上开通了&ldquo;老年乘客示范车&rdquo;，目前已抽调3辆公交车投入运行，行驶速度低、平稳，车长还会下车扶老人上车。</p>\r\n<p>　　据了解，52路公交车运行线路上有城隍庙、人民公园、体育场等公共活动场所和一些大型商场，老年人较多。&ldquo;老年乘客示范车&rdquo;的一名车长赵小勇告诉记者，该线路上老年人多于其他线路，示范车开通以来，受到老年乘客的欢迎。</p>\r\n<p>　　但因标识、标牌和配套设施尚在制作中，&ldquo;老年乘客示范车&rdquo;与普通公交尚无明显区别。标识牌最早将于明天装上，车上还将配置拐杖等，届时，&ldquo;老年乘客示范车&rdquo;将正式运行，专供老年人乘坐。</p>\r\n<p>　　据悉，目前郑州多家大型超市已经开通购物公交，车辆逐渐增多，在满足老年人购买新鲜蔬菜的同时减轻了公交的压力。</p>\r\n<p>　　<strong>【一份温暖】</strong></p>\r\n<p><strong>　　老人遗失在公交车上的&ldquo;感谢卡&rdquo;</strong></p>\r\n<p>　　&ldquo;上班高峰期，人多，为节约空间，其他人可以坐&lsquo;老幼病残孕妇专座&rsquo;，但是，有老幼病残孕妇上车时，专座上的人应当无条件让座。&rdquo;一名52路公交车长说，&ldquo;人少，座位够时，年轻人应当自觉坐在普通席位上。&rdquo;</p>\r\n<p>　　其实，郑州人本就喜欢让座给老年人，在全国都比较有名，老年人常觉温暖。昨天，调度员于建龙给记者展示了一个乘客遗失在公交车上的物品。这是一张&ldquo;感谢卡&rdquo;，上写&ldquo;你是当代活雷锋，主动让座我感动！祝你身体永康健，祝你心想万事成&rdquo;，卡片背面写着&ldquo;我叫胡秀云&rdquo;，还写着电话号码。</p>\r\n<p>　　于建龙说，这张卡片是昨天公交车上的遗失物品，看完让人感动。&ldquo;很多老人都有感恩之心，年轻人让座，老年人心里很温暖。&rdquo;52路公交车长赵小勇说，&ldquo;经常有老人在车上对我说，感谢年轻人让座。&rdquo;</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('67', 'text', '<p style=\"text-indent: 2em\">王克勤说自己是个受&ldquo;士文化&rdquo;影响颇重的人。在漫长的历史银河中，&ldquo;士文化&rdquo;不仅作为横坐标以时间长轴的形式被延续了下来，同时也作为纵向标尺影响着一代又一代的知识分子，朝着人格的更深、更高处探索与进取。时光伴随尘埃飞扬而过，历史的光影照在 &ldquo;士人&rdquo;之上，我们看到&ldquo;士&rdquo;的种类着实缤纷：昨有著书立说的&ldquo;学士&rdquo;，亦有为知己者死的&ldquo;勇士&rdquo;，还有通晓阴阳历算的&ldquo;方士&rdquo;，以及为人出谋划策的&ldquo;策士&rdquo;&hellip;&hellip;而如今，看见王克勤的所为所行，才猛然发觉，&ldquo;士&rdquo;的文化已随时光辗转，相容创新。&ldquo;我就是一个热爱公益、捍卫公益、践行公益的&lsquo;士&rsquo;。&rdquo;王克勤如此说道。这个以&ldquo;中国第一调查记者&rdquo;身份名满天下的&ldquo;士&rdquo;，在犀利和凛冽的无疆新闻中行走，虽砥砺于诸多风雨险阻，但仍深秉毅持着&ldquo;为他谋福&rdquo;的思想, 延续着&ldquo;士不可以不弘毅，任重而道远&rdquo;的中华民族公益思想。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;其实公益之念，从来不曾走远。&rdquo;王克勤坚信：每一个中国正士的身上，一定充溢着公而益众的铁血雄魂和慈悲柔情，只要在这个时代敢于坚持，中国公益之士的能量就会被唤起、被汇集，终成大势。</p>\r\n<p style=\"text-indent: 2em\">■ 本报记者 艾已晴</p>\r\n<p style=\"text-indent: 2em\"><strong>好人好报是内心的安宁</strong></p>\r\n<p style=\"text-indent: 2em\">王克勤的记者生涯已有二十多年。这二十多年来，王克勤因为其持恒的职业操守、卓越扎实的新闻调查功底、与恶势力死磕到底的坚毅精神、对弱势底层群体的不吝关怀，以及对公益事业的热忱付出，使默默无闻的自己变成了新闻行业中的标杆型人物。</p>\r\n<p style=\"text-indent: 2em\">王克勤是个不折不扣的社会观察者、调查者和参与者。毋庸置疑的是，无论处于社会的何种时期，他对社会的热点、难点，总能把握精准，认知独到。也正是因为这样的&ldquo;能耐&rdquo;，让王克勤在从事公益事业之时，总能找到社会之中最迫切待解且对未来影响深远的公益聚焦点。2011年6月15日，王克勤联合中华社会救助基金会共同发起了&ldquo;大爱清尘&middot;寻救中国尘肺病农民兄弟大行动&rdquo;，他将公益的帮扶群体聚焦在了在死亡线上苦苦挣扎、缺少医药、最苦难、最底层的6000万尘肺农民，这其实就是王克勤对社会问题的敏感认知延展至公益项目的最好体现。</p>\r\n<p style=\"text-indent: 2em\">然而，尽管调查记者和公益项目策划人之间有着非常接近的社会特性，但这两种身份其实有着很大的不同。前者凛冽直接、锐利若刀，而后者则更需要温情与调和。置身于这两种不同之中，王克勤自己有着怎样的辨别？</p>\r\n<p style=\"text-indent: 2em\">王克勤告诉记者：&ldquo;其实，做公益也需要调查的本领，要像调查记者似的，不怕艰难险阻地收集材料，倾听需要帮助之人的疾苦，同时也需要用事实说话。虚假的求助信息绝对不能被容忍，因为这样会深深伤害公益事业的整体公信力。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">&ldquo;但因为公益的信息时常来自民间，苦而难的形式又不只一种，政府在面临很多不熟悉或者闻所未闻的苦难之时，一定会有暂时不适的感觉。如果此时公益人和政府出现正面冲突或者情绪用事，放弃坚持已久的救助，只能徒增矛盾，无法解决问题中最真切的部分。&rdquo;王克勤说道。</p>\r\n<p style=\"text-indent: 2em\">王克勤回忆起&ldquo;邢台艾滋病事件&rdquo;时说：&ldquo;那时候，人们对艾滋病的认知非常少，于是很多人把艾滋病妖魔化，地方政府更是&lsquo;谈艾色变&rsquo;。因此我就一条一条资料收集给政府看，思想是一步一步转变的，有时候，做公益、启思想，是不能着急的。公益人，就是要收集详实的事实资料，在准备充分的情况下，才可推动地方政府的公益事业和政策。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">&ldquo;公益事业可能更需要学会&lsquo;合作&rsquo;，特别是学会和政府合作。为了那些需要帮助的人们，我现在也在学习和改变的道路上前行。&rdquo;王克勤说。</p>\r\n<p style=\"text-indent: 2em\">事实上，正如王克勤所示，民间公益组织实为政府强有力的补充，政府和公益组织之间的关系，并非二元对立，而是搭建平台、共同成长。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;无论是调查记者，还是公益人，我对于这两种工作的感情都是深厚的，极其热爱它们。因为它们都能让我收获内心的安宁。&rdquo;王克勤表示，&ldquo;有的人可能为了生存做着一份不喜欢的工作，有的人做一份有钱但是很枯燥的工作。我能做既喜欢又有意义、做再多次也不觉得疲倦无趣的工作，是非常幸福开心的。&rdquo;说到这里，王克勤喜悦难掩。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;而在这个社会中，好人是否能及时获得相匹配的&lsquo;好报&rsquo;，其实是一个一时间无法很好回答的问题。但我始终坚信，好人的&lsquo;好报&rsquo;，其实就是内心的安宁。&rdquo;王克勤对记者坦诚道来，&ldquo;获得内心的安宁着实是一种人生的莫大幸运，因为事实上，很多的酸涩与苦痛，是可以被内心的安宁感消解的。而让人心满足本就很难，它是个世界难题，但幸运的是，这种安宁的来源可以通过不停地行善来制造。&rdquo;</p>\r\n<p style=\"text-indent: 2em\"><strong>士与公益人之间的自我拉扯</strong></p>\r\n<p style=\"text-indent: 2em\">&ldquo;我身上传统的影子非常浓重。&rdquo;王克勤不掩自豪，受传统士文化影响，王克勤乐善好施，轻财好士。如果你仔细体会的话，其实这个外在文秀的公益者，心中活着一个传统形象鲜明的&ldquo;大英雄&rdquo;。</p>\r\n<p style=\"text-indent: 2em\">古训云：轻财足以聚人，律己足以服人，量宽足以得人，身先足以率人。王克勤铭信，与钱保持距离，不贪钱、善分配，是公益人所遵循的基本理念。</p>\r\n<p style=\"text-indent: 2em\">然而，无法忽视的是，在今天这样一个追逐经济成就的时代，像王克勤这样遵循&ldquo;士&rdquo;之善道、轻财尚义的人，多少会面对这样的心理纠结：一方面是士的文雅和坚守；另一方面，面对尘肺病人几近绝望的求助，想到救助资金捉襟见肘的尴尬和无奈，还有那么一丝不甘和心酸。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;我很多时候会陷入扭曲的心理状态，不断地出现自我拉扯，感到很苦恼，也很困扰。&rdquo;王克勤真诚地表示。</p>\r\n<p style=\"text-indent: 2em\">一名老调查记者不媚权利资本的为人准则和公益筹款的艰难现实，形成这个&ldquo;只为苍生说话&rdquo;的风骨之人心中的软肋，也催生了行动之上的尴尬。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;别人能为一个公益项目的筹资去应酬，这方面，我好像却不太能行。&rdquo;王克勤笑着告诉记者，&ldquo;但也正因为如此，深觉善款的宝贵，对于救命的公益钱，定当毫厘珍惜。&rdquo;</p>\r\n<p style=\"text-indent: 2em\"><strong>去明星化的公益&ldquo;明&rdquo;人</strong></p>\r\n<p style=\"text-indent: 2em\">王克勤早已是个名人，如今的他更因公益事业上的风生水起，俨然有向&ldquo;公益明星&rdquo;发展的势头。毫不夸张地说，这些年，王克勤拿公益类的大奖拿到手软，更受到了媒体圈和公益圈人士的&ldquo;热捧&rdquo;。人们甚至在各种颁奖晚会上欣然发现，王克勤出现的频率不比演艺明星小&mdash;&mdash;2010年度时尚先生盛典的年度时尚先生、《新周刊》&ldquo;2011中国杯帆船赛蓝色盛典晚宴&rdquo;颁发的&ldquo;时代骑士&lsquo;爱骑士&rsquo;&rdquo;勋章、《南方都市报》&ldquo;责任中国&rdquo;2011公益盛典颁奖礼的&ldquo;2011公益行动奖&rdquo;、&ldquo;<a class=\"a-tips-Article-QQ\" href=\"http://www.qq.com/\" target=\"_blank\">腾讯网</a>思享之夜&rdquo;2011年度公益记者&hellip;&hellip;种种荣誉，如潮水般涌来。然而这些给予和称赞却没有让王克勤失掉最本色的东西，比起明星，王克勤好像更热衷于做一个公益&ldquo;明&rdquo;人。</p>\r\n<p style=\"text-indent: 2em\">即便走&ldquo;明星化路线&rdquo;能为公益项目带来迅速的资源和名声，王克勤却仍不选择做一个明星公益人。他觉得他永远是那个在田间地头，满脚泥泞、一卷裤腿儿席地而坐、与农民兄弟唠家常的人。在躁气十足的&ldquo;浮时代&rdquo;，他希望用自己的&ldquo;沉&rdquo;的方式，将朴素的公益模式树立成一种品牌。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;我觉得做公益要把身段低到尘埃里，这种&lsquo;低&rsquo;不是自卑，也不是恐惧，对于我自身而言，做公益其实是需要谦卑和踏实的。踏实、&lsquo;亲人&rsquo;的公益模式，也许在很多方面的发展上并没有那么成效显著、一步千里，但它是值得推敲，可持续、可延伸的。&rdquo;王克勤说道。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;但是这并不代表，我对于&lsquo;明星&rsquo;是反感、排斥的。&rdquo;王克勤补充道。令人感到惊讶的是，对于名气不迷信、不依赖、不刻意、不拒绝的王克勤，却获得了无数名人朋友的热情相挺。</p>\r\n<p style=\"text-indent: 2em\">2011 月11月12日，著名影星陈坤携手大爱清尘基金举办了&ldquo;爱、自由呼吸&rdquo;徒步活动，呼吁全社会共同关注尘肺农民。2011年12月10日在四川，陈坤再次支援王克勤义举，举办了&ldquo;爱、自由呼吸&rdquo;制氧机捐赠活动。陈坤及部分网友捐资购买53台医用制氧机，赠送给四川、陕西、湖北等地的尘肺患者。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;在&lsquo;大爱清尘&rsquo;最开始的时候，捐款人寥寥无几，我当时想着，&lsquo;大爱清尘&rsquo;可能办不下去了。没想到的是，姚晨帮&lsquo;大爱清尘&rsquo;转发了微博，捐款一下子就多了起来。&rdquo;王克勤言语中流露谢意。</p>\r\n<p style=\"text-indent: 2em\">翻开王克勤的履历，你会惊奇于他经历的转变：农家子弟出身的王克勤曾在市委机关从事过文秘宣传，在外贸进出口公司从事过商贸业务，而且还在一家国企担任过一年多的副厂长。1989年从业媒体开始，至今先后在《甘肃经济日报》、《西部发展报》、《西部商报》、《中国经济时报》从事记者编辑、专栏负责人、部主任及执行总编等工作。而他如今的身份，则是一名真真切切的公益人。从过政、经过商、事过文，风景看遍，此时此刻，他听从本心，拥抱公益。&ldquo;杜鹃啼血，精卫填海。我们是平凡人，也许我们没有拯救世界的力量，但我们固守爱与善良，坚持行动与呐喊。&rdquo;王克勤这个现代之士从未忘却古老的善之初心，他知道他的未来，定会与公益紧紧捆绑，用真切的呐喊和真心的行动与民众紧紧相连。</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('68', 'text', '<p style=\"text-align: center; text-indent: 2em\"><img alt=\"\" src=\"/uploads/1/image/public/201303/20130321005400_hpkjcm.jpg\" style=\"width: 399px; height: 320px\" /></p>\r\n<p style=\"text-indent: 2em\">&ldquo;这一个星期，全是采访，把我累病了。&rdquo;陈楚碧说。</p>\r\n<p style=\"text-indent: 2em\">陈楚碧是广东省中山市南朗镇人，之前从来没有被媒体关注过的她，突然间被全国大批媒体围追堵截，这使她的生活发生了突如其来的变化，她说自己很不适应。</p>\r\n<p style=\"text-indent: 2em\">这种变化源于她在1995年参加&ldquo;特区与老区心连心&rdquo;活动，如今机缘巧合让她遇到了当初的受助者，却发现当初捐资的400元对方称只收到40元。</p>\r\n<p style=\"text-indent: 2em\">事件经过18年的酝酿发酵，不得不说过于漫长。而时过境迁，现在再去试图还原当时的情景，很多细枝末节已是无从考证。</p>\r\n<p style=\"text-indent: 2em\">然而思考和追问并没有停止，是什么导致了捐赠结果大幅缩水？如何捐赠才能保证有效执行？尊重捐赠人意愿是否重要？第三方监管应该如何执行？</p>\r\n<p style=\"text-indent: 2em\">带着这一系列问题，《公益时报》记者采访了事件当事人、公益领域专家学者，以求探寻长期存有的&ldquo;中国式捐赠&rdquo;特色。</p>\r\n<p style=\"text-indent: 2em\"><strong>400捐款变40缩水10倍</strong></p>\r\n<p style=\"text-indent: 2em\">1995 年陈楚碧还是深圳南山区南头街道大汪山社区的居民组长，有天她接到上面下发通知，希望社区动员居民参加一个扶贫助学活动，根据经济条件，资助模式可以选择 &ldquo;一对一&rdquo;或&ldquo;多对一&rdquo;，陈楚碧当时家庭条件还算不错，就选择了&ldquo;一对一&rdquo;，并确定江西省峡江县戈坪乡戈平小学五年级学生陈小喜为资助对象。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;当时&lsquo;希望工程&rsquo;的影响力还是蛮大的，社区召集我们集中发放了多张资助卡，卡片上写了这些孩子的详细信息，我就选中了陈小喜，当时他12岁，以每年400块标准连续资助他4年，这时他刚好能够初中毕业，如果成绩好可能会考上高中甚至上大学。但我没有想到他跟我这么多年来总共才收到40元钱，这令我很意外，整整&lsquo;缩水&rsquo;10倍。&rdquo;陈楚碧对《公益时报》记者表示。</p>\r\n<p style=\"text-indent: 2em\">1995年7月陈小喜念小学五年级，1999年初中毕业后因无钱继续上高中而选择参军，后又回家务农。2001年陈小喜委托当时在东莞打工的叔叔给资助人陈楚碧写信，希望能帮助安排一份工作，随即收到了陈楚碧回信，信中说欢迎陈小喜来中山并将他安排在自己丈夫开办的石头厂里做工，信封里还附夹了20元钱。陈小喜在邀约下随即赴中山打工并与资助人相见后，双方才知道捐助款项并没有按实际款额发放，此时已经是2001年。12年后，被资助人的身边人将此事发到了网上才引起热议。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;我只是在小学五年级那一年收到过40块钱，其后的几年再也没有收到过，上了初中，我以为人家没有再捐款了也不好多问，最后20块钱，是在我初中毕业后想请她帮我找个工作在回信中捎来的，我总共就收到了60元。&rdquo;陈小喜在接受《公益时报》记者采访时说。</p>\r\n<p style=\"text-indent: 2em\">现在陈小喜在一家工厂做叉车工，每月工资有3000多元。&ldquo;当时我成绩还算很好的，2个科目总共200分我就考了187分，1995年时候400元还算得上一笔不小的钱，如果我每年有这400元，可能现在结果会不一样。&rdquo;陈小喜说。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;那时候每年200元学费对我家来说都很吃力，每到交学费时家里情况都很紧张。&rdquo;陈小喜说，这笔资助款没有用到他身上。</p>\r\n<p style=\"text-indent: 2em\"><strong>捐赠人的问责意识</strong></p>\r\n<p style=\"text-indent: 2em\">&ldquo;我都已经捐了钱还要我去监管，这累不累呀。这是一种普遍心态，通过相关调研我们发现中国公众普遍缺乏这种捐赠维权意识。&rdquo;清华大学公共管理学院创新与社会责任研究中心主任邓国胜对《公益时报》记者说。</p>\r\n<p style=\"text-indent: 2em\">1995年开始连续捐款4年中陈楚碧只收到过陈小喜的一封感谢信，其他消息并未获得太多，也根本不了解资助钱款发放过程和额度。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;捐了就捐了，当时也不只我一个人，还有好多社区居民我们都有捐，4年中我只收到过陈小喜一封感谢信，信中也没有提及到钱的数额，我觉得有感谢信就肯定是收到了钱，我也没想去问他究竟收了多少钱？下次再捐款我要多看看了。&rdquo;陈楚碧说。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;这是当今国人捐赠的一个普遍心态，有些大型企业捐赠也是如此，捐过就算完，究竟这笔钱是怎么花的，花到何处，他们并不清楚。&rdquo;华南师范大学法学院副教授唐昊对《公益时报》记者表示，&ldquo;捐款人应该把捐款这件事当成自己的，而不是捐完后就成了国家或某些公益组织的事。当前国家在法律环境和社会氛围中对于公民社会的认同感还没有建立起来，没有承担社会责任的传统的习惯，往往我们碰到这样事情，下一步采取的一定就是不捐了，这样完全又成了一个消极行为，也改变不了捐赠习惯，作为一个积极的公民就应该去追溯捐款的去处，我们都需要一个向积极公民方向发展的时间，希望这个时间越短越好。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">2010 年5月，福建福耀玻璃集团董事长曹德旺、曹晖父子以个人名义，通过中国扶贫基金会向云南、贵州等五省区市的贫困家庭捐赠善款2亿元，根据双方合同约定，基金会必须在半年内将2亿元捐款发放到西南五省区的近10万户困难群众手中；善款下发之后，将由评估机构随机抽检10%的受助家庭，如发现不合格率超过 1%，中国扶贫基金会将对超过1%的部分予以30倍的赔偿（最高赔偿额不超过项目管理费），甚至还聘请、组建了专业的监督委员会，对善款的使用情况进行监督，这也开创了中国捐赠者对公益捐款问责的先河。</p>\r\n<p style=\"text-indent: 2em\">邓国胜认为，捐赠维权意识的缺少不仅仅是个人也包括企业。&ldquo;捐完款后就不再过问，反正就是爱心已经表达了，至于这个钱怎么花了不再关心，对善款流向的关注度不够是中国捐赠者普遍存在的问题，通过这件事情提醒捐赠人，不仅要表达爱心，而且要关注捐款流向，加强对公益组织的监督，这一点是非常重要的。但是针对这种小额个人捐款，他要自己去维护权益，成本确实太高，技术上有一定的难度，怎么很好的发挥现代传媒的作用，和透过独立第三方的监督，可能是下一步发展方向。&rdquo;邓国胜说。</p>\r\n<p style=\"text-indent: 2em\"><strong>捐款人也是上帝</strong></p>\r\n<p style=\"text-indent: 2em\">据新华网江西频道3月12日最新消息称，江西峡江县&ldquo;助学捐款缩水&rdquo;事件调查有了新进展。据吉安市希望工程实施办公室介绍，经调查核实，捐款人陈楚碧女士通过&ldquo;1+1&rdquo;助学活动捐助的400元捐助款去向已查明。受助人陈小喜当时领取了两个学期共80元的捐助款，其余320元转为资助其他困难小学生。</p>\r\n<p style=\"text-indent: 2em\">由于当时特定历史条件，捐受双方不能够有效沟通，指定性捐款在执行过程中走样，捐助资金转给他人，捐赠人是否有知情权和决定权？</p>\r\n<p style=\"text-indent: 2em\">对于中国公益界有时会出现违背捐赠人意愿的行为，北京师范大学公益研究院院长王振耀在接受《公益时报》记者采访时表示：&ldquo;一直都说顾客就是上帝，其实捐赠方也应该归结为上帝，上帝作出捐赠行为后，剩下的执行环节不管是公益机构还是个人就应该为上帝服好务，应该对捐赠人的善款使用情况进行如实告知。这件事发生在1990年中后期，可以理解为当时特定历史条件下信息通讯不如现在发达，但只要是执行方和受助方能够给捐赠人一个回应，也可能好多捐赠纠纷就不会发生。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">&ldquo;如果查实这笔钱确实是捐赠额与受助人领取金额不等，当地的执行机构应该给陈楚碧一个道歉，不能因为时间久远而就不了了之，一个道歉会解开双方更多心结，也是一种处理问题的高雅方式。&rdquo;王振耀说。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;政府对于公益组织应该进行有效监管的，主要监管机构应该是民政部门和相关执法机关，有效监管有助于提高捐赠资金使用的透明度和使用效率。&rdquo;邓国胜说。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;第三方监管特别重要，这种监管对于领导来说很有压力的。&rdquo;王振耀也持有同样观点，&ldquo;我们现在监管要么松、要么紧，松的时候搞些什么评估不疼不痒，紧的时候就跟组织斗法，这两种都不好。&rdquo;</p>\r\n<p style=\"text-indent: 2em\">&ldquo;作为捐赠方就应该注重捐赠效果，想做好事，就应该把好事做好，做不好这一步，到头来只能是捐赠方和受赠方都不高兴，好事反倒变得差强人意。&rdquo;王振耀说，&ldquo;中国目前要是发生一起捐赠方的法律诉讼，或许能够有效促进此类事件的解决，改变中国捐赠格局。&rdquo;</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('69', 'text', '<p style=\"text-indent: 2em\">60800毫升鲜血意味着什么？</p>\r\n<p style=\"text-indent: 2em\">如果按平均每个病人用血800毫升计算，挽救的是70多位患者的生命。</p>\r\n<p style=\"text-indent: 2em\">而对于一个普通人来说，这些血量相当于给他全身换血10余次。若按国家捐献全血和血小板的时间间隔，至少坚持十年一次不落地献血，才能达到这个数值。</p>\r\n<p style=\"text-indent: 2em\">创造这个数值的是宁波宁海县一位普通水电工王伟栋。</p>\r\n<p style=\"text-indent: 2em\">2002年的一天，还在宁波永信钢管厂工作的王伟栋像往常一样上班，一辆献血车刚好停在桃源路口，他没有献过血，觉得很新鲜。&ldquo;要不我也试试？&rdquo;等到休息日，王伟栋特地来到县献血办，体检、化验通过后，他捐献了200毫升全血。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;从血站出来，我心里装着满满的成就感，一直在想，我的血会救到哪些人？&rdquo;从此，王伟栋跟献血结下了不解之缘。</p>\r\n<p style=\"text-indent: 2em\">此后几年里，只要献全血的间隔时间6个月一到，他就会揣着&ldquo;红本本&rdquo;赶往宁波市中心血站献血。2007年，王伟栋得知可以去宁波市中心血站捐献血小板，每隔28天能捐献血小板10至20单位，相当于800毫升全血。于是，他改为捐献血小板，这一坚持又是6年。</p>\r\n<p style=\"text-indent: 2em\">2012年7月1日起，国家调整了机采血小板的采血间隔，从原来的28天调整为14天，他又开始了每月两次的献血之路。至今，他已累计献血达83次。</p>\r\n<p style=\"text-indent: 2em\">&ldquo;既然参加献血了，就要对自己的血液质量负责，这也是对被救助人负责。&rdquo;献血次数多了，王伟栋为自己定下了许多规矩：不能熬夜，饮食科学，烟酒不沾&hellip;&hellip;</p>\r\n<p style=\"text-indent: 2em\">&ldquo;11年来坚持参加献血，每次采血血液质量都合格，不仅仅是一片爱心，更是自律精神的体现。&rdquo;一位经常献血的志愿者告诉记者，为了保证血液质量，献血者最好烟酒不碰，饮食清淡，献血前要注意休息，而现在随着群众生活水平的提高，很多人饮食不注意，血液质量很多都不合格。</p>\r\n<p style=\"text-indent: 2em\">这场&ldquo;爱心长跑&rdquo;，王伟栋期待更多的人加入。如今，他还是一名无偿献血服务队的志愿者，动员周边的人加入到无偿献血队伍中来。他说：&ldquo;无偿献血是一项人人参与的公益性活动，我们手拉手，才能构筑起生命新的长城。&rdquo;</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('70', 'text', '<p>欢迎测试！</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('71', 'text', '<p>Jspxcms1.0正式发布</p>\r\n');
INSERT INTO `cms_info_clob` VALUES ('72', 'text', '<p>Jspxcms2.0正式发布</p>\r\n');

-- ----------------------------
-- Table structure for `cms_info_custom`
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_custom`;
CREATE TABLE `cms_info_custom` (
  `f_info_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_infocustom_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infocustom_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息自定义表';

-- ----------------------------
-- Records of cms_info_custom
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_info_detail`
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_detail`;
CREATE TABLE `cms_info_detail` (
  `f_info_id` int(11) NOT NULL,
  `f_title` varchar(150) NOT NULL COMMENT '主标题',
  `f_subtitle` varchar(150) DEFAULT NULL COMMENT '副标题',
  `f_full_title` varchar(150) DEFAULT NULL COMMENT '完整标题',
  `f_link_url` varchar(255) DEFAULT NULL COMMENT '链接url',
  `f_color` varchar(50) DEFAULT NULL COMMENT '颜色',
  `f_is_strong` char(1) NOT NULL DEFAULT '0' COMMENT '是否粗体',
  `f_is_em` char(1) NOT NULL DEFAULT '0' COMMENT '是否斜体',
  `f_meta_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_source` varchar(50) DEFAULT NULL COMMENT '来源名称',
  `f_source_url` varchar(255) DEFAULT NULL COMMENT '来源url',
  `f_author` varchar(50) DEFAULT NULL COMMENT '作者',
  `f_small_image` varchar(255) DEFAULT NULL COMMENT '小图',
  `f_large_image` varchar(255) DEFAULT NULL COMMENT '大图',
  `f_video` varchar(255) DEFAULT NULL COMMENT '视频url',
  `f_file` varchar(255) DEFAULT NULL COMMENT '文件url',
  `f_file_name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `f_info_template` varchar(255) DEFAULT NULL COMMENT '信息模板',
  `f_info_path` varchar(255) DEFAULT NULL COMMENT '信息路径',
  `f_video_name` varchar(255) DEFAULT NULL COMMENT '视频名称',
  `f_is_new_window` char(1) DEFAULT NULL COMMENT '是否在新窗口打开',
  `f_file_length` bigint(20) DEFAULT NULL COMMENT '文档长度',
  PRIMARY KEY (`f_info_id`),
  CONSTRAINT `fk_cms_infodetail_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息详细表';

-- ----------------------------
-- Records of cms_info_detail
-- ----------------------------
INSERT INTO `cms_info_detail` VALUES ('24', '中央决定周强任最高人民法院党组书记', null, null, null, null, '0', '0', null, '南方日报', null, '杨春', '/uploads/1/image/public/201303/20130318014022_0guow9.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('25', '国防大学教授：中国军费增长只是在“补课”', null, null, null, null, '0', '0', null, '南方日报', null, '杨春', null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('26', '全国人大宣读部委官员人选 反对票多引发惊叹', null, null, null, null, '0', '0', null, '中国广播网', null, '王军', null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('27', '聚划算成清仓专用 问题产品充斥', null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('28', '中国制药企业首次在美国反垄断诉讼中遭处罚', null, null, null, null, '0', '0', null, '中国广播网', null, '张祥', null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('29', '朝鲜发表告全体朝鲜民族书 称半岛处在战争边缘', null, null, null, null, '0', '0', null, '中国新闻网', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('30', '报告称中国取代英国成世界第5大常规武器出口国', null, null, null, null, '0', '0', null, '环球时报', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('31', '日本允许企业参与战机制造 违反武器出口三原则', null, null, null, null, '0', '0', null, '中国新闻网', null, null, '/uploads/1/image/public/201303/20130318083544_p5et5u.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('32', '加拿大市民抱怨“中文招牌广告过多”引争议', null, null, null, null, '0', '0', null, '环球时报', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('33', '汽车高速爆胎致车祸 鉴定机构回避轮胎质量问题', null, null, null, null, '0', '0', null, null, null, null, '/uploads/1/image/public/201303/20130318084854_x4wvqy.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('34', '市民未插卡取款机吐出一万元 不受诱惑忙报警', null, null, null, null, '0', '0', null, '春城晚报', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('35', '石家庄一市民夜间骑车撞电线杆获赔1.5万元', null, null, null, null, '0', '0', null, '中国新闻网', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('36', '上海离婚量上升 “离婚缘由”填“购房需求”', null, null, null, null, '0', '0', null, '东方网', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('37', '苹果或将季度股息提升56% 年股息将达3.7%', null, null, null, null, '0', '0', null, '腾讯科技', null, null, '/uploads/1/image/public/201303/20130318091217_owcigs.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('38', '华为在德国赢得对中兴4G基站专利诉讼', null, null, null, null, '0', '0', null, '腾讯科技', null, null, '/uploads/1/image/public/201303/20130318090820_h8dw6s.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('39', '夏普将错失高通3月29日的第二轮投资', null, null, null, null, '0', '0', null, '腾讯科技', null, null, '/uploads/1/image/public/201303/20130318091115_3qappk.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('40', 'Jspxcms官方网站正式改版', null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('43', '凤凰传奇赚1亿 人气搭档怎么分钱', null, null, null, null, '0', '0', null, '腾讯娱乐', null, null, '/uploads/1/image/public/201303/20130319005453_gcalyk.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('44', '拍戏有多苦：演员冬淋冰水夏捂袄', null, null, null, null, '0', '0', null, '腾讯娱乐', null, null, '/uploads/1/image/public/201303/20130319010101_m771w4.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('45', '专访杨幂：“事业有成”离我很远 不着急完婚', null, null, null, null, '0', '0', null, '腾讯娱乐', null, null, '/uploads/1/image/public/201303/20130319010624_en4gsf.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('46', '刘德华《盲探》牵手郑秀文：不跟梁朝伟拼演技', null, null, null, null, '0', '0', null, '腾讯娱乐', null, null, '/uploads/1/image/public/201303/20130319010940_e4blxf.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('47', '足协曾忧王迪成\"定时炸弹\" 两次漏判国安点球', null, null, null, null, '0', '0', null, '腾讯体育', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('48', '热火不败继续称霸实力榜 湖人升至第9火箭第11', null, null, null, null, '0', '0', null, '新华网', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('49', '足协或罚武汉暴力后卫停赛2场 格隆停赛不变', null, null, null, null, '0', '0', null, '腾讯体育', null, null, '/uploads/1/image/public/201303/20130319012002_dsuaw3.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('50', '西媒：巴萨巴黎巅峰对决 皇马上签穆帅会老友', null, null, null, null, '0', '0', null, '腾讯体育', null, null, '/uploads/1/image/public/201303/20130319012426_unib1p.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('52', '尚德宣布可转债违约 成大陆首家公司债违约企业', null, null, null, null, '0', '0', null, '腾讯财经', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('53', '俄媒：苏联为买军火曾贿赂罗斯福', null, null, null, null, '0', '0', null, '新华网', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('54', 'WSJ：中国正在重蹈美国金融危机覆辙', null, null, null, null, '0', '0', null, '东方网', null, '李军', null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('55', '传中兴管理人员被蒙古国反贪局逮捕 公司否认', null, null, null, null, '0', '0', null, '环球时报', null, null, '/uploads/1/image/public/201303/20130319013842_536jdy.jpg', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('64', '欢迎浏览！', null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('66', '郑州老人公交车上为年轻人让座 20人站着不敢坐', null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('67', '王克勤：士不可以不公益，任重而道远', null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('68', '捐款400变40：一场中国式捐赠引发的捐赠责权探讨', null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('69', '宁海一水电工11年献血 “爱心长跑”挽救70条生命', null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('70', 'Jspxcms演示站正式上线', null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('71', 'Jspxcms1.0发布公告', null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('72', 'Jspxcms2.0发布公告', null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `cms_info_file`
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_file`;
CREATE TABLE `cms_info_file` (
  `f_info_id` int(11) NOT NULL,
  `f_name` varchar(150) NOT NULL COMMENT '文件名称',
  `f_url` varchar(255) NOT NULL COMMENT '文件url地址',
  `f_index` int(11) NOT NULL DEFAULT '0' COMMENT '文件索引',
  `f_downloads` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  `f_length` bigint(20) NOT NULL DEFAULT '0' COMMENT '文件长度',
  KEY `fk_cms_infofile_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infofile_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息附件集表';

-- ----------------------------
-- Records of cms_info_file
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_info_image`
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_image`;
CREATE TABLE `cms_info_image` (
  `f_info_id` int(11) NOT NULL,
  `f_name` varchar(150) DEFAULT NULL COMMENT '图片名称',
  `f_url` varchar(255) NOT NULL COMMENT '图片url',
  `f_index` int(11) NOT NULL DEFAULT '0' COMMENT '图片索引',
  `f_text` longtext COMMENT '图片正文',
  KEY `fk_cms_infoimage_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infoimage_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息图片集表';

-- ----------------------------
-- Records of cms_info_image
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_info_node`
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_node`;
CREATE TABLE `cms_info_node` (
  `f_info_id` int(11) NOT NULL COMMENT '信息',
  `f_node_id` int(11) NOT NULL COMMENT '节点',
  `f_node_index` int(11) NOT NULL COMMENT '节点索引',
  PRIMARY KEY (`f_info_id`,`f_node_id`,`f_node_index`),
  KEY `fk_cms_infonode_node` (`f_node_id`),
  CONSTRAINT `fk_cms_infonode_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infonode_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息与节点关联表';

-- ----------------------------
-- Records of cms_info_node
-- ----------------------------
INSERT INTO `cms_info_node` VALUES ('43', '38', '0');
INSERT INTO `cms_info_node` VALUES ('44', '38', '0');
INSERT INTO `cms_info_node` VALUES ('45', '38', '0');
INSERT INTO `cms_info_node` VALUES ('46', '38', '0');
INSERT INTO `cms_info_node` VALUES ('27', '39', '0');
INSERT INTO `cms_info_node` VALUES ('37', '39', '0');
INSERT INTO `cms_info_node` VALUES ('38', '39', '0');
INSERT INTO `cms_info_node` VALUES ('39', '39', '0');
INSERT INTO `cms_info_node` VALUES ('47', '40', '0');
INSERT INTO `cms_info_node` VALUES ('48', '40', '0');
INSERT INTO `cms_info_node` VALUES ('49', '40', '0');
INSERT INTO `cms_info_node` VALUES ('50', '40', '0');
INSERT INTO `cms_info_node` VALUES ('52', '41', '0');
INSERT INTO `cms_info_node` VALUES ('53', '41', '0');
INSERT INTO `cms_info_node` VALUES ('54', '41', '0');
INSERT INTO `cms_info_node` VALUES ('55', '41', '0');
INSERT INTO `cms_info_node` VALUES ('24', '42', '0');
INSERT INTO `cms_info_node` VALUES ('25', '42', '0');
INSERT INTO `cms_info_node` VALUES ('26', '42', '0');
INSERT INTO `cms_info_node` VALUES ('28', '42', '0');
INSERT INTO `cms_info_node` VALUES ('33', '43', '0');
INSERT INTO `cms_info_node` VALUES ('34', '43', '0');
INSERT INTO `cms_info_node` VALUES ('35', '43', '0');
INSERT INTO `cms_info_node` VALUES ('36', '43', '0');
INSERT INTO `cms_info_node` VALUES ('29', '44', '0');
INSERT INTO `cms_info_node` VALUES ('30', '44', '0');
INSERT INTO `cms_info_node` VALUES ('31', '44', '0');
INSERT INTO `cms_info_node` VALUES ('32', '44', '0');
INSERT INTO `cms_info_node` VALUES ('40', '45', '0');
INSERT INTO `cms_info_node` VALUES ('64', '45', '0');
INSERT INTO `cms_info_node` VALUES ('70', '45', '0');
INSERT INTO `cms_info_node` VALUES ('71', '45', '0');
INSERT INTO `cms_info_node` VALUES ('72', '45', '0');
INSERT INTO `cms_info_node` VALUES ('66', '46', '0');
INSERT INTO `cms_info_node` VALUES ('67', '46', '0');
INSERT INTO `cms_info_node` VALUES ('68', '46', '0');
INSERT INTO `cms_info_node` VALUES ('69', '46', '0');

-- ----------------------------
-- Table structure for `cms_info_special`
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_special`;
CREATE TABLE `cms_info_special` (
  `f_info_id` int(11) NOT NULL COMMENT '信息',
  `f_special_id` int(11) NOT NULL COMMENT '专题',
  `f_special_index` int(11) NOT NULL COMMENT '专题索引',
  PRIMARY KEY (`f_info_id`,`f_special_id`,`f_special_index`),
  KEY `fk_cms_infospec_special` (`f_special_id`),
  CONSTRAINT `fk_cms_infospec_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infospec_special` FOREIGN KEY (`f_special_id`) REFERENCES `cms_special` (`f_special_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息与专题关联表';

-- ----------------------------
-- Records of cms_info_special
-- ----------------------------
INSERT INTO `cms_info_special` VALUES ('27', '1', '0');

-- ----------------------------
-- Table structure for `cms_info_tag`
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_tag`;
CREATE TABLE `cms_info_tag` (
  `f_info_id` int(11) NOT NULL COMMENT '信息',
  `f_tag_id` int(11) NOT NULL COMMENT 'tag',
  `f_tag_index` int(11) NOT NULL COMMENT 'tag索引',
  PRIMARY KEY (`f_info_id`,`f_tag_id`,`f_tag_index`),
  KEY `fk_cms_infotag_tag` (`f_tag_id`),
  CONSTRAINT `fk_cms_infotag_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infotag_tag` FOREIGN KEY (`f_tag_id`) REFERENCES `cms_tag` (`f_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息与tag关联表';

-- ----------------------------
-- Records of cms_info_tag
-- ----------------------------
INSERT INTO `cms_info_tag` VALUES ('30', '56', '0');
INSERT INTO `cms_info_tag` VALUES ('54', '56', '0');
INSERT INTO `cms_info_tag` VALUES ('54', '57', '1');
INSERT INTO `cms_info_tag` VALUES ('55', '58', '0');
INSERT INTO `cms_info_tag` VALUES ('55', '59', '1');
INSERT INTO `cms_info_tag` VALUES ('55', '60', '2');
INSERT INTO `cms_info_tag` VALUES ('55', '61', '3');
INSERT INTO `cms_info_tag` VALUES ('54', '62', '2');
INSERT INTO `cms_info_tag` VALUES ('53', '63', '0');
INSERT INTO `cms_info_tag` VALUES ('53', '64', '1');
INSERT INTO `cms_info_tag` VALUES ('53', '65', '2');
INSERT INTO `cms_info_tag` VALUES ('53', '66', '3');
INSERT INTO `cms_info_tag` VALUES ('52', '67', '0');
INSERT INTO `cms_info_tag` VALUES ('52', '68', '1');
INSERT INTO `cms_info_tag` VALUES ('52', '69', '2');
INSERT INTO `cms_info_tag` VALUES ('52', '70', '3');
INSERT INTO `cms_info_tag` VALUES ('30', '71', '1');
INSERT INTO `cms_info_tag` VALUES ('30', '72', '2');
INSERT INTO `cms_info_tag` VALUES ('30', '73', '3');

-- ----------------------------
-- Table structure for `cms_member`
-- ----------------------------
DROP TABLE IF EXISTS `cms_member`;
CREATE TABLE `cms_member` (
  `f_member_id` int(11) NOT NULL,
  `f_membergroup_id` int(11) NOT NULL COMMENT '会员组',
  `f_avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `f_self_intro` varchar(255) DEFAULT NULL COMMENT '自我介绍',
  `f_come_from` varchar(100) DEFAULT NULL COMMENT '来自',
  `f_gender` char(1) DEFAULT NULL COMMENT '性别',
  `f_status` int(11) NOT NULL COMMENT '状态',
  PRIMARY KEY (`f_member_id`),
  KEY `fk_cms_member_membergroup` (`f_membergroup_id`),
  CONSTRAINT `fk_cms_member_membergroup` FOREIGN KEY (`f_membergroup_id`) REFERENCES `cms_member_group` (`f_membergroup_id`),
  CONSTRAINT `fk_cms_member_user` FOREIGN KEY (`f_member_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of cms_member
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_membergroup_site`
-- ----------------------------
DROP TABLE IF EXISTS `cms_membergroup_site`;
CREATE TABLE `cms_membergroup_site` (
  `f_memgroupsite_id` int(11) NOT NULL,
  `f_membergroup_id` int(11) NOT NULL COMMENT '会员组',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_is_all_view` char(1) NOT NULL DEFAULT '1' COMMENT '所有浏览权限',
  `f_is_all_contri` char(1) NOT NULL DEFAULT '0' COMMENT '所有投稿权限',
  `f_is_all_exemption` char(1) NOT NULL DEFAULT '0' COMMENT '所有投稿免审核',
  PRIMARY KEY (`f_memgroupsite_id`),
  KEY `fk_cms_memgroupsite_memgroup` (`f_membergroup_id`),
  KEY `fk_cms_memgroupsite_site` (`f_site_id`),
  CONSTRAINT `fk_cms_memgroupsite_memgroup` FOREIGN KEY (`f_membergroup_id`) REFERENCES `cms_member_group` (`f_membergroup_id`),
  CONSTRAINT `fk_cms_memgroupsite_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组站点表';

-- ----------------------------
-- Records of cms_membergroup_site
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_member_group`
-- ----------------------------
DROP TABLE IF EXISTS `cms_member_group`;
CREATE TABLE `cms_member_group` (
  `f_membergroup_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL,
  `f_description` varchar(255) DEFAULT NULL,
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  PRIMARY KEY (`f_membergroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员组表';

-- ----------------------------
-- Records of cms_member_group
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_memgroupnode_contri`
-- ----------------------------
DROP TABLE IF EXISTS `cms_memgroupnode_contri`;
CREATE TABLE `cms_memgroupnode_contri` (
  `f_node_id` int(11) NOT NULL,
  `f_memgroupsite_id` int(11) NOT NULL,
  PRIMARY KEY (`f_node_id`,`f_memgroupsite_id`),
  KEY `fk_cms_mgncontri_memgroup` (`f_memgroupsite_id`),
  CONSTRAINT `fk_cms_mgncontri_memgroup` FOREIGN KEY (`f_memgroupsite_id`) REFERENCES `cms_membergroup_site` (`f_memgroupsite_id`),
  CONSTRAINT `fk_cms_mgncontri_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员组与投稿权限关联表';

-- ----------------------------
-- Records of cms_memgroupnode_contri
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_memgroupnode_view`
-- ----------------------------
DROP TABLE IF EXISTS `cms_memgroupnode_view`;
CREATE TABLE `cms_memgroupnode_view` (
  `f_node_id` int(11) NOT NULL,
  `f_memgroupsite_id` int(11) NOT NULL,
  PRIMARY KEY (`f_node_id`,`f_memgroupsite_id`),
  KEY `fk_cms_mgnview_memgroup` (`f_memgroupsite_id`),
  CONSTRAINT `fk_cms_mgnview_memgroup` FOREIGN KEY (`f_memgroupsite_id`) REFERENCES `cms_membergroup_site` (`f_memgroupsite_id`),
  CONSTRAINT `fk_cms_mgnview_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员组与节点浏览权限关联表';

-- ----------------------------
-- Records of cms_memgroupnode_view
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_model`
-- ----------------------------
DROP TABLE IF EXISTS `cms_model`;
CREATE TABLE `cms_model` (
  `f_model_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_type` int(11) NOT NULL COMMENT '类型(1:首页;2:栏目;3:内容;4:专题)',
  `f_name` varchar(50) NOT NULL COMMENT '名称',
  `f_seq` int(11) NOT NULL DEFAULT '10' COMMENT '顺序',
  PRIMARY KEY (`f_model_id`),
  KEY `fk_cms_model_site` (`f_site_id`),
  CONSTRAINT `fk_cms_model_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模型表';

-- ----------------------------
-- Records of cms_model
-- ----------------------------
INSERT INTO `cms_model` VALUES ('1', '1', '1', '首页', '0');
INSERT INTO `cms_model` VALUES ('2', '1', '3', '新闻', '0');
INSERT INTO `cms_model` VALUES ('3', '1', '2', '新闻', '0');
INSERT INTO `cms_model` VALUES ('4', '1', '2', '图片', '2147483647');
INSERT INTO `cms_model` VALUES ('5', '1', '1', '??', '2147483647');

-- ----------------------------
-- Table structure for `cms_model_custom`
-- ----------------------------
DROP TABLE IF EXISTS `cms_model_custom`;
CREATE TABLE `cms_model_custom` (
  `f_model_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_modecust_model` (`f_model_id`),
  CONSTRAINT `fk_cms_modecust_model` FOREIGN KEY (`f_model_id`) REFERENCES `cms_model` (`f_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模型自定义表';

-- ----------------------------
-- Records of cms_model_custom
-- ----------------------------
INSERT INTO `cms_model_custom` VALUES ('2', 'nodeExtension', '.html');
INSERT INTO `cms_model_custom` VALUES ('2', 'generateInfo', 'true');
INSERT INTO `cms_model_custom` VALUES ('2', 'generateNode', 'true');
INSERT INTO `cms_model_custom` VALUES ('2', 'infoExtension', '.html');
INSERT INTO `cms_model_custom` VALUES ('2', 'template', '/info.html');
INSERT INTO `cms_model_custom` VALUES ('2', 'staticMethod', '3');
INSERT INTO `cms_model_custom` VALUES ('3', 'defPage', 'true');
INSERT INTO `cms_model_custom` VALUES ('3', 'nodeExtension', '.html');
INSERT INTO `cms_model_custom` VALUES ('3', 'staticPage', '1');
INSERT INTO `cms_model_custom` VALUES ('3', 'listTemplate', '/list.html');
INSERT INTO `cms_model_custom` VALUES ('3', 'generateInfo', 'false');
INSERT INTO `cms_model_custom` VALUES ('3', 'coverTemplate', '/cover.html');
INSERT INTO `cms_model_custom` VALUES ('3', 'generateNode', 'false');
INSERT INTO `cms_model_custom` VALUES ('3', 'infoPath', '');
INSERT INTO `cms_model_custom` VALUES ('3', 'nodePath', '');
INSERT INTO `cms_model_custom` VALUES ('3', 'infoExtension', '.html');
INSERT INTO `cms_model_custom` VALUES ('3', 'staticMethod', '3');
INSERT INTO `cms_model_custom` VALUES ('1', 'infoExtension', '.html');
INSERT INTO `cms_model_custom` VALUES ('1', 'infoPath', '');
INSERT INTO `cms_model_custom` VALUES ('1', 'defPage', 'false');
INSERT INTO `cms_model_custom` VALUES ('1', 'nodeExtension', '.html');
INSERT INTO `cms_model_custom` VALUES ('1', 'template', '/index.html');
INSERT INTO `cms_model_custom` VALUES ('1', 'nodePath', '');
INSERT INTO `cms_model_custom` VALUES ('1', 'generateInfo', 'false');
INSERT INTO `cms_model_custom` VALUES ('1', 'staticPage', '1');
INSERT INTO `cms_model_custom` VALUES ('1', 'staticMethod', '3');
INSERT INTO `cms_model_custom` VALUES ('1', 'generateNode', 'false');
INSERT INTO `cms_model_custom` VALUES ('4', 'defPage', 'true');
INSERT INTO `cms_model_custom` VALUES ('4', 'nodeExtension', '.html');
INSERT INTO `cms_model_custom` VALUES ('4', 'staticPage', '1');
INSERT INTO `cms_model_custom` VALUES ('4', 'listTemplate', 'list.html');
INSERT INTO `cms_model_custom` VALUES ('4', 'generateInfo', 'false');
INSERT INTO `cms_model_custom` VALUES ('4', 'coverTemplate', 'cover.html');
INSERT INTO `cms_model_custom` VALUES ('4', 'generateNode', 'false');
INSERT INTO `cms_model_custom` VALUES ('4', 'infoPath', '');
INSERT INTO `cms_model_custom` VALUES ('4', 'nodePath', '');
INSERT INTO `cms_model_custom` VALUES ('4', 'infoExtension', '.html');
INSERT INTO `cms_model_custom` VALUES ('4', 'staticMethod', '3');
INSERT INTO `cms_model_custom` VALUES ('5', 'defPage', 'true');
INSERT INTO `cms_model_custom` VALUES ('5', 'infoPath', '');
INSERT INTO `cms_model_custom` VALUES ('5', 'nodePath', '');
INSERT INTO `cms_model_custom` VALUES ('5', 'nodeExtension', '.html');
INSERT INTO `cms_model_custom` VALUES ('5', 'generateInfo', 'false');
INSERT INTO `cms_model_custom` VALUES ('5', 'generateNode', 'false');
INSERT INTO `cms_model_custom` VALUES ('5', 'staticMethod', '3');
INSERT INTO `cms_model_custom` VALUES ('5', 'infoExtension', '.html');
INSERT INTO `cms_model_custom` VALUES ('5', 'staticPage', '1');
INSERT INTO `cms_model_custom` VALUES ('5', 'template', '????');

-- ----------------------------
-- Table structure for `cms_model_field`
-- ----------------------------
DROP TABLE IF EXISTS `cms_model_field`;
CREATE TABLE `cms_model_field` (
  `f_modefiel_id` int(11) NOT NULL,
  `f_model_id` int(11) NOT NULL COMMENT '模型',
  `f_type` int(11) NOT NULL COMMENT '输入类型',
  `f_inner_type` int(11) NOT NULL DEFAULT '0' COMMENT '内部类型(0:用户自定义字段;1:系统定义字段;2:预留大文本字段;3:预留可查询字段)',
  `f_label` varchar(50) NOT NULL COMMENT '字段标签',
  `f_name` varchar(50) NOT NULL COMMENT '字段名称',
  `f_prompt` varchar(255) DEFAULT NULL COMMENT '提示信息',
  `f_def_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `f_is_required` char(1) NOT NULL DEFAULT '0' COMMENT '是否必填项',
  `f_seq` int(11) NOT NULL DEFAULT '10' COMMENT '顺序',
  `f_is_dbl_column` char(1) NOT NULL DEFAULT '0' COMMENT '是否双列布局',
  PRIMARY KEY (`f_modefiel_id`),
  KEY `fk_cms_modefiel_model` (`f_model_id`),
  CONSTRAINT `fk_cms_modefiel_model` FOREIGN KEY (`f_model_id`) REFERENCES `cms_model` (`f_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模型字段表';

-- ----------------------------
-- Records of cms_model_field
-- ----------------------------
INSERT INTO `cms_model_field` VALUES ('1', '1', '1', '2', '名称', 'name', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('2', '1', '1', '2', '编码', 'number', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('5', '1', '5', '2', '节点模型', 'nodeModel', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('6', '1', '5', '2', '信息模型', 'infoModel', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('7', '1', '1', '2', '节点页模板', 'nodeTemplate', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('8', '1', '1', '2', '信息页模板', 'infoTemplate', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('9', '1', '1', '2', '节点页静态化', 'generateNode', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('10', '1', '1', '2', '信息页静态化', 'generateInfo', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('11', '1', '5', '2', '静态化方式', 'staticMethod', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('12', '1', '1', '2', '静态化页数', 'staticPage', null, '1', '1', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('199', '4', '1', '2', '所属节点', 'parent', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('200', '4', '1', '2', '名称', 'name', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('201', '4', '1', '2', '编码', 'number', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('202', '4', '1', '2', '链接地址', 'linkUrl', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('203', '4', '5', '2', '新窗口打开', 'newWindow', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('216', '4', '5', '2', '节点模型', 'nodeModel', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('217', '4', '5', '2', '信息模型', 'infoModel', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('235', '2', '1', '2', '节点', 'node', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('236', '2', '1', '2', '副节点', 'nodes', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('237', '2', '1', '2', '专题', 'specials', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('238', '2', '1', '2', '标题', 'title', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('239', '2', '1', '2', '颜色', 'color', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('240', '2', '1', '2', '副标题', 'subtitle', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('241', '2', '1', '2', '完整标题', 'fullTitle', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('242', '2', '1', '2', '关键词', 'tagKeywords', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('243', '2', '6', '2', '描述', 'metaDescription', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('244', '2', '1', '2', '文件路径', 'infoPath', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('245', '2', '1', '2', '模板', 'infoTemplate', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('246', '2', '1', '2', '优先级', 'priority', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('247', '2', '2', '2', '发布时间', 'publishDate', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('248', '2', '1', '2', '来源', 'source', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('249', '2', '1', '2', '作者', 'author', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('250', '2', '1', '2', '属性', 'attributes', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('251', '2', '7', '2', '标题图', 'smallImage', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('252', '2', '7', '2', '正文图', 'largeImage', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('253', '2', '9', '2', '文件', 'file', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('254', '2', '8', '2', '视频', 'video', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('255', '2', '50', '2', '正文', 'text', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('256', '3', '1', '2', '所属节点', 'parent', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('257', '3', '1', '2', '名称', 'name', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('258', '3', '1', '2', '编码', 'number', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('259', '3', '1', '2', '链接地址', 'linkUrl', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('260', '3', '5', '2', '新窗口打开', 'newWindow', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('261', '3', '1', '2', '关键词', 'metaKeywords', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('262', '3', '1', '2', '描述', 'metaDescription', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('263', '3', '5', '2', '节点模型', 'nodeModel', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('264', '3', '5', '2', '信息模型', 'infoModel', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('265', '3', '1', '2', '节点页模板', 'nodeTemplate', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('266', '3', '1', '2', '信息页模板', 'infoTemplate', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('267', '3', '1', '2', '节点页静态化', 'generateNode', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('268', '3', '1', '2', '信息页静态化', 'generateInfo', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('269', '3', '5', '2', '静态化方式', 'staticMethod', null, null, '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('270', '3', '1', '2', '静态化页数', 'staticPage', null, '1', '0', '2147483647', '1');
INSERT INTO `cms_model_field` VALUES ('271', '3', '7', '2', '标题图', 'smallImage', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('272', '3', '7', '2', '正文图', 'largeImage', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('273', '1', '1', '2', '关键词', 'metaKeywords', null, null, '0', '2147483647', '0');
INSERT INTO `cms_model_field` VALUES ('274', '1', '1', '2', '描述', 'metaDescription', null, null, '0', '2147483647', '0');

-- ----------------------------
-- Table structure for `cms_model_field_custom`
-- ----------------------------
DROP TABLE IF EXISTS `cms_model_field_custom`;
CREATE TABLE `cms_model_field_custom` (
  `f_modefiel_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_modfiecus_modefiel` (`f_modefiel_id`),
  CONSTRAINT `fk_cms_modfiecus_modefiel` FOREIGN KEY (`f_modefiel_id`) REFERENCES `cms_model_field` (`f_modefiel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模型字段自定义信息表';

-- ----------------------------
-- Records of cms_model_field_custom
-- ----------------------------
INSERT INTO `cms_model_field_custom` VALUES ('251', 'imageHeight', '106');
INSERT INTO `cms_model_field_custom` VALUES ('251', 'imageWidth', '143');
INSERT INTO `cms_model_field_custom` VALUES ('252', 'imageHeight', '200');
INSERT INTO `cms_model_field_custom` VALUES ('252', 'imageWidth', '290');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'imageHeight', '106');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'imageWidth', '143');
INSERT INTO `cms_model_field_custom` VALUES ('272', 'imageHeight', '200');
INSERT INTO `cms_model_field_custom` VALUES ('272', 'imageWidth', '290');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'datePattern', '');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'cols', '');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'validation', '');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'rows', '');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'width', '');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'maxlength', '');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'toolbar', '');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'options', '');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'imageWatermark', 'false');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'height', '');
INSERT INTO `cms_model_field_custom` VALUES ('271', 'imageScale', 'false');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'datePattern', '');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'cols', '');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'validation', '');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'imageHeight', '');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'rows', '');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'width', '');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'maxlength', '');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'toolbar', '');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'options', '');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'imageWatermark', 'false');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'height', '');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'imageWidth', '');
INSERT INTO `cms_model_field_custom` VALUES ('201', 'imageScale', 'false');
INSERT INTO `cms_model_field_custom` VALUES ('251', 'datePattern', '');
INSERT INTO `cms_model_field_custom` VALUES ('251', 'cols', '');
INSERT INTO `cms_model_field_custom` VALUES ('251', 'validation', '');
INSERT INTO `cms_model_field_custom` VALUES ('251', 'rows', '');
INSERT INTO `cms_model_field_custom` VALUES ('251', 'width', '');
INSERT INTO `cms_model_field_custom` VALUES ('251', 'maxlength', '');
INSERT INTO `cms_model_field_custom` VALUES ('251', 'toolbar', '');
INSERT INTO `cms_model_field_custom` VALUES ('251', 'options', '');
INSERT INTO `cms_model_field_custom` VALUES ('251', 'imageWatermark', 'false');
INSERT INTO `cms_model_field_custom` VALUES ('251', 'height', '');
INSERT INTO `cms_model_field_custom` VALUES ('251', 'imageScale', 'false');

-- ----------------------------
-- Table structure for `cms_node`
-- ----------------------------
DROP TABLE IF EXISTS `cms_node`;
CREATE TABLE `cms_node` (
  `f_node_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_parent_id` int(11) DEFAULT NULL COMMENT '父节点',
  `f_creator_id` int(11) NOT NULL COMMENT '创建者',
  `f_node_model_id` int(11) NOT NULL COMMENT '节点模型',
  `f_workflow_id` int(11) DEFAULT NULL COMMENT '流程',
  `f_info_model_id` int(11) DEFAULT NULL COMMENT '信息模型',
  `f_number` varchar(100) DEFAULT NULL COMMENT '编码',
  `f_name` varchar(150) NOT NULL COMMENT '名称',
  `f_tree_number` varchar(100) NOT NULL DEFAULT '0000' COMMENT '树编码',
  `f_tree_level` int(11) NOT NULL DEFAULT '0' COMMENT '树级别',
  `f_tree_max` varchar(10) NOT NULL DEFAULT '0000' COMMENT '树子节点最大编码',
  `f_creation_date` datetime NOT NULL COMMENT '创建时间',
  `f_views` int(11) NOT NULL DEFAULT '0' COMMENT '浏览总数',
  `f_is_real_node` char(1) NOT NULL DEFAULT '1' COMMENT '是否真实节点',
  `f_is_hidden` char(1) NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `f_p1` tinyint(4) DEFAULT NULL COMMENT '自定义1',
  `f_p2` tinyint(4) DEFAULT NULL COMMENT '自定义2',
  `f_p3` tinyint(4) DEFAULT NULL COMMENT '自定义3',
  `f_p4` tinyint(4) DEFAULT NULL COMMENT '自定义4',
  `f_p5` tinyint(4) DEFAULT NULL COMMENT '自定义5',
  `f_p6` tinyint(4) DEFAULT NULL COMMENT '自定义6',
  `f_refers` int(11) NOT NULL DEFAULT '0' COMMENT '信息数量',
  PRIMARY KEY (`f_node_id`),
  KEY `fk_cms_node_model_info` (`f_info_model_id`),
  KEY `fk_cms_node_model_node` (`f_node_model_id`),
  KEY `fk_cms_node_parent` (`f_parent_id`),
  KEY `fk_cms_node_site` (`f_site_id`),
  KEY `fk_cms_node_user_creator` (`f_creator_id`),
  KEY `fk_cms_node_workflow` (`f_workflow_id`),
  CONSTRAINT `fk_cms_node_model_info` FOREIGN KEY (`f_info_model_id`) REFERENCES `cms_model` (`f_model_id`),
  CONSTRAINT `fk_cms_node_model_node` FOREIGN KEY (`f_node_model_id`) REFERENCES `cms_model` (`f_model_id`),
  CONSTRAINT `fk_cms_node_parent` FOREIGN KEY (`f_parent_id`) REFERENCES `cms_node` (`f_node_id`),
  CONSTRAINT `fk_cms_node_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_node_user_creator` FOREIGN KEY (`f_creator_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_node_workflow` FOREIGN KEY (`f_workflow_id`) REFERENCES `cms_workflow` (`f_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节点表';

-- ----------------------------
-- Records of cms_node
-- ----------------------------
INSERT INTO `cms_node` VALUES ('1', '1', null, '1', '1', null, '2', null, '首页', '0000', '0', '0007', '2013-02-21 20:59:27', '100', '1', '0', null, null, null, null, null, null, '-44');
INSERT INTO `cms_node` VALUES ('36', '1', '1', '1', '3', null, '2', 'news', '新闻', '0000-0000', '1', '0003', '2013-03-04 22:18:36', '0', '1', '0', null, null, null, null, null, null, '-11');
INSERT INTO `cms_node` VALUES ('38', '1', '1', '1', '4', null, '2', 'yule', '娱乐', '0000-0002', '1', '0000', '2013-03-04 22:18:42', '0', '1', '0', null, null, null, null, null, null, '-8');
INSERT INTO `cms_node` VALUES ('39', '1', '1', '1', '3', null, '2', 'tech', '科技', '0000-0004', '1', '0000', '2013-03-18 01:27:17', '0', '1', '0', null, null, null, null, null, null, '-11');
INSERT INTO `cms_node` VALUES ('40', '1', '1', '1', '3', null, '2', 'sport', '体育', '0000-0003', '1', '0000', '2013-03-18 01:27:48', '0', '1', '0', null, null, null, null, null, null, '-3');
INSERT INTO `cms_node` VALUES ('41', '1', '1', '1', '3', null, '2', 'fina', '财经', '0000-0001', '1', '0000', '2013-03-18 01:28:02', '0', '1', '0', null, null, null, null, null, null, '-5');
INSERT INTO `cms_node` VALUES ('42', '1', '36', '1', '3', null, '2', null, '国内', '0000-0000-0000', '2', '0000', '2013-03-18 01:30:03', '0', '1', '0', null, null, null, null, null, null, '-29');
INSERT INTO `cms_node` VALUES ('43', '1', '36', '1', '3', null, '2', null, '社会', '0000-0000-0002', '2', '0000', '2013-03-18 01:33:08', '0', '1', '0', null, null, null, null, null, null, '-8');
INSERT INTO `cms_node` VALUES ('44', '1', '36', '1', '3', null, '2', null, '国际', '0000-0000-0001', '2', '0000', '2013-03-18 01:33:48', '0', '1', '0', null, null, null, null, null, null, '-16');
INSERT INTO `cms_node` VALUES ('45', '1', '1', '1', '3', null, '2', 'notice', '网站公告', '0000-0006', '1', '0000', '2013-03-18 12:54:03', '0', '1', '1', null, null, null, null, null, null, '10');
INSERT INTO `cms_node` VALUES ('46', '1', '1', '1', '3', null, '2', null, '公益', '0000-0005', '1', '0000', '2013-03-21 00:47:38', '0', '1', '0', null, null, null, null, null, null, '-1');

-- ----------------------------
-- Table structure for `cms_node_buffer`
-- ----------------------------
DROP TABLE IF EXISTS `cms_node_buffer`;
CREATE TABLE `cms_node_buffer` (
  `f_node_id` int(11) NOT NULL,
  `f_views` int(11) NOT NULL COMMENT '浏览次数',
  PRIMARY KEY (`f_node_id`),
  CONSTRAINT `fk_cms_nodebuffer_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节点缓冲表';

-- ----------------------------
-- Records of cms_node_buffer
-- ----------------------------
INSERT INTO `cms_node_buffer` VALUES ('1', '8');

-- ----------------------------
-- Table structure for `cms_node_clob`
-- ----------------------------
DROP TABLE IF EXISTS `cms_node_clob`;
CREATE TABLE `cms_node_clob` (
  `f_node_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` longtext COMMENT '值',
  KEY `fk_cms_nodeclob_node` (`f_node_id`),
  CONSTRAINT `fk_cms_nodeclob_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节点大字段表';

-- ----------------------------
-- Records of cms_node_clob
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_node_custom`
-- ----------------------------
DROP TABLE IF EXISTS `cms_node_custom`;
CREATE TABLE `cms_node_custom` (
  `f_node_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_nodecustom_node` (`f_node_id`),
  CONSTRAINT `fk_cms_nodecustom_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节点自定义表';

-- ----------------------------
-- Records of cms_node_custom
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_node_detail`
-- ----------------------------
DROP TABLE IF EXISTS `cms_node_detail`;
CREATE TABLE `cms_node_detail` (
  `f_node_id` int(11) NOT NULL,
  `f_link_url` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `f_meta_keywords` varchar(150) DEFAULT NULL COMMENT '关键字',
  `f_meta_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_is_new_window` char(1) DEFAULT NULL COMMENT '是否在新窗口打开',
  `f_node_template` varchar(255) DEFAULT NULL COMMENT '节点模板',
  `f_info_template` varchar(255) DEFAULT NULL COMMENT '信息模板',
  `f_is_generate_node` char(1) DEFAULT NULL COMMENT '是否生成节点页',
  `f_is_generate_info` char(1) DEFAULT NULL COMMENT '是否生成信息页',
  `f_node_extension` varchar(10) DEFAULT NULL COMMENT '节点页扩展名',
  `f_info_extension` varchar(10) DEFAULT NULL COMMENT '信息页扩展名',
  `f_node_path` varchar(100) DEFAULT NULL COMMENT '节点路径',
  `f_info_path` varchar(100) DEFAULT NULL COMMENT '信息路径',
  `f_is_def_page` char(1) DEFAULT '1' COMMENT '是否默认页',
  `f_static_method` int(11) DEFAULT '3' COMMENT '静态页生成方式(0:手动生成;1:自动生成节点页;2:自动生成信息页及节点页;3:自动生成信息页、节点页、父节点页、首页)',
  `f_static_page` int(11) DEFAULT '1' COMMENT '节点列表静态化页数',
  `f_small_image` varchar(255) DEFAULT NULL COMMENT '小图',
  `f_large_image` varchar(255) DEFAULT NULL COMMENT '大图',
  PRIMARY KEY (`f_node_id`),
  CONSTRAINT `fk_cms_nodedetail_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节点详细表';

-- ----------------------------
-- Records of cms_node_detail
-- ----------------------------
INSERT INTO `cms_node_detail` VALUES ('1', null, null, null, null, null, null, null, null, null, null, '/index', null, '1', null, '1', null, null);
INSERT INTO `cms_node_detail` VALUES ('36', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('38', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('39', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('40', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('41', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('42', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('43', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('44', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('45', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('46', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `cms_org`
-- ----------------------------
DROP TABLE IF EXISTS `cms_org`;
CREATE TABLE `cms_org` (
  `f_org_id` int(11) NOT NULL,
  `f_parent_id` int(11) DEFAULT NULL COMMENT '上级组织',
  `f_name` varchar(150) NOT NULL COMMENT '名称',
  `f_full_name` varchar(150) DEFAULT NULL COMMENT '全称',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_number` varchar(100) NOT NULL COMMENT '编码',
  `f_tree_number` varchar(100) NOT NULL DEFAULT '0000' COMMENT '树编码',
  `f_tree_level` int(11) NOT NULL DEFAULT '0' COMMENT '树级别',
  `f_tree_max` varchar(10) NOT NULL DEFAULT '0000' COMMENT '树子节点最大编码',
  PRIMARY KEY (`f_org_id`),
  KEY `fk_cms_org_parent` (`f_parent_id`),
  CONSTRAINT `fk_cms_org_parent` FOREIGN KEY (`f_parent_id`) REFERENCES `cms_org` (`f_org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组织表';

-- ----------------------------
-- Records of cms_org
-- ----------------------------
INSERT INTO `cms_org` VALUES ('1', null, '所有', null, null, '000', '0000', '0', '0000');

-- ----------------------------
-- Table structure for `cms_role`
-- ----------------------------
DROP TABLE IF EXISTS `cms_role`;
CREATE TABLE `cms_role` (
  `f_role_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  PRIMARY KEY (`f_role_id`),
  KEY `fk_cms_role_site` (`f_site_id`),
  CONSTRAINT `fk_cms_role_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of cms_role
-- ----------------------------
INSERT INTO `cms_role` VALUES ('1', '1', '管理员', null, '2147483647');

-- ----------------------------
-- Table structure for `cms_rolenode_info`
-- ----------------------------
DROP TABLE IF EXISTS `cms_rolenode_info`;
CREATE TABLE `cms_rolenode_info` (
  `f_node_id` int(11) NOT NULL,
  `f_rolesite_id` int(11) NOT NULL,
  PRIMARY KEY (`f_node_id`,`f_rolesite_id`),
  KEY `fk_cms_rninfo_role` (`f_rolesite_id`),
  CONSTRAINT `fk_cms_rninfo_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`),
  CONSTRAINT `fk_cms_rninfo_role` FOREIGN KEY (`f_rolesite_id`) REFERENCES `cms_role_site` (`f_rolesite_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与信息权限关联表';

-- ----------------------------
-- Records of cms_rolenode_info
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_rolenode_node`
-- ----------------------------
DROP TABLE IF EXISTS `cms_rolenode_node`;
CREATE TABLE `cms_rolenode_node` (
  `f_node_id` int(11) NOT NULL,
  `f_rolesite_id` int(11) NOT NULL,
  PRIMARY KEY (`f_node_id`,`f_rolesite_id`),
  KEY `fk_cms_rnnode_role` (`f_rolesite_id`),
  CONSTRAINT `fk_cms_rnnode_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`),
  CONSTRAINT `fk_cms_rnnode_role` FOREIGN KEY (`f_rolesite_id`) REFERENCES `cms_role_site` (`f_rolesite_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与节点权限关联表';

-- ----------------------------
-- Records of cms_rolenode_node
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_role_site`
-- ----------------------------
DROP TABLE IF EXISTS `cms_role_site`;
CREATE TABLE `cms_role_site` (
  `f_rolesite_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_role_id` int(11) NOT NULL,
  `f_is_all_node` char(1) NOT NULL DEFAULT '0' COMMENT '所有节点权限',
  `f_is_all_info` char(1) NOT NULL DEFAULT '0' COMMENT '所有信息权限',
  `f_info_right_type` int(11) NOT NULL DEFAULT '1' COMMENT '信息权限类型(1:所有;2:\r\n\r\n组织;3:自身)',
  `f_is_all_perm` char(1) NOT NULL DEFAULT '0' COMMENT '所有功能权限',
  `f_perms` longtext COMMENT '功能权限',
  PRIMARY KEY (`f_rolesite_id`),
  KEY `fk_cms_rolesite_role` (`f_role_id`),
  KEY `fk_cms_rolesite_site` (`f_site_id`),
  CONSTRAINT `fk_cms_rolesite_role` FOREIGN KEY (`f_role_id`) REFERENCES `cms_role` (`f_role_id`),
  CONSTRAINT `fk_cms_rolesite_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色站点表';

-- ----------------------------
-- Records of cms_role_site
-- ----------------------------
INSERT INTO `cms_role_site` VALUES ('1', '1', '1', '0', '0', '1', '1', null);

-- ----------------------------
-- Table structure for `cms_scoreboard`
-- ----------------------------
DROP TABLE IF EXISTS `cms_scoreboard`;
CREATE TABLE `cms_scoreboard` (
  `f_scoreboard_id` int(11) NOT NULL,
  `f_scoreitem_id` int(11) NOT NULL COMMENT '记分项',
  `f_ftype` varchar(50) NOT NULL COMMENT '外表标识',
  `f_fid` int(11) NOT NULL COMMENT '外表ID',
  `f_score` int(11) NOT NULL DEFAULT '0' COMMENT '得分',
  PRIMARY KEY (`f_scoreboard_id`),
  KEY `fk_cms_scoreboard_scoreitem` (`f_scoreitem_id`),
  CONSTRAINT `fk_cms_scoreboard_scoreitem` FOREIGN KEY (`f_scoreitem_id`) REFERENCES `cms_scoreitem` (`f_scoreitem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='计分牌表';

-- ----------------------------
-- Records of cms_scoreboard
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_scoreboard_scoreuser`
-- ----------------------------
DROP TABLE IF EXISTS `cms_scoreboard_scoreuser`;
CREATE TABLE `cms_scoreboard_scoreuser` (
  `f_scoreboard_id` int(11) NOT NULL,
  `f_user_id` int(11) NOT NULL,
  PRIMARY KEY (`f_scoreboard_id`,`f_user_id`),
  KEY `fk_cms_scoreboard_user` (`f_user_id`),
  CONSTRAINT `fk_cms_scoreboard_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_user_scoreboard` FOREIGN KEY (`f_scoreboard_id`) REFERENCES `cms_scoreboard` (`f_scoreboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记分牌与用户关联表';

-- ----------------------------
-- Records of cms_scoreboard_scoreuser
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_scoregroup`
-- ----------------------------
DROP TABLE IF EXISTS `cms_scoregroup`;
CREATE TABLE `cms_scoregroup` (
  `f_scoregroup_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(150) NOT NULL COMMENT '名称',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  PRIMARY KEY (`f_scoregroup_id`),
  KEY `fk_cms_scoregroup_site` (`f_site_id`),
  CONSTRAINT `fk_cms_scoregroup_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='计分组';

-- ----------------------------
-- Records of cms_scoregroup
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_scoreitem`
-- ----------------------------
DROP TABLE IF EXISTS `cms_scoreitem`;
CREATE TABLE `cms_scoreitem` (
  `f_scoreitem_id` int(11) NOT NULL,
  `f_scoregroup_id` int(11) NOT NULL COMMENT '计分组',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  PRIMARY KEY (`f_scoreitem_id`),
  KEY `fk_cms_scoreitem_scoregroup` (`f_scoregroup_id`),
  KEY `fk_cms_scoreitem_site` (`f_site_id`),
  CONSTRAINT `fk_cms_scoreitem_scoregroup` FOREIGN KEY (`f_scoregroup_id`) REFERENCES `cms_scoregroup` (`f_scoregroup_id`),
  CONSTRAINT `fk_cms_scoreitem_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='计分项表';

-- ----------------------------
-- Records of cms_scoreitem
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_site`
-- ----------------------------
DROP TABLE IF EXISTS `cms_site`;
CREATE TABLE `cms_site` (
  `f_site_id` int(11) NOT NULL,
  `f_global_id` int(11) NOT NULL COMMENT '全局',
  `f_org_id` int(11) NOT NULL COMMENT '组织',
  `f_parent_id` int(11) DEFAULT NULL COMMENT '上级站点',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_full_name` varchar(100) DEFAULT NULL COMMENT '完整名称',
  `f_html_path` varchar(100) DEFAULT NULL COMMENT 'html路径',
  `f_domain` varchar(100) NOT NULL DEFAULT 'localhost' COMMENT '域名',
  `f_is_with_domain` char(1) NOT NULL DEFAULT '0' COMMENT '是否URL包含域名',
  `f_template_theme` varchar(100) NOT NULL DEFAULT 'default' COMMENT '模板主题',
  `f_tree_number` varchar(100) NOT NULL DEFAULT '0000' COMMENT '树编码',
  `f_tree_level` int(11) NOT NULL DEFAULT '0' COMMENT '树级别',
  `f_tree_max` varchar(10) NOT NULL DEFAULT '0000' COMMENT '树子节点最大编码',
  `f_no_picture` varchar(255) NOT NULL DEFAULT '/img/no_picture.jpg' COMMENT '暂无图片',
  PRIMARY KEY (`f_site_id`),
  KEY `fk_cms_site_global` (`f_global_id`),
  KEY `fk_cms_site_org` (`f_org_id`),
  KEY `fk_cms_site_parent` (`f_parent_id`),
  CONSTRAINT `fk_cms_site_global` FOREIGN KEY (`f_global_id`) REFERENCES `cms_global` (`f_global_id`),
  CONSTRAINT `fk_cms_site_org` FOREIGN KEY (`f_org_id`) REFERENCES `cms_org` (`f_org_id`),
  CONSTRAINT `fk_cms_site_parent` FOREIGN KEY (`f_parent_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站点表';

-- ----------------------------
-- Records of cms_site
-- ----------------------------
INSERT INTO `cms_site` VALUES ('1', '1', '1', null, 'jspxcms', 'jspxcms', null, 'localhost', '0', 'bluewise', '0000', '0', '0000', '/images/no_picture.jpg');

-- ----------------------------
-- Table structure for `cms_special`
-- ----------------------------
DROP TABLE IF EXISTS `cms_special`;
CREATE TABLE `cms_special` (
  `f_special_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_speccate_id` int(11) NOT NULL COMMENT '专题类别',
  `f_creation_date` datetime NOT NULL COMMENT '创建日期',
  `f_title` varchar(150) NOT NULL COMMENT '标题',
  `f_meta_keywords` varchar(150) DEFAULT NULL COMMENT '关键字',
  `f_meta_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_small_image` varchar(255) DEFAULT NULL COMMENT '小图',
  `f_large_image` varchar(255) DEFAULT NULL COMMENT '大图',
  `f_video` varchar(255) DEFAULT NULL COMMENT '视频',
  `f_views` int(11) NOT NULL DEFAULT '0' COMMENT '浏览总数',
  `f_is_recommend` char(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `f_refers` int(11) NOT NULL DEFAULT '0' COMMENT '信息数量',
  `f_is_with_image` char(1) NOT NULL DEFAULT '0' COMMENT '是否有图片',
  PRIMARY KEY (`f_special_id`),
  KEY `fk_cms_special_site` (`f_site_id`),
  KEY `fk_cms_special_speccate` (`f_speccate_id`),
  CONSTRAINT `fk_cms_special_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_special_speccate` FOREIGN KEY (`f_speccate_id`) REFERENCES `cms_special_category` (`f_speccate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='专题表';

-- ----------------------------
-- Records of cms_special
-- ----------------------------
INSERT INTO `cms_special` VALUES ('1', '1', '1', '2013-02-28 17:10:02', '论道中国', null, null, '/uploads/1/image/public/201303/20130318030529_8vfvns.jpg', null, null, '0', '0', '3', '0');
INSERT INTO `cms_special` VALUES ('2', '1', '1', '2013-02-27 17:10:53', '问题与建议', null, null, null, null, null, '0', '0', '2', '0');
INSERT INTO `cms_special` VALUES ('8', '1', '1', '2013-03-19 02:57:45', '食品安全报告', null, null, null, null, null, '0', '0', '0', '0');
INSERT INTO `cms_special` VALUES ('9', '1', '2', '2013-03-19 02:58:18', '名家专论', null, null, null, null, null, '0', '0', '0', '0');
INSERT INTO `cms_special` VALUES ('10', '1', '2', '2013-03-19 02:58:35', '资本主义危机纵横谈', null, null, null, null, null, '0', '0', '0', '0');
INSERT INTO `cms_special` VALUES ('11', '1', '3', '2013-03-19 03:00:11', '热钱透视', null, null, null, null, null, '0', '0', '0', '0');
INSERT INTO `cms_special` VALUES ('12', '1', '3', '2013-03-19 03:00:39', '能源观察', null, null, null, null, null, '0', '0', '0', '0');
INSERT INTO `cms_special` VALUES ('13', '1', '4', '2013-03-19 03:01:02', '核武透明度', null, null, null, null, null, '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `cms_special_category`
-- ----------------------------
DROP TABLE IF EXISTS `cms_special_category`;
CREATE TABLE `cms_special_category` (
  `f_speccate_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(50) NOT NULL COMMENT '名称',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  `f_views` int(11) NOT NULL DEFAULT '0' COMMENT '浏览总数',
  `f_meta_keywords` varchar(150) DEFAULT NULL COMMENT '关键字',
  `f_meta_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_creation_date` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY (`f_speccate_id`),
  KEY `fk_cms_speccategory_site` (`f_site_id`),
  CONSTRAINT `fk_cms_speccategory_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='专题类别表';

-- ----------------------------
-- Records of cms_special_category
-- ----------------------------
INSERT INTO `cms_special_category` VALUES ('1', '1', '中国观点', '2147483647', '0', null, null, '2013-02-28 17:09:49');
INSERT INTO `cms_special_category` VALUES ('2', '1', '国际观点', '2147483647', '0', null, null, '2013-03-18 02:22:45');
INSERT INTO `cms_special_category` VALUES ('3', '1', '财经观点', '2147483647', '0', null, null, '2013-03-18 02:58:00');
INSERT INTO `cms_special_category` VALUES ('4', '1', '军事观点', '2147483647', '0', null, null, '2013-03-18 02:58:52');

-- ----------------------------
-- Table structure for `cms_tag`
-- ----------------------------
DROP TABLE IF EXISTS `cms_tag`;
CREATE TABLE `cms_tag` (
  `f_tag_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(50) NOT NULL COMMENT '名称',
  `f_creation_date` datetime NOT NULL COMMENT '创建日期',
  `f_refers` int(11) NOT NULL DEFAULT '0' COMMENT '引用次数',
  PRIMARY KEY (`f_tag_id`),
  KEY `fk_cms_tag_site` (`f_site_id`),
  CONSTRAINT `fk_cms_tag_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tag表';

-- ----------------------------
-- Records of cms_tag
-- ----------------------------
INSERT INTO `cms_tag` VALUES ('56', '1', '中国', '2013-03-11 12:00:12', '3');
INSERT INTO `cms_tag` VALUES ('57', '1', '美国', '2013-03-11 12:00:12', '1');
INSERT INTO `cms_tag` VALUES ('58', '1', '中兴', '2013-03-19 02:08:21', '1');
INSERT INTO `cms_tag` VALUES ('59', '1', '蒙古国', '2013-03-19 02:08:21', '1');
INSERT INTO `cms_tag` VALUES ('60', '1', '反贪局', '2013-03-19 02:08:21', '1');
INSERT INTO `cms_tag` VALUES ('61', '1', '逮捕', '2013-03-19 02:08:21', '1');
INSERT INTO `cms_tag` VALUES ('62', '1', '金融危机', '2013-03-19 02:08:58', '1');
INSERT INTO `cms_tag` VALUES ('63', '1', '苏联', '2013-03-19 02:09:23', '1');
INSERT INTO `cms_tag` VALUES ('64', '1', '军火', '2013-03-19 02:09:23', '1');
INSERT INTO `cms_tag` VALUES ('65', '1', '贿赂', '2013-03-19 02:09:23', '1');
INSERT INTO `cms_tag` VALUES ('66', '1', '罗斯福', '2013-03-19 02:09:23', '1');
INSERT INTO `cms_tag` VALUES ('67', '1', '可转债', '2013-03-19 02:10:00', '1');
INSERT INTO `cms_tag` VALUES ('68', '1', '违约', '2013-03-19 02:10:00', '1');
INSERT INTO `cms_tag` VALUES ('69', '1', '首家', '2013-03-19 02:10:00', '1');
INSERT INTO `cms_tag` VALUES ('70', '1', '公司债', '2013-03-19 02:10:00', '1');
INSERT INTO `cms_tag` VALUES ('71', '1', '英国', '2013-03-19 02:27:44', '1');
INSERT INTO `cms_tag` VALUES ('72', '1', '常规武器', '2013-03-19 02:27:44', '1');
INSERT INTO `cms_tag` VALUES ('73', '1', '出口国', '2013-03-19 02:27:44', '1');

-- ----------------------------
-- Table structure for `cms_user`
-- ----------------------------
DROP TABLE IF EXISTS `cms_user`;
CREATE TABLE `cms_user` (
  `f_user_id` int(11) NOT NULL,
  `f_org_id` int(11) NOT NULL COMMENT '组织',
  `f_username` varchar(50) NOT NULL COMMENT '用户名',
  `f_password` varchar(128) DEFAULT NULL COMMENT '密码',
  `f_salt` varchar(32) DEFAULT NULL COMMENT '加密混淆码',
  `f_email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `f_real_name` varchar(100) DEFAULT NULL COMMENT '用户实名',
  `f_mobile` varchar(100) DEFAULT NULL COMMENT '手机',
  `f_prev_login_date` datetime DEFAULT NULL COMMENT '上次登录日期',
  `f_prev_login_ip` varchar(100) DEFAULT NULL COMMENT '上次登录IP',
  `f_last_login_date` datetime DEFAULT NULL COMMENT '最后登录日期',
  `f_last_login_ip` varchar(100) DEFAULT NULL COMMENT '最后登录IP',
  `f_creation_date` datetime NOT NULL COMMENT '加入日期',
  `f_creation_ip` varchar(100) NOT NULL COMMENT '加入IP',
  `f_logins` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:正常,1:禁用)',
  PRIMARY KEY (`f_user_id`),
  UNIQUE KEY `ak_username` (`f_username`),
  KEY `fk_cms_user_org` (`f_org_id`),
  CONSTRAINT `fk_cms_user_org` FOREIGN KEY (`f_org_id`) REFERENCES `cms_org` (`f_org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of cms_user
-- ----------------------------
INSERT INTO `cms_user` VALUES ('0', '1', 'anonymous', null, null, null, null, null, null, null, null, null, '2013-03-09 22:18:56', '127.0.0.1', '0', '0');
INSERT INTO `cms_user` VALUES ('1', '1', 'admin', '', null, null, null, null, '2013-08-03 09:06:35', '0:0:0:0:0:0:0:1', '2013-08-03 09:54:32', '0:0:0:0:0:0:0:1', '2013-02-21 20:59:27', '127.0.0.1', '140', '0');

-- ----------------------------
-- Table structure for `cms_user_org`
-- ----------------------------
DROP TABLE IF EXISTS `cms_user_org`;
CREATE TABLE `cms_user_org` (
  `f_user_id` int(11) NOT NULL,
  `f_org_id` int(11) NOT NULL,
  PRIMARY KEY (`f_user_id`,`f_org_id`),
  KEY `fk_cms_userorg_org` (`f_org_id`),
  CONSTRAINT `fk_cms_userorg_org` FOREIGN KEY (`f_org_id`) REFERENCES `cms_org` (`f_org_id`),
  CONSTRAINT `fk_cms_userorg_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与组织关联表';

-- ----------------------------
-- Records of cms_user_org
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_workflow`
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflow`;
CREATE TABLE `cms_workflow` (
  `f_workflow_id` int(11) NOT NULL,
  `f_workflowgroup_id` int(11) NOT NULL COMMENT '工作流',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  `f_status` int(11) NOT NULL DEFAULT '1' COMMENT '状态(1:启用;2:禁用)',
  PRIMARY KEY (`f_workflow_id`),
  KEY `fk_cms_workflow_site` (`f_site_id`),
  KEY `fk_cms_workflow_workflowgroup` (`f_workflowgroup_id`),
  CONSTRAINT `fk_cms_workflow_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_workflow_workflowgroup` FOREIGN KEY (`f_workflowgroup_id`) REFERENCES `cms_workflow_group` (`f_workflowgroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作流表';

-- ----------------------------
-- Records of cms_workflow
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_workflowproc_user`
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflowproc_user`;
CREATE TABLE `cms_workflowproc_user` (
  `f_workflowprocess_id` int(11) NOT NULL,
  `f_user_id` int(11) NOT NULL,
  PRIMARY KEY (`f_workflowprocess_id`,`f_user_id`),
  KEY `fk_cms_wfpuser_user` (`f_user_id`),
  CONSTRAINT `fk_cms_wfpuser_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_wfpuser_wfprocess` FOREIGN KEY (`f_workflowprocess_id`) REFERENCES `cms_workflow_process` (`f_workflowprocess_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作流过程与用户关联表';

-- ----------------------------
-- Records of cms_workflowproc_user
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_workflowstep_role`
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflowstep_role`;
CREATE TABLE `cms_workflowstep_role` (
  `f_role_id` int(11) NOT NULL,
  `f_workflowstep_id` int(11) NOT NULL,
  PRIMARY KEY (`f_role_id`,`f_workflowstep_id`),
  KEY `fk_cms_wfsteprole_wfstep` (`f_workflowstep_id`),
  CONSTRAINT `fk_cms_wfsteprole_role` FOREIGN KEY (`f_role_id`) REFERENCES `cms_role` (`f_role_id`),
  CONSTRAINT `fk_cms_wfsteprole_wfstep` FOREIGN KEY (`f_workflowstep_id`) REFERENCES `cms_workflow_step` (`f_workflowstep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='审核步骤与角色关联表';

-- ----------------------------
-- Records of cms_workflowstep_role
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_workflow_group`
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflow_group`;
CREATE TABLE `cms_workflow_group` (
  `f_workflowgroup_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  PRIMARY KEY (`f_workflowgroup_id`),
  KEY `fk_cms_workflowgroup_site` (`f_site_id`),
  CONSTRAINT `fk_cms_workflowgroup_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作流组表';

-- ----------------------------
-- Records of cms_workflow_group
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_workflow_log`
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflow_log`;
CREATE TABLE `cms_workflow_log` (
  `f_workflowlog_id` int(11) NOT NULL,
  `f_user_id` int(11) NOT NULL COMMENT '操作人',
  `f_workflowprocess_id` int(11) NOT NULL COMMENT '过程',
  `f_from` varchar(100) NOT NULL COMMENT '从哪',
  `f_to` varchar(100) NOT NULL COMMENT '到哪',
  `f_creation_date` datetime NOT NULL COMMENT '创建时间',
  `f_opinion` varchar(255) DEFAULT NULL COMMENT '意见',
  `f_type` int(11) NOT NULL COMMENT '类型(1:前进;2后退:;3:原地)',
  PRIMARY KEY (`f_workflowlog_id`),
  KEY `fk_cms_workflowlog_user` (`f_user_id`),
  KEY `fk_cms_workflowlog_wfprocess` (`f_workflowprocess_id`),
  CONSTRAINT `fk_cms_workflowlog_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_workflowlog_wfprocess` FOREIGN KEY (`f_workflowprocess_id`) REFERENCES `cms_workflow_process` (`f_workflowprocess_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作流流程日志表';

-- ----------------------------
-- Records of cms_workflow_log
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_workflow_process`
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflow_process`;
CREATE TABLE `cms_workflow_process` (
  `f_workflowprocess_id` int(11) NOT NULL,
  `f_workflow_id` int(11) NOT NULL COMMENT '流程',
  `f_user_id` int(11) NOT NULL COMMENT '发起人',
  `f_data_id` int(11) NOT NULL COMMENT '数据ID',
  `f_start_date` datetime NOT NULL COMMENT '开始时间',
  `f_end_date` datetime DEFAULT NULL COMMENT '结束时间',
  `f_step` int(11) NOT NULL COMMENT '步骤',
  `f_is_end` char(1) NOT NULL DEFAULT '0' COMMENT '是否终点',
  PRIMARY KEY (`f_workflowprocess_id`),
  KEY `fk_cms_workflowproc_user` (`f_user_id`),
  KEY `fk_cms_workflowproc_workflow` (`f_workflow_id`),
  CONSTRAINT `fk_cms_workflowproc_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_workflowproc_workflow` FOREIGN KEY (`f_workflow_id`) REFERENCES `cms_workflow` (`f_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作流过程表';

-- ----------------------------
-- Records of cms_workflow_process
-- ----------------------------

-- ----------------------------
-- Table structure for `cms_workflow_step`
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflow_step`;
CREATE TABLE `cms_workflow_step` (
  `f_workflowstep_id` int(11) NOT NULL,
  `f_workflow_id` int(11) NOT NULL COMMENT '工作流',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  PRIMARY KEY (`f_workflowstep_id`),
  KEY `fk_cms_workflowstep_workflow` (`f_workflow_id`),
  CONSTRAINT `fk_cms_workflowstep_workflow` FOREIGN KEY (`f_workflow_id`) REFERENCES `cms_workflow` (`f_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作流步骤表';

-- ----------------------------
-- Records of cms_workflow_step
-- ----------------------------

-- ----------------------------
-- Table structure for `t_id_table`
-- ----------------------------
DROP TABLE IF EXISTS `t_id_table`;
CREATE TABLE `t_id_table` (
  `f_table` varchar(100) NOT NULL COMMENT '表名',
  `f_id_value` bigint(20) NOT NULL COMMENT 'ID值',
  PRIMARY KEY (`f_table`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主键表';

-- ----------------------------
-- Records of t_id_table
-- ----------------------------
INSERT INTO `t_id_table` VALUES ('cms_attribute', '5');
INSERT INTO `t_id_table` VALUES ('cms_comment', '7');
INSERT INTO `t_id_table` VALUES ('cms_info', '73');
INSERT INTO `t_id_table` VALUES ('cms_info_attribute', '329');
INSERT INTO `t_id_table` VALUES ('cms_model', '6');
INSERT INTO `t_id_table` VALUES ('cms_model_field', '275');
INSERT INTO `t_id_table` VALUES ('cms_node', '47');
INSERT INTO `t_id_table` VALUES ('cms_org', '1');
INSERT INTO `t_id_table` VALUES ('cms_role', '2');
INSERT INTO `t_id_table` VALUES ('cms_role_site', '2');
INSERT INTO `t_id_table` VALUES ('cms_site', '1');
INSERT INTO `t_id_table` VALUES ('cms_special', '14');
INSERT INTO `t_id_table` VALUES ('cms_special_category', '5');
INSERT INTO `t_id_table` VALUES ('cms_tag', '74');
INSERT INTO `t_id_table` VALUES ('cms_user', '2');
