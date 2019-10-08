# phpcms bakfile
# version:PHPCMS V9
# time:2019-10-07 16:34:43
# type:phpcms
# phpcms:http://www.phpcms.cn
# --------------------------------------------------------


DROP TABLE IF EXISTS `v9_admin`;
CREATE TABLE `v9_admin` (
  `userid` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `roleid` smallint(5) DEFAULT '0',
  `encrypt` varchar(6) DEFAULT NULL,
  `lastloginip` varchar(15) DEFAULT NULL,
  `lastlogintime` int(10) unsigned DEFAULT '0',
  `email` varchar(40) DEFAULT NULL,
  `realname` varchar(50) NOT NULL DEFAULT '',
  `card` varchar(255) NOT NULL,
  `lang` varchar(6) NOT NULL,
  PRIMARY KEY (`userid`),
  KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `v9_admin` VALUES('1','admin','45f442468b1f5e0095ed5734bce66c58','1','3wwpHe','','1570435864','844800670@qq.com','','','');

DROP TABLE IF EXISTS `v9_admin_panel`;
CREATE TABLE `v9_admin_panel` (
  `menuid` mediumint(8) unsigned NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name` char(32) DEFAULT NULL,
  `url` char(255) DEFAULT NULL,
  `datetime` int(10) unsigned DEFAULT '0',
  UNIQUE KEY `userid` (`menuid`,`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_admin_role`;
CREATE TABLE `v9_admin_role` (
  `roleid` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `rolename` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`roleid`),
  KEY `listorder` (`listorder`),
  KEY `disabled` (`disabled`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

INSERT INTO `v9_admin_role` VALUES('1','超级管理员','超级管理员','0','0');
INSERT INTO `v9_admin_role` VALUES('2','站点管理员','站点管理员','0','0');
INSERT INTO `v9_admin_role` VALUES('3','运营总监','运营总监','1','0');
INSERT INTO `v9_admin_role` VALUES('4','总编','总编','5','0');
INSERT INTO `v9_admin_role` VALUES('5','编辑','编辑','1','0');
INSERT INTO `v9_admin_role` VALUES('7','发布人员','发布人员','0','0');

DROP TABLE IF EXISTS `v9_admin_role_priv`;
CREATE TABLE `v9_admin_role_priv` (
  `roleid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `m` char(20) NOT NULL,
  `c` char(20) NOT NULL,
  `a` char(20) NOT NULL,
  `data` char(30) NOT NULL DEFAULT '',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  KEY `roleid` (`roleid`,`m`,`c`,`a`,`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_announce`;
CREATE TABLE `v9_announce` (
  `aid` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `title` char(80) NOT NULL,
  `content` text NOT NULL,
  `starttime` date NOT NULL DEFAULT '0000-00-00',
  `endtime` date NOT NULL DEFAULT '0000-00-00',
  `username` varchar(40) NOT NULL,
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `hits` smallint(5) unsigned NOT NULL DEFAULT '0',
  `passed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `style` char(15) NOT NULL,
  `show_template` char(30) NOT NULL,
  PRIMARY KEY (`aid`),
  KEY `siteid` (`siteid`,`passed`,`endtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_attachment`;
CREATE TABLE `v9_attachment` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module` char(15) NOT NULL,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `filename` char(50) NOT NULL,
  `filepath` char(200) NOT NULL,
  `filesize` int(10) unsigned NOT NULL DEFAULT '0',
  `fileext` char(10) NOT NULL,
  `isimage` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isthumb` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `downloads` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `uploadtime` int(10) unsigned NOT NULL DEFAULT '0',
  `uploadip` char(15) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `authcode` char(32) NOT NULL,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`aid`),
  KEY `authcode` (`authcode`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

INSERT INTO `v9_attachment` VALUES('13','content','8','邓小平检阅自卫队.jpg','2018/0205/20180205080605571.jpg','46737','jpg','1','0','0','1','1517832365','127.0.0.1','1','559fa98ac91f460bf8db8e94ef2e9ab9','1');
INSERT INTO `v9_attachment` VALUES('12','content','0','914a491e3077e98d8f181bcce986eca1.jpg','2018/0205/20180205080312763.jpg','106704','jpg','1','0','0','1','1517832192','127.0.0.1','1','a6b0a8e0fd209fe7eadea8d126ffc891','1');
INSERT INTO `v9_attachment` VALUES('16','content','8','s1.jpg','2018/0205/20180205080838151.jpg','16620','jpg','1','0','0','1','1517832518','127.0.0.1','1','7955b630df4cb1d9c70a3954a8cf4d25','1');
INSERT INTO `v9_attachment` VALUES('15','content','0','head.jpg','2018/0205/20180205080803789.jpg','285537','jpg','1','0','0','1','1517832483','127.0.0.1','1','db102efa8e901f0a45cac80e1c56d095','1');
INSERT INTO `v9_attachment` VALUES('14','content','8','邓小平检阅自卫队.jpg','2018/0205/20180205080642165.jpg','46737','jpg','1','0','0','1','1517832402','127.0.0.1','1','a61f454f8824280ec0aa7b5524eb102e','1');
INSERT INTO `v9_attachment` VALUES('6','content','0','head.jpg','2018/0204/20180204021631727.jpg','285537','jpg','1','0','0','1','1517724991','127.0.0.1','1','01d12581555e3b04b5ab4733452208b1','1');
INSERT INTO `v9_attachment` VALUES('7','content','6','a1.jpg','2018/0204/20180204062025580.jpg','942387','jpg','1','0','0','1','1517739625','127.0.0.1','1','15c497b5963847c98386a65413f6fc3a','1');
INSERT INTO `v9_attachment` VALUES('8','content','8','a1.jpg','2018/0204/20180204063257442.jpg','942387','jpg','1','0','0','1','1517740377','127.0.0.1','1','ab274439478fa172814d9b2762270a83','1');
INSERT INTO `v9_attachment` VALUES('9','content','8','a2.jpg','2018/0204/20180204063342124.jpg','639752','jpg','1','0','0','1','1517740422','127.0.0.1','1','7af83c85a0471514574b6eddf27b0895','1');
INSERT INTO `v9_attachment` VALUES('10','content','8','a3.jpg','2018/0204/20180204063415757.jpg','1020428','jpg','1','0','0','1','1517740455','127.0.0.1','1','524a5c77fe7a6c55c75f3a58a7106343','1');
INSERT INTO `v9_attachment` VALUES('11','content','8','a4.jpg','2018/0204/20180204063437958.jpg','1182434','jpg','1','0','0','1','1517740477','127.0.0.1','1','d69d34e4503aa137f526de054a8d8e55','1');
INSERT INTO `v9_attachment` VALUES('17','content','8','邓小平检阅自卫队.jpg','2018/0205/20180205080906158.jpg','46737','jpg','1','0','0','1','1517832546','127.0.0.1','1','2bf212bc776875fab089ad152376ddc6','1');
INSERT INTO `v9_attachment` VALUES('18','content','8','TB2j39.aSYH8KJjSspdXXcRgVXa_!!3195498716.jpg','2018/0205/20180205081026695.jpg','361577','jpg','1','0','0','1','1517832626','127.0.0.1','0','ed221f697bf083ef92c819d9b46e0e54','1');
INSERT INTO `v9_attachment` VALUES('19','content','0','head.jpg','2018/0205/20180205081154623.jpg','285537','jpg','1','0','0','1','1517832714','127.0.0.1','0','f5e253b9fef31a483ecf49d23a60be17','1');
INSERT INTO `v9_attachment` VALUES('20','content','0','head.jpg','2018/0210/20180210053231391.jpg','285537','jpg','1','0','0','1','1518255151','127.0.0.1','0','754078c974ed7c4391966bf622cbddb3','1');
INSERT INTO `v9_attachment` VALUES('25','content','13','1信图片_20190120184742.jpg','2019/1006/20191006052618929.jpg','570766','jpg','1','0','0','1','1570353978','','1','f06794294fc8c9399c076abeab2ae0fb','1');

DROP TABLE IF EXISTS `v9_attachment_index`;
CREATE TABLE `v9_attachment_index` (
  `keyid` char(30) NOT NULL,
  `aid` char(10) NOT NULL,
  KEY `keyid` (`keyid`),
  KEY `aid` (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_attachment_index` VALUES('c-8-7','13');
INSERT INTO `v9_attachment_index` VALUES('c-8-7','12');
INSERT INTO `v9_attachment_index` VALUES('c-8-7','16');
INSERT INTO `v9_attachment_index` VALUES('c-8-7','15');
INSERT INTO `v9_attachment_index` VALUES('c-8-7','14');
INSERT INTO `v9_attachment_index` VALUES('c-6-2','6');
INSERT INTO `v9_attachment_index` VALUES('c-6-2','7');
INSERT INTO `v9_attachment_index` VALUES('c-8-3','8');
INSERT INTO `v9_attachment_index` VALUES('c-8-4','9');
INSERT INTO `v9_attachment_index` VALUES('c-8-5','10');
INSERT INTO `v9_attachment_index` VALUES('c-8-6','11');
INSERT INTO `v9_attachment_index` VALUES('c-8-7','17');
INSERT INTO `v9_attachment_index` VALUES('c-13-2','25');

DROP TABLE IF EXISTS `v9_badword`;
CREATE TABLE `v9_badword` (
  `badid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `badword` char(20) NOT NULL,
  `level` tinyint(5) NOT NULL DEFAULT '1',
  `replaceword` char(20) NOT NULL DEFAULT '0',
  `lastusetime` int(10) unsigned NOT NULL DEFAULT '0',
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`badid`),
  UNIQUE KEY `badword` (`badword`),
  KEY `usetimes` (`replaceword`,`listorder`),
  KEY `hits` (`listorder`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_block`;
CREATE TABLE `v9_block` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned DEFAULT '0',
  `name` char(50) DEFAULT NULL,
  `pos` char(30) DEFAULT NULL,
  `type` tinyint(1) DEFAULT '0',
  `data` text,
  `template` text,
  PRIMARY KEY (`id`),
  KEY `pos` (`pos`),
  KEY `type` (`type`),
  KEY `siteid` (`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `v9_block` VALUES('1','1','标题','logo','1','<img alt=\"\" src=\"http://www.dazuiwoniuyuanxuezhi.com/uploadfile/2018/0210/20180210053231391.jpg\" style=\"width: 1200px; height: 94px;\" />','');
INSERT INTO `v9_block` VALUES('2','1','版权信息','publishInfo','1','版权所有：XXX救护车销售有限公司 电话：86-010-xxxxxxxx　地址：XXXXXXXXXXXXXXXXXX 京ICP备10059925号-1','');
INSERT INTO `v9_block` VALUES('3','1','标题图','logo','1','','');

DROP TABLE IF EXISTS `v9_block_history`;
CREATE TABLE `v9_block_history` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `blockid` int(10) unsigned DEFAULT '0',
  `data` text,
  `creat_at` int(10) unsigned DEFAULT '0',
  `userid` mediumint(8) unsigned DEFAULT '0',
  `username` char(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

INSERT INTO `v9_block_history` VALUES('1','1','{\"id\":\"1\",\"siteid\":\"1\",\"name\":\"\\u6807\\u9898\",\"pos\":\"logo\",\"type\":\"1\",\"data\":\"\",\"template\":\"\"}','1517725007','1','admin');
INSERT INTO `v9_block_history` VALUES('2','2','{\"id\":\"2\",\"siteid\":\"1\",\"name\":\"\\u7248\\u6743\\u4fe1\\u606f\",\"pos\":\"publishInfo\",\"type\":\"1\",\"data\":\"\",\"template\":\"\"}','1517725054','1','admin');
INSERT INTO `v9_block_history` VALUES('3','1','{\"id\":\"1\",\"siteid\":\"1\",\"name\":\"\\u6807\\u9898\",\"pos\":\"logo\",\"type\":\"1\",\"data\":\"<img alt=\\\"\\\" src=\\\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204021631727.jpg\\\" style=\\\"width: 1920px; height: 150px;\\\" \\/>\",\"template\":\"\"}','1517832204','1','admin');
INSERT INTO `v9_block_history` VALUES('4','1','{\"id\":\"1\",\"siteid\":\"1\",\"name\":\"\\u6807\\u9898\",\"pos\":\"logo\",\"type\":\"1\",\"data\":\"<img alt=\\\"\\\" src=\\\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0205\\/20180205080312763.jpg\\\" style=\\\"width: 1024px; height: 768px;\\\" \\/>\",\"template\":\"\"}','1517832726','1','admin');
INSERT INTO `v9_block_history` VALUES('5','1','{\"id\":\"1\",\"siteid\":\"1\",\"name\":\"\\u6807\\u9898\",\"pos\":\"logo\",\"type\":\"1\",\"data\":\"<img alt=\\\"\\\" src=\\\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0205\\/20180205081154623.jpg\\\" style=\\\"width: 1920px; height: 150px;\\\" \\/>\",\"template\":\"\"}','1518255170','1','admin');

DROP TABLE IF EXISTS `v9_block_priv`;
CREATE TABLE `v9_block_priv` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `roleid` tinyint(3) unsigned DEFAULT '0',
  `siteid` smallint(5) unsigned DEFAULT '0',
  `blockid` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `blockid` (`blockid`),
  KEY `roleid` (`roleid`,`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_cache`;
CREATE TABLE `v9_cache` (
  `filename` char(50) NOT NULL,
  `path` char(50) NOT NULL,
  `data` mediumtext NOT NULL,
  PRIMARY KEY (`filename`,`path`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_cache` VALUES('mood_program.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  1 => \n  array (\n    1 => \n    array (\n      \'use\' => \'1\',\n      \'name\' => \'震惊\',\n      \'pic\' => \'mood/a1.gif\',\n    ),\n    2 => \n    array (\n      \'use\' => \'1\',\n      \'name\' => \'不解\',\n      \'pic\' => \'mood/a2.gif\',\n    ),\n    3 => \n    array (\n      \'use\' => \'1\',\n      \'name\' => \'愤怒\',\n      \'pic\' => \'mood/a3.gif\',\n    ),\n    4 => \n    array (\n      \'use\' => \'1\',\n      \'name\' => \'杯具\',\n      \'pic\' => \'mood/a4.gif\',\n    ),\n    5 => \n    array (\n      \'use\' => \'1\',\n      \'name\' => \'无聊\',\n      \'pic\' => \'mood/a5.gif\',\n    ),\n    6 => \n    array (\n      \'use\' => \'1\',\n      \'name\' => \'高兴\',\n      \'pic\' => \'mood/a6.gif\',\n    ),\n    7 => \n    array (\n      \'use\' => \'1\',\n      \'name\' => \'支持\',\n      \'pic\' => \'mood/a7.gif\',\n    ),\n    8 => \n    array (\n      \'use\' => \'1\',\n      \'name\' => \'超赞\',\n      \'pic\' => \'mood/a8.gif\',\n    ),\n    9 => \n    array (\n      \'use\' => NULL,\n      \'name\' => \'\',\n      \'pic\' => \'\',\n    ),\n    10 => \n    array (\n      \'use\' => NULL,\n      \'name\' => \'\',\n      \'pic\' => \'\',\n    ),\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('category_content.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  13 => \'1\',\n  14 => \'1\',\n);\n?>');
INSERT INTO `v9_cache` VALUES('category_content_1.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  13 => \n  array (\n    \'catid\' => \'13\',\n    \'siteid\' => \'1\',\n    \'type\' => \'0\',\n    \'modelid\' => \'12\',\n    \'parentid\' => \'0\',\n    \'arrparentid\' => \'0\',\n    \'child\' => \'0\',\n    \'arrchildid\' => \'13\',\n    \'catname\' => \'小法庭\',\n    \'style\' => \'\',\n    \'image\' => \'\',\n    \'description\' => \'\',\n    \'parentdir\' => \'\',\n    \'catdir\' => \'littleCourt\',\n    \'url\' => \'http://localhost/ambulance/index.php?m=content&c=index&a=lists&catid=13\',\n    \'items\' => \'1\',\n    \'hits\' => \'0\',\n    \'setting\' => \'{\"workflowid\":\"\",\"ishtml\":\"0\",\"content_ishtml\":\"0\",\"create_to_html_root\":\"0\",\"template_list\":\"dzwn_v1\",\"category_template\":\"category\",\"list_template\":\"list\",\"show_template\":\"show\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"6\",\"show_ruleid\":\"16\"}\',\n    \'listorder\' => \'13\',\n    \'ismenu\' => \'1\',\n    \'sethtml\' => \'0\',\n    \'letter\' => \'xiaofating\',\n    \'usable_type\' => \'\',\n    \'create_to_html_root\' => \'0\',\n    \'ishtml\' => \'0\',\n    \'content_ishtml\' => \'0\',\n    \'category_ruleid\' => \'6\',\n    \'show_ruleid\' => \'16\',\n    \'workflowid\' => \'\',\n    \'isdomain\' => \'0\',\n  ),\n  14 => \n  array (\n    \'catid\' => \'14\',\n    \'siteid\' => \'1\',\n    \'type\' => \'1\',\n    \'modelid\' => \'0\',\n    \'parentid\' => \'0\',\n    \'arrparentid\' => \'0\',\n    \'child\' => \'0\',\n    \'arrchildid\' => \'14\',\n    \'catname\' => \'小法庭1\',\n    \'style\' => \'\',\n    \'image\' => \'\',\n    \'description\' => \'\',\n    \'parentdir\' => \'\',\n    \'catdir\' => \'littleCourt1\',\n    \'url\' => \'http://localhost/ambulance/index.php?m=content&c=index&a=lists&catid=14\',\n    \'items\' => \'0\',\n    \'hits\' => \'0\',\n    \'setting\' => \'{\"ishtml\":\"0\",\"template_list\":\"dzwn_v1\",\"page_template\":\"page\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"6\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}\',\n    \'listorder\' => \'14\',\n    \'ismenu\' => \'1\',\n    \'sethtml\' => \'0\',\n    \'letter\' => \'xiaofating1\',\n    \'usable_type\' => \'\',\n    \'create_to_html_root\' => NULL,\n    \'ishtml\' => \'0\',\n    \'content_ishtml\' => NULL,\n    \'category_ruleid\' => \'6\',\n    \'show_ruleid\' => \'\',\n    \'workflowid\' => NULL,\n    \'isdomain\' => \'0\',\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('type_content_1.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  54 => \n  array (\n    \'typeid\' => \'54\',\n    \'siteid\' => \'1\',\n    \'module\' => \'content\',\n    \'modelid\' => \'0\',\n    \'name\' => \'友情大类\',\n    \'parentid\' => \'0\',\n    \'typedir\' => \'\',\n    \'url\' => \'\',\n    \'template\' => \'\',\n    \'listorder\' => \'0\',\n    \'description\' => \'测试用\',\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('bakup_tables.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  0 => \'v9_admin\',\n  1 => \'v9_admin_panel\',\n  2 => \'v9_admin_role\',\n  3 => \'v9_admin_role_priv\',\n  4 => \'v9_announce\',\n  5 => \'v9_attachment\',\n  6 => \'v9_attachment_index\',\n  7 => \'v9_badword\',\n  8 => \'v9_block\',\n  9 => \'v9_block_history\',\n  10 => \'v9_block_priv\',\n  11 => \'v9_cache\',\n  12 => \'v9_category\',\n  13 => \'v9_category_priv\',\n  14 => \'v9_collection_content\',\n  15 => \'v9_collection_history\',\n  16 => \'v9_collection_node\',\n  17 => \'v9_collection_program\',\n  18 => \'v9_comment\',\n  19 => \'v9_comment_check\',\n  20 => \'v9_comment_data_1\',\n  21 => \'v9_comment_setting\',\n  22 => \'v9_comment_table\',\n  23 => \'v9_content_check\',\n  24 => \'v9_copyfrom\',\n  25 => \'v9_datacall\',\n  26 => \'v9_dbsource\',\n  27 => \'v9_download\',\n  28 => \'v9_download_data\',\n  29 => \'v9_downservers\',\n  30 => \'v9_extend_setting\',\n  31 => \'v9_favorite\',\n  32 => \'v9_hits\',\n  33 => \'v9_ipbanned\',\n  34 => \'v9_keylink\',\n  35 => \'v9_keyword\',\n  36 => \'v9_keyword_data\',\n  37 => \'v9_link\',\n  38 => \'v9_linkage\',\n  39 => \'v9_live\',\n  40 => \'v9_live_data\',\n  41 => \'v9_log\',\n  42 => \'v9_member\',\n  43 => \'v9_member_detail\',\n  44 => \'v9_member_group\',\n  45 => \'v9_member_menu\',\n  46 => \'v9_member_verify\',\n  47 => \'v9_member_vip\',\n  48 => \'v9_menu\',\n  49 => \'v9_message\',\n  50 => \'v9_message_data\',\n  51 => \'v9_message_group\',\n  52 => \'v9_model\',\n  53 => \'v9_model_field\',\n  54 => \'v9_module\',\n  55 => \'v9_mood\',\n  56 => \'v9_news\',\n  57 => \'v9_news_data\',\n  58 => \'v9_page\',\n  59 => \'v9_pay_account\',\n  60 => \'v9_pay_payment\',\n  61 => \'v9_pay_spend\',\n  62 => \'v9_picture\',\n  63 => \'v9_picture_data\',\n  64 => \'v9_position\',\n  65 => \'v9_position_data\',\n  66 => \'v9_poster\',\n  67 => \'v9_poster_201801\',\n  68 => \'v9_poster_201802\',\n  69 => \'v9_poster_201907\',\n  70 => \'v9_poster_201909\',\n  71 => \'v9_poster_201910\',\n  72 => \'v9_poster_space\',\n  73 => \'v9_queue\',\n  74 => \'v9_release_point\',\n  75 => \'v9_search\',\n  76 => \'v9_search_keyword\',\n  77 => \'v9_session\',\n  78 => \'v9_site\',\n  79 => \'v9_sms_report\',\n  80 => \'v9_special\',\n  81 => \'v9_special_c_data\',\n  82 => \'v9_special_content\',\n  83 => \'v9_sphinx_counter\',\n  84 => \'v9_sso_admin\',\n  85 => \'v9_sso_applications\',\n  86 => \'v9_sso_members\',\n  87 => \'v9_sso_messagequeue\',\n  88 => \'v9_sso_session\',\n  89 => \'v9_sso_settings\',\n  90 => \'v9_tag\',\n  91 => \'v9_template_bak\',\n  92 => \'v9_times\',\n  93 => \'v9_type\',\n  94 => \'v9_urlrule\',\n  95 => \'v9_video\',\n  96 => \'v9_video_content\',\n  97 => \'v9_video_data\',\n  98 => \'v9_video_store\',\n  99 => \'v9_vote_data\',\n  100 => \'v9_vote_option\',\n  101 => \'v9_vote_subject\',\n  102 => \'v9_wap\',\n  103 => \'v9_wap_type\',\n  104 => \'v9_workflow\',\n);\n?>');
INSERT INTO `v9_cache` VALUES('sitelist.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  1 => \n  array (\n    \'siteid\' => \'1\',\n    \'name\' => \'大嘴蜗牛网\',\n    \'dirname\' => \'\',\n    \'domain\' => \'http://localhost/test/\',\n    \'site_title\' => \'大嘴蜗牛\',\n    \'keywords\' => \'大嘴蜗牛\',\n    \'description\' => \'一个优质UGC网站\',\n    \'release_point\' => \'\',\n    \'default_style\' => \'dzwn_v1\',\n    \'template\' => \'dzwn_v1\',\n    \'setting\' => \'{\"upload_maxsize\":\"2048\",\"upload_allowext\":\"jpg|jpeg|gif|bmp|png|doc|docx|xls|xlsx|ppt|pptx|pdf|txt|rar|zip|swf\",\"watermark_enable\":\"1\",\"watermark_minwidth\":\"300\",\"watermark_minheight\":\"300\",\"watermark_img\":\"statics\\\\/images\\\\/water\\\\/\\\\/mark.png\",\"watermark_pct\":\"85\",\"watermark_quality\":\"80\",\"watermark_pos\":\"9\"}\',\n    \'uuid\' => \'6df16bc5-03fc-11e8-8f26-00245427aa68\',\n    \'url\' => \'http://localhost/test/\',\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('downservers.cache.php','caches_commons/caches_data/','<?php\nreturn NULL;\n?>');
INSERT INTO `v9_cache` VALUES('badword.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n);\n?>');
INSERT INTO `v9_cache` VALUES('ipbanned.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n);\n?>');
INSERT INTO `v9_cache` VALUES('keylink.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n);\n?>');
INSERT INTO `v9_cache` VALUES('position.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  2 => \n  array (\n    \'posid\' => \'2\',\n    \'modelid\' => \'0\',\n    \'catid\' => \'0\',\n    \'name\' => \'首页头条推荐\',\n    \'maxnum\' => \'20\',\n    \'extention\' => \'\',\n    \'listorder\' => \'4\',\n    \'siteid\' => \'1\',\n    \'thumb\' => \'\',\n  ),\n  1 => \n  array (\n    \'posid\' => \'1\',\n    \'modelid\' => \'0\',\n    \'catid\' => \'0\',\n    \'name\' => \'首页焦点图推荐\',\n    \'maxnum\' => \'20\',\n    \'extention\' => \'\',\n    \'listorder\' => \'1\',\n    \'siteid\' => \'1\',\n    \'thumb\' => \'\',\n  ),\n  13 => \n  array (\n    \'posid\' => \'13\',\n    \'modelid\' => \'82\',\n    \'catid\' => \'0\',\n    \'name\' => \'栏目页焦点图\',\n    \'maxnum\' => \'20\',\n    \'extention\' => \'\',\n    \'listorder\' => \'0\',\n    \'siteid\' => \'1\',\n    \'thumb\' => \'\',\n  ),\n  5 => \n  array (\n    \'posid\' => \'5\',\n    \'modelid\' => \'69\',\n    \'catid\' => \'0\',\n    \'name\' => \'推荐下载\',\n    \'maxnum\' => \'20\',\n    \'extention\' => \'\',\n    \'listorder\' => \'0\',\n    \'siteid\' => \'1\',\n    \'thumb\' => \'\',\n  ),\n  8 => \n  array (\n    \'posid\' => \'8\',\n    \'modelid\' => \'30\',\n    \'catid\' => \'54\',\n    \'name\' => \'图片频道首页焦点图\',\n    \'maxnum\' => \'20\',\n    \'extention\' => \'\',\n    \'listorder\' => \'0\',\n    \'siteid\' => \'1\',\n    \'thumb\' => \'\',\n  ),\n  9 => \n  array (\n    \'posid\' => \'9\',\n    \'modelid\' => \'0\',\n    \'catid\' => \'0\',\n    \'name\' => \'网站顶部推荐\',\n    \'maxnum\' => \'20\',\n    \'extention\' => \'\',\n    \'listorder\' => \'0\',\n    \'siteid\' => \'1\',\n    \'thumb\' => \'\',\n  ),\n  10 => \n  array (\n    \'posid\' => \'10\',\n    \'modelid\' => \'0\',\n    \'catid\' => \'0\',\n    \'name\' => \'栏目首页推荐\',\n    \'maxnum\' => \'20\',\n    \'extention\' => \'\',\n    \'listorder\' => \'0\',\n    \'siteid\' => \'1\',\n    \'thumb\' => \'\',\n  ),\n  12 => \n  array (\n    \'posid\' => \'12\',\n    \'modelid\' => \'0\',\n    \'catid\' => \'0\',\n    \'name\' => \'首页图片推荐\',\n    \'maxnum\' => \'20\',\n    \'extention\' => \'\',\n    \'listorder\' => \'0\',\n    \'siteid\' => \'1\',\n    \'thumb\' => \'\',\n  ),\n  14 => \n  array (\n    \'posid\' => \'14\',\n    \'modelid\' => \'0\',\n    \'catid\' => \'0\',\n    \'name\' => \'视频首页焦点图\',\n    \'maxnum\' => \'20\',\n    \'extention\' => \'\',\n    \'listorder\' => \'0\',\n    \'siteid\' => \'1\',\n    \'thumb\' => \'\',\n  ),\n  15 => \n  array (\n    \'posid\' => \'15\',\n    \'modelid\' => \'0\',\n    \'catid\' => \'0\',\n    \'name\' => \'视频首页头条推荐\',\n    \'maxnum\' => \'20\',\n    \'extention\' => \'\',\n    \'listorder\' => \'0\',\n    \'siteid\' => \'1\',\n    \'thumb\' => \'\',\n  ),\n  16 => \n  array (\n    \'posid\' => \'16\',\n    \'modelid\' => \'0\',\n    \'catid\' => \'0\',\n    \'name\' => \'视频首页每日热点\',\n    \'maxnum\' => \'20\',\n    \'extention\' => \'\',\n    \'listorder\' => \'0\',\n    \'siteid\' => \'1\',\n    \'thumb\' => \'\',\n  ),\n  17 => \n  array (\n    \'posid\' => \'17\',\n    \'modelid\' => \'0\',\n    \'catid\' => \'0\',\n    \'name\' => \'视频栏目精彩推荐\',\n    \'maxnum\' => \'20\',\n    \'extention\' => \'\',\n    \'listorder\' => \'0\',\n    \'siteid\' => \'1\',\n    \'thumb\' => \'\',\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('role_siteid.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n);\n?>');
INSERT INTO `v9_cache` VALUES('role.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  1 => \'超级管理员\',\n  2 => \'站点管理员\',\n  3 => \'运营总监\',\n  4 => \'总编\',\n  5 => \'编辑\',\n  7 => \'发布人员\',\n);\n?>');
INSERT INTO `v9_cache` VALUES('urlrules_detail.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  1 => \n  array (\n    \'urlruleid\' => \'1\',\n    \'module\' => \'content\',\n    \'file\' => \'category\',\n    \'ishtml\' => \'1\',\n    \'urlrule\' => \'{$categorydir}{$catdir}/index.html|{$categorydir}{$catdir}/{$page}.html\',\n    \'example\' => \'news/china/1000.html\',\n  ),\n  6 => \n  array (\n    \'urlruleid\' => \'6\',\n    \'module\' => \'content\',\n    \'file\' => \'category\',\n    \'ishtml\' => \'0\',\n    \'urlrule\' => \'index.php?m=content&c=index&a=lists&catid={$catid}|index.php?m=content&c=index&a=lists&catid={$catid}&page={$page}\',\n    \'example\' => \'index.php?m=content&c=index&a=lists&catid=1&page=1\',\n  ),\n  11 => \n  array (\n    \'urlruleid\' => \'11\',\n    \'module\' => \'content\',\n    \'file\' => \'show\',\n    \'ishtml\' => \'1\',\n    \'urlrule\' => \'{$year}/{$catdir}_{$month}{$day}/{$id}.html|{$year}/{$catdir}_{$month}{$day}/{$id}_{$page}.html\',\n    \'example\' => \'2010/catdir_0720/1_2.html\',\n  ),\n  12 => \n  array (\n    \'urlruleid\' => \'12\',\n    \'module\' => \'content\',\n    \'file\' => \'show\',\n    \'ishtml\' => \'1\',\n    \'urlrule\' => \'{$categorydir}{$catdir}/{$year}/{$month}{$day}/{$id}.html|{$categorydir}{$catdir}/{$year}/{$month}{$day}/{$id}_{$page}.html\',\n    \'example\' => \'it/product/2010/0720/1_2.html\',\n  ),\n  16 => \n  array (\n    \'urlruleid\' => \'16\',\n    \'module\' => \'content\',\n    \'file\' => \'show\',\n    \'ishtml\' => \'0\',\n    \'urlrule\' => \'index.php?m=content&c=index&a=show&catid={$catid}&id={$id}|index.php?m=content&c=index&a=show&catid={$catid}&id={$id}&page={$page}\',\n    \'example\' => \'index.php?m=content&c=index&a=show&catid=1&id=1\',\n  ),\n  17 => \n  array (\n    \'urlruleid\' => \'17\',\n    \'module\' => \'content\',\n    \'file\' => \'show\',\n    \'ishtml\' => \'0\',\n    \'urlrule\' => \'show-{$catid}-{$id}-{$page}.html\',\n    \'example\' => \'show-1-2-1.html\',\n  ),\n  18 => \n  array (\n    \'urlruleid\' => \'18\',\n    \'module\' => \'content\',\n    \'file\' => \'show\',\n    \'ishtml\' => \'0\',\n    \'urlrule\' => \'content-{$catid}-{$id}-{$page}.html\',\n    \'example\' => \'content-1-2-1.html\',\n  ),\n  30 => \n  array (\n    \'urlruleid\' => \'30\',\n    \'module\' => \'content\',\n    \'file\' => \'category\',\n    \'ishtml\' => \'0\',\n    \'urlrule\' => \'list-{$catid}-{$page}.html\',\n    \'example\' => \'list-1-1.html\',\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('urlrules.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  1 => \'{$categorydir}{$catdir}/index.html|{$categorydir}{$catdir}/{$page}.html\',\n  6 => \'index.php?m=content&c=index&a=lists&catid={$catid}|index.php?m=content&c=index&a=lists&catid={$catid}&page={$page}\',\n  11 => \'{$year}/{$catdir}_{$month}{$day}/{$id}.html|{$year}/{$catdir}_{$month}{$day}/{$id}_{$page}.html\',\n  12 => \'{$categorydir}{$catdir}/{$year}/{$month}{$day}/{$id}.html|{$categorydir}{$catdir}/{$year}/{$month}{$day}/{$id}_{$page}.html\',\n  16 => \'index.php?m=content&c=index&a=show&catid={$catid}&id={$id}|index.php?m=content&c=index&a=show&catid={$catid}&id={$id}&page={$page}\',\n  17 => \'show-{$catid}-{$id}-{$page}.html\',\n  18 => \'content-{$catid}-{$id}-{$page}.html\',\n  30 => \'list-{$catid}-{$page}.html\',\n);\n?>');
INSERT INTO `v9_cache` VALUES('modules.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  \'admin\' => \n  array (\n    \'module\' => \'admin\',\n    \'name\' => \'admin\',\n    \'url\' => \'\',\n    \'iscore\' => \'1\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'{\"admin_email\":\"phpcms@phpcms.cn\",\"maxloginfailedtimes\":\"8\",\"minrefreshtime\":\"2\",\"mail_type\":\"1\",\"mail_server\":\"smtp.qq.com\",\"mail_port\":\"25\",\"category_ajax\":\"0\",\"mail_user\":\"phpcms.cn@foxmail.com\",\"mail_auth\":\"1\",\"mail_from\":\"phpcms.cn@foxmail.com\",\"mail_password\":\"\",\"errorlog_size\":\"20\"}\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-10-18\',\n    \'updatedate\' => \'2010-10-18\',\n  ),\n  \'member\' => \n  array (\n    \'module\' => \'member\',\n    \'name\' => \'会员\',\n    \'url\' => \'\',\n    \'iscore\' => \'1\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'{\"allowregister\":\"1\",\"choosemodel\":\"1\",\"enablemailcheck\":\"0\",\"enablcodecheck\":\"0\",\"mobile_checktype\":\"2\",\"user_sendsms_title\":\"\",\"registerverify\":\"0\",\"showapppoint\":\"0\",\"rmb_point_rate\":\"10\",\"defualtpoint\":\"0\",\"defualtamount\":\"0\",\"showregprotocol\":\"0\",\"regprotocol\":\"\\\\t\\\\t \\\\u6b22\\\\u8fce\\\\u60a8\\\\u6ce8\\\\u518c\\\\u6210\\\\u4e3aphpcms\\\\u7528\\\\u6237\\\\r\\\\n\\\\u8bf7\\\\u4ed4\\\\u7ec6\\\\u9605\\\\u8bfb\\\\u4e0b\\\\u9762\\\\u7684\\\\u534f\\\\u8bae\\\\uff0c\\\\u53ea\\\\u6709\\\\u63a5\\\\u53d7\\\\u534f\\\\u8bae\\\\u624d\\\\u80fd\\\\u7ee7\\\\u7eed\\\\u8fdb\\\\u884c\\\\u6ce8\\\\u518c\\\\u3002 \\\\r\\\\n1\\\\uff0e\\\\u670d\\\\u52a1\\\\u6761\\\\u6b3e\\\\u7684\\\\u786e\\\\u8ba4\\\\u548c\\\\u63a5\\\\u7eb3\\\\r\\\\n\\\\u3000\\\\u3000phpcms\\\\u7528\\\\u6237\\\\u670d\\\\u52a1\\\\u7684\\\\u6240\\\\u6709\\\\u6743\\\\u548c\\\\u8fd0\\\\u4f5c\\\\u6743\\\\u5f52phpcms\\\\u62e5\\\\u6709\\\\u3002phpcms\\\\u6240\\\\u63d0\\\\u4f9b\\\\u7684\\\\u670d\\\\u52a1\\\\u5c06\\\\u6309\\\\u7167\\\\u6709\\\\u5173\\\\u7ae0\\\\u7a0b\\\\u3001\\\\u670d\\\\u52a1\\\\u6761\\\\u6b3e\\\\u548c\\\\u64cd\\\\u4f5c\\\\u89c4\\\\u5219\\\\u4e25\\\\u683c\\\\u6267\\\\u884c\\\\u3002\\\\u7528\\\\u6237\\\\u901a\\\\u8fc7\\\\u6ce8\\\\u518c\\\\u7a0b\\\\u5e8f\\\\u70b9\\\\u51fb\\\\u201c\\\\u6211\\\\u540c\\\\u610f\\\\u201d \\\\u6309\\\\u94ae\\\\uff0c\\\\u5373\\\\u8868\\\\u793a\\\\u7528\\\\u6237\\\\u4e0ephpcms\\\\u8fbe\\\\u6210\\\\u534f\\\\u8bae\\\\u5e76\\\\u63a5\\\\u53d7\\\\u6240\\\\u6709\\\\u7684\\\\u670d\\\\u52a1\\\\u6761\\\\u6b3e\\\\u3002\\\\r\\\\n2\\\\uff0e phpcms\\\\u670d\\\\u52a1\\\\u7b80\\\\u4ecb\\\\r\\\\n\\\\u3000\\\\u3000phpcms\\\\u901a\\\\u8fc7\\\\u56fd\\\\u9645\\\\u4e92\\\\u8054\\\\u7f51\\\\u4e3a\\\\u7528\\\\u6237\\\\u63d0\\\\u4f9b\\\\u65b0\\\\u95fb\\\\u53ca\\\\u6587\\\\u7ae0\\\\u6d4f\\\\u89c8\\\\u3001\\\\u56fe\\\\u7247\\\\u6d4f\\\\u89c8\\\\u3001\\\\u8f6f\\\\u4ef6\\\\u4e0b\\\\u8f7d\\\\u3001\\\\u7f51\\\\u4e0a\\\\u7559\\\\u8a00\\\\u548cBBS\\\\u8bba\\\\u575b\\\\u7b49\\\\u670d\\\\u52a1\\\\u3002\\\\r\\\\n\\\\u3000\\\\u3000\\\\u7528\\\\u6237\\\\u5fc5\\\\u987b\\\\uff1a \\\\r\\\\n\\\\u3000\\\\u30001)\\\\u8d2d\\\\u7f6e\\\\u8bbe\\\\u5907\\\\uff0c\\\\u5305\\\\u62ec\\\\u4e2a\\\\u4eba\\\\u7535\\\\u8111\\\\u4e00\\\\u53f0\\\\u3001\\\\u8c03\\\\u5236\\\\u89e3\\\\u8c03\\\\u5668\\\\u4e00\\\\u4e2a\\\\u53ca\\\\u914d\\\\u5907\\\\u4e0a\\\\u7f51\\\\u88c5\\\\u7f6e\\\\u3002 \\\\r\\\\n\\\\u3000\\\\u30002)\\\\u4e2a\\\\u4eba\\\\u4e0a\\\\u7f51\\\\u548c\\\\u652f\\\\u4ed8\\\\u4e0e\\\\u6b64\\\\u670d\\\\u52a1\\\\u6709\\\\u5173\\\\u7684\\\\u7535\\\\u8bdd\\\\u8d39\\\\u7528\\\\u3001\\\\u7f51\\\\u7edc\\\\u8d39\\\\u7528\\\\u3002\\\\r\\\\n\\\\u3000\\\\u3000\\\\u7528\\\\u6237\\\\u540c\\\\u610f\\\\uff1a \\\\r\\\\n\\\\u3000\\\\u30001)\\\\u63d0\\\\u4f9b\\\\u53ca\\\\u65f6\\\\u3001\\\\u8be6\\\\u5c3d\\\\u53ca\\\\u51c6\\\\u786e\\\\u7684\\\\u4e2a\\\\u4eba\\\\u8d44\\\\u6599\\\\u3002 \\\\r\\\\n\\\\u3000\\\\u30002)\\\\u4e0d\\\\u65ad\\\\u66f4\\\\u65b0\\\\u6ce8\\\\u518c\\\\u8d44\\\\u6599\\\\uff0c\\\\u7b26\\\\u5408\\\\u53ca\\\\u65f6\\\\u3001\\\\u8be6\\\\u5c3d\\\\u3001\\\\u51c6\\\\u786e\\\\u7684\\\\u8981\\\\u6c42\\\\u3002\\\\u6240\\\\u6709\\\\u539f\\\\u59cb\\\\u952e\\\\u5165\\\\u7684\\\\u8d44\\\\u6599\\\\u5c06\\\\u5f15\\\\u7528\\\\u4e3a\\\\u6ce8\\\\u518c\\\\u8d44\\\\u6599\\\\u3002 \\\\r\\\\n\\\\u3000\\\\u30003)\\\\u7528\\\\u6237\\\\u540c\\\\u610f\\\\u9075\\\\u5b88\\\\u300a\\\\u4e2d\\\\u534e\\\\u4eba\\\\u6c11\\\\u5171\\\\u548c\\\\u56fd\\\\u4fdd\\\\u5b88\\\\u56fd\\\\u5bb6\\\\u79d8\\\\u5bc6\\\\u6cd5\\\\u300b\\\\u3001\\\\u300a\\\\u4e2d\\\\u534e\\\\u4eba\\\\u6c11\\\\u5171\\\\u548c\\\\u56fd\\\\u8ba1\\\\u7b97\\\\u673a\\\\u4fe1\\\\u606f\\\\u7cfb\\\\u7edf\\\\u5b89\\\\u5168\\\\u4fdd\\\\u62a4\\\\u6761\\\\u4f8b\\\\u300b\\\\u3001\\\\u300a\\\\u8ba1\\\\u7b97\\\\u673a\\\\u8f6f\\\\u4ef6\\\\u4fdd\\\\u62a4\\\\u6761\\\\u4f8b\\\\u300b\\\\u7b49\\\\u6709\\\\u5173\\\\u8ba1\\\\u7b97\\\\u673a\\\\u53ca\\\\u4e92\\\\u8054\\\\u7f51\\\\u89c4\\\\u5b9a\\\\u7684\\\\u6cd5\\\\u5f8b\\\\u548c\\\\u6cd5\\\\u89c4\\\\u3001\\\\u5b9e\\\\u65bd\\\\u529e\\\\u6cd5\\\\u3002\\\\u5728\\\\u4efb\\\\u4f55\\\\u60c5\\\\u51b5\\\\u4e0b\\\\uff0cphpcms\\\\u5408\\\\u7406\\\\u5730\\\\u8ba4\\\\u4e3a\\\\u7528\\\\u6237\\\\u7684\\\\u884c\\\\u4e3a\\\\u53ef\\\\u80fd\\\\u8fdd\\\\u53cd\\\\u4e0a\\\\u8ff0\\\\u6cd5\\\\u5f8b\\\\u3001\\\\u6cd5\\\\u89c4\\\\uff0cphpcms\\\\u53ef\\\\u4ee5\\\\u5728\\\\u4efb\\\\u4f55\\\\u65f6\\\\u5019\\\\uff0c\\\\u4e0d\\\\u7ecf\\\\u4e8b\\\\u5148\\\\u901a\\\\u77e5\\\\u7ec8\\\\u6b62\\\\u5411\\\\u8be5\\\\u7528\\\\u6237\\\\u63d0\\\\u4f9b\\\\u670d\\\\u52a1\\\\u3002\\\\u7528\\\\u6237\\\\u5e94\\\\u4e86\\\\u89e3\\\\u56fd\\\\u9645\\\\u4e92\\\\u8054\\\\u7f51\\\\u7684\\\\u65e0\\\\u56fd\\\\u754c\\\\u6027\\\\uff0c\\\\u5e94\\\\u7279\\\\u522b\\\\u6ce8\\\\u610f\\\\u9075\\\\u5b88\\\\u5f53\\\\u5730\\\\u6240\\\\u6709\\\\u6709\\\\u5173\\\\u7684\\\\u6cd5\\\\u5f8b\\\\u548c\\\\u6cd5\\\\u89c4\\\\u3002\\\\r\\\\n3\\\\uff0e \\\\u670d\\\\u52a1\\\\u6761\\\\u6b3e\\\\u7684\\\\u4fee\\\\u6539\\\\r\\\\n\\\\u3000\\\\u3000phpcms\\\\u4f1a\\\\u4e0d\\\\u5b9a\\\\u65f6\\\\u5730\\\\u4fee\\\\u6539\\\\u670d\\\\u52a1\\\\u6761\\\\u6b3e\\\\uff0c\\\\u670d\\\\u52a1\\\\u6761\\\\u6b3e\\\\u4e00\\\\u65e6\\\\u53d1\\\\u751f\\\\u53d8\\\\u52a8\\\\uff0c\\\\u5c06\\\\u4f1a\\\\u5728\\\\u76f8\\\\u5173\\\\u9875\\\\u9762\\\\u4e0a\\\\u63d0\\\\u793a\\\\u4fee\\\\u6539\\\\u5185\\\\u5bb9\\\\u3002\\\\u5982\\\\u679c\\\\u60a8\\\\u540c\\\\u610f\\\\u6539\\\\u52a8\\\\uff0c\\\\u5219\\\\u518d\\\\u4e00\\\\u6b21\\\\u70b9\\\\u51fb\\\\u201c\\\\u6211\\\\u540c\\\\u610f\\\\u201d\\\\u6309\\\\u94ae\\\\u3002 \\\\u5982\\\\u679c\\\\u60a8\\\\u4e0d\\\\u63a5\\\\u53d7\\\\uff0c\\\\u5219\\\\u53ca\\\\u65f6\\\\u53d6\\\\u6d88\\\\u60a8\\\\u7684\\\\u7528\\\\u6237\\\\u4f7f\\\\u7528\\\\u670d\\\\u52a1\\\\u8d44\\\\u683c\\\\u3002\\\\r\\\\n4\\\\uff0e \\\\u670d\\\\u52a1\\\\u4fee\\\\u8ba2\\\\r\\\\n\\\\u3000\\\\u3000phpcms\\\\u4fdd\\\\u7559\\\\u968f\\\\u65f6\\\\u4fee\\\\u6539\\\\u6216\\\\u4e2d\\\\u65ad\\\\u670d\\\\u52a1\\\\u800c\\\\u4e0d\\\\u9700\\\\u77e5\\\\u7167\\\\u7528\\\\u6237\\\\u7684\\\\u6743\\\\u5229\\\\u3002phpcms\\\\u884c\\\\u4f7f\\\\u4fee\\\\u6539\\\\u6216\\\\u4e2d\\\\u65ad\\\\u670d\\\\u52a1\\\\u7684\\\\u6743\\\\u5229\\\\uff0c\\\\u4e0d\\\\u9700\\\\u5bf9\\\\u7528\\\\u6237\\\\u6216\\\\u7b2c\\\\u4e09\\\\u65b9\\\\u8d1f\\\\u8d23\\\\u3002\\\\r\\\\n5\\\\uff0e \\\\u7528\\\\u6237\\\\u9690\\\\u79c1\\\\u5236\\\\u5ea6\\\\r\\\\n\\\\u3000\\\\u3000\\\\u5c0a\\\\u91cd\\\\u7528\\\\u6237\\\\u4e2a\\\\u4eba\\\\u9690\\\\u79c1\\\\u662fphpcms\\\\u7684 \\\\u57fa\\\\u672c\\\\u653f\\\\u7b56\\\\u3002phpcms\\\\u4e0d\\\\u4f1a\\\\u516c\\\\u5f00\\\\u3001\\\\u7f16\\\\u8f91\\\\u6216\\\\u900f\\\\u9732\\\\u7528\\\\u6237\\\\u7684\\\\u6ce8\\\\u518c\\\\u4fe1\\\\u606f\\\\uff0c\\\\u9664\\\\u975e\\\\u6709\\\\u6cd5\\\\u5f8b\\\\u8bb8\\\\u53ef\\\\u8981\\\\u6c42\\\\uff0c\\\\u6216phpcms\\\\u5728\\\\u8bda\\\\u4fe1\\\\u7684\\\\u57fa\\\\u7840\\\\u4e0a\\\\u8ba4\\\\u4e3a\\\\u900f\\\\u9732\\\\u8fd9\\\\u4e9b\\\\u4fe1\\\\u606f\\\\u5728\\\\u4ee5\\\\u4e0b\\\\u4e09\\\\u79cd\\\\u60c5\\\\u51b5\\\\u662f\\\\u5fc5\\\\u8981\\\\u7684\\\\uff1a \\\\r\\\\n\\\\u3000\\\\u30001)\\\\u9075\\\\u5b88\\\\u6709\\\\u5173\\\\u6cd5\\\\u5f8b\\\\u89c4\\\\u5b9a\\\\uff0c\\\\u9075\\\\u4ece\\\\u5408\\\\u6cd5\\\\u670d\\\\u52a1\\\\u7a0b\\\\u5e8f\\\\u3002 \\\\r\\\\n\\\\u3000\\\\u30002)\\\\u4fdd\\\\u6301\\\\u7ef4\\\\u62a4phpcms\\\\u7684\\\\u5546\\\\u6807\\\\u6240\\\\u6709\\\\u6743\\\\u3002 \\\\r\\\\n\\\\u3000\\\\u30003)\\\\u5728\\\\u7d27\\\\u6025\\\\u60c5\\\\u51b5\\\\u4e0b\\\\u7aed\\\\u529b\\\\u7ef4\\\\u62a4\\\\u7528\\\\u6237\\\\u4e2a\\\\u4eba\\\\u548c\\\\u793e\\\\u4f1a\\\\u5927\\\\u4f17\\\\u7684\\\\u9690\\\\u79c1\\\\u5b89\\\\u5168\\\\u3002 \\\\r\\\\n\\\\u3000\\\\u30004)\\\\u7b26\\\\u5408\\\\u5176\\\\u4ed6\\\\u76f8\\\\u5173\\\\u7684\\\\u8981\\\\u6c42\\\\u3002 \\\\r\\\\n6\\\\uff0e\\\\u7528\\\\u6237\\\\u7684\\\\u5e10\\\\u53f7\\\\uff0c\\\\u5bc6\\\\u7801\\\\u548c\\\\u5b89\\\\u5168\\\\u6027\\\\r\\\\n\\\\u3000\\\\u3000\\\\u4e00\\\\u65e6\\\\u6ce8\\\\u518c\\\\u6210\\\\u529f\\\\u6210\\\\u4e3aphpcms\\\\u7528\\\\u6237\\\\uff0c\\\\u60a8\\\\u5c06\\\\u5f97\\\\u5230\\\\u4e00\\\\u4e2a\\\\u5bc6\\\\u7801\\\\u548c\\\\u5e10\\\\u53f7\\\\u3002\\\\u5982\\\\u679c\\\\u60a8\\\\u4e0d\\\\u4fdd\\\\u7ba1\\\\u597d\\\\u81ea\\\\u5df1\\\\u7684\\\\u5e10\\\\u53f7\\\\u548c\\\\u5bc6\\\\u7801\\\\u5b89\\\\u5168\\\\uff0c\\\\u5c06\\\\u5bf9\\\\u56e0\\\\u6b64\\\\u4ea7\\\\u751f\\\\u7684\\\\u540e\\\\u679c\\\\u8d1f\\\\u5168\\\\u90e8\\\\u8d23\\\\u4efb\\\\u3002\\\\u53e6\\\\u5916\\\\uff0c\\\\u6bcf\\\\u4e2a\\\\u7528\\\\u6237\\\\u90fd\\\\u8981\\\\u5bf9\\\\u5176\\\\u5e10\\\\u6237\\\\u4e2d\\\\u7684\\\\u6240\\\\u6709\\\\u6d3b\\\\u52a8\\\\u548c\\\\u4e8b\\\\u4ef6\\\\u8d1f\\\\u5168\\\\u8d23\\\\u3002\\\\u60a8\\\\u53ef\\\\u968f\\\\u65f6\\\\u6839\\\\u636e\\\\u6307\\\\u793a\\\\u6539\\\\u53d8\\\\u60a8\\\\u7684\\\\u5bc6\\\\u7801\\\\uff0c\\\\u4e5f\\\\u53ef\\\\u4ee5\\\\u7ed3\\\\u675f\\\\u65e7\\\\u7684\\\\u5e10\\\\u6237\\\\u91cd\\\\u5f00\\\\u4e00\\\\u4e2a\\\\u65b0\\\\u5e10\\\\u6237\\\\u3002\\\\u7528\\\\u6237\\\\u540c\\\\u610f\\\\u82e5\\\\u53d1\\\\u73b0\\\\u4efb\\\\u4f55\\\\u975e\\\\u6cd5\\\\u4f7f\\\\u7528\\\\u7528\\\\u6237\\\\u5e10\\\\u53f7\\\\u6216\\\\u5b89\\\\u5168\\\\u6f0f\\\\u6d1e\\\\u7684\\\\u60c5\\\\u51b5\\\\uff0c\\\\u7acb\\\\u5373\\\\u901a\\\\u77e5phpcms\\\\u3002\\\\r\\\\n7\\\\uff0e \\\\u514d\\\\u8d23\\\\u6761\\\\u6b3e\\\\r\\\\n\\\\u3000\\\\u3000\\\\u7528\\\\u6237\\\\u660e\\\\u786e\\\\u540c\\\\u610f\\\\u7f51\\\\u7ad9\\\\u670d\\\\u52a1\\\\u7684\\\\u4f7f\\\\u7528\\\\u7531\\\\u7528\\\\u6237\\\\u4e2a\\\\u4eba\\\\u627f\\\\u62c5\\\\u98ce\\\\u9669\\\\u3002 \\\\u3000\\\\u3000 \\\\r\\\\n\\\\u3000\\\\u3000phpcms\\\\u4e0d\\\\u4f5c\\\\u4efb\\\\u4f55\\\\u7c7b\\\\u578b\\\\u7684\\\\u62c5\\\\u4fdd\\\\uff0c\\\\u4e0d\\\\u62c5\\\\u4fdd\\\\u670d\\\\u52a1\\\\u4e00\\\\u5b9a\\\\u80fd\\\\u6ee1\\\\u8db3\\\\u7528\\\\u6237\\\\u7684\\\\u8981\\\\u6c42\\\\uff0c\\\\u4e5f\\\\u4e0d\\\\u62c5\\\\u4fdd\\\\u670d\\\\u52a1\\\\u4e0d\\\\u4f1a\\\\u53d7\\\\u4e2d\\\\u65ad\\\\uff0c\\\\u5bf9\\\\u670d\\\\u52a1\\\\u7684\\\\u53ca\\\\u65f6\\\\u6027\\\\uff0c\\\\u5b89\\\\u5168\\\\u6027\\\\uff0c\\\\u51fa\\\\u9519\\\\u53d1\\\\u751f\\\\u90fd\\\\u4e0d\\\\u4f5c\\\\u62c5\\\\u4fdd\\\\u3002\\\\u7528\\\\u6237\\\\u7406\\\\u89e3\\\\u5e76\\\\u63a5\\\\u53d7\\\\uff1a\\\\u4efb\\\\u4f55\\\\u901a\\\\u8fc7phpcms\\\\u670d\\\\u52a1\\\\u53d6\\\\u5f97\\\\u7684\\\\u4fe1\\\\u606f\\\\u8d44\\\\u6599\\\\u7684\\\\u53ef\\\\u9760\\\\u6027\\\\u53d6\\\\u51b3\\\\u4e8e\\\\u7528\\\\u6237\\\\u81ea\\\\u5df1\\\\uff0c\\\\u7528\\\\u6237\\\\u81ea\\\\u5df1\\\\u627f\\\\u62c5\\\\u6240\\\\u6709\\\\u98ce\\\\u9669\\\\u548c\\\\u8d23\\\\u4efb\\\\u3002 \\\\r\\\\n8\\\\uff0e\\\\u6709\\\\u9650\\\\u8d23\\\\u4efb\\\\r\\\\n\\\\u3000\\\\u3000phpcms\\\\u5bf9\\\\u4efb\\\\u4f55\\\\u76f4\\\\u63a5\\\\u3001\\\\u95f4\\\\u63a5\\\\u3001\\\\u5076\\\\u7136\\\\u3001\\\\u7279\\\\u6b8a\\\\u53ca\\\\u7ee7\\\\u8d77\\\\u7684\\\\u635f\\\\u5bb3\\\\u4e0d\\\\u8d1f\\\\u8d23\\\\u4efb\\\\u3002\\\\r\\\\n9\\\\uff0e \\\\u4e0d\\\\u63d0\\\\u4f9b\\\\u96f6\\\\u552e\\\\u548c\\\\u5546\\\\u4e1a\\\\u6027\\\\u670d\\\\u52a1 \\\\r\\\\n\\\\u3000\\\\u3000\\\\u7528\\\\u6237\\\\u4f7f\\\\u7528\\\\u7f51\\\\u7ad9\\\\u670d\\\\u52a1\\\\u7684\\\\u6743\\\\u5229\\\\u662f\\\\u4e2a\\\\u4eba\\\\u7684\\\\u3002\\\\u7528\\\\u6237\\\\u53ea\\\\u80fd\\\\u662f\\\\u4e00\\\\u4e2a\\\\u5355\\\\u72ec\\\\u7684\\\\u4e2a\\\\u4f53\\\\u800c\\\\u4e0d\\\\u80fd\\\\u662f\\\\u4e00\\\\u4e2a\\\\u516c\\\\u53f8\\\\u6216\\\\u5b9e\\\\u4f53\\\\u5546\\\\u4e1a\\\\u6027\\\\u7ec4\\\\u7ec7\\\\u3002\\\\u7528\\\\u6237\\\\u627f\\\\u8bfa\\\\u4e0d\\\\u7ecfphpcms\\\\u540c\\\\u610f\\\\uff0c\\\\u4e0d\\\\u80fd\\\\u5229\\\\u7528\\\\u7f51\\\\u7ad9\\\\u670d\\\\u52a1\\\\u8fdb\\\\u884c\\\\u9500\\\\u552e\\\\u6216\\\\u5176\\\\u4ed6\\\\u5546\\\\u4e1a\\\\u7528\\\\u9014\\\\u3002\\\\r\\\\n10\\\\uff0e\\\\u7528\\\\u6237\\\\u8d23\\\\u4efb \\\\r\\\\n\\\\u3000\\\\u3000\\\\u7528\\\\u6237\\\\u5355\\\\u72ec\\\\u627f\\\\u62c5\\\\u4f20\\\\u8f93\\\\u5185\\\\u5bb9\\\\u7684\\\\u8d23\\\\u4efb\\\\u3002\\\\u7528\\\\u6237\\\\u5fc5\\\\u987b\\\\u9075\\\\u5faa\\\\uff1a \\\\r\\\\n\\\\u3000\\\\u30001)\\\\u4ece\\\\u4e2d\\\\u56fd\\\\u5883\\\\u5185\\\\u5411\\\\u5916\\\\u4f20\\\\u8f93\\\\u6280\\\\u672f\\\\u6027\\\\u8d44\\\\u6599\\\\u65f6\\\\u5fc5\\\\u987b\\\\u7b26\\\\u5408\\\\u4e2d\\\\u56fd\\\\u6709\\\\u5173\\\\u6cd5\\\\u89c4\\\\u3002 \\\\r\\\\n\\\\u3000\\\\u30002)\\\\u4f7f\\\\u7528\\\\u7f51\\\\u7ad9\\\\u670d\\\\u52a1\\\\u4e0d\\\\u4f5c\\\\u975e\\\\u6cd5\\\\u7528\\\\u9014\\\\u3002 \\\\r\\\\n\\\\u3000\\\\u30003)\\\\u4e0d\\\\u5e72\\\\u6270\\\\u6216\\\\u6df7\\\\u4e71\\\\u7f51\\\\u7edc\\\\u670d\\\\u52a1\\\\u3002 \\\\r\\\\n\\\\u3000\\\\u30004)\\\\u4e0d\\\\u5728\\\\u8bba\\\\u575bBBS\\\\u6216\\\\u7559\\\\u8a00\\\\u7c3f\\\\u53d1\\\\u8868\\\\u4efb\\\\u4f55\\\\u4e0e\\\\u653f\\\\u6cbb\\\\u76f8\\\\u5173\\\\u7684\\\\u4fe1\\\\u606f\\\\u3002 \\\\r\\\\n\\\\u3000\\\\u30005)\\\\u9075\\\\u5b88\\\\u6240\\\\u6709\\\\u4f7f\\\\u7528\\\\u7f51\\\\u7ad9\\\\u670d\\\\u52a1\\\\u7684\\\\u7f51\\\\u7edc\\\\u534f\\\\u8bae\\\\u3001\\\\u89c4\\\\u5b9a\\\\u3001\\\\u7a0b\\\\u5e8f\\\\u548c\\\\u60ef\\\\u4f8b\\\\u3002\\\\r\\\\n\\\\u3000\\\\u30006)\\\\u4e0d\\\\u5f97\\\\u5229\\\\u7528\\\\u672c\\\\u7ad9\\\\u5371\\\\u5bb3\\\\u56fd\\\\u5bb6\\\\u5b89\\\\u5168\\\\u3001\\\\u6cc4\\\\u9732\\\\u56fd\\\\u5bb6\\\\u79d8\\\\u5bc6\\\\uff0c\\\\u4e0d\\\\u5f97\\\\u4fb5\\\\u72af\\\\u56fd\\\\u5bb6\\\\u793e\\\\u4f1a\\\\u96c6\\\\u4f53\\\\u7684\\\\u548c\\\\u516c\\\\u6c11\\\\u7684\\\\u5408\\\\u6cd5\\\\u6743\\\\u76ca\\\\u3002\\\\r\\\\n\\\\u3000\\\\u30007)\\\\u4e0d\\\\u5f97\\\\u5229\\\\u7528\\\\u672c\\\\u7ad9\\\\u5236\\\\u4f5c\\\\u3001\\\\u590d\\\\u5236\\\\u548c\\\\u4f20\\\\u64ad\\\\u4e0b\\\\u5217\\\\u4fe1\\\\u606f\\\\uff1a \\\\r\\\\n\\\\u3000\\\\u3000\\\\u30001\\\\u3001\\\\u717d\\\\u52a8\\\\u6297\\\\u62d2\\\\u3001\\\\u7834\\\\u574f\\\\u5baa\\\\u6cd5\\\\u548c\\\\u6cd5\\\\u5f8b\\\\u3001\\\\u884c\\\\u653f\\\\u6cd5\\\\u89c4\\\\u5b9e\\\\u65bd\\\\u7684\\\\uff1b\\\\r\\\\n\\\\u3000\\\\u3000\\\\u30002\\\\u3001\\\\u717d\\\\u52a8\\\\u98a0\\\\u8986\\\\u56fd\\\\u5bb6\\\\u653f\\\\u6743\\\\uff0c\\\\u63a8\\\\u7ffb\\\\u793e\\\\u4f1a\\\\u4e3b\\\\u4e49\\\\u5236\\\\u5ea6\\\\u7684\\\\uff1b\\\\r\\\\n\\\\u3000\\\\u3000\\\\u30003\\\\u3001\\\\u717d\\\\u52a8\\\\u5206\\\\u88c2\\\\u56fd\\\\u5bb6\\\\u3001\\\\u7834\\\\u574f\\\\u56fd\\\\u5bb6\\\\u7edf\\\\u4e00\\\\u7684\\\\uff1b\\\\r\\\\n\\\\u3000\\\\u3000\\\\u30004\\\\u3001\\\\u717d\\\\u52a8\\\\u6c11\\\\u65cf\\\\u4ec7\\\\u6068\\\\u3001\\\\u6c11\\\\u65cf\\\\u6b67\\\\u89c6\\\\uff0c\\\\u7834\\\\u574f\\\\u6c11\\\\u65cf\\\\u56e2\\\\u7ed3\\\\u7684\\\\uff1b\\\\r\\\\n\\\\u3000\\\\u3000\\\\u30005\\\\u3001\\\\u634f\\\\u9020\\\\u6216\\\\u8005\\\\u6b6a\\\\u66f2\\\\u4e8b\\\\u5b9e\\\\uff0c\\\\u6563\\\\u5e03\\\\u8c23\\\\u8a00\\\\uff0c\\\\u6270\\\\u4e71\\\\u793e\\\\u4f1a\\\\u79e9\\\\u5e8f\\\\u7684\\\\uff1b\\\\r\\\\n\\\\u3000\\\\u3000\\\\u30006\\\\u3001\\\\u5ba3\\\\u626c\\\\u5c01\\\\u5efa\\\\u8ff7\\\\u4fe1\\\\u3001\\\\u6deb\\\\u79fd\\\\u3001\\\\u8272\\\\u60c5\\\\u3001\\\\u8d4c\\\\u535a\\\\u3001\\\\u66b4\\\\u529b\\\\u3001\\\\u51f6\\\\u6740\\\\u3001\\\\u6050\\\\u6016\\\\u3001\\\\u6559\\\\u5506\\\\u72af\\\\u7f6a\\\\u7684\\\\uff1b\\\\r\\\\n\\\\u3000\\\\u3000\\\\u30007\\\\u3001\\\\u516c\\\\u7136\\\\u4fae\\\\u8fb1\\\\u4ed6\\\\u4eba\\\\u6216\\\\u8005\\\\u634f\\\\u9020\\\\u4e8b\\\\u5b9e\\\\u8bfd\\\\u8c24\\\\u4ed6\\\\u4eba\\\\u7684\\\\uff0c\\\\u6216\\\\u8005\\\\u8fdb\\\\u884c\\\\u5176\\\\u4ed6\\\\u6076\\\\u610f\\\\u653b\\\\u51fb\\\\u7684\\\\uff1b\\\\r\\\\n\\\\u3000\\\\u3000\\\\u30008\\\\u3001\\\\u635f\\\\u5bb3\\\\u56fd\\\\u5bb6\\\\u673a\\\\u5173\\\\u4fe1\\\\u8a89\\\\u7684\\\\uff1b\\\\r\\\\n\\\\u3000\\\\u3000\\\\u30009\\\\u3001\\\\u5176\\\\u4ed6\\\\u8fdd\\\\u53cd\\\\u5baa\\\\u6cd5\\\\u548c\\\\u6cd5\\\\u5f8b\\\\u884c\\\\u653f\\\\u6cd5\\\\u89c4\\\\u7684\\\\uff1b\\\\r\\\\n\\\\u3000\\\\u3000\\\\u300010\\\\u3001\\\\u8fdb\\\\u884c\\\\u5546\\\\u4e1a\\\\u5e7f\\\\u544a\\\\u884c\\\\u4e3a\\\\u7684\\\\u3002\\\\r\\\\n\\\\u3000\\\\u3000\\\\u7528\\\\u6237\\\\u4e0d\\\\u80fd\\\\u4f20\\\\u8f93\\\\u4efb\\\\u4f55\\\\u6559\\\\u5506\\\\u4ed6\\\\u4eba\\\\u6784\\\\u6210\\\\u72af\\\\u7f6a\\\\u884c\\\\u4e3a\\\\u7684\\\\u8d44\\\\u6599\\\\uff1b\\\\u4e0d\\\\u80fd\\\\u4f20\\\\u8f93\\\\u957f\\\\u56fd\\\\u5185\\\\u4e0d\\\\u5229\\\\u6761\\\\u4ef6\\\\u548c\\\\u6d89\\\\u53ca\\\\u56fd\\\\u5bb6\\\\u5b89\\\\u5168\\\\u7684\\\\u8d44\\\\u6599\\\\uff1b\\\\u4e0d\\\\u80fd\\\\u4f20\\\\u8f93\\\\u4efb\\\\u4f55\\\\u4e0d\\\\u7b26\\\\u5408\\\\u5f53\\\\u5730\\\\u6cd5\\\\u89c4\\\\u3001\\\\u56fd\\\\u5bb6\\\\u6cd5\\\\u5f8b\\\\u548c\\\\u56fd\\\\u9645\\\\u6cd5 \\\\u5f8b\\\\u7684\\\\u8d44\\\\u6599\\\\u3002\\\\u672a\\\\u7ecf\\\\u8bb8\\\\u53ef\\\\u800c\\\\u975e\\\\u6cd5\\\\u8fdb\\\\u5165\\\\u5176\\\\u5b83\\\\u7535\\\\u8111\\\\u7cfb\\\\u7edf\\\\u662f\\\\u7981\\\\u6b62\\\\u7684\\\\u3002\\\\u82e5\\\\u7528\\\\u6237\\\\u7684\\\\u884c\\\\u4e3a\\\\u4e0d\\\\u7b26\\\\u5408\\\\u4ee5\\\\u4e0a\\\\u7684\\\\u6761\\\\u6b3e\\\\uff0cphpcms\\\\u5c06\\\\u53d6\\\\u6d88\\\\u7528\\\\u6237\\\\u670d\\\\u52a1\\\\u5e10\\\\u53f7\\\\u3002\\\\r\\\\n11\\\\uff0e\\\\u7f51\\\\u7ad9\\\\u5185\\\\u5bb9\\\\u7684\\\\u6240\\\\u6709\\\\u6743\\\\r\\\\n\\\\u3000\\\\u3000phpcms\\\\u5b9a\\\\u4e49\\\\u7684\\\\u5185\\\\u5bb9\\\\u5305\\\\u62ec\\\\uff1a\\\\u6587\\\\u5b57\\\\u3001\\\\u8f6f\\\\u4ef6\\\\u3001\\\\u58f0\\\\u97f3\\\\u3001\\\\u76f8\\\\u7247\\\\u3001\\\\u5f55\\\\u8c61\\\\u3001\\\\u56fe\\\\u8868\\\\uff1b\\\\u5728\\\\u5e7f\\\\u544a\\\\u4e2d\\\\u5168\\\\u90e8\\\\u5185\\\\u5bb9\\\\uff1b\\\\u7535\\\\u5b50\\\\u90ae\\\\u4ef6\\\\u7684\\\\u5168\\\\u90e8\\\\u5185\\\\u5bb9\\\\uff1bphpcms\\\\u4e3a\\\\u7528\\\\u6237\\\\u63d0\\\\u4f9b\\\\u7684\\\\u5546\\\\u4e1a\\\\u4fe1\\\\u606f\\\\u3002\\\\u6240\\\\u6709\\\\u8fd9\\\\u4e9b\\\\u5185\\\\u5bb9\\\\u53d7\\\\u7248\\\\u6743\\\\u3001\\\\u5546\\\\u6807\\\\u3001\\\\u6807\\\\u7b7e\\\\u548c\\\\u5176\\\\u5b83\\\\u8d22\\\\u4ea7\\\\u6240\\\\u6709\\\\u6743\\\\u6cd5\\\\u5f8b\\\\u7684\\\\u4fdd\\\\u62a4\\\\u3002\\\\u6240\\\\u4ee5\\\\uff0c\\\\u7528\\\\u6237\\\\u53ea\\\\u80fd\\\\u5728phpcms\\\\u548c\\\\u5e7f\\\\u544a\\\\u5546\\\\u6388\\\\u6743\\\\u4e0b\\\\u624d\\\\u80fd\\\\u4f7f\\\\u7528\\\\u8fd9\\\\u4e9b\\\\u5185\\\\u5bb9\\\\uff0c\\\\u800c\\\\u4e0d\\\\u80fd\\\\u64c5\\\\u81ea\\\\u590d\\\\u5236\\\\u3001\\\\u7be1\\\\u6539\\\\u8fd9\\\\u4e9b\\\\u5185\\\\u5bb9\\\\u3001\\\\u6216\\\\u521b\\\\u9020\\\\u4e0e\\\\u5185\\\\u5bb9\\\\u6709\\\\u5173\\\\u7684\\\\u6d3e\\\\u751f\\\\u4ea7\\\\u54c1\\\\u3002\\\\r\\\\n12\\\\uff0e\\\\u9644\\\\u52a0\\\\u4fe1\\\\u606f\\\\u670d\\\\u52a1\\\\r\\\\n\\\\u3000\\\\u3000\\\\u7528\\\\u6237\\\\u5728\\\\u4eab\\\\u7528phpcms\\\\u63d0\\\\u4f9b\\\\u7684\\\\u514d\\\\u8d39\\\\u670d\\\\u52a1\\\\u7684\\\\u540c\\\\u65f6\\\\uff0c\\\\u540c\\\\u610f\\\\u63a5\\\\u53d7phpcms\\\\u63d0\\\\u4f9b\\\\u7684\\\\u5404\\\\u7c7b\\\\u9644\\\\u52a0\\\\u4fe1\\\\u606f\\\\u670d\\\\u52a1\\\\u3002\\\\r\\\\n13\\\\uff0e\\\\u89e3\\\\u91ca\\\\u6743\\\\r\\\\n\\\\u3000\\\\u3000\\\\u672c\\\\u6ce8\\\\u518c\\\\u534f\\\\u8bae\\\\u7684\\\\u89e3\\\\u91ca\\\\u6743\\\\u5f52phpcms\\\\u6240\\\\u6709\\\\u3002\\\\u5982\\\\u679c\\\\u5176\\\\u4e2d\\\\u6709\\\\u4efb\\\\u4f55\\\\u6761\\\\u6b3e\\\\u4e0e\\\\u56fd\\\\u5bb6\\\\u7684\\\\u6709\\\\u5173\\\\u6cd5\\\\u5f8b\\\\u76f8\\\\u62b5\\\\u89e6\\\\uff0c\\\\u5219\\\\u4ee5\\\\u56fd\\\\u5bb6\\\\u6cd5\\\\u5f8b\\\\u7684\\\\u660e\\\\u6587\\\\u89c4\\\\u5b9a\\\\u4e3a\\\\u51c6\\\\u3002 \",\"registerverifymessage\":\" \\\\u6b22\\\\u8fce\\\\u60a8\\\\u6ce8\\\\u518c\\\\u6210\\\\u4e3aphpcms\\\\u7528\\\\u6237\\\\uff0c\\\\u60a8\\\\u7684\\\\u8d26\\\\u53f7\\\\u9700\\\\u8981\\\\u90ae\\\\u7bb1\\\\u8ba4\\\\u8bc1\\\\uff0c\\\\u70b9\\\\u51fb\\\\u4e0b\\\\u9762\\\\u94fe\\\\u63a5\\\\u8fdb\\\\u884c\\\\u8ba4\\\\u8bc1\\\\uff1a{click}\\\\r\\\\n\\\\u6216\\\\u8005\\\\u5c06\\\\u7f51\\\\u5740\\\\u590d\\\\u5236\\\\u5230\\\\u6d4f\\\\u89c8\\\\u5668\\\\uff1a{url}\",\"forgetpassword\":\" phpcms\\\\u5bc6\\\\u7801\\\\u627e\\\\u56de\\\\uff0c\\\\u8bf7\\\\u5728\\\\u4e00\\\\u5c0f\\\\u65f6\\\\u5185\\\\u70b9\\\\u51fb\\\\u4e0b\\\\u9762\\\\u94fe\\\\u63a5\\\\u8fdb\\\\u884c\\\\u64cd\\\\u4f5c\\\\uff1a{click}\\\\r\\\\n\\\\u6216\\\\u8005\\\\u5c06\\\\u7f51\\\\u5740\\\\u590d\\\\u5236\\\\u5230\\\\u6d4f\\\\u89c8\\\\u5668\\\\uff1a{url}\"}\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-06\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'pay\' => \n  array (\n    \'module\' => \'pay\',\n    \'name\' => \'支付\',\n    \'url\' => \'\',\n    \'iscore\' => \'1\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-06\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'digg\' => \n  array (\n    \'module\' => \'digg\',\n    \'name\' => \'顶一下\',\n    \'url\' => \'\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-06\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'special\' => \n  array (\n    \'module\' => \'special\',\n    \'name\' => \'专题\',\n    \'url\' => \'\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-06\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'content\' => \n  array (\n    \'module\' => \'content\',\n    \'name\' => \'内容模块\',\n    \'url\' => \'\',\n    \'iscore\' => \'1\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-06\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'search\' => \n  array (\n    \'module\' => \'search\',\n    \'name\' => \'全站搜索\',\n    \'url\' => \'\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'array (\n  \\\'fulltextenble\\\' => \\\'1\\\',\n  \\\'relationenble\\\' => \\\'1\\\',\n  \\\'suggestenable\\\' => \\\'1\\\',\n  \\\'sphinxenable\\\' => \\\'0\\\',\n  \\\'sphinxhost\\\' => \\\'10.228.134.102\\\',\n  \\\'sphinxport\\\' => \\\'9312\\\',\n)\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-06\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'scan\' => \n  array (\n    \'module\' => \'scan\',\n    \'name\' => \'木马扫描\',\n    \'url\' => \'scan\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-01\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'attachment\' => \n  array (\n    \'module\' => \'attachment\',\n    \'name\' => \'附件\',\n    \'url\' => \'attachment\',\n    \'iscore\' => \'1\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-01\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'block\' => \n  array (\n    \'module\' => \'block\',\n    \'name\' => \'碎片\',\n    \'url\' => \'\',\n    \'iscore\' => \'1\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-01\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'collection\' => \n  array (\n    \'module\' => \'collection\',\n    \'name\' => \'采集模块\',\n    \'url\' => \'collection\',\n    \'iscore\' => \'1\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-01\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'dbsource\' => \n  array (\n    \'module\' => \'dbsource\',\n    \'name\' => \'数据源\',\n    \'url\' => \'\',\n    \'iscore\' => \'1\',\n    \'version\' => \'\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-01\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'template\' => \n  array (\n    \'module\' => \'template\',\n    \'name\' => \'模板风格\',\n    \'url\' => \'\',\n    \'iscore\' => \'1\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-01\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'release\' => \n  array (\n    \'module\' => \'release\',\n    \'name\' => \'发布点\',\n    \'url\' => \'\',\n    \'iscore\' => \'1\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-01\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'video\' => \n  array (\n    \'module\' => \'video\',\n    \'name\' => \'视频库\',\n    \'url\' => \'\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2012-09-28\',\n    \'updatedate\' => \'2012-09-28\',\n  ),\n  \'announce\' => \n  array (\n    \'module\' => \'announce\',\n    \'name\' => \'公告\',\n    \'url\' => \'announce/\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'公告\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2018-01-28\',\n    \'updatedate\' => \'2018-01-28\',\n  ),\n  \'comment\' => \n  array (\n    \'module\' => \'comment\',\n    \'name\' => \'评论\',\n    \'url\' => \'comment/\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'评论\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2018-01-28\',\n    \'updatedate\' => \'2018-01-28\',\n  ),\n  \'link\' => \n  array (\n    \'module\' => \'link\',\n    \'name\' => \'友情链接\',\n    \'url\' => \'\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'array (\n  1 => \n  array (\n    \\\'is_post\\\' => \\\'1\\\',\n    \\\'enablecheckcode\\\' => \\\'0\\\',\n  ),\n)\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-06\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'vote\' => \n  array (\n    \'module\' => \'vote\',\n    \'name\' => \'投票\',\n    \'url\' => \'\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'array (\r\n  1 => \r\n  array (\r\n    \\\'default_style\\\' => \\\'default\\\',\r\n    \\\'vote_tp_template\\\' => \\\'vote_tp\\\',\r\n    \\\'allowguest\\\' => \\\'1\\\',\r\n    \\\'enabled\\\' => \\\'1\\\',\r\n    \\\'interval\\\' => \\\'1\\\',\r\n    \\\'credit\\\' => \\\'1\\\',\r\n  ),\r\n)\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-06\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'message\' => \n  array (\n    \'module\' => \'message\',\n    \'name\' => \'短消息\',\n    \'url\' => \'\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-09-06\',\n    \'updatedate\' => \'2010-09-06\',\n  ),\n  \'mood\' => \n  array (\n    \'module\' => \'mood\',\n    \'name\' => \'新闻心情\',\n    \'url\' => \'mood/\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'新闻心情\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2018-01-28\',\n    \'updatedate\' => \'2018-01-28\',\n  ),\n  \'poster\' => \n  array (\n    \'module\' => \'poster\',\n    \'name\' => \'广告模块\',\n    \'url\' => \'poster/\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'广告模块\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2018-01-28\',\n    \'updatedate\' => \'2018-01-28\',\n  ),\n  \'formguide\' => \n  array (\n    \'module\' => \'formguide\',\n    \'name\' => \'表单向导\',\n    \'url\' => \'formguide/\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'formguide\',\n    \'setting\' => \'array (\n  \\\'allowmultisubmit\\\' => \\\'1\\\',\n  \\\'interval\\\' => \\\'30\\\',\n  \\\'allowunreg\\\' => \\\'0\\\',\n  \\\'mailmessage\\\' => \\\'用户向我们提交了表单数据，赶快去看看吧。\\\',\n)\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2010-10-20\',\n    \'updatedate\' => \'2010-10-20\',\n  ),\n  \'wap\' => \n  array (\n    \'module\' => \'wap\',\n    \'name\' => \'手机门户\',\n    \'url\' => \'wap/\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'手机门户\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2018-01-28\',\n    \'updatedate\' => \'2018-01-28\',\n  ),\n  \'upgrade\' => \n  array (\n    \'module\' => \'upgrade\',\n    \'name\' => \'在线升级\',\n    \'url\' => \'\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2011-05-18\',\n    \'updatedate\' => \'2011-05-18\',\n  ),\n  \'tag\' => \n  array (\n    \'module\' => \'tag\',\n    \'name\' => \'标签向导\',\n    \'url\' => \'tag/\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'标签向导\',\n    \'setting\' => \'\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2018-01-28\',\n    \'updatedate\' => \'2018-01-28\',\n  ),\n  \'sms\' => \n  array (\n    \'module\' => \'sms\',\n    \'name\' => \'短信平台\',\n    \'url\' => \'sms/\',\n    \'iscore\' => \'0\',\n    \'version\' => \'1.0\',\n    \'description\' => \'短信平台\',\n    \'setting\' => \'{\"sms_enable\":\"1\",\"userid\":\"dazuiwoniu\",\"productid\":\"dzwn\",\"sms_key\":\"tmnt1992\"}\',\n    \'listorder\' => \'0\',\n    \'disabled\' => \'0\',\n    \'installdate\' => \'2011-09-02\',\n    \'updatedate\' => \'2011-09-02\',\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('model.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  1 => \n  array (\n    \'modelid\' => \'1\',\n    \'siteid\' => \'1\',\n    \'name\' => \'文章模型\',\n    \'description\' => \'\',\n    \'tablename\' => \'news\',\n    \'setting\' => \'\',\n    \'addtime\' => \'0\',\n    \'items\' => \'0\',\n    \'enablesearch\' => \'1\',\n    \'disabled\' => \'0\',\n    \'default_style\' => \'ambulance\',\n    \'category_template\' => \'category\',\n    \'list_template\' => \'list\',\n    \'show_template\' => \'show\',\n    \'js_template\' => \'\',\n    \'admin_list_template\' => \'\',\n    \'member_add_template\' => \'\',\n    \'member_list_template\' => \'\',\n    \'sort\' => \'0\',\n    \'type\' => \'0\',\n  ),\n  2 => \n  array (\n    \'modelid\' => \'2\',\n    \'siteid\' => \'1\',\n    \'name\' => \'下载模型\',\n    \'description\' => \'\',\n    \'tablename\' => \'download\',\n    \'setting\' => \'\',\n    \'addtime\' => \'0\',\n    \'items\' => \'0\',\n    \'enablesearch\' => \'1\',\n    \'disabled\' => \'0\',\n    \'default_style\' => \'default\',\n    \'category_template\' => \'category_download\',\n    \'list_template\' => \'list_download\',\n    \'show_template\' => \'show_download\',\n    \'js_template\' => \'\',\n    \'admin_list_template\' => \'\',\n    \'member_add_template\' => \'\',\n    \'member_list_template\' => \'\',\n    \'sort\' => \'0\',\n    \'type\' => \'0\',\n  ),\n  3 => \n  array (\n    \'modelid\' => \'3\',\n    \'siteid\' => \'1\',\n    \'name\' => \'图片模型\',\n    \'description\' => \'\',\n    \'tablename\' => \'picture\',\n    \'setting\' => \'\',\n    \'addtime\' => \'0\',\n    \'items\' => \'0\',\n    \'enablesearch\' => \'1\',\n    \'disabled\' => \'0\',\n    \'default_style\' => \'default\',\n    \'category_template\' => \'category_picture\',\n    \'list_template\' => \'list_picture\',\n    \'show_template\' => \'show_picture\',\n    \'js_template\' => \'\',\n    \'admin_list_template\' => \'\',\n    \'member_add_template\' => \'\',\n    \'member_list_template\' => \'\',\n    \'sort\' => \'0\',\n    \'type\' => \'0\',\n  ),\n  11 => \n  array (\n    \'modelid\' => \'11\',\n    \'siteid\' => \'1\',\n    \'name\' => \'视频模型\',\n    \'description\' => \'\',\n    \'tablename\' => \'video\',\n    \'setting\' => \'\',\n    \'addtime\' => \'0\',\n    \'items\' => \'0\',\n    \'enablesearch\' => \'1\',\n    \'disabled\' => \'0\',\n    \'default_style\' => \'default\',\n    \'category_template\' => \'category_video\',\n    \'list_template\' => \'list_video\',\n    \'show_template\' => \'show_video\',\n    \'js_template\' => \'\',\n    \'admin_list_template\' => \'\',\n    \'member_add_template\' => \'\',\n    \'member_list_template\' => \'\',\n    \'sort\' => \'0\',\n    \'type\' => \'0\',\n  ),\n  12 => \n  array (\n    \'modelid\' => \'12\',\n    \'siteid\' => \'1\',\n    \'name\' => \'直播模型\',\n    \'description\' => \'用于发布直播的模型\',\n    \'tablename\' => \'live\',\n    \'setting\' => \'\',\n    \'addtime\' => \'0\',\n    \'items\' => \'0\',\n    \'enablesearch\' => \'1\',\n    \'disabled\' => \'0\',\n    \'default_style\' => \'dzwn_v1\',\n    \'category_template\' => \'category\',\n    \'list_template\' => \'list\',\n    \'show_template\' => \'show\',\n    \'js_template\' => \'\',\n    \'admin_list_template\' => \'content_list\',\n    \'member_add_template\' => \'\',\n    \'member_list_template\' => \'\',\n    \'sort\' => \'0\',\n    \'type\' => \'0\',\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('workflow_1.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  1 => \n  array (\n    \'workflowid\' => \'1\',\n    \'siteid\' => \'1\',\n    \'steps\' => \'1\',\n    \'workname\' => \'一级审核\',\n    \'description\' => \'审核一次\',\n    \'setting\' => \'\',\n    \'flag\' => \'0\',\n  ),\n  2 => \n  array (\n    \'workflowid\' => \'2\',\n    \'siteid\' => \'1\',\n    \'steps\' => \'2\',\n    \'workname\' => \'二级审核\',\n    \'description\' => \'审核两次\',\n    \'setting\' => \'\',\n    \'flag\' => \'0\',\n  ),\n  3 => \n  array (\n    \'workflowid\' => \'3\',\n    \'siteid\' => \'1\',\n    \'steps\' => \'3\',\n    \'workname\' => \'三级审核\',\n    \'description\' => \'审核三次\',\n    \'setting\' => \'\',\n    \'flag\' => \'0\',\n  ),\n  4 => \n  array (\n    \'workflowid\' => \'4\',\n    \'siteid\' => \'1\',\n    \'steps\' => \'4\',\n    \'workname\' => \'四级审核\',\n    \'description\' => \'四级审核\',\n    \'setting\' => \'\',\n    \'flag\' => \'0\',\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('member_model.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  10 => \n  array (\n    \'modelid\' => \'10\',\n    \'siteid\' => \'1\',\n    \'name\' => \'普通会员\',\n    \'description\' => \'普通会员\',\n    \'tablename\' => \'member_detail\',\n    \'setting\' => \'\',\n    \'addtime\' => \'0\',\n    \'items\' => \'0\',\n    \'enablesearch\' => \'1\',\n    \'disabled\' => \'0\',\n    \'default_style\' => \'\',\n    \'category_template\' => \'\',\n    \'list_template\' => \'\',\n    \'show_template\' => \'\',\n    \'js_template\' => \'\',\n    \'admin_list_template\' => \'\',\n    \'member_add_template\' => \'\',\n    \'member_list_template\' => \'\',\n    \'sort\' => \'0\',\n    \'type\' => \'2\',\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('special.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n);\n?>');
INSERT INTO `v9_cache` VALUES('common.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  \'admin_email\' => \'phpcms@phpcms.cn\',\n  \'maxloginfailedtimes\' => \'8\',\n  \'minrefreshtime\' => \'2\',\n  \'mail_type\' => \'1\',\n  \'mail_server\' => \'smtp.qq.com\',\n  \'mail_port\' => \'25\',\n  \'category_ajax\' => \'0\',\n  \'mail_user\' => \'phpcms.cn@foxmail.com\',\n  \'mail_auth\' => \'1\',\n  \'mail_from\' => \'phpcms.cn@foxmail.com\',\n  \'mail_password\' => \'\',\n  \'errorlog_size\' => \'20\',\n);\n?>');
INSERT INTO `v9_cache` VALUES('category_items_1.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n);\n?>');
INSERT INTO `v9_cache` VALUES('category_items_2.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n);\n?>');
INSERT INTO `v9_cache` VALUES('category_items_3.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n);\n?>');
INSERT INTO `v9_cache` VALUES('category_items_11.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n);\n?>');
INSERT INTO `v9_cache` VALUES('type_content.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  54 => \n  array (\n    \'typeid\' => \'54\',\n    \'siteid\' => \'1\',\n    \'module\' => \'content\',\n    \'modelid\' => \'0\',\n    \'name\' => \'友情大类\',\n    \'parentid\' => \'0\',\n    \'typedir\' => \'\',\n    \'url\' => \'\',\n    \'template\' => \'\',\n    \'listorder\' => \'0\',\n    \'description\' => \'测试用\',\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('vote.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  1 => \n  array (\n    \'default_style\' => \'default\',\n    \'vote_tp_template\' => \'vote_tp\',\n    \'allowguest\' => \'1\',\n    \'enabled\' => \'1\',\n    \'interval\' => \'1\',\n    \'credit\' => \'1\',\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('link.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  1 => \n  array (\n    \'is_post\' => \'1\',\n    \'enablecheckcode\' => \'0\',\n  ),\n);\n?>');
INSERT INTO `v9_cache` VALUES('type_.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n);\n?>');
INSERT INTO `v9_cache` VALUES('category_items_12.cache.php','caches_commons/caches_data/','<?php\nreturn array (\n  13 => \'1\',\n);\n?>');

DROP TABLE IF EXISTS `v9_category`;
CREATE TABLE `v9_category` (
  `catid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `module` varchar(15) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `parentid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `arrparentid` varchar(255) NOT NULL,
  `child` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `arrchildid` mediumtext NOT NULL,
  `catname` varchar(30) NOT NULL,
  `style` varchar(5) NOT NULL,
  `image` varchar(100) NOT NULL,
  `description` mediumtext NOT NULL,
  `parentdir` varchar(100) NOT NULL,
  `catdir` varchar(30) NOT NULL,
  `url` varchar(100) NOT NULL,
  `items` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `setting` mediumtext NOT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `sethtml` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `letter` varchar(30) NOT NULL,
  `usable_type` varchar(255) NOT NULL,
  PRIMARY KEY (`catid`),
  KEY `module` (`module`,`parentid`,`listorder`,`catid`),
  KEY `siteid` (`siteid`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

INSERT INTO `v9_category` VALUES('13','1','content','0','12','0','0','0','13','小法庭','','','','','littleCourt','http://localhost/ambulance/index.php?m=content&c=index&a=lists&catid=13','1','0','{\"workflowid\":\"\",\"ishtml\":\"0\",\"content_ishtml\":\"0\",\"create_to_html_root\":\"0\",\"template_list\":\"dzwn_v1\",\"category_template\":\"category\",\"list_template\":\"list\",\"show_template\":\"show\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"presentpoint\":\"1\",\"defaultchargepoint\":\"0\",\"paytype\":\"0\",\"repeatchargedays\":\"1\",\"category_ruleid\":\"6\",\"show_ruleid\":\"16\"}','13','1','0','xiaofating','');
INSERT INTO `v9_category` VALUES('14','1','content','1','0','0','0','0','14','小法庭1','','','','','littleCourt1','http://localhost/ambulance/index.php?m=content&c=index&a=lists&catid=14','0','0','{\"ishtml\":\"0\",\"template_list\":\"dzwn_v1\",\"page_template\":\"page\",\"meta_title\":\"\",\"meta_keywords\":\"\",\"meta_description\":\"\",\"category_ruleid\":\"6\",\"show_ruleid\":\"\",\"repeatchargedays\":\"1\"}','14','1','0','xiaofating1','');

DROP TABLE IF EXISTS `v9_category_priv`;
CREATE TABLE `v9_category_priv` (
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `roleid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `is_admin` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `action` char(30) NOT NULL,
  KEY `catid` (`catid`,`roleid`,`is_admin`,`action`),
  KEY `siteid` (`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_category_priv` VALUES('8','1','2','1','init');
INSERT INTO `v9_category_priv` VALUES('8','1','3','1','init');
INSERT INTO `v9_category_priv` VALUES('8','1','4','1','init');
INSERT INTO `v9_category_priv` VALUES('8','1','5','1','init');
INSERT INTO `v9_category_priv` VALUES('8','1','7','1','init');
INSERT INTO `v9_category_priv` VALUES('8','1','8','0','visit');
INSERT INTO `v9_category_priv` VALUES('8','1','2','0','visit');
INSERT INTO `v9_category_priv` VALUES('8','1','6','0','visit');
INSERT INTO `v9_category_priv` VALUES('8','1','4','0','visit');
INSERT INTO `v9_category_priv` VALUES('8','1','5','0','visit');
INSERT INTO `v9_category_priv` VALUES('8','1','7','0','visit');

DROP TABLE IF EXISTS `v9_collection_content`;
CREATE TABLE `v9_collection_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nodeid` int(10) unsigned NOT NULL DEFAULT '0',
  `siteid` mediumint(5) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(255) NOT NULL,
  `title` char(100) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nodeid` (`nodeid`,`siteid`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_collection_history`;
CREATE TABLE `v9_collection_history` (
  `md5` char(32) NOT NULL,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`md5`,`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_collection_history` VALUES('00e9e4f7ce9f79d82ae0c25943894ec6','1');
INSERT INTO `v9_collection_history` VALUES('01aa093218ef692ec7bd142a987eef23','1');
INSERT INTO `v9_collection_history` VALUES('020f3e558a34bf6b08aa73198949515f','1');
INSERT INTO `v9_collection_history` VALUES('02be318004e26616b686bddbe00fe041','1');
INSERT INTO `v9_collection_history` VALUES('0330cbc5cd1e1751b272424c898ac98a','1');
INSERT INTO `v9_collection_history` VALUES('05efa8fc270c82843c02eca18b4a91e9','1');
INSERT INTO `v9_collection_history` VALUES('06168fc81f956b159c09db8b88af12fe','1');
INSERT INTO `v9_collection_history` VALUES('071c31ff136aea1b89db300439f412d2','1');
INSERT INTO `v9_collection_history` VALUES('080acaa5e975bf8c5674aa95934c3c1d','1');
INSERT INTO `v9_collection_history` VALUES('08abacf4295134fa88273461510638ff','1');
INSERT INTO `v9_collection_history` VALUES('08cda751612f82717ee39f14cd949bf5','1');
INSERT INTO `v9_collection_history` VALUES('0913800250ae691da5c809dfea9032a4','1');
INSERT INTO `v9_collection_history` VALUES('099c2f95024b1fd3c2342ef3a46cee50','1');
INSERT INTO `v9_collection_history` VALUES('09c34cc736b93ea6f1322175cdaac51f','1');
INSERT INTO `v9_collection_history` VALUES('0a203d6bb9a3cc57621c6842527318ac','1');
INSERT INTO `v9_collection_history` VALUES('0a631200cc7c4862d6036050e274a828','1');
INSERT INTO `v9_collection_history` VALUES('0ab929274049d236d765f3ecef0819e5','1');
INSERT INTO `v9_collection_history` VALUES('0bc48e8cd281d06b22a163e5ae1b1e19','1');
INSERT INTO `v9_collection_history` VALUES('0be1118be3579dd14913f28d3a2f7664','1');
INSERT INTO `v9_collection_history` VALUES('0c6c754e90b8630a0739f8f9ca820003','1');
INSERT INTO `v9_collection_history` VALUES('0d960d7aa316ff68fc50292c53b8f5a4','1');
INSERT INTO `v9_collection_history` VALUES('0d9d981a56090856e8e0ee87b7eb2213','1');
INSERT INTO `v9_collection_history` VALUES('0e5dde9d5c4e6aa7f1f62c09fd821086','1');
INSERT INTO `v9_collection_history` VALUES('0e8cdd01d4d5b9b0cf84bb947d960469','1');
INSERT INTO `v9_collection_history` VALUES('0ea58d5fbedb126abeaaf2ed96c7ab1d','1');
INSERT INTO `v9_collection_history` VALUES('0ef5cf8c53538dc5dd445dc4cdcfbda8','1');
INSERT INTO `v9_collection_history` VALUES('10615cbfe00117252cf44518b93a8d58','1');
INSERT INTO `v9_collection_history` VALUES('116c0f87629f2410a533c419c35efd7a','1');
INSERT INTO `v9_collection_history` VALUES('117c8cf55895f91fa8141d0bc6b5ee5e','1');
INSERT INTO `v9_collection_history` VALUES('118b74f49728853ef86b3d5574f43547','1');
INSERT INTO `v9_collection_history` VALUES('12318359e8f9aa7694461fc432f6730d','1');
INSERT INTO `v9_collection_history` VALUES('1366783c915c3f7f03cb4b788f3a1f56','1');
INSERT INTO `v9_collection_history` VALUES('152a6804a69c6b86a9f0d386843f200b','1');
INSERT INTO `v9_collection_history` VALUES('15675138aeeff77ffaf770de8a46d7c0','1');
INSERT INTO `v9_collection_history` VALUES('15846798f9b344be50d69f79926bfb05','1');
INSERT INTO `v9_collection_history` VALUES('15a714f2e17add5afd8223b8b861b643','1');
INSERT INTO `v9_collection_history` VALUES('15d6c8ecda03302e2cc532aa9764842c','1');
INSERT INTO `v9_collection_history` VALUES('15de8282d9266d72965a557840f1a4e5','1');
INSERT INTO `v9_collection_history` VALUES('1772ab91afc772dba0be38a36c3f95ad','1');
INSERT INTO `v9_collection_history` VALUES('1797fa4b63b84407d1fc3875cedb8500','1');
INSERT INTO `v9_collection_history` VALUES('187ac92aea07eb75d02f49503f1c9b46','1');
INSERT INTO `v9_collection_history` VALUES('18dcd758978eb9abb5add64aca75ab25','1');
INSERT INTO `v9_collection_history` VALUES('18ec4b36b84006b5f71da7d7559afa8c','1');
INSERT INTO `v9_collection_history` VALUES('193903bf4514eb0a850d62330b9e2e82','1');
INSERT INTO `v9_collection_history` VALUES('195b87f5696e2e45fb16c19e1c067d00','1');
INSERT INTO `v9_collection_history` VALUES('195ea50eab0d2d0a677dabc769d63170','1');
INSERT INTO `v9_collection_history` VALUES('1a87340103d7cf05e46062ae6593f91d','1');
INSERT INTO `v9_collection_history` VALUES('1aa64a0926e74d9d72cf871fa2d91d59','1');
INSERT INTO `v9_collection_history` VALUES('1b16a35ef5a6bd522e9fc7220b0dc37a','1');
INSERT INTO `v9_collection_history` VALUES('1b52ddf6fdeb62e1491ea74cfbf62a24','1');
INSERT INTO `v9_collection_history` VALUES('1b7b19c576d07b513eeb027255985946','1');
INSERT INTO `v9_collection_history` VALUES('1bac01b43399e4af4f8d82b79832a969','1');
INSERT INTO `v9_collection_history` VALUES('1c53f010e9abdbccb8da1ac73652bae8','1');
INSERT INTO `v9_collection_history` VALUES('1d42b89c7d617fb10b19c82b85bf859a','1');
INSERT INTO `v9_collection_history` VALUES('1db04918f977110a5a64fca24f4fae31','1');
INSERT INTO `v9_collection_history` VALUES('1ea7e7b790746289fc31a71eff4582fd','1');
INSERT INTO `v9_collection_history` VALUES('1f8aaf14cb8b80135fec1b8409dc9d41','1');
INSERT INTO `v9_collection_history` VALUES('1fdb8398ec8ab67cd5f41a0c6e5ceca3','1');
INSERT INTO `v9_collection_history` VALUES('2043e5d1b36b42062754fad170a2c68f','1');
INSERT INTO `v9_collection_history` VALUES('204a0d972c7a2cf57347971475a1a8f4','1');
INSERT INTO `v9_collection_history` VALUES('2094fd9aa346e8b0d9f40837ec696782','1');
INSERT INTO `v9_collection_history` VALUES('20cce843221a541ee52026a67621dfa7','1');
INSERT INTO `v9_collection_history` VALUES('20fc1a95d7695ffee7500a206265caea','1');
INSERT INTO `v9_collection_history` VALUES('21471cefa76c2bbd397a5d7c99e1b300','1');
INSERT INTO `v9_collection_history` VALUES('21aac891a1ff27aeb5aac06916312c7d','1');
INSERT INTO `v9_collection_history` VALUES('253174bec2776a7dea9c0651948843b5','1');
INSERT INTO `v9_collection_history` VALUES('25e6226c1773589599dee269024a7964','1');
INSERT INTO `v9_collection_history` VALUES('26405baf72a22cd8d95cec3dc2cd6aa0','1');
INSERT INTO `v9_collection_history` VALUES('2645fceee968ee8db79e92940a17a0ad','1');
INSERT INTO `v9_collection_history` VALUES('27b8118cbf0998b25232141f401e6558','1');
INSERT INTO `v9_collection_history` VALUES('28f12b21fc5294cf33bf7fca8df6c27f','1');
INSERT INTO `v9_collection_history` VALUES('2926bb07c78bb09cd23cdf0f5a82030d','1');
INSERT INTO `v9_collection_history` VALUES('2a770f935e1a1752fff53a44d8527f84','1');
INSERT INTO `v9_collection_history` VALUES('2ae70eda38a55dc8f009bebd4d0d81e2','1');
INSERT INTO `v9_collection_history` VALUES('2c3e863beecb3a49cb597f8a1f49bb97','1');
INSERT INTO `v9_collection_history` VALUES('2c66a28a43032583d877d8f3ec73adb0','1');
INSERT INTO `v9_collection_history` VALUES('2e01c27f73bfbf4299b4dc2881bfe6d9','1');
INSERT INTO `v9_collection_history` VALUES('2ef48f96f809ad46ee1f8c77575663fd','1');
INSERT INTO `v9_collection_history` VALUES('2ef9da0678ac1020e16c5a8e97084eda','1');
INSERT INTO `v9_collection_history` VALUES('30e581d2a13b39368383802683a7dd66','1');
INSERT INTO `v9_collection_history` VALUES('32428e2c9a25b124f200f4e32cf858a8','1');
INSERT INTO `v9_collection_history` VALUES('32925a561293fcb98238c83caf31cb61','1');
INSERT INTO `v9_collection_history` VALUES('32cb847ef9dfb9db22b6522615bb8c07','1');
INSERT INTO `v9_collection_history` VALUES('32ddffe99a286d15953e1f6bc9480867','1');
INSERT INTO `v9_collection_history` VALUES('33260ed469a2c2ded49426fdd111d771','1');
INSERT INTO `v9_collection_history` VALUES('334ea049cba8377f154e3b3a4b61cda7','1');
INSERT INTO `v9_collection_history` VALUES('34e01b23ceb96cd9c02ebf49bd09d2d0','1');
INSERT INTO `v9_collection_history` VALUES('35132fe8c1f750434cfc612b5f1f7cd2','1');
INSERT INTO `v9_collection_history` VALUES('351331299bdc0a0fc3bea95014be968e','1');
INSERT INTO `v9_collection_history` VALUES('3522f37ce5bc1062e6299b517f2e3cb4','1');
INSERT INTO `v9_collection_history` VALUES('360c8df867761b3f07d0484bbf3afe25','1');
INSERT INTO `v9_collection_history` VALUES('39485c0a5ceaf3a06e1a38c445f07833','1');
INSERT INTO `v9_collection_history` VALUES('39a82984e0a689e5bf18481724084755','1');
INSERT INTO `v9_collection_history` VALUES('39c209f4910ac8f6c177f9a4c2f01656','1');
INSERT INTO `v9_collection_history` VALUES('39f0c15719c75c3eda5195a4ad7c47a5','1');
INSERT INTO `v9_collection_history` VALUES('3a2e7e5f67842678ffe322b6892961e2','1');
INSERT INTO `v9_collection_history` VALUES('3e87b30e587756ed9e77476784e8e4d8','1');
INSERT INTO `v9_collection_history` VALUES('3ecc479400d151f32ac27e2441e3cd68','1');
INSERT INTO `v9_collection_history` VALUES('3f64980ed58334f69095a24432396e54','1');
INSERT INTO `v9_collection_history` VALUES('3f896cf4986f78e1c4f0b87a37615c83','1');
INSERT INTO `v9_collection_history` VALUES('3fbce41f85c99374b32440ae85f6d22a','1');
INSERT INTO `v9_collection_history` VALUES('40e0a52e9c5f4570d00981ca9fbaf42f','1');
INSERT INTO `v9_collection_history` VALUES('41b7c02dec9ed589c8f7de52f200154c','1');
INSERT INTO `v9_collection_history` VALUES('422dd4be9287790bdc331a3cd6aa7c91','1');
INSERT INTO `v9_collection_history` VALUES('42930760c16cdcfe64057a757c478202','1');
INSERT INTO `v9_collection_history` VALUES('42dd6c4980bdbb57ef71827f66886d97','1');
INSERT INTO `v9_collection_history` VALUES('435221a48ce801c1d2f2b48028784db5','1');
INSERT INTO `v9_collection_history` VALUES('43803d3a097f84ae6ba492d21255579a','1');
INSERT INTO `v9_collection_history` VALUES('4443867dc826d410747378a1fdf6c94c','1');
INSERT INTO `v9_collection_history` VALUES('44c7d914d0cc384376e9dbbb41e8b6b0','1');
INSERT INTO `v9_collection_history` VALUES('45379e95104958ad4bf99d2d2f522dd7','1');
INSERT INTO `v9_collection_history` VALUES('456c934df569f80fe4e221595b454f65','1');
INSERT INTO `v9_collection_history` VALUES('4672c5afc6f3bab6cdaacff31f693aad','1');
INSERT INTO `v9_collection_history` VALUES('46f8aa3f8d20b1fd416627a085875099','1');
INSERT INTO `v9_collection_history` VALUES('4734468e7fd0d4a8bb8a32ee5000e38e','1');
INSERT INTO `v9_collection_history` VALUES('484d044f49800cceafd92b4f5b4586c7','1');
INSERT INTO `v9_collection_history` VALUES('489d8056159dc7afffac43326e87d48b','1');
INSERT INTO `v9_collection_history` VALUES('48ab014d8ce72ea2ba4c5cf20c1987f1','1');
INSERT INTO `v9_collection_history` VALUES('4978436beb31c669d24eb702274759fc','1');
INSERT INTO `v9_collection_history` VALUES('498f4a98b418ac12d7305f2aef1b94ac','1');
INSERT INTO `v9_collection_history` VALUES('49aa7226570f7dc1699f132cec906d8e','1');
INSERT INTO `v9_collection_history` VALUES('49ba526942d10bd73197049d66ad8530','1');
INSERT INTO `v9_collection_history` VALUES('4a1e86ab302feaaa780512ac75c25bf6','1');
INSERT INTO `v9_collection_history` VALUES('4a9ca0f3f6c2575afec35ae5883f2138','1');
INSERT INTO `v9_collection_history` VALUES('4da7f9ef1999d3f9a2236f851dc6ec3b','1');
INSERT INTO `v9_collection_history` VALUES('4e5413eaa1a6921ddc9573706d214ca1','1');
INSERT INTO `v9_collection_history` VALUES('4e56d84529bb998a6fc2385f09d37102','1');
INSERT INTO `v9_collection_history` VALUES('4e6ec8150fae3815b56f8c040413dabf','1');
INSERT INTO `v9_collection_history` VALUES('4e718d8568209b1e75eefd7276a32fa9','1');
INSERT INTO `v9_collection_history` VALUES('4e72c6f376122c9311a4e67d522ae831','1');
INSERT INTO `v9_collection_history` VALUES('4ef5a381b96fc983394a5471c4250a24','1');
INSERT INTO `v9_collection_history` VALUES('4ff7dacb30b84f874a6b214c02bcca22','1');
INSERT INTO `v9_collection_history` VALUES('5005f9979969b56393933589e2b04917','1');
INSERT INTO `v9_collection_history` VALUES('50ff70d7731cd30976c71bdf2f7da26c','1');
INSERT INTO `v9_collection_history` VALUES('510921c9dc8de999d6a812907c063972','1');
INSERT INTO `v9_collection_history` VALUES('51e0a9711eedd9fdbb926074101b4660','1');
INSERT INTO `v9_collection_history` VALUES('52c0c02fce255360629e732986e16f98','1');
INSERT INTO `v9_collection_history` VALUES('53659a55909c54b8e43e7c2125d6a5e4','1');
INSERT INTO `v9_collection_history` VALUES('54015f418cf12f5830cc41421605ae40','1');
INSERT INTO `v9_collection_history` VALUES('540c11780e6c037eff0f7d487591daab','1');
INSERT INTO `v9_collection_history` VALUES('543cad6ce0bda78e800eb4cc912bf822','1');
INSERT INTO `v9_collection_history` VALUES('54b05fb2668951ae9413fdceed76a0fe','1');
INSERT INTO `v9_collection_history` VALUES('54e61e0321837ae63d386d41e4ec4acf','1');
INSERT INTO `v9_collection_history` VALUES('558eb7455412ecf5a1011023d8da410f','1');
INSERT INTO `v9_collection_history` VALUES('55dcc259fa4e003983fbbd309369c335','1');
INSERT INTO `v9_collection_history` VALUES('55e747cf0f6fe8d3d53f32d5541aa15e','1');
INSERT INTO `v9_collection_history` VALUES('56899491367ac725b43cb4dcc1a227ec','1');
INSERT INTO `v9_collection_history` VALUES('56ac4085827bcd571911a5fe5e91ff6d','1');
INSERT INTO `v9_collection_history` VALUES('5a1575f8f6b904963761988dfb7db8b2','1');
INSERT INTO `v9_collection_history` VALUES('5a325ddcdae22b412368e4d44fc0fafe','1');
INSERT INTO `v9_collection_history` VALUES('5ab7f145b19ba82e3a556b7084209cf4','1');
INSERT INTO `v9_collection_history` VALUES('5c4b475ef89c26cf6a2bff7d9661a667','1');
INSERT INTO `v9_collection_history` VALUES('5d4b7242e13991fb71b0e50e26f284fb','1');
INSERT INTO `v9_collection_history` VALUES('5dcc1de0595c267f04242c933b68a162','1');
INSERT INTO `v9_collection_history` VALUES('5e52fd218335556c09a86a56008b2465','1');
INSERT INTO `v9_collection_history` VALUES('5e7da7cd948a3e2516b7dd5c5c544e13','1');
INSERT INTO `v9_collection_history` VALUES('5e9d89b3c9d2602abd8bab2250f15263','1');
INSERT INTO `v9_collection_history` VALUES('5fad3e1ac7409793fe582c9bea67104d','1');
INSERT INTO `v9_collection_history` VALUES('5ff40b563579d9979d12daf20fe0c2e3','1');
INSERT INTO `v9_collection_history` VALUES('60b356ceea7048f8599b4dd4007f8fca','1');
INSERT INTO `v9_collection_history` VALUES('6142509c652b1fbf7a0628b470d5cf46','1');
INSERT INTO `v9_collection_history` VALUES('621140347e9ee52605c7bf9562271467','1');
INSERT INTO `v9_collection_history` VALUES('623b9922b8a71e506381608820e2bfb9','1');
INSERT INTO `v9_collection_history` VALUES('62b373e894ae6af4b137bd40b5579877','1');
INSERT INTO `v9_collection_history` VALUES('62bdc10686f442a18a0b917870011400','1');
INSERT INTO `v9_collection_history` VALUES('63187c3596a7857baf7d9b6beb6ce2f9','1');
INSERT INTO `v9_collection_history` VALUES('632b24f2bbc509ff4c974afa08c0b024','1');
INSERT INTO `v9_collection_history` VALUES('633e4977a11d805e56f6b6d834a77d0c','1');
INSERT INTO `v9_collection_history` VALUES('646f3d8dd928ea3abe3de2b00bb6d05c','1');
INSERT INTO `v9_collection_history` VALUES('6572c0316e8cff8c86c8d44244a03761','1');
INSERT INTO `v9_collection_history` VALUES('66a6c29211ae60299106119c3da7a1c1','1');
INSERT INTO `v9_collection_history` VALUES('671e1cdcc80185f3e9bd894e56f1c7a9','1');
INSERT INTO `v9_collection_history` VALUES('675bfabd754b3333b55097b0310e3d44','1');
INSERT INTO `v9_collection_history` VALUES('683405f33254a2862184b4f831f95628','1');
INSERT INTO `v9_collection_history` VALUES('68fad1866c47c9015e2e6a321e290d94','1');
INSERT INTO `v9_collection_history` VALUES('69f33da0e93c3e52ea770543bd40f02a','1');
INSERT INTO `v9_collection_history` VALUES('6a34c2efb8175421f00ef48bb1d85ced','1');
INSERT INTO `v9_collection_history` VALUES('6a5da70d6fa8ff4ca3673801c5cf9402','1');
INSERT INTO `v9_collection_history` VALUES('6b3ece43be289bd70012e510e5515858','1');
INSERT INTO `v9_collection_history` VALUES('6bc5f22efcc1589c9058c9d1fea667af','1');
INSERT INTO `v9_collection_history` VALUES('6c422daf62cab9efd8bf914f90c25c6e','1');
INSERT INTO `v9_collection_history` VALUES('6dcbd826908af0d29b07e5379be913bf','1');
INSERT INTO `v9_collection_history` VALUES('6eefe217fb2e7df584a2b40c9ad5185d','1');
INSERT INTO `v9_collection_history` VALUES('6fb23a669c49dae0c7ad08de5b3c0d67','1');
INSERT INTO `v9_collection_history` VALUES('70c59f29758877641372cb6e38017b81','1');
INSERT INTO `v9_collection_history` VALUES('71c7a8c75197a791c85716aed1c45616','1');
INSERT INTO `v9_collection_history` VALUES('71e0f35fbfa56dd393224131f6960651','1');
INSERT INTO `v9_collection_history` VALUES('720ccebe95f6968db417db673f08aae3','1');
INSERT INTO `v9_collection_history` VALUES('7273ebf1aa56f426a373f3aa89d1387a','1');
INSERT INTO `v9_collection_history` VALUES('7281702cd0b227b494ad4dad3e706668','1');
INSERT INTO `v9_collection_history` VALUES('72a6c0f1216d40f2cbf6e17c1bb04387','1');
INSERT INTO `v9_collection_history` VALUES('73278c0ba8ffae17fbf8ee006f742bfb','1');
INSERT INTO `v9_collection_history` VALUES('733f82a961baa22d83eb729a2eea440b','1');
INSERT INTO `v9_collection_history` VALUES('7368f01df3f556e6cd3fa370ec4090d9','1');
INSERT INTO `v9_collection_history` VALUES('73d1d56448dc4fb75bc4c7bc6e3e7770','1');
INSERT INTO `v9_collection_history` VALUES('7671132d730b7ca0972f44c3bb19aea9','1');
INSERT INTO `v9_collection_history` VALUES('76eeae59241b2b9f5d91317af7f3c70e','1');
INSERT INTO `v9_collection_history` VALUES('785393e4a30cdaea096c422480ee96fb','1');
INSERT INTO `v9_collection_history` VALUES('786fda5bed3744462e6053e07239c136','1');
INSERT INTO `v9_collection_history` VALUES('787d281684ca0c62385f27946b4baf6b','1');
INSERT INTO `v9_collection_history` VALUES('78a82663e6302d9607e70d77ab42a501','1');
INSERT INTO `v9_collection_history` VALUES('7908acdc3ca78227db8ecb53c69b9d47','1');
INSERT INTO `v9_collection_history` VALUES('791d6a606bc2cef07701171e88ce1ab6','1');
INSERT INTO `v9_collection_history` VALUES('79ef98f1862b927e49a1b571aeda1208','1');
INSERT INTO `v9_collection_history` VALUES('7ac151113672feec03d09a6931dbfa33','1');
INSERT INTO `v9_collection_history` VALUES('7c49c752019a6e0388164aca4bd67af5','1');
INSERT INTO `v9_collection_history` VALUES('7dc9dbf2f01a615a3c6b7d4959c5b747','1');
INSERT INTO `v9_collection_history` VALUES('7de209f9a53e24ba27e7816fc641cf38','1');
INSERT INTO `v9_collection_history` VALUES('7e238caba66417f8387382dc8c3e442f','1');
INSERT INTO `v9_collection_history` VALUES('8012be0b484cb9833f7434c084e3b622','1');
INSERT INTO `v9_collection_history` VALUES('816e379b84b638e68bc5771180199ffa','1');
INSERT INTO `v9_collection_history` VALUES('8176a1f4fc1cc6c62a64877b67c7cecd','1');
INSERT INTO `v9_collection_history` VALUES('81a04692bb608aec5a396ea7fa7769a3','1');
INSERT INTO `v9_collection_history` VALUES('8352d6ab9677d761999d8916237cbc06','1');
INSERT INTO `v9_collection_history` VALUES('83797f62b18d854f0ef1da0698b514a3','1');
INSERT INTO `v9_collection_history` VALUES('84dda1751b45789ef8a92dab9d37d5f2','1');
INSERT INTO `v9_collection_history` VALUES('8533c1863912bbc758898849a5a61b03','1');
INSERT INTO `v9_collection_history` VALUES('85650207888374698f3839bd8bfae8c1','1');
INSERT INTO `v9_collection_history` VALUES('861bb695240bfe3a49de9eefb1760dc1','1');
INSERT INTO `v9_collection_history` VALUES('87e0a242e4031ca77e810f2ca8896099','1');
INSERT INTO `v9_collection_history` VALUES('887bc4b66ee3fc073fc150619751ec26','1');
INSERT INTO `v9_collection_history` VALUES('891e91d3620ae6dd9b387a6b11eff633','1');
INSERT INTO `v9_collection_history` VALUES('8a1942c744267bf4ce6a0f9038c35610','1');
INSERT INTO `v9_collection_history` VALUES('8ac2f98370cdcbafb11709f3e3de5e6e','1');
INSERT INTO `v9_collection_history` VALUES('8ae32457399d6631e0f9f09d129cbb8f','1');
INSERT INTO `v9_collection_history` VALUES('8b68fdba57884c154325e3f682694436','1');
INSERT INTO `v9_collection_history` VALUES('8bacba9b41194545b4bcfd89963c9f37','1');
INSERT INTO `v9_collection_history` VALUES('8c3538b5d7812b28e47cdf31356b4ab8','1');
INSERT INTO `v9_collection_history` VALUES('8c91da3b560f2230a071d56cfc49ae72','1');
INSERT INTO `v9_collection_history` VALUES('8c9790e9e1da701f6e1d1ff8903ee1c8','1');
INSERT INTO `v9_collection_history` VALUES('8c98d116945ab3d4a6948efaeb291097','1');
INSERT INTO `v9_collection_history` VALUES('8c9dd391ccb4596d4b091f7790908eb3','1');
INSERT INTO `v9_collection_history` VALUES('8ca43d67dd98763f8c0b8a1d75b50a9d','1');
INSERT INTO `v9_collection_history` VALUES('8eda8a0da06b6c26cd61c16d787d94f1','1');
INSERT INTO `v9_collection_history` VALUES('8f35226ca555e7ff0770d9aed4e24288','1');
INSERT INTO `v9_collection_history` VALUES('8f673584d12d014d7d311d43b9393d19','1');
INSERT INTO `v9_collection_history` VALUES('8fa71ff74280ada6bb2f3233c7f58b5f','1');
INSERT INTO `v9_collection_history` VALUES('8fe09167014081cff2a2eb86370f4247','1');
INSERT INTO `v9_collection_history` VALUES('9105589b59ebceb166ce483b9db95ba1','1');
INSERT INTO `v9_collection_history` VALUES('9189610774f0e989c4f07417adcda08a','1');
INSERT INTO `v9_collection_history` VALUES('91ac5f7c4a26b1d6d1e388d92195c54c','1');
INSERT INTO `v9_collection_history` VALUES('920810489fddc8fd5c62a73e2c4cd2bc','1');
INSERT INTO `v9_collection_history` VALUES('922bed108ac197644fb1bbdb91fe49a6','1');
INSERT INTO `v9_collection_history` VALUES('926fe537fe0514ba12fa9f676d1615c6','1');
INSERT INTO `v9_collection_history` VALUES('92c62768fa8a6815fae13dcd18d40e70','1');
INSERT INTO `v9_collection_history` VALUES('92da83b761eab662558659f7daec4871','1');
INSERT INTO `v9_collection_history` VALUES('92df58bc80baf8fa5cec48e7328b9fa2','1');
INSERT INTO `v9_collection_history` VALUES('945e882fd85b67306310bc8f28ae4291','1');
INSERT INTO `v9_collection_history` VALUES('95847cd68d053420ac231fac3fa885ad','1');
INSERT INTO `v9_collection_history` VALUES('9630ee04a6606851f23cca716e148641','1');
INSERT INTO `v9_collection_history` VALUES('972b3ec362a3346dc793ded8d5c06db4','1');
INSERT INTO `v9_collection_history` VALUES('977165494acc8158545cb60366597807','1');
INSERT INTO `v9_collection_history` VALUES('979c716158c4cd876f92ab0117d923a3','1');
INSERT INTO `v9_collection_history` VALUES('97c8694b8d78c5ffb2e5c3374b2e171a','1');
INSERT INTO `v9_collection_history` VALUES('980005fdd59499df2b33366979827e0b','1');
INSERT INTO `v9_collection_history` VALUES('99553ef723dcc6bd0fd746a71463db1c','1');
INSERT INTO `v9_collection_history` VALUES('9970d72fb6e37c0c8d77097dcab41600','1');
INSERT INTO `v9_collection_history` VALUES('9a4ac45ae48f2a7dd3e5897e954fb787','1');
INSERT INTO `v9_collection_history` VALUES('9b76b97ba12d5552751c55f5078f5cce','1');
INSERT INTO `v9_collection_history` VALUES('9bbd6143115ef0fcf5b0abe13a5c6410','1');
INSERT INTO `v9_collection_history` VALUES('9bfe7eb5c20a6bb34c21a763264944ec','1');
INSERT INTO `v9_collection_history` VALUES('9c672c56e379c10eadbbae36aef29d97','1');
INSERT INTO `v9_collection_history` VALUES('9cc35e08dd4d827755f6d8028cd11d5a','1');
INSERT INTO `v9_collection_history` VALUES('9d079b6d1919ae7d30e0148a155fedfa','1');
INSERT INTO `v9_collection_history` VALUES('9f025d9d5dfb301e63db970f0bec355a','1');
INSERT INTO `v9_collection_history` VALUES('9f768dd1a357f6e8aed45d7178215f22','1');
INSERT INTO `v9_collection_history` VALUES('a035e9e26bc4ebee25a98edde2670cdf','1');
INSERT INTO `v9_collection_history` VALUES('a15cb869ca918bf768addba85ca5f7f7','1');
INSERT INTO `v9_collection_history` VALUES('a253ec4b5c3a85f0de7f67d2be7f600b','1');
INSERT INTO `v9_collection_history` VALUES('a2dd63413c3788849f5e8b208bfcc470','1');
INSERT INTO `v9_collection_history` VALUES('a3e428601abaa1dda869f6fe76a4a407','1');
INSERT INTO `v9_collection_history` VALUES('a4ba878d544b7431ad36afc7444706a4','1');
INSERT INTO `v9_collection_history` VALUES('a6094b5528c6ce0f460b1468620c384c','1');
INSERT INTO `v9_collection_history` VALUES('a61579474c986d54a33f0720b7c7a31b','1');
INSERT INTO `v9_collection_history` VALUES('a63acbe21afe579ceb1a28c1e6ae7f48','1');
INSERT INTO `v9_collection_history` VALUES('a75a58a79f55c30926f96cb7fa94719c','1');
INSERT INTO `v9_collection_history` VALUES('a85143acb7e99854cf254351fbc6107f','1');
INSERT INTO `v9_collection_history` VALUES('a8ae499a2eecd419957d18ae42b3b548','1');
INSERT INTO `v9_collection_history` VALUES('a9cf2e163a9648682cae9126335fd1ae','1');
INSERT INTO `v9_collection_history` VALUES('a9f88df2d4c8c272c96f949d0eaa1158','1');
INSERT INTO `v9_collection_history` VALUES('aae46813b5f521240c50db4ccde97a6b','1');
INSERT INTO `v9_collection_history` VALUES('ab4353abf1e197406954dacf3049199a','1');
INSERT INTO `v9_collection_history` VALUES('ac79b04eefc77160edefd733680643c5','1');
INSERT INTO `v9_collection_history` VALUES('ad41346c170a105b4daba8ca68409c00','1');
INSERT INTO `v9_collection_history` VALUES('ae356facc891ddfcb811d14ba529e971','1');
INSERT INTO `v9_collection_history` VALUES('afac65691427495a2a8eaa083a80f6c3','1');
INSERT INTO `v9_collection_history` VALUES('afbc7c64d49f844ec394fa70d8fc526f','1');
INSERT INTO `v9_collection_history` VALUES('b23b12597303719b7fc748ab63f7717b','1');
INSERT INTO `v9_collection_history` VALUES('b307e867689c26164cb760d78c5d23a3','1');
INSERT INTO `v9_collection_history` VALUES('b310cbfa9428041afa186d619d9e4c21','1');
INSERT INTO `v9_collection_history` VALUES('b310f8adb6abeb109941e7af8148fa1d','1');
INSERT INTO `v9_collection_history` VALUES('b4674bb2956e403b00fef68fde83c661','1');
INSERT INTO `v9_collection_history` VALUES('b4bb5039a6b6c08993dd0119bbb0ec46','1');
INSERT INTO `v9_collection_history` VALUES('b51849cce34c72d5715d45c15bb7114d','1');
INSERT INTO `v9_collection_history` VALUES('b68f888bc2d59e83cdc728b8af571e55','1');
INSERT INTO `v9_collection_history` VALUES('b69e255b520be267d315c626877de3db','1');
INSERT INTO `v9_collection_history` VALUES('b70ad76a3c8dff5c7818e3eb3385b8c1','1');
INSERT INTO `v9_collection_history` VALUES('b70f6260d3e87a94e37e5d91b835d44b','1');
INSERT INTO `v9_collection_history` VALUES('b81d5dd0355f494ce77061bc57016756','1');
INSERT INTO `v9_collection_history` VALUES('b8d8953b80850eaaee9b226ef533c70e','1');
INSERT INTO `v9_collection_history` VALUES('b90f24ac34feeffac206635ed14714fd','1');
INSERT INTO `v9_collection_history` VALUES('b96e6d3b40a45af0af144be49dd5e72a','1');
INSERT INTO `v9_collection_history` VALUES('badb2b3e5baa0c6eb46abde6a6939bd8','1');
INSERT INTO `v9_collection_history` VALUES('baf9042d640f257abca064007e964cbb','1');
INSERT INTO `v9_collection_history` VALUES('bb21c36c1f1f17345bd940c3ac43e978','1');
INSERT INTO `v9_collection_history` VALUES('bbd322c146a0f7f19f8e753747e026e6','1');
INSERT INTO `v9_collection_history` VALUES('bc3cca1df0ac808c3c3dade062da2f2f','1');
INSERT INTO `v9_collection_history` VALUES('bd96267c13feed4b8475dfc7d850ad54','1');
INSERT INTO `v9_collection_history` VALUES('be05555437a07731657fdfd32d0b3e3c','1');
INSERT INTO `v9_collection_history` VALUES('be44f681218a0330ff5931c8ea82dc41','1');
INSERT INTO `v9_collection_history` VALUES('bee274458b6c61b1bca45aad764b4f97','1');
INSERT INTO `v9_collection_history` VALUES('bf2a2aa4048301d6beee70e6adfe0656','1');
INSERT INTO `v9_collection_history` VALUES('bf9f15062a5c120d98af01242144e38f','1');
INSERT INTO `v9_collection_history` VALUES('bfb7b1a4ebbcb37b05c61bb320528a9e','1');
INSERT INTO `v9_collection_history` VALUES('bfc82d0ca4d6ffedc462029e4d0d806f','1');
INSERT INTO `v9_collection_history` VALUES('c020a6c67297aa9d237aa8ac2daeefd2','1');
INSERT INTO `v9_collection_history` VALUES('c05e87aeabe17b0c3bfde1234f141647','1');
INSERT INTO `v9_collection_history` VALUES('c2677bc3f6dd581fa0fcd9f11f41c520','1');
INSERT INTO `v9_collection_history` VALUES('c26eb71e09235cada0fa90cf74a3745a','1');
INSERT INTO `v9_collection_history` VALUES('c2a24210320884e395fe29a66db56fa4','1');
INSERT INTO `v9_collection_history` VALUES('c32c29380daff8beb6af975d95d89979','1');
INSERT INTO `v9_collection_history` VALUES('c3db4f788dc4026458a671d58dcd374a','1');
INSERT INTO `v9_collection_history` VALUES('c3de0a2b736db43de9148833ec50960e','1');
INSERT INTO `v9_collection_history` VALUES('c43ecf7905f0255de6214cba2c60a87d','1');
INSERT INTO `v9_collection_history` VALUES('c4cd88bce7bb4e184449269f125b3da6','1');
INSERT INTO `v9_collection_history` VALUES('c51cc3ffba3e8b7f9e1ebad646f6821d','1');
INSERT INTO `v9_collection_history` VALUES('c5ef514cd61bda48e48e676a428b7ed4','1');
INSERT INTO `v9_collection_history` VALUES('c6193460a7c8043a8bf866d4b4830701','1');
INSERT INTO `v9_collection_history` VALUES('c6769d8a5959b8999ceaf65bd6b0f90e','1');
INSERT INTO `v9_collection_history` VALUES('c7f75a02e20f63b464e90b62d508738b','1');
INSERT INTO `v9_collection_history` VALUES('c8d201765d8310dd69994d94195d1966','1');
INSERT INTO `v9_collection_history` VALUES('c8d230586840b436e279fa26b44894fb','1');
INSERT INTO `v9_collection_history` VALUES('ca04a56403191b7309a586c15cf26ea7','1');
INSERT INTO `v9_collection_history` VALUES('cbb988a715fd84780cb68f57ddd378e9','1');
INSERT INTO `v9_collection_history` VALUES('cbd9e37cd69e7452d36f46bd1f799844','1');
INSERT INTO `v9_collection_history` VALUES('ccbf9d2327e8ecea58bd77885c7bacd2','1');
INSERT INTO `v9_collection_history` VALUES('ccf54e458f6e1ce8aed0f7711f30c7eb','1');
INSERT INTO `v9_collection_history` VALUES('cebc817a9325adbc3f2ae8a6aeca3f45','1');
INSERT INTO `v9_collection_history` VALUES('cfd0b4a72188d12d807c2606147d3d40','1');
INSERT INTO `v9_collection_history` VALUES('d0965776cf6c2844540b7997aa7b612a','1');
INSERT INTO `v9_collection_history` VALUES('d0ebe5d99afabb95e2e14ffa3ac70c02','1');
INSERT INTO `v9_collection_history` VALUES('d0ec8548c90253424bf395ac91b219dd','1');
INSERT INTO `v9_collection_history` VALUES('d228bc8c59f68a643dbdaf4367791b60','1');
INSERT INTO `v9_collection_history` VALUES('d3a1c6ca84ea519604948da864425bba','1');
INSERT INTO `v9_collection_history` VALUES('d5300e1df0bad30828919e61b559228b','1');
INSERT INTO `v9_collection_history` VALUES('d60b7e837d2ee104a055080f6ae6adbd','1');
INSERT INTO `v9_collection_history` VALUES('d6788e68de8e4a24a0acb25a32ab4f44','1');
INSERT INTO `v9_collection_history` VALUES('d679e6b4c6b96a062d45e3b30ca14e6d','1');
INSERT INTO `v9_collection_history` VALUES('d82c26eee94418ede6d34247197603e8','1');
INSERT INTO `v9_collection_history` VALUES('d961a08473a707b09f24902f2df674d6','1');
INSERT INTO `v9_collection_history` VALUES('d96ec99548ff01cdbe0d03e355f0871f','1');
INSERT INTO `v9_collection_history` VALUES('da043df341cd876fe889f8dcf83dd4e3','1');
INSERT INTO `v9_collection_history` VALUES('db3e567f85c51a9027683c6573b927e1','1');
INSERT INTO `v9_collection_history` VALUES('db449eac43eb61e1339781fd76c7a2e8','1');
INSERT INTO `v9_collection_history` VALUES('dbc5db9dd08ad2b00ec815b6265f78e5','1');
INSERT INTO `v9_collection_history` VALUES('dce5df476f45c9b7b1347078ef6e2ca8','1');
INSERT INTO `v9_collection_history` VALUES('dd3e3cf8bbd4d708107c454096d9bb32','1');
INSERT INTO `v9_collection_history` VALUES('de72e5620a630c16477a2cb3783c930c','1');
INSERT INTO `v9_collection_history` VALUES('e03bb8acd125b2fb78521d3bd792745a','1');
INSERT INTO `v9_collection_history` VALUES('e17ae05a0dc9b9638d2b98197e78a7ce','1');
INSERT INTO `v9_collection_history` VALUES('e1c39f1a0b35ea1044ff5c59ebfde1ac','1');
INSERT INTO `v9_collection_history` VALUES('e2f2df003697b3112fb5a08a68cc3e0e','1');
INSERT INTO `v9_collection_history` VALUES('e3c68f78150b730de30df93335fcd5a9','1');
INSERT INTO `v9_collection_history` VALUES('e3d595f3cf1a5c522de7779882888db0','1');
INSERT INTO `v9_collection_history` VALUES('e4039edafebb8b140b16a771586b1d69','1');
INSERT INTO `v9_collection_history` VALUES('e4691faec3374176e47813b9a7d4dd8d','1');
INSERT INTO `v9_collection_history` VALUES('e46c08ae41266457b1a8a2463668a2f3','1');
INSERT INTO `v9_collection_history` VALUES('e4db8d88808e238aa9d78bbc29cb95f4','1');
INSERT INTO `v9_collection_history` VALUES('e5277af6561e8bc6c8e34a5d9bd2102d','1');
INSERT INTO `v9_collection_history` VALUES('e5845213d6a9cb9d0cd57f16d852dde0','1');
INSERT INTO `v9_collection_history` VALUES('e5ae33b3467fe4dbb9a3b43b2470328b','1');
INSERT INTO `v9_collection_history` VALUES('e5cf160a4553e87e16225b90df0907ca','1');
INSERT INTO `v9_collection_history` VALUES('e683b12b49b989c9d087be1907065a4b','1');
INSERT INTO `v9_collection_history` VALUES('e7a0fd78e9e5e77d6ce1f417b47c713e','1');
INSERT INTO `v9_collection_history` VALUES('e9f0edad7911233076476f1ef951384b','1');
INSERT INTO `v9_collection_history` VALUES('e9f3a9aad1e51fef436129fc8d9c6860','1');
INSERT INTO `v9_collection_history` VALUES('eb8a69d466d0b4b5a6899a755b8ce195','1');
INSERT INTO `v9_collection_history` VALUES('ec306de867c89469a61eb01ff41da3a4','1');
INSERT INTO `v9_collection_history` VALUES('ec9a6d80d800681b501d1d37cdd8160f','1');
INSERT INTO `v9_collection_history` VALUES('ed175dffc6650964a67a84263a7ae713','1');
INSERT INTO `v9_collection_history` VALUES('ed5faa29d211cb35809391849528160c','1');
INSERT INTO `v9_collection_history` VALUES('eddaef6d5574b46958edc317bf500e87','1');
INSERT INTO `v9_collection_history` VALUES('ede9a370bab30014fe6395d96b4201aa','1');
INSERT INTO `v9_collection_history` VALUES('ee1afbd4a5e889fcc27509e4992d67e2','1');
INSERT INTO `v9_collection_history` VALUES('ef9c55bce2c8245ac3edff8db39eff00','1');
INSERT INTO `v9_collection_history` VALUES('efca85f1bd179e28fa1814a1e41bb9e9','1');
INSERT INTO `v9_collection_history` VALUES('effff982ab0c992185d4ec703a387087','1');
INSERT INTO `v9_collection_history` VALUES('f09c6a0ddce9ac52a30c20bad4378373','1');
INSERT INTO `v9_collection_history` VALUES('f17c1f0dced02a4622873a7448525477','1');
INSERT INTO `v9_collection_history` VALUES('f1bfd11a4e77a53b4c318a361e0c424e','1');
INSERT INTO `v9_collection_history` VALUES('f1df4a44030ed28a7234eb40d17b103f','1');
INSERT INTO `v9_collection_history` VALUES('f1f0b3b24945f690ed44dcb051e7ead8','1');
INSERT INTO `v9_collection_history` VALUES('f2bb4108e3c45b79d4a7e5d856abddbc','1');
INSERT INTO `v9_collection_history` VALUES('f2d6eec98d8aad69bf9427c4526bbb77','1');
INSERT INTO `v9_collection_history` VALUES('f2eda4df22c87f25391e4bc978069f3f','1');
INSERT INTO `v9_collection_history` VALUES('f32c01cea294610cc0d388b6f66c54e4','1');
INSERT INTO `v9_collection_history` VALUES('f3d2326d03af38e48dfdeed475ccecc7','1');
INSERT INTO `v9_collection_history` VALUES('f45a8acb523b923525fc6d5dc8ad96fc','1');
INSERT INTO `v9_collection_history` VALUES('f4cce80244ddb6099e7818733509e1db','1');
INSERT INTO `v9_collection_history` VALUES('f52cae8a9849f41b2d23783e1dbd1806','1');
INSERT INTO `v9_collection_history` VALUES('f54242632944f4e57741cbeac5766f52','1');
INSERT INTO `v9_collection_history` VALUES('f5ac73cfea52f0cdd52f8d18492d39c0','1');
INSERT INTO `v9_collection_history` VALUES('f5cfb6ed125b15f657b095d2345f37f4','1');
INSERT INTO `v9_collection_history` VALUES('f63748dbc008fb0bd72acba4c6f5e658','1');
INSERT INTO `v9_collection_history` VALUES('f6d070cca11ea86f0a0319cce8c0aaa4','1');
INSERT INTO `v9_collection_history` VALUES('f749a38e585f12ff09011363a766a7a2','1');
INSERT INTO `v9_collection_history` VALUES('f75936672820fd88b931108d94dd0bd8','1');
INSERT INTO `v9_collection_history` VALUES('f764b6d145e33bbed284b8046acb164c','1');
INSERT INTO `v9_collection_history` VALUES('f80fb0d527e655f13a660e36612a046e','1');
INSERT INTO `v9_collection_history` VALUES('f99a43fc5e0edc812c95fb0c7e52af1b','1');
INSERT INTO `v9_collection_history` VALUES('fad10c86ba09a0127ff56856b0f65943','1');
INSERT INTO `v9_collection_history` VALUES('fb8a05242a836f95edefacf1ea9f98a7','1');
INSERT INTO `v9_collection_history` VALUES('fc65b2b93f35be77a02c12e3d98134f8','1');
INSERT INTO `v9_collection_history` VALUES('fc731491ac4326f9f35894bd32beaf0d','1');
INSERT INTO `v9_collection_history` VALUES('fce4bb03c6030e2c94510ffa457159e7','1');
INSERT INTO `v9_collection_history` VALUES('fd28d6f6406e0ccfaf83b305683ba375','1');
INSERT INTO `v9_collection_history` VALUES('fdb172f22fd51f613d9b505cc3f2948b','1');
INSERT INTO `v9_collection_history` VALUES('fde2a9c1f5a3dd4d718b8211fa91b9aa','1');
INSERT INTO `v9_collection_history` VALUES('ffc63c67b484c94a6187be8e829eb80f','1');
INSERT INTO `v9_collection_history` VALUES('fffa6689bf279f8e756f4fc3e2ae9788','1');

DROP TABLE IF EXISTS `v9_collection_node`;
CREATE TABLE `v9_collection_node` (
  `nodeid` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `lastdate` int(10) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `sourcecharset` varchar(8) NOT NULL,
  `sourcetype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `urlpage` text NOT NULL,
  `pagesize_start` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pagesize_end` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `page_base` char(255) NOT NULL,
  `par_num` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `url_contain` char(100) NOT NULL,
  `url_except` char(100) NOT NULL,
  `url_start` char(100) NOT NULL DEFAULT '',
  `url_end` char(100) NOT NULL DEFAULT '',
  `title_rule` char(100) NOT NULL,
  `title_html_rule` text NOT NULL,
  `author_rule` char(100) NOT NULL,
  `author_html_rule` text NOT NULL,
  `comeform_rule` char(100) NOT NULL,
  `comeform_html_rule` text NOT NULL,
  `time_rule` char(100) NOT NULL,
  `time_html_rule` text NOT NULL,
  `content_rule` char(100) NOT NULL,
  `content_html_rule` text NOT NULL,
  `content_page_start` char(100) NOT NULL,
  `content_page_end` char(100) NOT NULL,
  `content_page_rule` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `content_page` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `content_nextpage` char(100) NOT NULL,
  `down_attachment` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `watermark` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `coll_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `customize_config` text NOT NULL,
  PRIMARY KEY (`nodeid`),
  KEY `siteid` (`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `v9_collection_node` VALUES('3','test','1519273052','1','gbk','1','http://shizheng.xilu.com/xlyw/index_(*).html','2','6','','1','.html','.jpg','<div class=\"newslist_box\">','<div class=\"pagebox\">','<h1>[内容]</h1>','','<div style=\"width:95px;\" class=\"left\">作者：[内容]</div>','','<div style=\"width:120px;\" class=\"left\">新闻出处：[内容]</div>','','作者：</div> <div style=\"width:120px;\" class=\"left\">[内容]</div>\r\n','','src=\"http://1.xilu.com/xskbhbbouvz.js \"></script></div>[内容]<!-- 124035：1内容页三通（分页符上） 类型：固定广告位 尺寸：615x','<script([^>]*)>(.*)</script>[|]\r\n<iframe([^>]*)>(.*)</iframe>[|]\r\n<object([^>]*)>(.*)</object>[|]\r\n<param([^>]*)>(.*)</param>[|]\r\n<!--([^>]*)-->[|]\r\n','','','1','1','','0','0','1','');

DROP TABLE IF EXISTS `v9_collection_program`;
CREATE TABLE `v9_collection_program` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `nodeid` int(10) unsigned NOT NULL DEFAULT '0',
  `modelid` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `config` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `siteid` (`siteid`),
  KEY `nodeid` (`nodeid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_comment`;
CREATE TABLE `v9_comment` (
  `commentid` char(30) NOT NULL,
  `siteid` smallint(5) NOT NULL DEFAULT '0',
  `title` char(255) NOT NULL,
  `url` char(255) NOT NULL,
  `total` int(8) unsigned DEFAULT '0',
  `square` mediumint(8) unsigned DEFAULT '0',
  `anti` mediumint(8) unsigned DEFAULT '0',
  `neutral` mediumint(8) unsigned DEFAULT '0',
  `display_type` tinyint(1) DEFAULT '0',
  `tableid` mediumint(8) unsigned DEFAULT '0',
  `lastupdate` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`commentid`),
  KEY `lastupdate` (`lastupdate`),
  KEY `siteid` (`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_comment_check`;
CREATE TABLE `v9_comment_check` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `comment_data_id` int(10) DEFAULT '0' COMMENT '论评ID号',
  `siteid` smallint(5) NOT NULL DEFAULT '0' COMMENT '站点ID',
  `tableid` mediumint(8) DEFAULT '0' COMMENT '数据存储表ID',
  PRIMARY KEY (`id`),
  KEY `siteid` (`siteid`),
  KEY `comment_data_id` (`comment_data_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_comment_data_1`;
CREATE TABLE `v9_comment_data_1` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `commentid` char(30) NOT NULL DEFAULT '' COMMENT '评论ID号',
  `siteid` smallint(5) NOT NULL DEFAULT '0' COMMENT '站点ID',
  `userid` int(10) unsigned DEFAULT '0' COMMENT '用户ID',
  `username` varchar(20) DEFAULT NULL COMMENT '用户名',
  `creat_at` int(10) DEFAULT NULL COMMENT '发布时间',
  `ip` varchar(15) DEFAULT NULL COMMENT '用户IP地址',
  `status` tinyint(1) DEFAULT '0' COMMENT '评论状态{0:未审核,-1:未通过审核,1:通过审核}',
  `content` text COMMENT '评论内容',
  `direction` tinyint(1) DEFAULT '0' COMMENT '评论方向{0:无方向,1:正文,2:反方,3:中立}',
  `support` mediumint(8) unsigned DEFAULT '0' COMMENT '支持数',
  `reply` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为回复',
  PRIMARY KEY (`id`),
  KEY `commentid` (`commentid`),
  KEY `direction` (`direction`),
  KEY `siteid` (`siteid`),
  KEY `support` (`support`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_comment_setting`;
CREATE TABLE `v9_comment_setting` (
  `siteid` smallint(5) NOT NULL DEFAULT '0' COMMENT '站点ID',
  `guest` tinyint(1) DEFAULT '0' COMMENT '是否允许游客评论',
  `check` tinyint(1) DEFAULT '0' COMMENT '是否需要审核',
  `code` tinyint(1) DEFAULT '0' COMMENT '是否开启验证码',
  `add_point` tinyint(3) unsigned DEFAULT '0' COMMENT '添加的积分数',
  `del_point` tinyint(3) unsigned DEFAULT '0' COMMENT '扣除的积分数',
  PRIMARY KEY (`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_comment_setting` VALUES('1','0','0','0','0','0');

DROP TABLE IF EXISTS `v9_comment_table`;
CREATE TABLE `v9_comment_table` (
  `tableid` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '表ID号',
  `total` int(10) unsigned DEFAULT '0' COMMENT '数据总量',
  `creat_at` int(10) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`tableid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `v9_comment_table` VALUES('1','0','0');

DROP TABLE IF EXISTS `v9_content_check`;
CREATE TABLE `v9_content_check` (
  `checkid` char(15) NOT NULL,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `title` char(80) NOT NULL,
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `username` (`username`),
  KEY `checkid` (`checkid`),
  KEY `status` (`status`,`inputtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_copyfrom`;
CREATE TABLE `v9_copyfrom` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `sitename` varchar(30) NOT NULL,
  `siteurl` varchar(100) NOT NULL,
  `thumb` varchar(100) NOT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_datacall`;
CREATE TABLE `v9_datacall` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` char(40) DEFAULT NULL,
  `dis_type` tinyint(1) unsigned DEFAULT '0',
  `type` tinyint(1) DEFAULT '0',
  `module` char(20) DEFAULT NULL,
  `action` char(20) DEFAULT NULL,
  `data` text,
  `template` text,
  `cache` mediumint(8) DEFAULT NULL,
  `num` smallint(6) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_dbsource`;
CREATE TABLE `v9_dbsource` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL,
  `host` varchar(20) NOT NULL,
  `port` int(5) NOT NULL DEFAULT '3306',
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `dbname` varchar(50) NOT NULL,
  `dbtablepre` varchar(30) NOT NULL,
  `charset` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `siteid` (`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_download`;
CREATE TABLE `v9_download` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` char(80) NOT NULL DEFAULT '',
  `style` char(24) NOT NULL DEFAULT '',
  `thumb` varchar(100) NOT NULL DEFAULT '',
  `keywords` char(40) NOT NULL DEFAULT '',
  `description` char(255) NOT NULL DEFAULT '',
  `posids` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(100) NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `sysadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  `systems` varchar(100) NOT NULL DEFAULT 'Win2000/WinXP/Win2003',
  `copytype` varchar(15) NOT NULL DEFAULT '',
  `language` varchar(10) NOT NULL DEFAULT '',
  `classtype` varchar(20) NOT NULL DEFAULT '',
  `version` varchar(20) NOT NULL DEFAULT '',
  `filesize` varchar(10) NOT NULL DEFAULT 'Unkown',
  `stars` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_download_data`;
CREATE TABLE `v9_download_data` (
  `id` mediumint(8) unsigned DEFAULT '0',
  `content` text NOT NULL,
  `readpoint` smallint(5) unsigned NOT NULL DEFAULT '0',
  `groupids_view` varchar(100) NOT NULL,
  `paginationtype` tinyint(1) NOT NULL,
  `maxcharperpage` mediumint(6) NOT NULL,
  `template` varchar(30) NOT NULL,
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `relation` varchar(255) NOT NULL DEFAULT '',
  `allow_comment` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `downfiles` mediumtext NOT NULL,
  `downfile` varchar(255) NOT NULL DEFAULT '',
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_downservers`;
CREATE TABLE `v9_downservers` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `sitename` varchar(100) DEFAULT NULL,
  `siteurl` varchar(255) DEFAULT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_extend_setting`;
CREATE TABLE `v9_extend_setting` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `key` char(30) NOT NULL,
  `data` mediumtext,
  PRIMARY KEY (`id`),
  KEY `key` (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_favorite`;
CREATE TABLE `v9_favorite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `title` char(100) NOT NULL,
  `url` char(100) NOT NULL,
  `adddate` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_hits`;
CREATE TABLE `v9_hits` (
  `hitsid` char(30) NOT NULL,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `yesterdayviews` int(10) unsigned NOT NULL DEFAULT '0',
  `dayviews` int(10) unsigned NOT NULL DEFAULT '0',
  `weekviews` int(10) unsigned NOT NULL DEFAULT '0',
  `monthviews` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`hitsid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_hits` VALUES('c-1-1','6','0','0','0','0','0','1517660021');
INSERT INTO `v9_hits` VALUES('c-1-2','6','0','0','0','0','0','1517660042');
INSERT INTO `v9_hits` VALUES('c-1-3','9','0','0','0','0','0','1517662874');
INSERT INTO `v9_hits` VALUES('c-1-4','9','1','0','1','1','1','1517662998');
INSERT INTO `v9_hits` VALUES('c-1-5','10','0','0','0','0','0','1517717008');
INSERT INTO `v9_hits` VALUES('c-1-6','10','0','0','0','0','0','1517717019');
INSERT INTO `v9_hits` VALUES('c-3-7','8','0','0','0','0','0','1517832553');
INSERT INTO `v9_hits` VALUES('c-3-3','8','0','0','0','0','0','1517740399');
INSERT INTO `v9_hits` VALUES('c-3-4','8','0','0','0','0','0','1517740433');
INSERT INTO `v9_hits` VALUES('c-3-5','8','0','0','0','0','0','1517740463');
INSERT INTO `v9_hits` VALUES('c-3-6','8','0','0','0','0','0','1517740484');
INSERT INTO `v9_hits` VALUES('c-12-2','13','0','0','0','0','0','1570353983');

DROP TABLE IF EXISTS `v9_ipbanned`;
CREATE TABLE `v9_ipbanned` (
  `ipbannedid` smallint(5) NOT NULL AUTO_INCREMENT,
  `ip` char(15) NOT NULL,
  `expires` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipbannedid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_keylink`;
CREATE TABLE `v9_keylink` (
  `keylinkid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `word` char(40) NOT NULL,
  `url` char(100) NOT NULL,
  PRIMARY KEY (`keylinkid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_keyword`;
CREATE TABLE `v9_keyword` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `keyword` char(100) NOT NULL,
  `pinyin` char(100) NOT NULL,
  `videonum` int(11) NOT NULL DEFAULT '0',
  `searchnums` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `keyword` (`keyword`,`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

INSERT INTO `v9_keyword` VALUES('1','1','大佛寺','dafosi','1','0');
INSERT INTO `v9_keyword` VALUES('2','1','士大夫','shidafu','1','0');
INSERT INTO `v9_keyword` VALUES('3','1','阿索','asuo','2','0');
INSERT INTO `v9_keyword` VALUES('4','1','difopasjsfa','difopasjsfa','1','0');
INSERT INTO `v9_keyword` VALUES('5','1','sajflajfalsfjsjif','sajflajfalsfjsjif','1','0');
INSERT INTO `v9_keyword` VALUES('6','1','abc','abc','1','0');
INSERT INTO `v9_keyword` VALUES('7','1','bcd','bcd','1','0');
INSERT INTO `v9_keyword` VALUES('8','1','图片','tupian','1','0');
INSERT INTO `v9_keyword` VALUES('9','1','edqiew','edqiew','1','0');
INSERT INTO `v9_keyword` VALUES('10','1','救护车','jiuhuche','6','0');
INSERT INTO `v9_keyword` VALUES('11','1','jsaifdklfjaew','jsaifdklfjaew','1','0');
INSERT INTO `v9_keyword` VALUES('12','1','','','17','0');

DROP TABLE IF EXISTS `v9_keyword_data`;
CREATE TABLE `v9_keyword_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tagid` int(10) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `contentid` char(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tagid` (`tagid`,`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

INSERT INTO `v9_keyword_data` VALUES('1','1','1','1-1');
INSERT INTO `v9_keyword_data` VALUES('2','2','1','1-1');
INSERT INTO `v9_keyword_data` VALUES('3','3','1','2-1');
INSERT INTO `v9_keyword_data` VALUES('4','4','1','3-1');
INSERT INTO `v9_keyword_data` VALUES('5','5','1','4-1');
INSERT INTO `v9_keyword_data` VALUES('6','6','1','5-1');
INSERT INTO `v9_keyword_data` VALUES('7','7','1','6-1');
INSERT INTO `v9_keyword_data` VALUES('8','8','1','1-3');
INSERT INTO `v9_keyword_data` VALUES('9','9','1','2-3');
INSERT INTO `v9_keyword_data` VALUES('10','10','1','3-3');
INSERT INTO `v9_keyword_data` VALUES('11','10','1','4-3');
INSERT INTO `v9_keyword_data` VALUES('12','10','1','5-3');
INSERT INTO `v9_keyword_data` VALUES('13','10','1','6-3');
INSERT INTO `v9_keyword_data` VALUES('14','11','1','7-3');
INSERT INTO `v9_keyword_data` VALUES('15','12','1','1-12');
INSERT INTO `v9_keyword_data` VALUES('16','12','1','2-12');

DROP TABLE IF EXISTS `v9_link`;
CREATE TABLE `v9_link` (
  `linkid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `linktype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `logo` varchar(255) NOT NULL DEFAULT '',
  `introduce` text NOT NULL,
  `username` varchar(30) NOT NULL DEFAULT '',
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `elite` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `passed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`linkid`),
  KEY `typeid` (`typeid`,`passed`,`listorder`,`linkid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `v9_link` VALUES('1','1','0','1','PHPCMS','http://www.phpcms.cn','http://www.phpcms.cn/images/logo_88_31.gif','','','1','1','1','1517124299');
INSERT INTO `v9_link` VALUES('2','1','0','1','盛大在线','http://www.sdo.com','http://www.snda.com/cn/logo/comp_logo_sdo.gif','','','0','0','1','1517124299');

DROP TABLE IF EXISTS `v9_linkage`;
CREATE TABLE `v9_linkage` (
  `linkageid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `style` varchar(35) NOT NULL,
  `parentid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `child` tinyint(1) NOT NULL,
  `arrchildid` mediumtext NOT NULL,
  `keyid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `setting` varchar(255) DEFAULT NULL,
  `siteid` smallint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`linkageid`,`keyid`),
  KEY `parentid` (`parentid`,`listorder`)
) ENGINE=MyISAM AUTO_INCREMENT=3360 DEFAULT CHARSET=utf8;

INSERT INTO `v9_linkage` VALUES('1','中国','1','0','0','','0','0','','','0');
INSERT INTO `v9_linkage` VALUES('2','北京市','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3','上海市','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('4','天津市','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('5','重庆市','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('6','河北省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('7','山西省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('8','内蒙古','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('9','辽宁省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('10','吉林省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('11','黑龙江省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('12','江苏省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('13','浙江省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('14','安徽省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('15','福建省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('16','江西省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('17','山东省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('18','河南省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('19','湖北省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('20','湖南省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('21','广东省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('22','广西','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('23','海南省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('24','四川省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('25','贵州省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('26','云南省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('27','西藏','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('28','陕西省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('29','甘肃省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('30','青海省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('31','宁夏','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('32','新疆','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('33','台湾省','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('34','香港','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('35','澳门','0','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('36','东城区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('37','西城区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('38','崇文区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('39','宣武区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('40','朝阳区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('41','石景山区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('42','海淀区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('43','门头沟区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('44','房山区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('45','通州区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('46','顺义区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('47','昌平区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('48','大兴区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('49','怀柔区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('50','平谷区','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('51','密云县','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('52','延庆县','0','2','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('53','黄浦区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('54','卢湾区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('55','徐汇区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('56','长宁区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('57','静安区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('58','普陀区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('59','闸北区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('60','虹口区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('61','杨浦区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('62','闵行区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('63','宝山区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('64','嘉定区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('65','浦东新区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('66','金山区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('67','松江区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('68','青浦区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('69','南汇区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('70','奉贤区','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('71','崇明县','0','3','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('72','和平区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('73','河东区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('74','河西区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('75','南开区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('76','河北区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('77','红桥区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('78','塘沽区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('79','汉沽区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('80','大港区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('81','东丽区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('82','西青区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('83','津南区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('84','北辰区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('85','武清区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('86','宝坻区','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('87','宁河县','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('88','静海县','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('89','蓟县','0','4','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('90','万州区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('91','涪陵区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('92','渝中区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('93','大渡口区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('94','江北区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('95','沙坪坝区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('96','九龙坡区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('97','南岸区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('98','北碚区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('99','万盛区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('100','双桥区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('101','渝北区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('102','巴南区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('103','黔江区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('104','长寿区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('105','綦江县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('106','潼南县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('107','铜梁县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('108','大足县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('109','荣昌县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('110','璧山县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('111','梁平县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('112','城口县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('113','丰都县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('114','垫江县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('115','武隆县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('116','忠县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('117','开县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('118','云阳县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('119','奉节县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('120','巫山县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('121','巫溪县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('122','石柱县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('123','秀山县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('124','酉阳县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('125','彭水县','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('126','江津区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('127','合川区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('128','永川区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('129','南川区','0','5','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('130','石家庄市','0','6','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('131','唐山市','0','6','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('132','秦皇岛市','0','6','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('133','邯郸市','0','6','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('134','邢台市','0','6','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('135','保定市','0','6','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('136','张家口市','0','6','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('137','承德市','0','6','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('138','沧州市','0','6','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('139','廊坊市','0','6','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('140','衡水市','0','6','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('141','太原市','0','7','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('142','大同市','0','7','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('143','阳泉市','0','7','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('144','长治市','0','7','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('145','晋城市','0','7','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('146','朔州市','0','7','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('147','晋中市','0','7','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('148','运城市','0','7','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('149','忻州市','0','7','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('150','临汾市','0','7','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('151','吕梁市','0','7','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('152','呼和浩特市','0','8','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('153','包头市','0','8','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('154','乌海市','0','8','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('155','赤峰市','0','8','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('156','通辽市','0','8','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('157','鄂尔多斯市','0','8','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('158','呼伦贝尔市','0','8','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('159','巴彦淖尔市','0','8','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('160','乌兰察布市','0','8','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('161','兴安盟','0','8','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('162','锡林郭勒盟','0','8','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('163','阿拉善盟','0','8','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('164','沈阳市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('165','大连市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('166','鞍山市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('167','抚顺市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('168','本溪市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('169','丹东市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('170','锦州市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('171','营口市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('172','阜新市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('173','辽阳市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('174','盘锦市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('175','铁岭市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('176','朝阳市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('177','葫芦岛市','0','9','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('178','长春市','0','10','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('179','吉林市','0','10','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('180','四平市','0','10','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('181','辽源市','0','10','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('182','通化市','0','10','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('183','白山市','0','10','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('184','松原市','0','10','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('185','白城市','0','10','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('186','延边','0','10','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('187','哈尔滨市','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('188','齐齐哈尔市','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('189','鸡西市','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('190','鹤岗市','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('191','双鸭山市','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('192','大庆市','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('193','伊春市','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('194','佳木斯市','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('195','七台河市','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('196','牡丹江市','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('197','黑河市','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('198','绥化市','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('199','大兴安岭地区','0','11','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('200','南京市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('201','无锡市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('202','徐州市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('203','常州市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('204','苏州市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('205','南通市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('206','连云港市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('207','淮安市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('208','盐城市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('209','扬州市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('210','镇江市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('211','泰州市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('212','宿迁市','0','12','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('213','杭州市','0','13','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('214','宁波市','0','13','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('215','温州市','0','13','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('216','嘉兴市','0','13','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('217','湖州市','0','13','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('218','绍兴市','0','13','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('219','金华市','0','13','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('220','衢州市','0','13','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('221','舟山市','0','13','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('222','台州市','0','13','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('223','丽水市','0','13','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('224','合肥市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('225','芜湖市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('226','蚌埠市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('227','淮南市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('228','马鞍山市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('229','淮北市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('230','铜陵市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('231','安庆市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('232','黄山市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('233','滁州市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('234','阜阳市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('235','宿州市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('236','巢湖市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('237','六安市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('238','亳州市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('239','池州市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('240','宣城市','0','14','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('241','福州市','0','15','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('242','厦门市','0','15','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('243','莆田市','0','15','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('244','三明市','0','15','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('245','泉州市','0','15','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('246','漳州市','0','15','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('247','南平市','0','15','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('248','龙岩市','0','15','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('249','宁德市','0','15','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('250','南昌市','0','16','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('251','景德镇市','0','16','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('252','萍乡市','0','16','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('253','九江市','0','16','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('254','新余市','0','16','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('255','鹰潭市','0','16','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('256','赣州市','0','16','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('257','吉安市','0','16','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('258','宜春市','0','16','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('259','抚州市','0','16','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('260','上饶市','0','16','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('261','济南市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('262','青岛市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('263','淄博市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('264','枣庄市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('265','东营市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('266','烟台市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('267','潍坊市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('268','济宁市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('269','泰安市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('270','威海市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('271','日照市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('272','莱芜市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('273','临沂市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('274','德州市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('275','聊城市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('276','滨州市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('277','荷泽市','0','17','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('278','郑州市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('279','开封市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('280','洛阳市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('281','平顶山市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('282','安阳市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('283','鹤壁市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('284','新乡市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('285','焦作市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('286','濮阳市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('287','许昌市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('288','漯河市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('289','三门峡市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('290','南阳市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('291','商丘市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('292','信阳市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('293','周口市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('294','驻马店市','0','18','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('295','武汉市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('296','黄石市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('297','十堰市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('298','宜昌市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('299','襄樊市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('300','鄂州市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('301','荆门市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('302','孝感市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('303','荆州市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('304','黄冈市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('305','咸宁市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('306','随州市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('307','恩施土家族苗族自治州','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('308','仙桃市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('309','潜江市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('310','天门市','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('311','神农架林区','0','19','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('312','长沙市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('313','株洲市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('314','湘潭市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('315','衡阳市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('316','邵阳市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('317','岳阳市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('318','常德市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('319','张家界市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('320','益阳市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('321','郴州市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('322','永州市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('323','怀化市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('324','娄底市','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('325','湘西土家族苗族自治州','0','20','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('326','广州市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('327','韶关市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('328','深圳市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('329','珠海市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('330','汕头市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('331','佛山市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('332','江门市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('333','湛江市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('334','茂名市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('335','肇庆市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('336','惠州市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('337','梅州市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('338','汕尾市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('339','河源市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('340','阳江市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('341','清远市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('342','东莞市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('343','中山市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('344','潮州市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('345','揭阳市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('346','云浮市','0','21','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('347','南宁市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('348','柳州市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('349','桂林市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('350','梧州市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('351','北海市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('352','防城港市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('353','钦州市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('354','贵港市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('355','玉林市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('356','百色市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('357','贺州市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('358','河池市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('359','来宾市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('360','崇左市','0','22','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('361','海口市','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('362','三亚市','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('363','五指山市','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('364','琼海市','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('365','儋州市','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('366','文昌市','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('367','万宁市','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('368','东方市','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('369','定安县','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('370','屯昌县','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('371','澄迈县','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('372','临高县','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('373','白沙黎族自治县','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('374','昌江黎族自治县','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('375','乐东黎族自治县','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('376','陵水黎族自治县','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('377','保亭黎族苗族自治县','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('378','琼中黎族苗族自治县','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('379','西沙群岛','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('380','南沙群岛','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('381','中沙群岛的岛礁及其海域','0','23','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('382','成都市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('383','自贡市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('384','攀枝花市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('385','泸州市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('386','德阳市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('387','绵阳市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('388','广元市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('389','遂宁市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('390','内江市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('391','乐山市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('392','南充市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('393','眉山市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('394','宜宾市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('395','广安市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('396','达州市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('397','雅安市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('398','巴中市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('399','资阳市','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('400','阿坝州','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('401','甘孜州','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('402','凉山州','0','24','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('403','贵阳市','0','25','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('404','六盘水市','0','25','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('405','遵义市','0','25','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('406','安顺市','0','25','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('407','铜仁地区','0','25','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('408','黔西南州','0','25','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('409','毕节地区','0','25','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('410','黔东南州','0','25','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('411','黔南州','0','25','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('412','昆明市','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('413','曲靖市','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('414','玉溪市','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('415','保山市','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('416','昭通市','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('417','丽江市','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('418','思茅市','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('419','临沧市','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('420','楚雄州','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('421','红河州','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('422','文山州','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('423','西双版纳','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('424','大理','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('425','德宏','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('426','怒江','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('427','迪庆','0','26','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('428','拉萨市','0','27','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('429','昌都','0','27','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('430','山南','0','27','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('431','日喀则','0','27','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('432','那曲','0','27','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('433','阿里','0','27','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('434','林芝','0','27','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('435','西安市','0','28','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('436','铜川市','0','28','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('437','宝鸡市','0','28','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('438','咸阳市','0','28','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('439','渭南市','0','28','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('440','延安市','0','28','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('441','汉中市','0','28','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('442','榆林市','0','28','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('443','安康市','0','28','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('444','商洛市','0','28','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('445','兰州市','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('446','嘉峪关市','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('447','金昌市','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('448','白银市','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('449','天水市','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('450','武威市','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('451','张掖市','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('452','平凉市','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('453','酒泉市','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('454','庆阳市','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('455','定西市','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('456','陇南市','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('457','临夏州','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('458','甘州','0','29','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('459','西宁市','0','30','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('460','海东地区','0','30','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('461','海州','0','30','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('462','黄南州','0','30','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('463','海南州','0','30','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('464','果洛州','0','30','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('465','玉树州','0','30','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('466','海西州','0','30','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('467','银川市','0','31','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('468','石嘴山市','0','31','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('469','吴忠市','0','31','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('470','固原市','0','31','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('471','中卫市','0','31','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('472','乌鲁木齐市','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('473','克拉玛依市','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('474','吐鲁番地区','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('475','哈密地区','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('476','昌吉州','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('477','博尔州','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('478','巴音郭楞州','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('479','阿克苏地区','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('480','克孜勒苏柯尔克孜自治州','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('481','喀什地区','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('482','和田地区','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('483','伊犁州','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('484','塔城地区','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('485','阿勒泰地区','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('486','石河子市','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('487','阿拉尔市','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('488','图木舒克市','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('489','五家渠市','0','32','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('490','台北市','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('491','高雄市','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('492','基隆市','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('493','新竹市','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('494','台中市','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('495','嘉义市','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('496','台南市','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('497','台北县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('498','桃园县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('499','新竹县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('500','苗栗县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('501','台中县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('502','彰化县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('503','南投县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('504','云林县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('505','嘉义县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('506','台南县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('507','高雄县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('508','屏东县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('509','宜兰县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('510','花莲县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('511','台东县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('512','澎湖县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('513','金门县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('514','连江县','0','33','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('515','中西区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('516','东区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('517','南区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('518','湾仔区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('519','九龙城区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('520','观塘区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('521','深水埗区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('522','黄大仙区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('523','油尖旺区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('524','离岛区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('525','葵青区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('526','北区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('527','西贡区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('528','沙田区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('529','大埔区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('530','荃湾区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('531','屯门区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('532','元朗区','0','34','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('533','花地玛堂区','0','35','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('534','市圣安多尼堂区','0','35','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('535','大堂区','0','35','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('536','望德堂区','0','35','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('537','风顺堂区','0','35','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('538','嘉模堂区','0','35','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('539','圣方济各堂区','0','35','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('540','长安区','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('541','桥东区','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('542','桥西区','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('543','新华区','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('544','井陉矿区','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('545','裕华区','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('546','井陉县','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('547','正定县','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('548','栾城县','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('549','行唐县','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('550','灵寿县','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('551','高邑县','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('552','深泽县','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('553','赞皇县','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('554','无极县','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('555','平山县','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('556','元氏县','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('557','赵县','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('558','辛集市','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('559','藁城市','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('560','晋州市','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('561','新乐市','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('562','鹿泉市','0','130','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('563','路南区','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('564','路北区','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('565','古冶区','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('566','开平区','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('567','丰南区','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('568','丰润区','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('569','滦县','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('570','滦南县','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('571','乐亭县','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('572','迁西县','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('573','玉田县','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('574','唐海县','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('575','遵化市','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('576','迁安市','0','131','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('577','海港区','0','132','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('578','山海关区','0','132','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('579','北戴河区','0','132','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('580','青龙县','0','132','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('581','昌黎县','0','132','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('582','抚宁县','0','132','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('583','卢龙县','0','132','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('584','邯山区','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('585','丛台区','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('586','复兴区','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('587','峰峰矿区','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('588','邯郸县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('589','临漳县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('590','成安县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('591','大名县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('592','涉县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('593','磁县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('594','肥乡县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('595','永年县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('596','邱县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('597','鸡泽县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('598','广平县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('599','馆陶县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('600','魏县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('601','曲周县','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('602','武安市','0','133','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('603','桥东区','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('604','桥西区','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('605','邢台县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('606','临城县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('607','内丘县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('608','柏乡县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('609','隆尧县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('610','任县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('611','南和县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('612','宁晋县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('613','巨鹿县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('614','新河县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('615','广宗县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('616','平乡县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('617','威县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('618','清河县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('619','临西县','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('620','南宫市','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('621','沙河市','0','134','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('622','新市区','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('623','北市区','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('624','南市区','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('625','满城县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('626','清苑县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('627','涞水县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('628','阜平县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('629','徐水县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('630','定兴县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('631','唐县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('632','高阳县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('633','容城县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('634','涞源县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('635','望都县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('636','安新县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('637','易县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('638','曲阳县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('639','蠡县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('640','顺平县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('641','博野县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('642','雄县','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('643','涿州市','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('644','定州市','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('645','安国市','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('646','高碑店市','0','135','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('647','桥东区','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('648','桥西区','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('649','宣化区','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('650','下花园区','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('651','宣化县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('652','张北县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('653','康保县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('654','沽源县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('655','尚义县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('656','蔚县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('657','阳原县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('658','怀安县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('659','万全县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('660','怀来县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('661','涿鹿县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('662','赤城县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('663','崇礼县','0','136','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('664','双桥区','0','137','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('665','双滦区','0','137','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('666','鹰手营子矿区','0','137','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('667','承德县','0','137','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('668','兴隆县','0','137','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('669','平泉县','0','137','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('670','滦平县','0','137','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('671','隆化县','0','137','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('672','丰宁县','0','137','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('673','宽城县','0','137','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('674','围场县','0','137','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('675','新华区','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('676','运河区','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('677','沧县','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('678','青县','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('679','东光县','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('680','海兴县','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('681','盐山县','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('682','肃宁县','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('683','南皮县','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('684','吴桥县','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('685','献县','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('686','孟村县','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('687','泊头市','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('688','任丘市','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('689','黄骅市','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('690','河间市','0','138','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('691','安次区','0','139','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('692','广阳区','0','139','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('693','固安县','0','139','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('694','永清县','0','139','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('695','香河县','0','139','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('696','大城县','0','139','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('697','文安县','0','139','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('698','大厂县','0','139','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('699','霸州市','0','139','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('700','三河市','0','139','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('701','桃城区','0','140','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('702','枣强县','0','140','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('703','武邑县','0','140','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('704','武强县','0','140','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('705','饶阳县','0','140','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('706','安平县','0','140','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('707','故城县','0','140','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('708','景县','0','140','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('709','阜城县','0','140','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('710','冀州市','0','140','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('711','深州市','0','140','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('712','小店区','0','141','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('713','迎泽区','0','141','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('714','杏花岭区','0','141','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('715','尖草坪区','0','141','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('716','万柏林区','0','141','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('717','晋源区','0','141','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('718','清徐县','0','141','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('719','阳曲县','0','141','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('720','娄烦县','0','141','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('721','古交市','0','141','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('722','城区','0','142','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('723','矿区','0','142','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('724','南郊区','0','142','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('725','新荣区','0','142','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('726','阳高县','0','142','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('727','天镇县','0','142','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('728','广灵县','0','142','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('729','灵丘县','0','142','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('730','浑源县','0','142','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('731','左云县','0','142','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('732','大同县','0','142','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('733','城区','0','143','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('734','矿区','0','143','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('735','郊区','0','143','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('736','平定县','0','143','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('737','盂县','0','143','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('738','城区','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('739','郊区','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('740','长治县','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('741','襄垣县','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('742','屯留县','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('743','平顺县','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('744','黎城县','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('745','壶关县','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('746','长子县','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('747','武乡县','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('748','沁县','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('749','沁源县','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('750','潞城市','0','144','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('751','城区','0','145','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('752','沁水县','0','145','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('753','阳城县','0','145','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('754','陵川县','0','145','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('755','泽州县','0','145','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('756','高平市','0','145','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('757','朔城区','0','146','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('758','平鲁区','0','146','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('759','山阴县','0','146','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('760','应县','0','146','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('761','右玉县','0','146','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('762','怀仁县','0','146','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('763','榆次区','0','147','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('764','榆社县','0','147','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('765','左权县','0','147','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('766','和顺县','0','147','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('767','昔阳县','0','147','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('768','寿阳县','0','147','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('769','太谷县','0','147','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('770','祁县','0','147','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('771','平遥县','0','147','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('772','灵石县','0','147','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('773','介休市','0','147','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('774','盐湖区','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('775','临猗县','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('776','万荣县','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('777','闻喜县','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('778','稷山县','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('779','新绛县','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('780','绛县','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('781','垣曲县','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('782','夏县','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('783','平陆县','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('784','芮城县','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('785','永济市','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('786','河津市','0','148','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('787','忻府区','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('788','定襄县','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('789','五台县','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('790','代县','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('791','繁峙县','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('792','宁武县','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('793','静乐县','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('794','神池县','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('795','五寨县','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('796','岢岚县','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('797','河曲县','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('798','保德县','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('799','偏关县','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('800','原平市','0','149','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('801','尧都区','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('802','曲沃县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('803','翼城县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('804','襄汾县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('805','洪洞县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('806','古县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('807','安泽县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('808','浮山县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('809','吉县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('810','乡宁县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('811','大宁县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('812','隰县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('813','永和县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('814','蒲县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('815','汾西县','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('816','侯马市','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('817','霍州市','0','150','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('818','离石区','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('819','文水县','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('820','交城县','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('821','兴县','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('822','临县','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('823','柳林县','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('824','石楼县','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('825','岚县','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('826','方山县','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('827','中阳县','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('828','交口县','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('829','孝义市','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('830','汾阳市','0','151','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('831','新城区','0','152','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('832','回民区','0','152','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('833','玉泉区','0','152','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('834','赛罕区','0','152','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('835','土默特左旗','0','152','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('836','托克托县','0','152','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('837','和林格尔县','0','152','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('838','清水河县','0','152','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('839','武川县','0','152','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('840','东河区','0','153','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('841','昆都仑区','0','153','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('842','青山区','0','153','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('843','石拐区','0','153','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('844','白云矿区','0','153','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('845','九原区','0','153','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('846','土默特右旗','0','153','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('847','固阳县','0','153','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('848','达尔罕茂明安联合旗','0','153','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('849','海勃湾区','0','154','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('850','海南区','0','154','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('851','乌达区','0','154','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('852','红山区','0','155','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('853','元宝山区','0','155','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('854','松山区','0','155','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('855','阿鲁科尔沁旗','0','155','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('856','巴林左旗','0','155','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('857','巴林右旗','0','155','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('858','林西县','0','155','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('859','克什克腾旗','0','155','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('860','翁牛特旗','0','155','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('861','喀喇沁旗','0','155','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('862','宁城县','0','155','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('863','敖汉旗','0','155','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('864','科尔沁区','0','156','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('865','科尔沁左翼中旗','0','156','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('866','科尔沁左翼后旗','0','156','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('867','开鲁县','0','156','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('868','库伦旗','0','156','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('869','奈曼旗','0','156','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('870','扎鲁特旗','0','156','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('871','霍林郭勒市','0','156','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('872','东胜区','0','157','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('873','达拉特旗','0','157','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('874','准格尔旗','0','157','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('875','鄂托克前旗','0','157','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('876','鄂托克旗','0','157','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('877','杭锦旗','0','157','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('878','乌审旗','0','157','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('879','伊金霍洛旗','0','157','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('880','海拉尔区','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('881','阿荣旗','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('882','莫力达瓦达斡尔族自治旗','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('883','鄂伦春自治旗','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('884','鄂温克族自治旗','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('885','陈巴尔虎旗','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('886','新巴尔虎左旗','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('887','新巴尔虎右旗','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('888','满洲里市','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('889','牙克石市','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('890','扎兰屯市','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('891','额尔古纳市','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('892','根河市','0','158','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('893','临河区','0','159','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('894','五原县','0','159','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('895','磴口县','0','159','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('896','乌拉特前旗','0','159','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('897','乌拉特中旗','0','159','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('898','乌拉特后旗','0','159','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('899','杭锦后旗','0','159','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('900','集宁区','0','160','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('901','卓资县','0','160','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('902','化德县','0','160','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('903','商都县','0','160','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('904','兴和县','0','160','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('905','凉城县','0','160','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('906','察哈尔右翼前旗','0','160','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('907','察哈尔右翼中旗','0','160','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('908','察哈尔右翼后旗','0','160','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('909','四子王旗','0','160','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('910','丰镇市','0','160','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('911','乌兰浩特市','0','161','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('912','阿尔山市','0','161','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('913','科尔沁右翼前旗','0','161','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('914','科尔沁右翼中旗','0','161','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('915','扎赉特旗','0','161','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('916','突泉县','0','161','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('917','二连浩特市','0','162','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('918','锡林浩特市','0','162','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('919','阿巴嘎旗','0','162','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('920','苏尼特左旗','0','162','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('921','苏尼特右旗','0','162','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('922','东乌珠穆沁旗','0','162','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('923','西乌珠穆沁旗','0','162','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('924','太仆寺旗','0','162','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('925','镶黄旗','0','162','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('926','正镶白旗','0','162','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('927','正蓝旗','0','162','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('928','多伦县','0','162','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('929','阿拉善左旗','0','163','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('930','阿拉善右旗','0','163','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('931','额济纳旗','0','163','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('932','和平区','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('933','沈河区','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('934','大东区','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('935','皇姑区','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('936','铁西区','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('937','苏家屯区','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('938','东陵区','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('939','新城子区','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('940','于洪区','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('941','辽中县','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('942','康平县','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('943','法库县','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('944','新民市','0','164','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('945','中山区','0','165','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('946','西岗区','0','165','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('947','沙河口区','0','165','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('948','甘井子区','0','165','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('949','旅顺口区','0','165','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('950','金州区','0','165','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('951','长海县','0','165','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('952','瓦房店市','0','165','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('953','普兰店市','0','165','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('954','庄河市','0','165','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('955','铁东区','0','166','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('956','铁西区','0','166','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('957','立山区','0','166','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('958','千山区','0','166','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('959','台安县','0','166','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('960','岫岩满族自治县','0','166','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('961','海城市','0','166','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('962','新抚区','0','167','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('963','东洲区','0','167','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('964','望花区','0','167','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('965','顺城区','0','167','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('966','抚顺县','0','167','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('967','新宾满族自治县','0','167','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('968','清原满族自治县','0','167','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('969','平山区','0','168','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('970','溪湖区','0','168','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('971','明山区','0','168','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('972','南芬区','0','168','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('973','本溪满族自治县','0','168','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('974','桓仁满族自治县','0','168','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('975','元宝区','0','169','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('976','振兴区','0','169','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('977','振安区','0','169','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('978','宽甸满族自治县','0','169','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('979','东港市','0','169','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('980','凤城市','0','169','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('981','古塔区','0','170','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('982','凌河区','0','170','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('983','太和区','0','170','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('984','黑山县','0','170','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('985','义县','0','170','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('986','凌海市','0','170','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('987','北镇市','0','170','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('988','站前区','0','171','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('989','西市区','0','171','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('990','鲅鱼圈区','0','171','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('991','老边区','0','171','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('992','盖州市','0','171','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('993','大石桥市','0','171','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('994','海州区','0','172','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('995','新邱区','0','172','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('996','太平区','0','172','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('997','清河门区','0','172','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('998','细河区','0','172','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('999','阜新蒙古族自治县','0','172','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1000','彰武县','0','172','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1001','白塔区','0','173','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1002','文圣区','0','173','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1003','宏伟区','0','173','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1004','弓长岭区','0','173','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1005','太子河区','0','173','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1006','辽阳县','0','173','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1007','灯塔市','0','173','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1008','双台子区','0','174','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1009','兴隆台区','0','174','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1010','大洼县','0','174','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1011','盘山县','0','174','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1012','银州区','0','175','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1013','清河区','0','175','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1014','铁岭县','0','175','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1015','西丰县','0','175','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1016','昌图县','0','175','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1017','调兵山市','0','175','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1018','开原市','0','175','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1019','双塔区','0','176','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1020','龙城区','0','176','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1021','朝阳县','0','176','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1022','建平县','0','176','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1023','喀喇沁左翼蒙古族自治县','0','176','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1024','北票市','0','176','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1025','凌源市','0','176','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1026','连山区','0','177','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1027','龙港区','0','177','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1028','南票区','0','177','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1029','绥中县','0','177','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1030','建昌县','0','177','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1031','兴城市','0','177','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1032','南关区','0','178','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1033','宽城区','0','178','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1034','朝阳区','0','178','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1035','二道区','0','178','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1036','绿园区','0','178','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1037','双阳区','0','178','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1038','农安县','0','178','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1039','九台市','0','178','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1040','榆树市','0','178','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1041','德惠市','0','178','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1042','昌邑区','0','179','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1043','龙潭区','0','179','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1044','船营区','0','179','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1045','丰满区','0','179','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1046','永吉县','0','179','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1047','蛟河市','0','179','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1048','桦甸市','0','179','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1049','舒兰市','0','179','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1050','磐石市','0','179','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1051','铁西区','0','180','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1052','铁东区','0','180','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1053','梨树县','0','180','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1054','伊通满族自治县','0','180','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1055','公主岭市','0','180','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1056','双辽市','0','180','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1057','龙山区','0','181','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1058','西安区','0','181','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1059','东丰县','0','181','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1060','东辽县','0','181','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1061','东昌区','0','182','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1062','二道江区','0','182','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1063','通化县','0','182','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1064','辉南县','0','182','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1065','柳河县','0','182','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1066','梅河口市','0','182','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1067','集安市','0','182','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1068','八道江区','0','183','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1069','抚松县','0','183','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1070','靖宇县','0','183','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1071','长白朝鲜族自治县','0','183','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1072','江源县','0','183','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1073','临江市','0','183','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1074','宁江区','0','184','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1075','前郭尔罗斯蒙古族自治县','0','184','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1076','长岭县','0','184','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1077','乾安县','0','184','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1078','扶余县','0','184','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1079','洮北区','0','185','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1080','镇赉县','0','185','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1081','通榆县','0','185','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1082','洮南市','0','185','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1083','大安市','0','185','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1084','延吉市','0','186','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1085','图们市','0','186','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1086','敦化市','0','186','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1087','珲春市','0','186','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1088','龙井市','0','186','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1089','和龙市','0','186','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1090','汪清县','0','186','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1091','安图县','0','186','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1092','道里区','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1093','南岗区','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1094','道外区','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1095','香坊区','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1096','动力区','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1097','平房区','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1098','松北区','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1099','呼兰区','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1100','依兰县','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1101','方正县','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1102','宾县','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1103','巴彦县','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1104','木兰县','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1105','通河县','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1106','延寿县','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1107','阿城市','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1108','双城市','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1109','尚志市','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1110','五常市','0','187','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1111','龙沙区','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1112','建华区','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1113','铁锋区','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1114','昂昂溪区','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1115','富拉尔基区','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1116','碾子山区','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1117','梅里斯达斡尔族区','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1118','龙江县','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1119','依安县','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1120','泰来县','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1121','甘南县','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1122','富裕县','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1123','克山县','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1124','克东县','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1125','拜泉县','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1126','讷河市','0','188','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1127','鸡冠区','0','189','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1128','恒山区','0','189','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1129','滴道区','0','189','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1130','梨树区','0','189','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1131','城子河区','0','189','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1132','麻山区','0','189','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1133','鸡东县','0','189','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1134','虎林市','0','189','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1135','密山市','0','189','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1136','向阳区','0','190','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1137','工农区','0','190','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1138','南山区','0','190','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1139','兴安区','0','190','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1140','东山区','0','190','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1141','兴山区','0','190','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1142','萝北县','0','190','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1143','绥滨县','0','190','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1144','尖山区','0','191','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1145','岭东区','0','191','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1146','四方台区','0','191','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1147','宝山区','0','191','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1148','集贤县','0','191','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1149','友谊县','0','191','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1150','宝清县','0','191','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1151','饶河县','0','191','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1152','萨尔图区','0','192','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1153','龙凤区','0','192','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1154','让胡路区','0','192','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1155','红岗区','0','192','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1156','大同区','0','192','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1157','肇州县','0','192','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1158','肇源县','0','192','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1159','林甸县','0','192','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1160','杜尔伯特蒙古族自治县','0','192','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1161','伊春区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1162','南岔区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1163','友好区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1164','西林区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1165','翠峦区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1166','新青区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1167','美溪区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1168','金山屯区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1169','五营区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1170','乌马河区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1171','汤旺河区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1172','带岭区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1173','乌伊岭区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1174','红星区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1175','上甘岭区','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1176','嘉荫县','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1177','铁力市','0','193','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1178','永红区','0','194','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1179','向阳区','0','194','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1180','前进区','0','194','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1181','东风区','0','194','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1182','郊区','0','194','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1183','桦南县','0','194','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1184','桦川县','0','194','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1185','汤原县','0','194','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1186','抚远县','0','194','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1187','同江市','0','194','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1188','富锦市','0','194','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1189','新兴区','0','195','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1190','桃山区','0','195','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1191','茄子河区','0','195','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1192','勃利县','0','195','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1193','东安区','0','196','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1194','阳明区','0','196','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1195','爱民区','0','196','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1196','西安区','0','196','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1197','东宁县','0','196','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1198','林口县','0','196','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1199','绥芬河市','0','196','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1200','海林市','0','196','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1201','宁安市','0','196','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1202','穆棱市','0','196','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1203','爱辉区','0','197','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1204','嫩江县','0','197','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1205','逊克县','0','197','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1206','孙吴县','0','197','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1207','北安市','0','197','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1208','五大连池市','0','197','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1209','北林区','0','198','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1210','望奎县','0','198','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1211','兰西县','0','198','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1212','青冈县','0','198','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1213','庆安县','0','198','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1214','明水县','0','198','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1215','绥棱县','0','198','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1216','安达市','0','198','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1217','肇东市','0','198','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1218','海伦市','0','198','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1219','呼玛县','0','199','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1220','塔河县','0','199','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1221','漠河县','0','199','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1222','玄武区','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1223','白下区','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1224','秦淮区','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1225','建邺区','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1226','鼓楼区','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1227','下关区','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1228','浦口区','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1229','栖霞区','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1230','雨花台区','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1231','江宁区','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1232','六合区','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1233','溧水县','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1234','高淳县','0','200','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1235','崇安区','0','201','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1236','南长区','0','201','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1237','北塘区','0','201','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1238','锡山区','0','201','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1239','惠山区','0','201','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1240','滨湖区','0','201','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1241','江阴市','0','201','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1242','宜兴市','0','201','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1243','鼓楼区','0','202','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1244','云龙区','0','202','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1245','九里区','0','202','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1246','贾汪区','0','202','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1247','泉山区','0','202','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1248','丰县','0','202','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1249','沛县','0','202','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1250','铜山县','0','202','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1251','睢宁县','0','202','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1252','新沂市','0','202','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1253','邳州市','0','202','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1254','天宁区','0','203','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1255','钟楼区','0','203','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1256','戚墅堰区','0','203','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1257','新北区','0','203','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1258','武进区','0','203','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1259','溧阳市','0','203','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1260','金坛市','0','203','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1261','沧浪区','0','204','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1262','平江区','0','204','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1263','金阊区','0','204','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1264','虎丘区','0','204','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1265','吴中区','0','204','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1266','相城区','0','204','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1267','常熟市','0','204','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1268','张家港市','0','204','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1269','昆山市','0','204','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1270','吴江市','0','204','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1271','太仓市','0','204','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1272','崇川区','0','205','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1273','港闸区','0','205','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1274','海安县','0','205','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1275','如东县','0','205','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1276','启东市','0','205','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1277','如皋市','0','205','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1278','通州市','0','205','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1279','海门市','0','205','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1280','连云区','0','206','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1281','新浦区','0','206','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1282','海州区','0','206','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1283','赣榆县','0','206','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1284','东海县','0','206','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1285','灌云县','0','206','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1286','灌南县','0','206','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1287','清河区','0','207','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1288','楚州区','0','207','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1289','淮阴区','0','207','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1290','清浦区','0','207','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1291','涟水县','0','207','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1292','洪泽县','0','207','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1293','盱眙县','0','207','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1294','金湖县','0','207','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1295','亭湖区','0','208','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1296','盐都区','0','208','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1297','响水县','0','208','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1298','滨海县','0','208','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1299','阜宁县','0','208','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1300','射阳县','0','208','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1301','建湖县','0','208','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1302','东台市','0','208','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1303','大丰市','0','208','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1304','广陵区','0','209','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1305','邗江区','0','209','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1306','维扬区','0','209','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1307','宝应县','0','209','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1308','仪征市','0','209','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1309','高邮市','0','209','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1310','江都市','0','209','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1311','京口区','0','210','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1312','润州区','0','210','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1313','丹徒区','0','210','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1314','丹阳市','0','210','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1315','扬中市','0','210','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1316','句容市','0','210','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1317','海陵区','0','211','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1318','高港区','0','211','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1319','兴化市','0','211','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1320','靖江市','0','211','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1321','泰兴市','0','211','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1322','姜堰市','0','211','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1323','宿城区','0','212','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1324','宿豫区','0','212','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1325','沭阳县','0','212','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1326','泗阳县','0','212','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1327','泗洪县','0','212','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1328','上城区','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1329','下城区','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1330','江干区','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1331','拱墅区','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1332','西湖区','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1333','滨江区','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1334','萧山区','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1335','余杭区','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1336','桐庐县','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1337','淳安县','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1338','建德市','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1339','富阳市','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1340','临安市','0','213','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1341','海曙区','0','214','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1342','江东区','0','214','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1343','江北区','0','214','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1344','北仑区','0','214','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1345','镇海区','0','214','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1346','鄞州区','0','214','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1347','象山县','0','214','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1348','宁海县','0','214','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1349','余姚市','0','214','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1350','慈溪市','0','214','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1351','奉化市','0','214','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1352','鹿城区','0','215','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1353','龙湾区','0','215','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1354','瓯海区','0','215','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1355','洞头县','0','215','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1356','永嘉县','0','215','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1357','平阳县','0','215','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1358','苍南县','0','215','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1359','文成县','0','215','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1360','泰顺县','0','215','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1361','瑞安市','0','215','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1362','乐清市','0','215','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1363','秀城区','0','216','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1364','秀洲区','0','216','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1365','嘉善县','0','216','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1366','海盐县','0','216','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1367','海宁市','0','216','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1368','平湖市','0','216','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1369','桐乡市','0','216','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1370','吴兴区','0','217','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1371','南浔区','0','217','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1372','德清县','0','217','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1373','长兴县','0','217','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1374','安吉县','0','217','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1375','越城区','0','218','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1376','绍兴县','0','218','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1377','新昌县','0','218','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1378','诸暨市','0','218','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1379','上虞市','0','218','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1380','嵊州市','0','218','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1381','婺城区','0','219','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1382','金东区','0','219','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1383','武义县','0','219','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1384','浦江县','0','219','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1385','磐安县','0','219','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1386','兰溪市','0','219','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1387','义乌市','0','219','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1388','东阳市','0','219','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1389','永康市','0','219','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1390','柯城区','0','220','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1391','衢江区','0','220','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1392','常山县','0','220','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1393','开化县','0','220','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1394','龙游县','0','220','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1395','江山市','0','220','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1396','定海区','0','221','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1397','普陀区','0','221','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1398','岱山县','0','221','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1399','嵊泗县','0','221','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1400','椒江区','0','222','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1401','黄岩区','0','222','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1402','路桥区','0','222','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1403','玉环县','0','222','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1404','三门县','0','222','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1405','天台县','0','222','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1406','仙居县','0','222','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1407','温岭市','0','222','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1408','临海市','0','222','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1409','莲都区','0','223','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1410','青田县','0','223','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1411','缙云县','0','223','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1412','遂昌县','0','223','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1413','松阳县','0','223','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1414','云和县','0','223','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1415','庆元县','0','223','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1416','景宁畲族自治县','0','223','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1417','龙泉市','0','223','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1418','瑶海区','0','224','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1419','庐阳区','0','224','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1420','蜀山区','0','224','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1421','包河区','0','224','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1422','长丰县','0','224','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1423','肥东县','0','224','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1424','肥西县','0','224','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1425','镜湖区','0','225','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1426','弋江区','0','225','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1427','鸠江区','0','225','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1428','三山区','0','225','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1429','芜湖县','0','225','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1430','繁昌县','0','225','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1431','南陵县','0','225','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1432','龙子湖区','0','226','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1433','蚌山区','0','226','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1434','禹会区','0','226','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1435','淮上区','0','226','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1436','怀远县','0','226','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1437','五河县','0','226','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1438','固镇县','0','226','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1439','大通区','0','227','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1440','田家庵区','0','227','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1441','谢家集区','0','227','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1442','八公山区','0','227','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1443','潘集区','0','227','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1444','凤台县','0','227','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1445','金家庄区','0','228','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1446','花山区','0','228','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1447','雨山区','0','228','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1448','当涂县','0','228','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1449','杜集区','0','229','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1450','相山区','0','229','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1451','烈山区','0','229','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1452','濉溪县','0','229','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1453','铜官山区','0','230','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1454','狮子山区','0','230','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1455','郊区','0','230','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1456','铜陵县','0','230','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1457','迎江区','0','231','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1458','大观区','0','231','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1459','宜秀区','0','231','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1460','怀宁县','0','231','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1461','枞阳县','0','231','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1462','潜山县','0','231','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1463','太湖县','0','231','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1464','宿松县','0','231','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1465','望江县','0','231','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1466','岳西县','0','231','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1467','桐城市','0','231','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1468','屯溪区','0','232','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1469','黄山区','0','232','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1470','徽州区','0','232','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1471','歙县','0','232','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1472','休宁县','0','232','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1473','黟县','0','232','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1474','祁门县','0','232','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1475','琅琊区','0','233','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1476','南谯区','0','233','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1477','来安县','0','233','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1478','全椒县','0','233','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1479','定远县','0','233','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1480','凤阳县','0','233','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1481','天长市','0','233','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1482','明光市','0','233','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1483','颍州区','0','234','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1484','颍东区','0','234','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1485','颍泉区','0','234','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1486','临泉县','0','234','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1487','太和县','0','234','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1488','阜南县','0','234','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1489','颍上县','0','234','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1490','界首市','0','234','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1491','埇桥区','0','235','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1492','砀山县','0','235','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1493','萧县','0','235','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1494','灵璧县','0','235','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1495','泗县','0','235','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1496','居巢区','0','236','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1497','庐江县','0','236','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1498','无为县','0','236','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1499','含山县','0','236','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1500','和县','0','236','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1501','金安区','0','237','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1502','裕安区','0','237','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1503','寿县','0','237','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1504','霍邱县','0','237','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1505','舒城县','0','237','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1506','金寨县','0','237','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1507','霍山县','0','237','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1508','谯城区','0','238','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1509','涡阳县','0','238','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1510','蒙城县','0','238','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1511','利辛县','0','238','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1512','贵池区','0','239','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1513','东至县','0','239','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1514','石台县','0','239','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1515','青阳县','0','239','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1516','宣州区','0','240','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1517','郎溪县','0','240','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1518','广德县','0','240','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1519','泾县','0','240','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1520','绩溪县','0','240','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1521','旌德县','0','240','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1522','宁国市','0','240','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1523','鼓楼区','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1524','台江区','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1525','仓山区','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1526','马尾区','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1527','晋安区','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1528','闽侯县','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1529','连江县','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1530','罗源县','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1531','闽清县','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1532','永泰县','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1533','平潭县','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1534','福清市','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1535','长乐市','0','241','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1536','思明区','0','242','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1537','海沧区','0','242','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1538','湖里区','0','242','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1539','集美区','0','242','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1540','同安区','0','242','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1541','翔安区','0','242','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1542','城厢区','0','243','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1543','涵江区','0','243','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1544','荔城区','0','243','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1545','秀屿区','0','243','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1546','仙游县','0','243','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1547','梅列区','0','244','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1548','三元区','0','244','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1549','明溪县','0','244','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1550','清流县','0','244','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1551','宁化县','0','244','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1552','大田县','0','244','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1553','尤溪县','0','244','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1554','沙县','0','244','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1555','将乐县','0','244','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1556','泰宁县','0','244','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1557','建宁县','0','244','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1558','永安市','0','244','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1559','鲤城区','0','245','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1560','丰泽区','0','245','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1561','洛江区','0','245','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1562','泉港区','0','245','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1563','惠安县','0','245','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1564','安溪县','0','245','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1565','永春县','0','245','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1566','德化县','0','245','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1567','金门县','0','245','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1568','石狮市','0','245','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1569','晋江市','0','245','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1570','南安市','0','245','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1571','芗城区','0','246','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1572','龙文区','0','246','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1573','云霄县','0','246','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1574','漳浦县','0','246','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1575','诏安县','0','246','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1576','长泰县','0','246','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1577','东山县','0','246','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1578','南靖县','0','246','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1579','平和县','0','246','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1580','华安县','0','246','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1581','龙海市','0','246','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1582','延平区','0','247','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1583','顺昌县','0','247','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1584','浦城县','0','247','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1585','光泽县','0','247','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1586','松溪县','0','247','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1587','政和县','0','247','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1588','邵武市','0','247','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1589','武夷山市','0','247','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1590','建瓯市','0','247','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1591','建阳市','0','247','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1592','新罗区','0','248','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1593','长汀县','0','248','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1594','永定县','0','248','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1595','上杭县','0','248','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1596','武平县','0','248','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1597','连城县','0','248','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1598','漳平市','0','248','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1599','蕉城区','0','249','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1600','霞浦县','0','249','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1601','古田县','0','249','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1602','屏南县','0','249','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1603','寿宁县','0','249','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1604','周宁县','0','249','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1605','柘荣县','0','249','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1606','福安市','0','249','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1607','福鼎市','0','249','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1608','东湖区','0','250','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1609','西湖区','0','250','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1610','青云谱区','0','250','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1611','湾里区','0','250','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1612','青山湖区','0','250','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1613','南昌县','0','250','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1614','新建县','0','250','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1615','安义县','0','250','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1616','进贤县','0','250','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1617','昌江区','0','251','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1618','珠山区','0','251','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1619','浮梁县','0','251','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1620','乐平市','0','251','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1621','安源区','0','252','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1622','湘东区','0','252','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1623','莲花县','0','252','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1624','上栗县','0','252','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1625','芦溪县','0','252','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1626','庐山区','0','253','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1627','浔阳区','0','253','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1628','九江县','0','253','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1629','武宁县','0','253','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1630','修水县','0','253','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1631','永修县','0','253','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1632','德安县','0','253','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1633','星子县','0','253','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1634','都昌县','0','253','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1635','湖口县','0','253','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1636','彭泽县','0','253','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1637','瑞昌市','0','253','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1638','渝水区','0','254','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1639','分宜县','0','254','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1640','月湖区','0','255','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1641','余江县','0','255','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1642','贵溪市','0','255','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1643','章贡区','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1644','赣县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1645','信丰县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1646','大余县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1647','上犹县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1648','崇义县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1649','安远县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1650','龙南县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1651','定南县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1652','全南县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1653','宁都县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1654','于都县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1655','兴国县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1656','会昌县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1657','寻乌县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1658','石城县','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1659','瑞金市','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1660','南康市','0','256','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1661','吉州区','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1662','青原区','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1663','吉安县','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1664','吉水县','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1665','峡江县','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1666','新干县','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1667','永丰县','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1668','泰和县','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1669','遂川县','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1670','万安县','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1671','安福县','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1672','永新县','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1673','井冈山市','0','257','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1674','袁州区','0','258','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1675','奉新县','0','258','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1676','万载县','0','258','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1677','上高县','0','258','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1678','宜丰县','0','258','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1679','靖安县','0','258','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1680','铜鼓县','0','258','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1681','丰城市','0','258','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1682','樟树市','0','258','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1683','高安市','0','258','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1684','临川区','0','259','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1685','南城县','0','259','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1686','黎川县','0','259','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1687','南丰县','0','259','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1688','崇仁县','0','259','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1689','乐安县','0','259','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1690','宜黄县','0','259','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1691','金溪县','0','259','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1692','资溪县','0','259','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1693','东乡县','0','259','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1694','广昌县','0','259','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1695','信州区','0','260','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1696','上饶县','0','260','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1697','广丰县','0','260','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1698','玉山县','0','260','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1699','铅山县','0','260','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1700','横峰县','0','260','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1701','弋阳县','0','260','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1702','余干县','0','260','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1703','鄱阳县','0','260','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1704','万年县','0','260','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1705','婺源县','0','260','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1706','德兴市','0','260','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1707','历下区','0','261','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1708','市中区','0','261','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1709','槐荫区','0','261','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1710','天桥区','0','261','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1711','历城区','0','261','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1712','长清区','0','261','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1713','平阴县','0','261','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1714','济阳县','0','261','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1715','商河县','0','261','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1716','章丘市','0','261','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1717','市南区','0','262','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1718','市北区','0','262','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1719','四方区','0','262','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1720','黄岛区','0','262','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1721','崂山区','0','262','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1722','李沧区','0','262','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1723','城阳区','0','262','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1724','胶州市','0','262','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1725','即墨市','0','262','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1726','平度市','0','262','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1727','胶南市','0','262','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1728','莱西市','0','262','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1729','淄川区','0','263','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1730','张店区','0','263','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1731','博山区','0','263','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1732','临淄区','0','263','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1733','周村区','0','263','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1734','桓台县','0','263','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1735','高青县','0','263','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1736','沂源县','0','263','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1737','市中区','0','264','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1738','薛城区','0','264','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1739','峄城区','0','264','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1740','台儿庄区','0','264','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1741','山亭区','0','264','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1742','滕州市','0','264','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1743','东营区','0','265','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1744','河口区','0','265','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1745','垦利县','0','265','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1746','利津县','0','265','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1747','广饶县','0','265','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1748','芝罘区','0','266','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1749','福山区','0','266','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1750','牟平区','0','266','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1751','莱山区','0','266','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1752','长岛县','0','266','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1753','龙口市','0','266','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1754','莱阳市','0','266','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1755','莱州市','0','266','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1756','蓬莱市','0','266','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1757','招远市','0','266','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1758','栖霞市','0','266','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1759','海阳市','0','266','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1760','潍城区','0','267','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1761','寒亭区','0','267','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1762','坊子区','0','267','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1763','奎文区','0','267','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1764','临朐县','0','267','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1765','昌乐县','0','267','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1766','青州市','0','267','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1767','诸城市','0','267','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1768','寿光市','0','267','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1769','安丘市','0','267','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1770','高密市','0','267','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1771','昌邑市','0','267','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1772','市中区','0','268','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1773','任城区','0','268','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1774','微山县','0','268','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1775','鱼台县','0','268','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1776','金乡县','0','268','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1777','嘉祥县','0','268','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1778','汶上县','0','268','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1779','泗水县','0','268','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1780','梁山县','0','268','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1781','曲阜市','0','268','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1782','兖州市','0','268','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1783','邹城市','0','268','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1784','泰山区','0','269','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1785','岱岳区','0','269','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1786','宁阳县','0','269','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1787','东平县','0','269','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1788','新泰市','0','269','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1789','肥城市','0','269','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1790','环翠区','0','270','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1791','文登市','0','270','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1792','荣成市','0','270','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1793','乳山市','0','270','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1794','东港区','0','271','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1795','岚山区','0','271','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1796','五莲县','0','271','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1797','莒县','0','271','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1798','莱城区','0','272','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1799','钢城区','0','272','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1800','兰山区','0','273','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1801','罗庄区','0','273','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1802','河东区','0','273','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1803','沂南县','0','273','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1804','郯城县','0','273','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1805','沂水县','0','273','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1806','苍山县','0','273','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1807','费县','0','273','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1808','平邑县','0','273','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1809','莒南县','0','273','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1810','蒙阴县','0','273','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1811','临沭县','0','273','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1812','德城区','0','274','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1813','陵县','0','274','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1814','宁津县','0','274','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1815','庆云县','0','274','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1816','临邑县','0','274','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1817','齐河县','0','274','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1818','平原县','0','274','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1819','夏津县','0','274','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1820','武城县','0','274','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1821','乐陵市','0','274','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1822','禹城市','0','274','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1823','东昌府区','0','275','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1824','阳谷县','0','275','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1825','莘县','0','275','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1826','茌平县','0','275','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1827','东阿县','0','275','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1828','冠县','0','275','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1829','高唐县','0','275','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1830','临清市','0','275','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1831','滨城区','0','276','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1832','惠民县','0','276','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1833','阳信县','0','276','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1834','无棣县','0','276','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1835','沾化县','0','276','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1836','博兴县','0','276','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1837','邹平县','0','276','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1838','牡丹区','0','277','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1839','曹县','0','277','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1840','单县','0','277','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1841','成武县','0','277','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1842','巨野县','0','277','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1843','郓城县','0','277','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1844','鄄城县','0','277','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1845','定陶县','0','277','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1846','东明县','0','277','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1847','中原区','0','278','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1848','二七区','0','278','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1849','管城回族区','0','278','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1850','金水区','0','278','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1851','上街区','0','278','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1852','惠济区','0','278','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1853','中牟县','0','278','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1854','巩义市','0','278','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1855','荥阳市','0','278','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1856','新密市','0','278','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1857','新郑市','0','278','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1858','登封市','0','278','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1859','龙亭区','0','279','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1860','顺河回族区','0','279','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1861','鼓楼区','0','279','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1862','禹王台区','0','279','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1863','金明区','0','279','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1864','杞县','0','279','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1865','通许县','0','279','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1866','尉氏县','0','279','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1867','开封县','0','279','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1868','兰考县','0','279','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1869','老城区','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1870','西工区','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1871','廛河回族区','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1872','涧西区','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1873','吉利区','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1874','洛龙区','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1875','孟津县','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1876','新安县','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1877','栾川县','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1878','嵩县','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1879','汝阳县','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1880','宜阳县','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1881','洛宁县','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1882','伊川县','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1883','偃师市','0','280','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1884','新华区','0','281','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1885','卫东区','0','281','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1886','石龙区','0','281','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1887','湛河区','0','281','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1888','宝丰县','0','281','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1889','叶县','0','281','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1890','鲁山县','0','281','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1891','郏县','0','281','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1892','舞钢市','0','281','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1893','汝州市','0','281','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1894','文峰区','0','282','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1895','北关区','0','282','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1896','殷都区','0','282','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1897','龙安区','0','282','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1898','安阳县','0','282','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1899','汤阴县','0','282','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1900','滑县','0','282','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1901','内黄县','0','282','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1902','林州市','0','282','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1903','鹤山区','0','283','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1904','山城区','0','283','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1905','淇滨区','0','283','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1906','浚县','0','283','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1907','淇县','0','283','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1908','红旗区','0','284','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1909','卫滨区','0','284','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1910','凤泉区','0','284','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1911','牧野区','0','284','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1912','新乡县','0','284','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1913','获嘉县','0','284','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1914','原阳县','0','284','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1915','延津县','0','284','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1916','封丘县','0','284','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1917','长垣县','0','284','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1918','卫辉市','0','284','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1919','辉县市','0','284','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1920','解放区','0','285','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1921','中站区','0','285','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1922','马村区','0','285','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1923','山阳区','0','285','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1924','修武县','0','285','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1925','博爱县','0','285','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1926','武陟县','0','285','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1927','温县','0','285','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1928','济源市','0','285','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1929','沁阳市','0','285','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1930','孟州市','0','285','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1931','华龙区','0','286','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1932','清丰县','0','286','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1933','南乐县','0','286','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1934','范县','0','286','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1935','台前县','0','286','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1936','濮阳县','0','286','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1937','魏都区','0','287','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1938','许昌县','0','287','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1939','鄢陵县','0','287','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1940','襄城县','0','287','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1941','禹州市','0','287','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1942','长葛市','0','287','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1943','源汇区','0','288','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1944','郾城区','0','288','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1945','召陵区','0','288','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1946','舞阳县','0','288','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1947','临颍县','0','288','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1948','湖滨区','0','289','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1949','渑池县','0','289','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1950','陕县','0','289','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1951','卢氏县','0','289','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1952','义马市','0','289','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1953','灵宝市','0','289','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1954','宛城区','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1955','卧龙区','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1956','南召县','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1957','方城县','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1958','西峡县','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1959','镇平县','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1960','内乡县','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1961','淅川县','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1962','社旗县','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1963','唐河县','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1964','新野县','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1965','桐柏县','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1966','邓州市','0','290','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1967','梁园区','0','291','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1968','睢阳区','0','291','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1969','民权县','0','291','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1970','睢县','0','291','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1971','宁陵县','0','291','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1972','柘城县','0','291','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1973','虞城县','0','291','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1974','夏邑县','0','291','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1975','永城市','0','291','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1976','浉河区','0','292','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1977','平桥区','0','292','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1978','罗山县','0','292','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1979','光山县','0','292','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1980','新县','0','292','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1981','商城县','0','292','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1982','固始县','0','292','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1983','潢川县','0','292','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1984','淮滨县','0','292','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1985','息县','0','292','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1986','川汇区','0','293','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1987','扶沟县','0','293','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1988','西华县','0','293','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1989','商水县','0','293','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1990','沈丘县','0','293','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1991','郸城县','0','293','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1992','淮阳县','0','293','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1993','太康县','0','293','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1994','鹿邑县','0','293','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1995','项城市','0','293','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1996','驿城区','0','294','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1997','西平县','0','294','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1998','上蔡县','0','294','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('1999','平舆县','0','294','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2000','正阳县','0','294','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2001','确山县','0','294','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2002','泌阳县','0','294','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2003','汝南县','0','294','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2004','遂平县','0','294','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2005','新蔡县','0','294','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2006','江岸区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2007','江汉区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2008','硚口区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2009','汉阳区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2010','武昌区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2011','青山区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2012','洪山区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2013','东西湖区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2014','汉南区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2015','蔡甸区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2016','江夏区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2017','黄陂区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2018','新洲区','0','295','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2019','黄石港区','0','296','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2020','西塞山区','0','296','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2021','下陆区','0','296','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2022','铁山区','0','296','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2023','阳新县','0','296','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2024','大冶市','0','296','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2025','茅箭区','0','297','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2026','张湾区','0','297','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2027','郧县','0','297','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2028','郧西县','0','297','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2029','竹山县','0','297','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2030','竹溪县','0','297','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2031','房县','0','297','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2032','丹江口市','0','297','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2033','西陵区','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2034','伍家岗区','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2035','点军区','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2036','猇亭区','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2037','夷陵区','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2038','远安县','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2039','兴山县','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2040','秭归县','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2041','长阳土家族自治县','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2042','五峰土家族自治县','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2043','宜都市','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2044','当阳市','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2045','枝江市','0','298','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2046','襄城区','0','299','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2047','樊城区','0','299','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2048','襄阳区','0','299','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2049','南漳县','0','299','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2050','谷城县','0','299','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2051','保康县','0','299','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2052','老河口市','0','299','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2053','枣阳市','0','299','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2054','宜城市','0','299','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2055','梁子湖区','0','300','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2056','华容区','0','300','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2057','鄂城区','0','300','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2058','东宝区','0','301','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2059','掇刀区','0','301','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2060','京山县','0','301','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2061','沙洋县','0','301','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2062','钟祥市','0','301','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2063','孝南区','0','302','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2064','孝昌县','0','302','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2065','大悟县','0','302','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2066','云梦县','0','302','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2067','应城市','0','302','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2068','安陆市','0','302','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2069','汉川市','0','302','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2070','沙市区','0','303','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2071','荆州区','0','303','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2072','公安县','0','303','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2073','监利县','0','303','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2074','江陵县','0','303','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2075','石首市','0','303','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2076','洪湖市','0','303','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2077','松滋市','0','303','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2078','黄州区','0','304','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2079','团风县','0','304','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2080','红安县','0','304','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2081','罗田县','0','304','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2082','英山县','0','304','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2083','浠水县','0','304','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2084','蕲春县','0','304','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2085','黄梅县','0','304','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2086','麻城市','0','304','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2087','武穴市','0','304','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2088','咸安区','0','305','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2089','嘉鱼县','0','305','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2090','通城县','0','305','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2091','崇阳县','0','305','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2092','通山县','0','305','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2093','赤壁市','0','305','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2094','曾都区','0','306','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2095','广水市','0','306','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2096','恩施市','0','307','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2097','利川市','0','307','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2098','建始县','0','307','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2099','巴东县','0','307','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2100','宣恩县','0','307','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2101','咸丰县','0','307','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2102','来凤县','0','307','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2103','鹤峰县','0','307','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2104','芙蓉区','0','312','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2105','天心区','0','312','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2106','岳麓区','0','312','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2107','开福区','0','312','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2108','雨花区','0','312','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2109','长沙县','0','312','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2110','望城县','0','312','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2111','宁乡县','0','312','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2112','浏阳市','0','312','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2113','荷塘区','0','313','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2114','芦淞区','0','313','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2115','石峰区','0','313','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2116','天元区','0','313','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2117','株洲县','0','313','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2118','攸县','0','313','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2119','茶陵县','0','313','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2120','炎陵县','0','313','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2121','醴陵市','0','313','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2122','雨湖区','0','314','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2123','岳塘区','0','314','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2124','湘潭县','0','314','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2125','湘乡市','0','314','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2126','韶山市','0','314','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2127','珠晖区','0','315','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2128','雁峰区','0','315','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2129','石鼓区','0','315','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2130','蒸湘区','0','315','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2131','南岳区','0','315','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2132','衡阳县','0','315','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2133','衡南县','0','315','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2134','衡山县','0','315','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2135','衡东县','0','315','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2136','祁东县','0','315','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2137','耒阳市','0','315','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2138','常宁市','0','315','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2139','双清区','0','316','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2140','大祥区','0','316','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2141','北塔区','0','316','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2142','邵东县','0','316','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2143','新邵县','0','316','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2144','邵阳县','0','316','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2145','隆回县','0','316','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2146','洞口县','0','316','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2147','绥宁县','0','316','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2148','新宁县','0','316','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2149','城步苗族自治县','0','316','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2150','武冈市','0','316','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2151','岳阳楼区','0','317','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2152','云溪区','0','317','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2153','君山区','0','317','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2154','岳阳县','0','317','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2155','华容县','0','317','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2156','湘阴县','0','317','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2157','平江县','0','317','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2158','汨罗市','0','317','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2159','临湘市','0','317','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2160','武陵区','0','318','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2161','鼎城区','0','318','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2162','安乡县','0','318','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2163','汉寿县','0','318','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2164','澧县','0','318','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2165','临澧县','0','318','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2166','桃源县','0','318','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2167','石门县','0','318','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2168','津市市','0','318','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2169','永定区','0','319','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2170','武陵源区','0','319','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2171','慈利县','0','319','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2172','桑植县','0','319','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2173','资阳区','0','320','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2174','赫山区','0','320','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2175','南县','0','320','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2176','桃江县','0','320','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2177','安化县','0','320','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2178','沅江市','0','320','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2179','北湖区','0','321','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2180','苏仙区','0','321','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2181','桂阳县','0','321','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2182','宜章县','0','321','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2183','永兴县','0','321','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2184','嘉禾县','0','321','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2185','临武县','0','321','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2186','汝城县','0','321','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2187','桂东县','0','321','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2188','安仁县','0','321','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2189','资兴市','0','321','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2190','零陵区','0','322','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2191','冷水滩区','0','322','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2192','祁阳县','0','322','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2193','东安县','0','322','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2194','双牌县','0','322','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2195','道县','0','322','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2196','江永县','0','322','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2197','宁远县','0','322','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2198','蓝山县','0','322','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2199','新田县','0','322','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2200','江华瑶族自治县','0','322','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2201','鹤城区','0','323','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2202','中方县','0','323','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2203','沅陵县','0','323','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2204','辰溪县','0','323','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2205','溆浦县','0','323','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2206','会同县','0','323','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2207','麻阳苗族自治县','0','323','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2208','新晃侗族自治县','0','323','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2209','芷江侗族自治县','0','323','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2210','靖州苗族侗族自治县','0','323','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2211','通道侗族自治县','0','323','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2212','洪江市','0','323','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2213','娄星区','0','324','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2214','双峰县','0','324','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2215','新化县','0','324','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2216','冷水江市','0','324','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2217','涟源市','0','324','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2218','吉首市','0','325','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2219','泸溪县','0','325','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2220','凤凰县','0','325','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2221','花垣县','0','325','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2222','保靖县','0','325','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2223','古丈县','0','325','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2224','永顺县','0','325','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2225','龙山县','0','325','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2226','荔湾区','0','326','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2227','越秀区','0','326','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2228','海珠区','0','326','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2229','天河区','0','326','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2230','白云区','0','326','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2231','黄埔区','0','326','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2232','番禺区','0','326','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2233','花都区','0','326','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2234','南沙区','0','326','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2235','萝岗区','0','326','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2236','增城市','0','326','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2237','从化市','0','326','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2238','武江区','0','327','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2239','浈江区','0','327','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2240','曲江区','0','327','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2241','始兴县','0','327','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2242','仁化县','0','327','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2243','翁源县','0','327','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2244','乳源瑶族自治县','0','327','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2245','新丰县','0','327','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2246','乐昌市','0','327','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2247','南雄市','0','327','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2248','罗湖区','0','328','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2249','福田区','0','328','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2250','南山区','0','328','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2251','宝安区','0','328','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2252','龙岗区','0','328','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2253','盐田区','0','328','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2254','香洲区','0','329','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2255','斗门区','0','329','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2256','金湾区','0','329','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2257','龙湖区','0','330','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2258','金平区','0','330','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2259','濠江区','0','330','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2260','潮阳区','0','330','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2261','潮南区','0','330','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2262','澄海区','0','330','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2263','南澳县','0','330','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2264','禅城区','0','331','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2265','南海区','0','331','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2266','顺德区','0','331','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2267','三水区','0','331','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2268','高明区','0','331','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2269','蓬江区','0','332','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2270','江海区','0','332','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2271','新会区','0','332','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2272','台山市','0','332','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2273','开平市','0','332','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2274','鹤山市','0','332','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2275','恩平市','0','332','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2276','赤坎区','0','333','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2277','霞山区','0','333','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2278','坡头区','0','333','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2279','麻章区','0','333','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2280','遂溪县','0','333','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2281','徐闻县','0','333','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2282','廉江市','0','333','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2283','雷州市','0','333','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2284','吴川市','0','333','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2285','茂南区','0','334','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2286','茂港区','0','334','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2287','电白县','0','334','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2288','高州市','0','334','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2289','化州市','0','334','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2290','信宜市','0','334','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2291','端州区','0','335','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2292','鼎湖区','0','335','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2293','广宁县','0','335','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2294','怀集县','0','335','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2295','封开县','0','335','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2296','德庆县','0','335','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2297','高要市','0','335','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2298','四会市','0','335','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2299','惠城区','0','336','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2300','惠阳区','0','336','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2301','博罗县','0','336','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2302','惠东县','0','336','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2303','龙门县','0','336','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2304','梅江区','0','337','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2305','梅县','0','337','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2306','大埔县','0','337','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2307','丰顺县','0','337','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2308','五华县','0','337','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2309','平远县','0','337','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2310','蕉岭县','0','337','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2311','兴宁市','0','337','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2312','城区','0','338','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2313','海丰县','0','338','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2314','陆河县','0','338','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2315','陆丰市','0','338','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2316','源城区','0','339','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2317','紫金县','0','339','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2318','龙川县','0','339','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2319','连平县','0','339','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2320','和平县','0','339','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2321','东源县','0','339','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2322','江城区','0','340','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2323','阳西县','0','340','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2324','阳东县','0','340','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2325','阳春市','0','340','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2326','清城区','0','341','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2327','佛冈县','0','341','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2328','阳山县','0','341','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2329','连山壮族瑶族自治县','0','341','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2330','连南瑶族自治县','0','341','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2331','清新县','0','341','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2332','英德市','0','341','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2333','连州市','0','341','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2334','湘桥区','0','344','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2335','潮安县','0','344','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2336','饶平县','0','344','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2337','榕城区','0','345','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2338','揭东县','0','345','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2339','揭西县','0','345','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2340','惠来县','0','345','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2341','普宁市','0','345','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2342','云城区','0','346','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2343','新兴县','0','346','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2344','郁南县','0','346','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2345','云安县','0','346','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2346','罗定市','0','346','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2347','兴宁区','0','347','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2348','青秀区','0','347','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2349','江南区','0','347','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2350','西乡塘区','0','347','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2351','良庆区','0','347','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2352','邕宁区','0','347','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2353','武鸣县','0','347','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2354','隆安县','0','347','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2355','马山县','0','347','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2356','上林县','0','347','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2357','宾阳县','0','347','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2358','横县','0','347','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2359','城中区','0','348','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2360','鱼峰区','0','348','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2361','柳南区','0','348','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2362','柳北区','0','348','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2363','柳江县','0','348','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2364','柳城县','0','348','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2365','鹿寨县','0','348','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2366','融安县','0','348','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2367','融水苗族自治县','0','348','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2368','三江侗族自治县','0','348','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2369','秀峰区','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2370','叠彩区','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2371','象山区','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2372','七星区','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2373','雁山区','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2374','阳朔县','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2375','临桂县','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2376','灵川县','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2377','全州县','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2378','兴安县','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2379','永福县','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2380','灌阳县','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2381','龙胜各族自治县','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2382','资源县','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2383','平乐县','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2384','荔蒲县','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2385','恭城瑶族自治县','0','349','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2386','万秀区','0','350','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2387','蝶山区','0','350','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2388','长洲区','0','350','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2389','苍梧县','0','350','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2390','藤县','0','350','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2391','蒙山县','0','350','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2392','岑溪市','0','350','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2393','海城区','0','351','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2394','银海区','0','351','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2395','铁山港区','0','351','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2396','合浦县','0','351','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2397','港口区','0','352','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2398','防城区','0','352','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2399','上思县','0','352','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2400','东兴市','0','352','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2401','钦南区','0','353','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2402','钦北区','0','353','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2403','灵山县','0','353','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2404','浦北县','0','353','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2405','港北区','0','354','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2406','港南区','0','354','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2407','覃塘区','0','354','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2408','平南县','0','354','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2409','桂平市','0','354','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2410','玉州区','0','355','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2411','容县','0','355','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2412','陆川县','0','355','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2413','博白县','0','355','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2414','兴业县','0','355','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2415','北流市','0','355','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2416','右江区','0','356','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2417','田阳县','0','356','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2418','田东县','0','356','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2419','平果县','0','356','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2420','德保县','0','356','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2421','靖西县','0','356','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2422','那坡县','0','356','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2423','凌云县','0','356','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2424','乐业县','0','356','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2425','田林县','0','356','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2426','西林县','0','356','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2427','隆林各族自治县','0','356','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2428','八步区','0','357','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2429','昭平县','0','357','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2430','钟山县','0','357','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2431','富川瑶族自治县','0','357','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2432','金城江区','0','358','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2433','南丹县','0','358','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2434','天峨县','0','358','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2435','凤山县','0','358','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2436','东兰县','0','358','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2437','罗城仫佬族自治县','0','358','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2438','环江毛南族自治县','0','358','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2439','巴马瑶族自治县','0','358','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2440','都安瑶族自治县','0','358','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2441','大化瑶族自治县','0','358','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2442','宜州市','0','358','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2443','兴宾区','0','359','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2444','忻城县','0','359','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2445','象州县','0','359','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2446','武宣县','0','359','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2447','金秀瑶族自治县','0','359','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2448','合山市','0','359','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2449','江洲区','0','360','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2450','扶绥县','0','360','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2451','宁明县','0','360','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2452','龙州县','0','360','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2453','大新县','0','360','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2454','天等县','0','360','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2455','凭祥市','0','360','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2456','秀英区','0','361','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2457','龙华区','0','361','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2458','琼山区','0','361','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2459','美兰区','0','361','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2460','锦江区','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2461','青羊区','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2462','金牛区','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2463','武侯区','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2464','成华区','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2465','龙泉驿区','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2466','青白江区','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2467','新都区','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2468','温江区','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2469','金堂县','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2470','双流县','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2471','郫县','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2472','大邑县','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2473','蒲江县','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2474','新津县','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2475','都江堰市','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2476','彭州市','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2477','邛崃市','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2478','崇州市','0','382','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2479','自流井区','0','383','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2480','贡井区','0','383','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2481','大安区','0','383','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2482','沿滩区','0','383','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2483','荣县','0','383','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2484','富顺县','0','383','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2485','东区','0','384','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2486','西区','0','384','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2487','仁和区','0','384','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2488','米易县','0','384','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2489','盐边县','0','384','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2490','江阳区','0','385','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2491','纳溪区','0','385','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2492','龙马潭区','0','385','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2493','泸县','0','385','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2494','合江县','0','385','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2495','叙永县','0','385','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2496','古蔺县','0','385','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2497','旌阳区','0','386','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2498','中江县','0','386','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2499','罗江县','0','386','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2500','广汉市','0','386','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2501','什邡市','0','386','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2502','绵竹市','0','386','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2503','涪城区','0','387','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2504','游仙区','0','387','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2505','三台县','0','387','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2506','盐亭县','0','387','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2507','安县','0','387','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2508','梓潼县','0','387','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2509','北川羌族自治县','0','387','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2510','平武县','0','387','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2511','江油市','0','387','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2512','市中区','0','388','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2513','元坝区','0','388','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2514','朝天区','0','388','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2515','旺苍县','0','388','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2516','青川县','0','388','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2517','剑阁县','0','388','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2518','苍溪县','0','388','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2519','船山区','0','389','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2520','安居区','0','389','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2521','蓬溪县','0','389','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2522','射洪县','0','389','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2523','大英县','0','389','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2524','市中区','0','390','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2525','东兴区','0','390','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2526','威远县','0','390','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2527','资中县','0','390','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2528','隆昌县','0','390','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2529','市中区','0','391','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2530','沙湾区','0','391','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2531','五通桥区','0','391','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2532','金口河区','0','391','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2533','犍为县','0','391','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2534','井研县','0','391','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2535','夹江县','0','391','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2536','沐川县','0','391','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2537','峨边彝族自治县','0','391','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2538','马边彝族自治县','0','391','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2539','峨眉山市','0','391','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2540','顺庆区','0','392','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2541','高坪区','0','392','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2542','嘉陵区','0','392','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2543','南部县','0','392','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2544','营山县','0','392','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2545','蓬安县','0','392','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2546','仪陇县','0','392','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2547','西充县','0','392','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2548','阆中市','0','392','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2549','东坡区','0','393','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2550','仁寿县','0','393','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2551','彭山县','0','393','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2552','洪雅县','0','393','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2553','丹棱县','0','393','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2554','青神县','0','393','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2555','翠屏区','0','394','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2556','宜宾县','0','394','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2557','南溪县','0','394','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2558','江安县','0','394','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2559','长宁县','0','394','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2560','高县','0','394','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2561','珙县','0','394','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2562','筠连县','0','394','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2563','兴文县','0','394','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2564','屏山县','0','394','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2565','广安区','0','395','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2566','岳池县','0','395','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2567','武胜县','0','395','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2568','邻水县','0','395','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2569','华蓥市','0','395','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2570','通川区','0','396','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2571','达县','0','396','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2572','宣汉县','0','396','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2573','开江县','0','396','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2574','大竹县','0','396','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2575','渠县','0','396','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2576','万源市','0','396','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2577','雨城区','0','397','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2578','名山县','0','397','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2579','荥经县','0','397','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2580','汉源县','0','397','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2581','石棉县','0','397','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2582','天全县','0','397','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2583','芦山县','0','397','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2584','宝兴县','0','397','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2585','巴州区','0','398','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2586','通江县','0','398','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2587','南江县','0','398','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2588','平昌县','0','398','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2589','雁江区','0','399','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2590','安岳县','0','399','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2591','乐至县','0','399','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2592','简阳市','0','399','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2593','汶川县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2594','理县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2595','茂县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2596','松潘县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2597','九寨沟县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2598','金川县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2599','小金县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2600','黑水县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2601','马尔康县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2602','壤塘县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2603','阿坝县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2604','若尔盖县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2605','红原县','0','400','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2606','康定县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2607','泸定县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2608','丹巴县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2609','九龙县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2610','雅江县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2611','道孚县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2612','炉霍县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2613','甘孜县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2614','新龙县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2615','德格县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2616','白玉县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2617','石渠县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2618','色达县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2619','理塘县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2620','巴塘县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2621','乡城县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2622','稻城县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2623','得荣县','0','401','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2624','西昌市','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2625','木里藏族自治县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2626','盐源县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2627','德昌县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2628','会理县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2629','会东县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2630','宁南县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2631','普格县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2632','布拖县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2633','金阳县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2634','昭觉县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2635','喜德县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2636','冕宁县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2637','越西县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2638','甘洛县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2639','美姑县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2640','雷波县','0','402','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2641','南明区','0','403','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2642','云岩区','0','403','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2643','花溪区','0','403','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2644','乌当区','0','403','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2645','白云区','0','403','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2646','小河区','0','403','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2647','开阳县','0','403','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2648','息烽县','0','403','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2649','修文县','0','403','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2650','清镇市','0','403','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2651','钟山区','0','404','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2652','六枝特区','0','404','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2653','水城县','0','404','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2654','盘县','0','404','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2655','红花岗区','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2656','汇川区','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2657','遵义县','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2658','桐梓县','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2659','绥阳县','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2660','正安县','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2661','道真仡佬族苗族自治县','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2662','务川仡佬族苗族自治县','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2663','凤冈县','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2664','湄潭县','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2665','余庆县','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2666','习水县','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2667','赤水市','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2668','仁怀市','0','405','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2669','西秀区','0','406','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2670','平坝县','0','406','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2671','普定县','0','406','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2672','镇宁布依族苗族自治县','0','406','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2673','关岭布依族苗族自治县','0','406','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2674','紫云苗族布依族自治县','0','406','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2675','铜仁市','0','407','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2676','江口县','0','407','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2677','玉屏侗族自治县','0','407','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2678','石阡县','0','407','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2679','思南县','0','407','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2680','印江土家族苗族自治县','0','407','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2681','德江县','0','407','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2682','沿河土家族自治县','0','407','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2683','松桃苗族自治县','0','407','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2684','万山特区','0','407','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2685','兴义市','0','408','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2686','兴仁县','0','408','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2687','普安县','0','408','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2688','晴隆县','0','408','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2689','贞丰县','0','408','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2690','望谟县','0','408','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2691','册亨县','0','408','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2692','安龙县','0','408','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2693','毕节市','0','409','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2694','大方县','0','409','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2695','黔西县','0','409','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2696','金沙县','0','409','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2697','织金县','0','409','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2698','纳雍县','0','409','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2699','威宁彝族回族苗族自治县','0','409','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2700','赫章县','0','409','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2701','凯里市','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2702','黄平县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2703','施秉县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2704','三穗县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2705','镇远县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2706','岑巩县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2707','天柱县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2708','锦屏县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2709','剑河县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2710','台江县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2711','黎平县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2712','榕江县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2713','从江县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2714','雷山县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2715','麻江县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2716','丹寨县','0','410','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2717','都匀市','0','411','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2718','福泉市','0','411','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2719','荔波县','0','411','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2720','贵定县','0','411','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2721','瓮安县','0','411','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2722','独山县','0','411','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2723','平塘县','0','411','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2724','罗甸县','0','411','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2725','长顺县','0','411','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2726','龙里县','0','411','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2727','惠水县','0','411','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2728','三都水族自治县','0','411','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2729','五华区','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2730','盘龙区','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2731','官渡区','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2732','西山区','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2733','东川区','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2734','呈贡县','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2735','晋宁县','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2736','富民县','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2737','宜良县','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2738','石林彝族自治县','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2739','嵩明县','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2740','禄劝彝族苗族自治县','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2741','寻甸回族彝族自治县','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2742','安宁市','0','412','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2743','麒麟区','0','413','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2744','马龙县','0','413','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2745','陆良县','0','413','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2746','师宗县','0','413','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2747','罗平县','0','413','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2748','富源县','0','413','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2749','会泽县','0','413','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2750','沾益县','0','413','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2751','宣威市','0','413','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2752','红塔区','0','414','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2753','江川县','0','414','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2754','澄江县','0','414','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2755','通海县','0','414','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2756','华宁县','0','414','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2757','易门县','0','414','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2758','峨山彝族自治县','0','414','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2759','新平彝族傣族自治县','0','414','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2760','元江哈尼族彝族傣族自治县','0','414','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2761','隆阳区','0','415','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2762','施甸县','0','415','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2763','腾冲县','0','415','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2764','龙陵县','0','415','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2765','昌宁县','0','415','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2766','昭阳区','0','416','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2767','鲁甸县','0','416','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2768','巧家县','0','416','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2769','盐津县','0','416','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2770','大关县','0','416','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2771','永善县','0','416','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2772','绥江县','0','416','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2773','镇雄县','0','416','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2774','彝良县','0','416','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2775','威信县','0','416','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2776','水富县','0','416','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2777','古城区','0','417','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2778','玉龙纳西族自治县','0','417','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2779','永胜县','0','417','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2780','华坪县','0','417','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2781','宁蒗彝族自治县','0','417','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2782','翠云区','0','418','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2783','普洱哈尼族彝族自治县','0','418','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2784','墨江哈尼族自治县','0','418','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2785','景东彝族自治县','0','418','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2786','景谷傣族彝族自治县','0','418','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2787','镇沅彝族哈尼族拉祜族自治县','0','418','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2788','江城哈尼族彝族自治县','0','418','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2789','孟连傣族拉祜族佤族自治县','0','418','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2790','澜沧拉祜族自治县','0','418','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2791','西盟佤族自治县','0','418','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2792','临翔区','0','419','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2793','凤庆县','0','419','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2794','云县','0','419','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2795','永德县','0','419','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2796','镇康县','0','419','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2797','双江拉祜族佤族布朗族傣族自治县','0','419','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2798','耿马傣族佤族自治县','0','419','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2799','沧源佤族自治县','0','420','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2800','楚雄市','0','420','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2801','双柏县','0','420','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2802','牟定县','0','420','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2803','南华县','0','420','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2804','姚安县','0','420','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2805','大姚县','0','420','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2806','永仁县','0','420','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2807','元谋县','0','420','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2808','武定县','0','420','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2809','禄丰县','0','420','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2810','个旧市','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2811','开远市','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2812','蒙自县','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2813','屏边苗族自治县','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2814','建水县','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2815','石屏县','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2816','弥勒县','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2817','泸西县','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2818','元阳县','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2819','红河县','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2820','金平苗族瑶族傣族自治县','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2821','绿春县','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2822','河口瑶族自治县','0','421','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2823','文山县','0','422','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2824','砚山县','0','422','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2825','西畴县','0','422','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2826','麻栗坡县','0','422','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2827','马关县','0','422','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2828','丘北县','0','422','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2829','广南县','0','422','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2830','富宁县','0','422','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2831','景洪市','0','423','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2832','勐海县','0','423','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2833','勐腊县','0','423','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2834','大理市','0','424','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2835','漾濞彝族自治县','0','424','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2836','祥云县','0','424','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2837','宾川县','0','424','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2838','弥渡县','0','424','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2839','南涧彝族自治县','0','424','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2840','巍山彝族回族自治县','0','424','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2841','永平县','0','424','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2842','云龙县','0','424','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2843','洱源县','0','424','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2844','剑川县','0','424','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2845','鹤庆县','0','424','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2846','瑞丽市','0','425','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2847','潞西市','0','425','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2848','梁河县','0','425','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2849','盈江县','0','425','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2850','陇川县','0','425','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2851','泸水县','0','426','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2852','福贡县','0','426','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2853','贡山独龙族怒族自治县','0','426','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2854','兰坪白族普米族自治县','0','426','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2855','香格里拉县','0','427','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2856','德钦县','0','427','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2857','维西傈僳族自治县','0','427','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2858','城关区','0','428','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2859','林周县','0','428','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2860','当雄县','0','428','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2861','尼木县','0','428','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2862','曲水县','0','428','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2863','堆龙德庆县','0','428','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2864','达孜县','0','428','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2865','墨竹工卡县','0','428','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2866','昌都县','0','429','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2867','江达县','0','429','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2868','贡觉县','0','429','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2869','类乌齐县','0','429','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2870','丁青县','0','429','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2871','察雅县','0','429','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2872','八宿县','0','429','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2873','左贡县','0','429','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2874','芒康县','0','429','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2875','洛隆县','0','429','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2876','边坝县','0','429','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2877','乃东县','0','430','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2878','扎囊县','0','430','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2879','贡嘎县','0','430','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2880','桑日县','0','430','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2881','琼结县','0','430','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2882','曲松县','0','430','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2883','措美县','0','430','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2884','洛扎县','0','430','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2885','加查县','0','430','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2886','隆子县','0','430','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2887','错那县','0','430','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2888','浪卡子县','0','430','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2889','日喀则市','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2890','南木林县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2891','江孜县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2892','定日县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2893','萨迦县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2894','拉孜县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2895','昂仁县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2896','谢通门县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2897','白朗县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2898','仁布县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2899','康马县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2900','定结县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2901','仲巴县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2902','亚东县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2903','吉隆县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2904','聂拉木县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2905','萨嘎县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2906','岗巴县','0','431','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2907','那曲县','0','432','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2908','嘉黎县','0','432','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2909','比如县','0','432','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2910','聂荣县','0','432','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2911','安多县','0','432','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2912','申扎县','0','432','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2913','索县','0','432','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2914','班戈县','0','432','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2915','巴青县','0','432','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2916','尼玛县','0','432','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2917','普兰县','0','433','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2918','札达县','0','433','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2919','噶尔县','0','433','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2920','日土县','0','433','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2921','革吉县','0','433','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2922','改则县','0','433','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2923','措勤县','0','433','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2924','林芝县','0','434','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2925','工布江达县','0','434','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2926','米林县','0','434','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2927','墨脱县','0','434','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2928','波密县','0','434','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2929','察隅县','0','434','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2930','朗县','0','434','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2931','新城区','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2932','碑林区','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2933','莲湖区','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2934','灞桥区','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2935','未央区','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2936','雁塔区','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2937','阎良区','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2938','临潼区','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2939','长安区','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2940','蓝田县','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2941','周至县','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2942','户县','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2943','高陵县','0','435','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2944','王益区','0','436','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2945','印台区','0','436','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2946','耀州区','0','436','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2947','宜君县','0','436','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2948','渭滨区','0','437','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2949','金台区','0','437','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2950','陈仓区','0','437','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2951','凤翔县','0','437','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2952','岐山县','0','437','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2953','扶风县','0','437','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2954','眉县','0','437','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2955','陇县','0','437','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2956','千阳县','0','437','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2957','麟游县','0','437','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2958','凤县','0','437','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2959','太白县','0','437','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2960','秦都区','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2961','杨凌区','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2962','渭城区','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2963','三原县','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2964','泾阳县','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2965','乾县','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2966','礼泉县','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2967','永寿县','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2968','彬县','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2969','长武县','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2970','旬邑县','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2971','淳化县','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2972','武功县','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2973','兴平市','0','438','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2974','临渭区','0','439','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2975','华县','0','439','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2976','潼关县','0','439','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2977','大荔县','0','439','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2978','合阳县','0','439','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2979','澄城县','0','439','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2980','蒲城县','0','439','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2981','白水县','0','439','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2982','富平县','0','439','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2983','韩城市','0','439','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2984','华阴市','0','439','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2985','宝塔区','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2986','延长县','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2987','延川县','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2988','子长县','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2989','安塞县','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2990','志丹县','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2991','吴起县','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2992','甘泉县','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2993','富县','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2994','洛川县','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2995','宜川县','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2996','黄龙县','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2997','黄陵县','0','440','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2998','汉台区','0','441','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('2999','南郑县','0','441','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3000','城固县','0','441','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3001','洋县','0','441','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3002','西乡县','0','441','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3003','勉县','0','441','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3004','宁强县','0','441','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3005','略阳县','0','441','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3006','镇巴县','0','441','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3007','留坝县','0','441','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3008','佛坪县','0','441','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3009','榆阳区','0','442','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3010','神木县','0','442','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3011','府谷县','0','442','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3012','横山县','0','442','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3013','靖边县','0','442','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3014','定边县','0','442','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3015','绥德县','0','442','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3016','米脂县','0','442','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3017','佳县','0','442','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3018','吴堡县','0','442','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3019','清涧县','0','442','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3020','子洲县','0','442','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3021','汉滨区','0','443','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3022','汉阴县','0','443','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3023','石泉县','0','443','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3024','宁陕县','0','443','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3025','紫阳县','0','443','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3026','岚皋县','0','443','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3027','平利县','0','443','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3028','镇坪县','0','443','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3029','旬阳县','0','443','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3030','白河县','0','443','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3031','商州区','0','444','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3032','洛南县','0','444','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3033','丹凤县','0','444','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3034','商南县','0','444','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3035','山阳县','0','444','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3036','镇安县','0','444','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3037','柞水县','0','444','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3038','城关区','0','445','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3039','七里河区','0','445','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3040','西固区','0','445','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3041','安宁区','0','445','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3042','红古区','0','445','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3043','永登县','0','445','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3044','皋兰县','0','445','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3045','榆中县','0','445','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3046','金川区','0','447','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3047','永昌县','0','447','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3048','白银区','0','448','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3049','平川区','0','448','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3050','靖远县','0','448','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3051','会宁县','0','448','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3052','景泰县','0','448','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3053','秦城区','0','449','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3054','北道区','0','449','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3055','清水县','0','449','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3056','秦安县','0','449','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3057','甘谷县','0','449','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3058','武山县','0','449','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3059','张家川回族自治县','0','449','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3060','凉州区','0','450','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3061','民勤县','0','450','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3062','古浪县','0','450','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3063','天祝藏族自治县','0','450','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3064','甘州区','0','451','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3065','肃南裕固族自治县','0','451','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3066','民乐县','0','451','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3067','临泽县','0','451','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3068','高台县','0','451','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3069','山丹县','0','451','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3070','崆峒区','0','452','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3071','泾川县','0','452','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3072','灵台县','0','452','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3073','崇信县','0','452','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3074','华亭县','0','452','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3075','庄浪县','0','452','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3076','静宁县','0','452','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3077','肃州区','0','453','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3078','金塔县','0','453','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3079','瓜州县','0','453','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3080','肃北蒙古族自治县','0','453','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3081','阿克塞哈萨克族自治县','0','453','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3082','玉门市','0','453','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3083','敦煌市','0','453','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3084','西峰区','0','454','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3085','庆城县','0','454','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3086','环县','0','454','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3087','华池县','0','454','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3088','合水县','0','454','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3089','正宁县','0','454','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3090','宁县','0','454','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3091','镇原县','0','454','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3092','安定区','0','455','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3093','通渭县','0','455','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3094','陇西县','0','455','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3095','渭源县','0','455','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3096','临洮县','0','455','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3097','漳县','0','455','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3098','岷县','0','455','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3099','武都区','0','456','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3100','成县','0','456','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3101','文县','0','456','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3102','宕昌县','0','456','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3103','康县','0','456','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3104','西和县','0','456','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3105','礼县','0','456','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3106','徽县','0','456','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3107','两当县','0','456','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3108','临夏市','0','457','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3109','临夏县','0','457','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3110','康乐县','0','457','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3111','永靖县','0','457','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3112','广河县','0','457','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3113','和政县','0','457','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3114','东乡族自治县','0','457','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3115','积石山保安族东乡族撒拉族自治县','0','457','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3116','合作市','0','458','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3117','临潭县','0','458','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3118','卓尼县','0','458','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3119','舟曲县','0','458','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3120','迭部县','0','458','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3121','玛曲县','0','458','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3122','碌曲县','0','458','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3123','夏河县','0','458','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3124','城东区','0','459','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3125','城中区','0','459','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3126','城西区','0','459','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3127','城北区','0','459','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3128','大通回族土族自治县','0','459','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3129','湟中县','0','459','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3130','湟源县','0','459','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3131','平安县','0','460','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3132','民和回族土族自治县','0','460','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3133','乐都县','0','460','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3134','互助土族自治县','0','460','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3135','化隆回族自治县','0','460','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3136','循化撒拉族自治县','0','460','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3137','门源回族自治县','0','461','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3138','祁连县','0','461','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3139','海晏县','0','461','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3140','刚察县','0','461','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3141','同仁县','0','462','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3142','尖扎县','0','462','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3143','泽库县','0','462','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3144','河南蒙古族自治县','0','462','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3145','共和县','0','463','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3146','同德县','0','463','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3147','贵德县','0','463','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3148','兴海县','0','463','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3149','贵南县','0','463','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3150','玛沁县','0','464','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3151','班玛县','0','464','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3152','甘德县','0','464','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3153','达日县','0','464','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3154','久治县','0','464','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3155','玛多县','0','464','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3156','玉树县','0','465','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3157','杂多县','0','465','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3158','称多县','0','465','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3159','治多县','0','465','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3160','囊谦县','0','465','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3161','曲麻莱县','0','465','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3162','格尔木市','0','466','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3163','德令哈市','0','466','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3164','乌兰县','0','466','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3165','都兰县','0','466','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3166','天峻县','0','466','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3167','兴庆区','0','467','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3168','西夏区','0','467','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3169','金凤区','0','467','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3170','永宁县','0','467','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3171','贺兰县','0','467','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3172','灵武市','0','467','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3173','大武口区','0','468','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3174','惠农区','0','468','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3175','平罗县','0','468','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3176','利通区','0','469','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3177','盐池县','0','469','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3178','同心县','0','469','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3179','青铜峡市','0','469','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3180','原州区','0','470','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3181','西吉县','0','470','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3182','隆德县','0','470','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3183','泾源县','0','470','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3184','彭阳县','0','470','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3185','沙坡头区','0','471','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3186','中宁县','0','471','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3187','海原县','0','471','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3188','天山区','0','472','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3189','沙依巴克区','0','472','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3190','新市区','0','472','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3191','水磨沟区','0','472','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3192','头屯河区','0','472','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3193','达坂城区','0','472','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3194','东山区','0','472','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3195','乌鲁木齐县','0','472','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3196','独山子区','0','473','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3197','克拉玛依区','0','473','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3198','白碱滩区','0','473','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3199','乌尔禾区','0','473','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3200','吐鲁番市','0','474','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3201','鄯善县','0','474','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3202','托克逊县','0','474','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3203','哈密市','0','475','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3204','巴里坤哈萨克自治县','0','475','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3205','伊吾县','0','475','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3206','昌吉市','0','476','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3207','阜康市','0','476','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3208','米泉市','0','476','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3209','呼图壁县','0','476','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3210','玛纳斯县','0','476','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3211','奇台县','0','476','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3212','吉木萨尔县','0','476','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3213','木垒哈萨克自治县','0','476','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3214','博乐市','0','477','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3215','精河县','0','477','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3216','温泉县','0','477','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3217','库尔勒市','0','478','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3218','轮台县','0','478','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3219','尉犁县','0','478','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3220','若羌县','0','478','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3221','且末县','0','478','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3222','焉耆回族自治县','0','478','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3223','和静县','0','478','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3224','和硕县','0','478','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3225','博湖县','0','478','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3226','阿克苏市','0','479','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3227','温宿县','0','479','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3228','库车县','0','479','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3229','沙雅县','0','479','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3230','新和县','0','479','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3231','拜城县','0','479','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3232','乌什县','0','479','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3233','阿瓦提县','0','479','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3234','柯坪县','0','479','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3235','阿图什市','0','480','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3236','阿克陶县','0','480','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3237','阿合奇县','0','480','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3238','乌恰县','0','480','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3239','喀什市','0','481','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3240','疏附县','0','481','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3241','疏勒县','0','481','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3242','英吉沙县','0','481','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3243','泽普县','0','481','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3244','莎车县','0','481','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3245','叶城县','0','481','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3246','麦盖提县','0','481','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3247','岳普湖县','0','481','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3248','伽师县','0','481','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3249','巴楚县','0','481','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3250','塔什库尔干塔吉克自治县','0','481','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3251','和田市','0','482','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3252','和田县','0','482','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3253','墨玉县','0','482','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3254','皮山县','0','482','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3255','洛浦县','0','482','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3256','策勒县','0','482','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3257','于田县','0','482','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3258','民丰县','0','482','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3259','伊宁市','0','483','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3260','奎屯市','0','483','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3261','伊宁县','0','483','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3262','察布查尔锡伯自治县','0','483','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3263','霍城县','0','483','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3264','巩留县','0','483','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3265','新源县','0','483','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3266','昭苏县','0','483','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3267','特克斯县','0','483','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3268','尼勒克县','0','483','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3269','塔城市','0','484','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3270','乌苏市','0','484','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3271','额敏县','0','484','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3272','沙湾县','0','484','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3273','托里县','0','484','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3274','裕民县','0','484','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3275','和布克赛尔蒙古自治县','0','484','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3276','阿勒泰市','0','485','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3277','布尔津县','0','485','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3278','富蕴县','0','485','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3279','福海县','0','485','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3280','哈巴河县','0','485','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3281','青河县','0','485','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3282','吉木乃县','0','485','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3358','钓鱼岛','','0','0','','1','0','','','0');
INSERT INTO `v9_linkage` VALUES('3359','钓鱼岛','','3358','0','','1','0','','','0');

DROP TABLE IF EXISTS `v9_live`;
CREATE TABLE `v9_live` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` char(80) NOT NULL DEFAULT '',
  `style` char(24) NOT NULL DEFAULT '',
  `thumb` char(100) NOT NULL DEFAULT '',
  `keywords` char(40) NOT NULL DEFAULT '',
  `description` char(255) NOT NULL DEFAULT '',
  `posids` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(100) NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `sysadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  `APPID` varchar(255) NOT NULL DEFAULT '',
  `channel` varchar(255) NOT NULL DEFAULT '',
  `mainPicture` varchar(255) NOT NULL DEFAULT '',
  `certificate` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `v9_live` VALUES('2','13','0','小米雷军的Are you OK ok ok？','','http://localhost/test/uploadfile/2019/1006/20191006052618929.jpg','','','1','http://localhost/test/index.php?m=content&c=index&a=show&catid=13&id=2','0','99','1','0','admin','1570353911','1570354004','d140295873a34978b3a1909bf956e464','1000','','');

DROP TABLE IF EXISTS `v9_live_data`;
CREATE TABLE `v9_live_data` (
  `id` mediumint(8) unsigned DEFAULT '0',
  `content` text NOT NULL,
  `readpoint` smallint(5) unsigned NOT NULL DEFAULT '0',
  `groupids_view` varchar(100) NOT NULL,
  `paginationtype` tinyint(1) NOT NULL,
  `maxcharperpage` mediumint(6) NOT NULL,
  `template` varchar(30) NOT NULL,
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allow_comment` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `relation` varchar(255) NOT NULL DEFAULT '',
  `infomation` mediumtext NOT NULL,
  `substance` mediumtext NOT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_live_data` VALUES('2','','0','','0','10000','','0','1','','小米雷军','');

DROP TABLE IF EXISTS `v9_log`;
CREATE TABLE `v9_log` (
  `logid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `field` varchar(15) NOT NULL,
  `value` int(10) unsigned NOT NULL DEFAULT '0',
  `module` varchar(15) NOT NULL,
  `file` varchar(20) NOT NULL,
  `action` varchar(20) NOT NULL,
  `querystring` varchar(255) NOT NULL,
  `data` mediumtext NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `username` varchar(20) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`logid`),
  KEY `module` (`module`,`file`,`action`),
  KEY `username` (`username`,`action`)
) ENGINE=MyISAM AUTO_INCREMENT=1130 DEFAULT CHARSET=utf8;

INSERT INTO `v9_log` VALUES('1','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2018-01-28 15:25:09');
INSERT INTO `v9_log` VALUES('2','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2018-01-28 15:25:31');
INSERT INTO `v9_log` VALUES('3','','0','link','','link','?m=link&c=link&a=edit','','1','admin','127.0.0.1','2018-01-28 17:55:48');
INSERT INTO `v9_log` VALUES('4','','0','link','','link','?m=link&c=link&a=edit','','1','admin','127.0.0.1','2018-01-28 17:55:53');
INSERT INTO `v9_log` VALUES('5','','0','link','','link','?m=link&c=link&a=listorder','','1','admin','127.0.0.1','2018-01-28 17:56:28');
INSERT INTO `v9_log` VALUES('6','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-01 20:08:46');
INSERT INTO `v9_log` VALUES('7','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-01 20:10:18');
INSERT INTO `v9_log` VALUES('8','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-01 20:11:40');
INSERT INTO `v9_log` VALUES('9','','0','template','','file','?m=template&c=file&a=edit_pc_tag','','1','admin','127.0.0.1','2018-02-01 20:17:10');
INSERT INTO `v9_log` VALUES('10','','0','template','','file','?m=template&c=file&a=updatefilename','','1','admin','127.0.0.1','2018-02-01 20:27:55');
INSERT INTO `v9_log` VALUES('11','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-01 20:33:12');
INSERT INTO `v9_log` VALUES('12','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-01 20:33:37');
INSERT INTO `v9_log` VALUES('13','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-01 20:37:24');
INSERT INTO `v9_log` VALUES('14','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-01 20:37:40');
INSERT INTO `v9_log` VALUES('15','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-01 20:42:11');
INSERT INTO `v9_log` VALUES('16','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-01 20:43:10');
INSERT INTO `v9_log` VALUES('17','','0','content','','sitemodel','?m=content&c=sitemodel&a=add','','1','admin','127.0.0.1','2018-02-01 21:10:10');
INSERT INTO `v9_log` VALUES('18','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-03 19:43:07');
INSERT INTO `v9_log` VALUES('19','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-03 19:43:23');
INSERT INTO `v9_log` VALUES('20','','0','template','','style','?m=template&c=style&a=import','','1','admin','127.0.0.1','2018-02-03 19:43:37');
INSERT INTO `v9_log` VALUES('21','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-03 19:44:42');
INSERT INTO `v9_log` VALUES('22','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-03 19:44:55');
INSERT INTO `v9_log` VALUES('23','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-03 20:11:23');
INSERT INTO `v9_log` VALUES('24','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-03 20:11:53');
INSERT INTO `v9_log` VALUES('25','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-03 20:12:28');
INSERT INTO `v9_log` VALUES('26','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-03 20:12:52');
INSERT INTO `v9_log` VALUES('27','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-03 20:12:58');
INSERT INTO `v9_log` VALUES('28','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-03 20:13:26');
INSERT INTO `v9_log` VALUES('29','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-03 20:13:41');
INSERT INTO `v9_log` VALUES('30','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-03 20:13:43');
INSERT INTO `v9_log` VALUES('31','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-03 20:14:02');
INSERT INTO `v9_log` VALUES('32','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-03 20:15:12');
INSERT INTO `v9_log` VALUES('33','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-03 20:15:43');
INSERT INTO `v9_log` VALUES('34','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-03 20:16:35');
INSERT INTO `v9_log` VALUES('35','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-03 20:17:29');
INSERT INTO `v9_log` VALUES('36','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-03 21:00:52');
INSERT INTO `v9_log` VALUES('37','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-03 21:01:14');
INSERT INTO `v9_log` VALUES('38','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-03 21:01:16');
INSERT INTO `v9_log` VALUES('39','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-03 21:01:44');
INSERT INTO `v9_log` VALUES('40','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-03 21:04:20');
INSERT INTO `v9_log` VALUES('41','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-03 21:27:17');
INSERT INTO `v9_log` VALUES('42','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-03 21:27:26');
INSERT INTO `v9_log` VALUES('43','','0','template','','file','?m=template&c=file&a=edit_pc_tag','','1','admin','127.0.0.1','2018-02-03 21:27:33');
INSERT INTO `v9_log` VALUES('44','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-03 21:33:17');
INSERT INTO `v9_log` VALUES('45','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-03 21:34:01');
INSERT INTO `v9_log` VALUES('46','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-03 21:35:00');
INSERT INTO `v9_log` VALUES('47','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-03 21:36:05');
INSERT INTO `v9_log` VALUES('48','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-03 21:46:40');
INSERT INTO `v9_log` VALUES('49','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-03 21:46:59');
INSERT INTO `v9_log` VALUES('50','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-03 21:47:19');
INSERT INTO `v9_log` VALUES('51','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-03 21:47:40');
INSERT INTO `v9_log` VALUES('52','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-03 21:48:00');
INSERT INTO `v9_log` VALUES('53','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-03 21:48:27');
INSERT INTO `v9_log` VALUES('54','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-03 21:48:32');
INSERT INTO `v9_log` VALUES('55','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 11:03:23');
INSERT INTO `v9_log` VALUES('56','','0','template','','file','?m=template&c=file&a=updatefilename','','1','admin','127.0.0.1','2018-02-04 11:24:33');
INSERT INTO `v9_log` VALUES('57','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 11:24:43');
INSERT INTO `v9_log` VALUES('58','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 11:25:46');
INSERT INTO `v9_log` VALUES('59','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 11:26:24');
INSERT INTO `v9_log` VALUES('60','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-04 11:26:44');
INSERT INTO `v9_log` VALUES('61','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-04 11:26:52');
INSERT INTO `v9_log` VALUES('62','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 11:27:09');
INSERT INTO `v9_log` VALUES('63','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 11:27:30');
INSERT INTO `v9_log` VALUES('64','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 11:27:43');
INSERT INTO `v9_log` VALUES('65','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-04 11:36:30');
INSERT INTO `v9_log` VALUES('66','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-04 11:38:11');
INSERT INTO `v9_log` VALUES('67','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-04 11:40:34');
INSERT INTO `v9_log` VALUES('68','','0','content','','sitemodel','?m=content&c=sitemodel&a=add','','1','admin','127.0.0.1','2018-02-04 11:41:08');
INSERT INTO `v9_log` VALUES('69','','0','content','','sitemodel','?m=content&c=sitemodel&a=edit','','1','admin','127.0.0.1','2018-02-04 11:41:17');
INSERT INTO `v9_log` VALUES('70','','0','content','','sitemodel','?m=content&c=sitemodel&a=edit','','1','admin','127.0.0.1','2018-02-04 11:41:44');
INSERT INTO `v9_log` VALUES('71','','0','template','','file','?m=template&c=file&a=edit_file','','1','admin','127.0.0.1','2018-02-04 11:43:22');
INSERT INTO `v9_log` VALUES('72','','0','template','','file','?m=template&c=file&a=updatefilename','','1','admin','127.0.0.1','2018-02-04 11:43:32');
INSERT INTO `v9_log` VALUES('73','','0','content','','sitemodel','?m=content&c=sitemodel&a=edit','','1','admin','127.0.0.1','2018-02-04 11:44:34');
INSERT INTO `v9_log` VALUES('74','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-04 11:46:07');
INSERT INTO `v9_log` VALUES('75','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-04 11:46:22');
INSERT INTO `v9_log` VALUES('76','','0','content','','sitemodel','?m=content&c=sitemodel&a=edit','','1','admin','127.0.0.1','2018-02-04 11:46:32');
INSERT INTO `v9_log` VALUES('77','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 11:47:44');
INSERT INTO `v9_log` VALUES('78','','0','template','','file','?m=template&c=file&a=updatefilename','','1','admin','127.0.0.1','2018-02-04 11:48:17');
INSERT INTO `v9_log` VALUES('79','','0','content','','sitemodel','?m=content&c=sitemodel&a=edit','','1','admin','127.0.0.1','2018-02-04 11:48:34');
INSERT INTO `v9_log` VALUES('80','','0','content','','sitemodel','?m=content&c=sitemodel&a=edit','','1','admin','127.0.0.1','2018-02-04 11:48:37');
INSERT INTO `v9_log` VALUES('81','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 11:48:52');
INSERT INTO `v9_log` VALUES('82','','0','admin','','category','?m=admin&c=category&a=delete','','1','admin','127.0.0.1','2018-02-04 11:51:14');
INSERT INTO `v9_log` VALUES('83','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 11:51:28');
INSERT INTO `v9_log` VALUES('84','','0','admin','','category','?m=admin&c=category&a=delete','','1','admin','127.0.0.1','2018-02-04 11:52:03');
INSERT INTO `v9_log` VALUES('85','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-04 11:52:08');
INSERT INTO `v9_log` VALUES('86','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-04 11:52:48');
INSERT INTO `v9_log` VALUES('87','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 11:53:12');
INSERT INTO `v9_log` VALUES('88','','0','content','','sitemodel','?m=content&c=sitemodel&a=edit','','1','admin','127.0.0.1','2018-02-04 11:53:25');
INSERT INTO `v9_log` VALUES('89','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 11:53:51');
INSERT INTO `v9_log` VALUES('90','','0','template','','file','?m=template&c=file&a=edit_pc_tag','','1','admin','127.0.0.1','2018-02-04 11:54:24');
INSERT INTO `v9_log` VALUES('91','','0','template','','file','?m=template&c=file&a=edit_pc_tag','','1','admin','127.0.0.1','2018-02-04 11:54:34');
INSERT INTO `v9_log` VALUES('92','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 11:55:33');
INSERT INTO `v9_log` VALUES('93','','0','template','','style','?m=template&c=style&a=disable','','1','admin','127.0.0.1','2018-02-04 11:56:17');
INSERT INTO `v9_log` VALUES('94','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-04 12:02:12');
INSERT INTO `v9_log` VALUES('95','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-04 12:02:26');
INSERT INTO `v9_log` VALUES('96','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 12:03:17');
INSERT INTO `v9_log` VALUES('97','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 12:03:28');
INSERT INTO `v9_log` VALUES('98','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 12:03:30');
INSERT INTO `v9_log` VALUES('99','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 12:03:39');
INSERT INTO `v9_log` VALUES('100','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 12:05:14');
INSERT INTO `v9_log` VALUES('101','','0','admin','','category','?m=admin&c=category&a=delete','','1','admin','127.0.0.1','2018-02-04 12:05:47');
INSERT INTO `v9_log` VALUES('102','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-04 12:06:19');
INSERT INTO `v9_log` VALUES('103','','0','content','','sitemodel','?m=content&c=sitemodel&a=edit','','1','admin','127.0.0.1','2018-02-04 12:06:55');
INSERT INTO `v9_log` VALUES('104','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 12:08:58');
INSERT INTO `v9_log` VALUES('105','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 12:12:57');
INSERT INTO `v9_log` VALUES('106','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-04 12:14:32');
INSERT INTO `v9_log` VALUES('107','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 12:19:24');
INSERT INTO `v9_log` VALUES('108','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 12:19:45');
INSERT INTO `v9_log` VALUES('109','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-04 12:24:38');
INSERT INTO `v9_log` VALUES('110','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-04 12:25:01');
INSERT INTO `v9_log` VALUES('111','','0','admin','','category','?m=admin&c=category&a=delete','','1','admin','127.0.0.1','2018-02-04 12:26:27');
INSERT INTO `v9_log` VALUES('112','','0','content','','content','?m=content&c=content&a=listorder','','1','admin','127.0.0.1','2018-02-04 12:27:36');
INSERT INTO `v9_log` VALUES('113','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 12:31:07');
INSERT INTO `v9_log` VALUES('114','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 12:31:12');
INSERT INTO `v9_log` VALUES('115','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 12:49:01');
INSERT INTO `v9_log` VALUES('116','','0','content','','sitemodel','?m=content&c=sitemodel&a=edit','','1','admin','127.0.0.1','2018-02-04 12:52:24');
INSERT INTO `v9_log` VALUES('117','','0','content','','sitemodel','?m=content&c=sitemodel&a=edit','','1','admin','127.0.0.1','2018-02-04 13:34:10');
INSERT INTO `v9_log` VALUES('118','','0','template','','file','?m=template&c=file&a=updatefilename','','1','admin','127.0.0.1','2018-02-04 13:36:16');
INSERT INTO `v9_log` VALUES('119','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 13:36:22');
INSERT INTO `v9_log` VALUES('120','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 13:45:06');
INSERT INTO `v9_log` VALUES('121','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 13:45:34');
INSERT INTO `v9_log` VALUES('122','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 13:55:11');
INSERT INTO `v9_log` VALUES('123','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 13:56:54');
INSERT INTO `v9_log` VALUES('124','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 13:56:56');
INSERT INTO `v9_log` VALUES('125','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 13:57:36');
INSERT INTO `v9_log` VALUES('126','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 13:58:40');
INSERT INTO `v9_log` VALUES('127','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 13:58:55');
INSERT INTO `v9_log` VALUES('128','','0','block','','block_admin','?m=block&c=block_admin&a=add','','1','admin','127.0.0.1','2018-02-04 14:06:47');
INSERT INTO `v9_log` VALUES('129','','0','block','','block_admin','?m=block&c=block_admin&a=add','','1','admin','127.0.0.1','2018-02-04 14:06:59');
INSERT INTO `v9_log` VALUES('130','','0','block','','block_admin','?m=block&c=block_admin&a=add','','1','admin','127.0.0.1','2018-02-04 14:15:59');
INSERT INTO `v9_log` VALUES('131','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-04 14:16:01');
INSERT INTO `v9_log` VALUES('132','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-04 14:16:47');
INSERT INTO `v9_log` VALUES('133','','0','block','','block_admin','?m=block&c=block_admin&a=add','','1','admin','127.0.0.1','2018-02-04 14:16:57');
INSERT INTO `v9_log` VALUES('134','','0','block','','block_admin','?m=block&c=block_admin&a=add','','1','admin','127.0.0.1','2018-02-04 14:17:08');
INSERT INTO `v9_log` VALUES('135','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-04 14:17:09');
INSERT INTO `v9_log` VALUES('136','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-04 14:17:34');
INSERT INTO `v9_log` VALUES('137','','0','template','','style','?m=template&c=style&a=disable','','1','admin','127.0.0.1','2018-02-04 18:17:39');
INSERT INTO `v9_log` VALUES('138','','0','template','','style','?m=template&c=style&a=disable','','1','admin','127.0.0.1','2018-02-04 18:17:43');
INSERT INTO `v9_log` VALUES('139','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-04 18:18:05');
INSERT INTO `v9_log` VALUES('140','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-04 18:18:14');
INSERT INTO `v9_log` VALUES('141','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 18:19:23');
INSERT INTO `v9_log` VALUES('142','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 18:19:40');
INSERT INTO `v9_log` VALUES('143','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2018-02-04 18:20:09');
INSERT INTO `v9_log` VALUES('144','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2018-02-04 18:20:37');
INSERT INTO `v9_log` VALUES('145','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2018-02-04 18:20:41');
INSERT INTO `v9_log` VALUES('146','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2018-02-04 18:25:54');
INSERT INTO `v9_log` VALUES('147','','0','member','','member_menu','?m=member&c=member_menu&a=manage','','1','admin','127.0.0.1','2018-02-04 18:26:07');
INSERT INTO `v9_log` VALUES('148','','0','template','','style','?m=template&c=style&a=disable','','1','admin','127.0.0.1','2018-02-04 18:31:35');
INSERT INTO `v9_log` VALUES('149','','0','template','','style','?m=template&c=style&a=disable','','1','admin','127.0.0.1','2018-02-04 18:31:38');
INSERT INTO `v9_log` VALUES('150','','0','template','','style','?m=template&c=style&a=updatename','','1','admin','127.0.0.1','2018-02-04 18:31:42');
INSERT INTO `v9_log` VALUES('151','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-04 18:31:56');
INSERT INTO `v9_log` VALUES('152','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2018-02-04 18:32:04');
INSERT INTO `v9_log` VALUES('153','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 18:32:32');
INSERT INTO `v9_log` VALUES('154','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 18:33:19');
INSERT INTO `v9_log` VALUES('155','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 18:33:21');
INSERT INTO `v9_log` VALUES('156','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 18:33:53');
INSERT INTO `v9_log` VALUES('157','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 18:33:56');
INSERT INTO `v9_log` VALUES('158','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 18:34:23');
INSERT INTO `v9_log` VALUES('159','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 18:34:25');
INSERT INTO `v9_log` VALUES('160','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-04 18:34:44');
INSERT INTO `v9_log` VALUES('161','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 18:37:23');
INSERT INTO `v9_log` VALUES('162','','0','template','','file','?m=template&c=file&a=edit_pc_tag','','1','admin','127.0.0.1','2018-02-04 18:37:27');
INSERT INTO `v9_log` VALUES('163','','0','template','','file','?m=template&c=file&a=edit_pc_tag','','1','admin','127.0.0.1','2018-02-04 18:38:10');
INSERT INTO `v9_log` VALUES('164','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 18:43:31');
INSERT INTO `v9_log` VALUES('165','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-04 18:44:01');
INSERT INTO `v9_log` VALUES('166','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 18:47:41');
INSERT INTO `v9_log` VALUES('167','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 18:48:12');
INSERT INTO `v9_log` VALUES('168','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 18:48:19');
INSERT INTO `v9_log` VALUES('169','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 18:48:45');
INSERT INTO `v9_log` VALUES('170','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2018-02-04 18:51:07');
INSERT INTO `v9_log` VALUES('171','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2018-02-04 18:51:36');
INSERT INTO `v9_log` VALUES('172','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2018-02-04 18:51:58');
INSERT INTO `v9_log` VALUES('173','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2018-02-04 18:52:39');
INSERT INTO `v9_log` VALUES('174','','0','content','','content','?m=content&c=content&a=listorder','','1','admin','127.0.0.1','2018-02-04 20:03:53');
INSERT INTO `v9_log` VALUES('175','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 20:05:46');
INSERT INTO `v9_log` VALUES('176','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-04 20:06:36');
INSERT INTO `v9_log` VALUES('177','','0','content','','content','?m=content&c=content&a=listorder','','1','admin','127.0.0.1','2018-02-04 23:12:00');
INSERT INTO `v9_log` VALUES('178','','0','content','','content','?m=content&c=content&a=delete','','1','admin','127.0.0.1','2018-02-04 23:12:17');
INSERT INTO `v9_log` VALUES('179','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-05 18:40:00');
INSERT INTO `v9_log` VALUES('180','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-05 18:40:01');
INSERT INTO `v9_log` VALUES('181','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-05 18:40:13');
INSERT INTO `v9_log` VALUES('182','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-05 18:40:15');
INSERT INTO `v9_log` VALUES('183','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-05 18:40:25');
INSERT INTO `v9_log` VALUES('184','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-05 18:40:56');
INSERT INTO `v9_log` VALUES('185','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-05 18:41:07');
INSERT INTO `v9_log` VALUES('186','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:41:19');
INSERT INTO `v9_log` VALUES('187','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:41:56');
INSERT INTO `v9_log` VALUES('188','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:41:57');
INSERT INTO `v9_log` VALUES('189','','0','block','','block_admin','?m=block&c=block_admin&a=add','','1','admin','127.0.0.1','2018-02-05 18:42:23');
INSERT INTO `v9_log` VALUES('190','','0','block','','block_admin','?m=block&c=block_admin&a=add','','1','admin','127.0.0.1','2018-02-05 18:43:03');
INSERT INTO `v9_log` VALUES('191','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-05 18:43:05');
INSERT INTO `v9_log` VALUES('192','','0','template','','file','?m=template&c=file&a=visualization','','1','admin','127.0.0.1','2018-02-05 18:44:37');
INSERT INTO `v9_log` VALUES('193','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:45:05');
INSERT INTO `v9_log` VALUES('194','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:46:16');
INSERT INTO `v9_log` VALUES('195','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:46:18');
INSERT INTO `v9_log` VALUES('196','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:46:39');
INSERT INTO `v9_log` VALUES('197','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:46:48');
INSERT INTO `v9_log` VALUES('198','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:48:19');
INSERT INTO `v9_log` VALUES('199','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-05 18:48:27');
INSERT INTO `v9_log` VALUES('200','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-05 18:49:08');
INSERT INTO `v9_log` VALUES('201','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:49:18');
INSERT INTO `v9_log` VALUES('202','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:49:36');
INSERT INTO `v9_log` VALUES('203','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:49:38');
INSERT INTO `v9_log` VALUES('204','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:50:32');
INSERT INTO `v9_log` VALUES('205','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-05 18:51:11');
INSERT INTO `v9_log` VALUES('206','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-05 18:51:35');
INSERT INTO `v9_log` VALUES('207','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-05 18:51:45');
INSERT INTO `v9_log` VALUES('208','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:51:52');
INSERT INTO `v9_log` VALUES('209','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:51:58');
INSERT INTO `v9_log` VALUES('210','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:51:59');
INSERT INTO `v9_log` VALUES('211','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:53:46');
INSERT INTO `v9_log` VALUES('212','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:53:48');
INSERT INTO `v9_log` VALUES('213','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 18:54:01');
INSERT INTO `v9_log` VALUES('214','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-05 20:01:27');
INSERT INTO `v9_log` VALUES('215','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-05 20:01:40');
INSERT INTO `v9_log` VALUES('216','','0','block','','block_admin','?m=block&c=block_admin&a=edit','','1','admin','127.0.0.1','2018-02-05 20:02:08');
INSERT INTO `v9_log` VALUES('217','','0','block','','block_admin','?m=block&c=block_admin&a=edit','','1','admin','127.0.0.1','2018-02-05 20:02:14');
INSERT INTO `v9_log` VALUES('218','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-05 20:02:18');
INSERT INTO `v9_log` VALUES('219','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-05 20:02:25');
INSERT INTO `v9_log` VALUES('220','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-05 20:03:24');
INSERT INTO `v9_log` VALUES('221','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 20:05:38');
INSERT INTO `v9_log` VALUES('222','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-05 20:07:39');
INSERT INTO `v9_log` VALUES('223','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 20:08:26');
INSERT INTO `v9_log` VALUES('224','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 20:09:13');
INSERT INTO `v9_log` VALUES('225','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-05 20:11:32');
INSERT INTO `v9_log` VALUES('226','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-05 20:12:06');
INSERT INTO `v9_log` VALUES('227','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 20:21:37');
INSERT INTO `v9_log` VALUES('228','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-05 20:25:34');
INSERT INTO `v9_log` VALUES('229','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-05 20:25:57');
INSERT INTO `v9_log` VALUES('230','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-05 20:27:49');
INSERT INTO `v9_log` VALUES('231','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 20:28:08');
INSERT INTO `v9_log` VALUES('232','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 20:28:26');
INSERT INTO `v9_log` VALUES('233','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 20:28:34');
INSERT INTO `v9_log` VALUES('234','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 20:28:50');
INSERT INTO `v9_log` VALUES('235','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2018-02-05 20:28:57');
INSERT INTO `v9_log` VALUES('236','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2018-02-05 20:29:16');
INSERT INTO `v9_log` VALUES('237','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2018-02-10 15:04:49');
INSERT INTO `v9_log` VALUES('238','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2018-02-10 15:05:01');
INSERT INTO `v9_log` VALUES('239','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 15:05:09');
INSERT INTO `v9_log` VALUES('240','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 15:05:16');
INSERT INTO `v9_log` VALUES('241','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 15:05:19');
INSERT INTO `v9_log` VALUES('242','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 15:05:24');
INSERT INTO `v9_log` VALUES('243','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 15:05:25');
INSERT INTO `v9_log` VALUES('244','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 15:05:27');
INSERT INTO `v9_log` VALUES('245','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 15:05:30');
INSERT INTO `v9_log` VALUES('246','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 15:05:36');
INSERT INTO `v9_log` VALUES('247','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 15:05:40');
INSERT INTO `v9_log` VALUES('248','','0','admin','','database','?m=admin&c=database&a=import','','1','admin','127.0.0.1','2018-02-10 15:05:42');
INSERT INTO `v9_log` VALUES('249','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-10 15:46:43');
INSERT INTO `v9_log` VALUES('250','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-10 15:46:59');
INSERT INTO `v9_log` VALUES('251','','0','template','','style','?m=template&c=style&a=export','','1','admin','127.0.0.1','2018-02-10 15:47:21');
INSERT INTO `v9_log` VALUES('252','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-10 17:21:04');
INSERT INTO `v9_log` VALUES('253','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2018-02-10 17:22:00');
INSERT INTO `v9_log` VALUES('254','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 17:27:33');
INSERT INTO `v9_log` VALUES('255','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 17:27:37');
INSERT INTO `v9_log` VALUES('256','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 17:27:42');
INSERT INTO `v9_log` VALUES('257','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2018-02-10 17:27:45');
INSERT INTO `v9_log` VALUES('258','','0','admin','','database','?m=admin&c=database&a=import','','1','admin','127.0.0.1','2018-02-10 17:27:47');
INSERT INTO `v9_log` VALUES('259','','0','block','','block_admin','?m=block&c=block_admin&a=edit','','1','admin','127.0.0.1','2018-02-10 17:32:03');
INSERT INTO `v9_log` VALUES('260','','0','block','','block_admin','?m=block&c=block_admin&a=edit','','1','admin','127.0.0.1','2018-02-10 17:32:06');
INSERT INTO `v9_log` VALUES('261','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-10 17:32:10');
INSERT INTO `v9_log` VALUES('262','','0','block','','block_admin','?m=block&c=block_admin&a=block_update','','1','admin','127.0.0.1','2018-02-10 17:32:50');
INSERT INTO `v9_log` VALUES('263','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-21 19:53:30');
INSERT INTO `v9_log` VALUES('264','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-21 19:53:30');
INSERT INTO `v9_log` VALUES('265','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-21 19:53:44');
INSERT INTO `v9_log` VALUES('266','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 19:53:52');
INSERT INTO `v9_log` VALUES('267','','0','collection','','node','?m=collection&c=node&a=add','','1','admin','127.0.0.1','2018-02-21 19:53:54');
INSERT INTO `v9_log` VALUES('268','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 19:54:00');
INSERT INTO `v9_log` VALUES('269','','0','collection','','node','?m=collection&c=node&a=add','','1','admin','127.0.0.1','2018-02-21 19:54:04');
INSERT INTO `v9_log` VALUES('270','','0','collection','','node','?m=collection&c=node&a=add','','1','admin','127.0.0.1','2018-02-21 20:15:21');
INSERT INTO `v9_log` VALUES('271','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:15:22');
INSERT INTO `v9_log` VALUES('272','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:15:54');
INSERT INTO `v9_log` VALUES('273','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:16:08');
INSERT INTO `v9_log` VALUES('274','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:16:10');
INSERT INTO `v9_log` VALUES('275','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:16:36');
INSERT INTO `v9_log` VALUES('276','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:16:37');
INSERT INTO `v9_log` VALUES('277','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:16:37');
INSERT INTO `v9_log` VALUES('278','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:16:38');
INSERT INTO `v9_log` VALUES('279','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:16:38');
INSERT INTO `v9_log` VALUES('280','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:16:39');
INSERT INTO `v9_log` VALUES('281','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:16:40');
INSERT INTO `v9_log` VALUES('282','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:16:41');
INSERT INTO `v9_log` VALUES('283','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:16:43');
INSERT INTO `v9_log` VALUES('284','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:16:43');
INSERT INTO `v9_log` VALUES('285','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:19:04');
INSERT INTO `v9_log` VALUES('286','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:19:07');
INSERT INTO `v9_log` VALUES('287','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:26:24');
INSERT INTO `v9_log` VALUES('288','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:26:25');
INSERT INTO `v9_log` VALUES('289','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:26:53');
INSERT INTO `v9_log` VALUES('290','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:27:02');
INSERT INTO `v9_log` VALUES('291','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:27:03');
INSERT INTO `v9_log` VALUES('292','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:27:16');
INSERT INTO `v9_log` VALUES('293','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:27:58');
INSERT INTO `v9_log` VALUES('294','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:27:59');
INSERT INTO `v9_log` VALUES('295','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:28:07');
INSERT INTO `v9_log` VALUES('296','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:28:26');
INSERT INTO `v9_log` VALUES('297','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:28:27');
INSERT INTO `v9_log` VALUES('298','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:28:36');
INSERT INTO `v9_log` VALUES('299','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:28:56');
INSERT INTO `v9_log` VALUES('300','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:28:57');
INSERT INTO `v9_log` VALUES('301','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:29:11');
INSERT INTO `v9_log` VALUES('302','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:29:33');
INSERT INTO `v9_log` VALUES('303','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:29:34');
INSERT INTO `v9_log` VALUES('304','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:29:46');
INSERT INTO `v9_log` VALUES('305','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:33:38');
INSERT INTO `v9_log` VALUES('306','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:33:39');
INSERT INTO `v9_log` VALUES('307','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:34:55');
INSERT INTO `v9_log` VALUES('308','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:34:55');
INSERT INTO `v9_log` VALUES('309','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:34:55');
INSERT INTO `v9_log` VALUES('310','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:34:56');
INSERT INTO `v9_log` VALUES('311','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:00');
INSERT INTO `v9_log` VALUES('312','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:00');
INSERT INTO `v9_log` VALUES('313','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:01');
INSERT INTO `v9_log` VALUES('314','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:35:15');
INSERT INTO `v9_log` VALUES('315','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:16');
INSERT INTO `v9_log` VALUES('316','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:17');
INSERT INTO `v9_log` VALUES('317','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:17');
INSERT INTO `v9_log` VALUES('318','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:18');
INSERT INTO `v9_log` VALUES('319','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:19');
INSERT INTO `v9_log` VALUES('320','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:19');
INSERT INTO `v9_log` VALUES('321','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:20');
INSERT INTO `v9_log` VALUES('322','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:20');
INSERT INTO `v9_log` VALUES('323','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:21');
INSERT INTO `v9_log` VALUES('324','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-21 20:35:21');
INSERT INTO `v9_log` VALUES('325','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:35:24');
INSERT INTO `v9_log` VALUES('326','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:29');
INSERT INTO `v9_log` VALUES('327','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:29');
INSERT INTO `v9_log` VALUES('328','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:29');
INSERT INTO `v9_log` VALUES('329','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:29');
INSERT INTO `v9_log` VALUES('330','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:30');
INSERT INTO `v9_log` VALUES('331','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:30');
INSERT INTO `v9_log` VALUES('332','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:30');
INSERT INTO `v9_log` VALUES('333','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:30');
INSERT INTO `v9_log` VALUES('334','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:31');
INSERT INTO `v9_log` VALUES('335','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:31');
INSERT INTO `v9_log` VALUES('336','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:31');
INSERT INTO `v9_log` VALUES('337','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:32');
INSERT INTO `v9_log` VALUES('338','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:32');
INSERT INTO `v9_log` VALUES('339','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:32');
INSERT INTO `v9_log` VALUES('340','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:33');
INSERT INTO `v9_log` VALUES('341','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:33');
INSERT INTO `v9_log` VALUES('342','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:33');
INSERT INTO `v9_log` VALUES('343','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:34');
INSERT INTO `v9_log` VALUES('344','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:34');
INSERT INTO `v9_log` VALUES('345','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:34');
INSERT INTO `v9_log` VALUES('346','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:35');
INSERT INTO `v9_log` VALUES('347','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:35');
INSERT INTO `v9_log` VALUES('348','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:35');
INSERT INTO `v9_log` VALUES('349','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:35');
INSERT INTO `v9_log` VALUES('350','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:36');
INSERT INTO `v9_log` VALUES('351','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:36');
INSERT INTO `v9_log` VALUES('352','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:36');
INSERT INTO `v9_log` VALUES('353','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:37');
INSERT INTO `v9_log` VALUES('354','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:37');
INSERT INTO `v9_log` VALUES('355','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:37');
INSERT INTO `v9_log` VALUES('356','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:38');
INSERT INTO `v9_log` VALUES('357','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:38');
INSERT INTO `v9_log` VALUES('358','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:38');
INSERT INTO `v9_log` VALUES('359','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:39');
INSERT INTO `v9_log` VALUES('360','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:39');
INSERT INTO `v9_log` VALUES('361','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:39');
INSERT INTO `v9_log` VALUES('362','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:40');
INSERT INTO `v9_log` VALUES('363','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:40');
INSERT INTO `v9_log` VALUES('364','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:40');
INSERT INTO `v9_log` VALUES('365','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:41');
INSERT INTO `v9_log` VALUES('366','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:41');
INSERT INTO `v9_log` VALUES('367','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:41');
INSERT INTO `v9_log` VALUES('368','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:42');
INSERT INTO `v9_log` VALUES('369','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:42');
INSERT INTO `v9_log` VALUES('370','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:42');
INSERT INTO `v9_log` VALUES('371','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:43');
INSERT INTO `v9_log` VALUES('372','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:43');
INSERT INTO `v9_log` VALUES('373','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:43');
INSERT INTO `v9_log` VALUES('374','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:43');
INSERT INTO `v9_log` VALUES('375','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:44');
INSERT INTO `v9_log` VALUES('376','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:44');
INSERT INTO `v9_log` VALUES('377','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:44');
INSERT INTO `v9_log` VALUES('378','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:44');
INSERT INTO `v9_log` VALUES('379','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:45');
INSERT INTO `v9_log` VALUES('380','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:45');
INSERT INTO `v9_log` VALUES('381','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:45');
INSERT INTO `v9_log` VALUES('382','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:48');
INSERT INTO `v9_log` VALUES('383','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:49');
INSERT INTO `v9_log` VALUES('384','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-21 20:35:49');
INSERT INTO `v9_log` VALUES('385','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:35:56');
INSERT INTO `v9_log` VALUES('386','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-21 20:36:13');
INSERT INTO `v9_log` VALUES('387','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:37:50');
INSERT INTO `v9_log` VALUES('388','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:37:52');
INSERT INTO `v9_log` VALUES('389','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-21 20:39:24');
INSERT INTO `v9_log` VALUES('390','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-21 20:39:25');
INSERT INTO `v9_log` VALUES('391','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-22 11:02:33');
INSERT INTO `v9_log` VALUES('392','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2018-02-22 11:02:51');
INSERT INTO `v9_log` VALUES('393','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:02:59');
INSERT INTO `v9_log` VALUES('394','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:04:27');
INSERT INTO `v9_log` VALUES('395','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:04:57');
INSERT INTO `v9_log` VALUES('396','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:03');
INSERT INTO `v9_log` VALUES('397','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:04');
INSERT INTO `v9_log` VALUES('398','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:04');
INSERT INTO `v9_log` VALUES('399','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:04');
INSERT INTO `v9_log` VALUES('400','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:05');
INSERT INTO `v9_log` VALUES('401','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:05');
INSERT INTO `v9_log` VALUES('402','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:05');
INSERT INTO `v9_log` VALUES('403','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:05');
INSERT INTO `v9_log` VALUES('404','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:06');
INSERT INTO `v9_log` VALUES('405','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:06');
INSERT INTO `v9_log` VALUES('406','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:06');
INSERT INTO `v9_log` VALUES('407','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:06');
INSERT INTO `v9_log` VALUES('408','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:07');
INSERT INTO `v9_log` VALUES('409','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:07');
INSERT INTO `v9_log` VALUES('410','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:07');
INSERT INTO `v9_log` VALUES('411','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:07');
INSERT INTO `v9_log` VALUES('412','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:08');
INSERT INTO `v9_log` VALUES('413','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:08');
INSERT INTO `v9_log` VALUES('414','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:08');
INSERT INTO `v9_log` VALUES('415','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:08');
INSERT INTO `v9_log` VALUES('416','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:09');
INSERT INTO `v9_log` VALUES('417','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:09');
INSERT INTO `v9_log` VALUES('418','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:09');
INSERT INTO `v9_log` VALUES('419','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:09');
INSERT INTO `v9_log` VALUES('420','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:10');
INSERT INTO `v9_log` VALUES('421','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:10');
INSERT INTO `v9_log` VALUES('422','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:10');
INSERT INTO `v9_log` VALUES('423','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:11');
INSERT INTO `v9_log` VALUES('424','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:11');
INSERT INTO `v9_log` VALUES('425','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:11');
INSERT INTO `v9_log` VALUES('426','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:11');
INSERT INTO `v9_log` VALUES('427','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:12');
INSERT INTO `v9_log` VALUES('428','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:12');
INSERT INTO `v9_log` VALUES('429','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:12');
INSERT INTO `v9_log` VALUES('430','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:12');
INSERT INTO `v9_log` VALUES('431','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:13');
INSERT INTO `v9_log` VALUES('432','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:13');
INSERT INTO `v9_log` VALUES('433','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:13');
INSERT INTO `v9_log` VALUES('434','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:13');
INSERT INTO `v9_log` VALUES('435','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:14');
INSERT INTO `v9_log` VALUES('436','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:14');
INSERT INTO `v9_log` VALUES('437','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:14');
INSERT INTO `v9_log` VALUES('438','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:14');
INSERT INTO `v9_log` VALUES('439','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:14');
INSERT INTO `v9_log` VALUES('440','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:15');
INSERT INTO `v9_log` VALUES('441','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:15');
INSERT INTO `v9_log` VALUES('442','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:15');
INSERT INTO `v9_log` VALUES('443','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:16');
INSERT INTO `v9_log` VALUES('444','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:16');
INSERT INTO `v9_log` VALUES('445','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:16');
INSERT INTO `v9_log` VALUES('446','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:16');
INSERT INTO `v9_log` VALUES('447','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:17');
INSERT INTO `v9_log` VALUES('448','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:17');
INSERT INTO `v9_log` VALUES('449','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:17');
INSERT INTO `v9_log` VALUES('450','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:17');
INSERT INTO `v9_log` VALUES('451','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:05:18');
INSERT INTO `v9_log` VALUES('452','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:05:18');
INSERT INTO `v9_log` VALUES('453','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:05:27');
INSERT INTO `v9_log` VALUES('454','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:07:15');
INSERT INTO `v9_log` VALUES('455','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:07:17');
INSERT INTO `v9_log` VALUES('456','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:07:19');
INSERT INTO `v9_log` VALUES('457','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:07:21');
INSERT INTO `v9_log` VALUES('458','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:07:22');
INSERT INTO `v9_log` VALUES('459','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:07:26');
INSERT INTO `v9_log` VALUES('460','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:08:31');
INSERT INTO `v9_log` VALUES('461','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:08:33');
INSERT INTO `v9_log` VALUES('462','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:11:30');
INSERT INTO `v9_log` VALUES('463','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:11:52');
INSERT INTO `v9_log` VALUES('464','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:11:54');
INSERT INTO `v9_log` VALUES('465','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:18:15');
INSERT INTO `v9_log` VALUES('466','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:21:32');
INSERT INTO `v9_log` VALUES('467','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:21:33');
INSERT INTO `v9_log` VALUES('468','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:21:47');
INSERT INTO `v9_log` VALUES('469','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:21:53');
INSERT INTO `v9_log` VALUES('470','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:21:55');
INSERT INTO `v9_log` VALUES('471','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:22:11');
INSERT INTO `v9_log` VALUES('472','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:35:54');
INSERT INTO `v9_log` VALUES('473','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:35:55');
INSERT INTO `v9_log` VALUES('474','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:36:20');
INSERT INTO `v9_log` VALUES('475','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:37:40');
INSERT INTO `v9_log` VALUES('476','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:37:41');
INSERT INTO `v9_log` VALUES('477','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:37:52');
INSERT INTO `v9_log` VALUES('478','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:37:52');
INSERT INTO `v9_log` VALUES('479','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:37:52');
INSERT INTO `v9_log` VALUES('480','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:37:53');
INSERT INTO `v9_log` VALUES('481','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:37:53');
INSERT INTO `v9_log` VALUES('482','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:37:54');
INSERT INTO `v9_log` VALUES('483','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:37:54');
INSERT INTO `v9_log` VALUES('484','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:37:55');
INSERT INTO `v9_log` VALUES('485','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:37:55');
INSERT INTO `v9_log` VALUES('486','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:37:56');
INSERT INTO `v9_log` VALUES('487','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:00');
INSERT INTO `v9_log` VALUES('488','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:00');
INSERT INTO `v9_log` VALUES('489','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:01');
INSERT INTO `v9_log` VALUES('490','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:02');
INSERT INTO `v9_log` VALUES('491','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:03');
INSERT INTO `v9_log` VALUES('492','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:03');
INSERT INTO `v9_log` VALUES('493','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:04');
INSERT INTO `v9_log` VALUES('494','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:05');
INSERT INTO `v9_log` VALUES('495','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:05');
INSERT INTO `v9_log` VALUES('496','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:06');
INSERT INTO `v9_log` VALUES('497','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:07');
INSERT INTO `v9_log` VALUES('498','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:07');
INSERT INTO `v9_log` VALUES('499','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:08');
INSERT INTO `v9_log` VALUES('500','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:08');
INSERT INTO `v9_log` VALUES('501','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:12');
INSERT INTO `v9_log` VALUES('502','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:13');
INSERT INTO `v9_log` VALUES('503','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:13');
INSERT INTO `v9_log` VALUES('504','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:14');
INSERT INTO `v9_log` VALUES('505','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:15');
INSERT INTO `v9_log` VALUES('506','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:15');
INSERT INTO `v9_log` VALUES('507','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:16');
INSERT INTO `v9_log` VALUES('508','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:17');
INSERT INTO `v9_log` VALUES('509','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:17');
INSERT INTO `v9_log` VALUES('510','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:18');
INSERT INTO `v9_log` VALUES('511','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:19');
INSERT INTO `v9_log` VALUES('512','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:19');
INSERT INTO `v9_log` VALUES('513','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:21');
INSERT INTO `v9_log` VALUES('514','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:22');
INSERT INTO `v9_log` VALUES('515','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:22');
INSERT INTO `v9_log` VALUES('516','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:23');
INSERT INTO `v9_log` VALUES('517','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:24');
INSERT INTO `v9_log` VALUES('518','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:24');
INSERT INTO `v9_log` VALUES('519','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:25');
INSERT INTO `v9_log` VALUES('520','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:26');
INSERT INTO `v9_log` VALUES('521','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:26');
INSERT INTO `v9_log` VALUES('522','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:27');
INSERT INTO `v9_log` VALUES('523','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:28');
INSERT INTO `v9_log` VALUES('524','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:29');
INSERT INTO `v9_log` VALUES('525','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:29');
INSERT INTO `v9_log` VALUES('526','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:30');
INSERT INTO `v9_log` VALUES('527','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:31');
INSERT INTO `v9_log` VALUES('528','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:32');
INSERT INTO `v9_log` VALUES('529','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:32');
INSERT INTO `v9_log` VALUES('530','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:33');
INSERT INTO `v9_log` VALUES('531','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:34');
INSERT INTO `v9_log` VALUES('532','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:34');
INSERT INTO `v9_log` VALUES('533','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:35');
INSERT INTO `v9_log` VALUES('534','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:35');
INSERT INTO `v9_log` VALUES('535','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:36');
INSERT INTO `v9_log` VALUES('536','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:37');
INSERT INTO `v9_log` VALUES('537','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:38');
INSERT INTO `v9_log` VALUES('538','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:38');
INSERT INTO `v9_log` VALUES('539','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:39');
INSERT INTO `v9_log` VALUES('540','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:40');
INSERT INTO `v9_log` VALUES('541','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:41');
INSERT INTO `v9_log` VALUES('542','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:41');
INSERT INTO `v9_log` VALUES('543','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:42');
INSERT INTO `v9_log` VALUES('544','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:46');
INSERT INTO `v9_log` VALUES('545','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:38:46');
INSERT INTO `v9_log` VALUES('546','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:38:47');
INSERT INTO `v9_log` VALUES('547','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:38:52');
INSERT INTO `v9_log` VALUES('548','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:39:15');
INSERT INTO `v9_log` VALUES('549','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:39:19');
INSERT INTO `v9_log` VALUES('550','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:40:51');
INSERT INTO `v9_log` VALUES('551','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 11:41:06');
INSERT INTO `v9_log` VALUES('552','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:41:07');
INSERT INTO `v9_log` VALUES('553','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:41:11');
INSERT INTO `v9_log` VALUES('554','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:41:11');
INSERT INTO `v9_log` VALUES('555','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:41:11');
INSERT INTO `v9_log` VALUES('556','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:41:11');
INSERT INTO `v9_log` VALUES('557','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:41:12');
INSERT INTO `v9_log` VALUES('558','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:41:12');
INSERT INTO `v9_log` VALUES('559','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:14');
INSERT INTO `v9_log` VALUES('560','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:15');
INSERT INTO `v9_log` VALUES('561','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:16');
INSERT INTO `v9_log` VALUES('562','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:17');
INSERT INTO `v9_log` VALUES('563','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:18');
INSERT INTO `v9_log` VALUES('564','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:19');
INSERT INTO `v9_log` VALUES('565','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:21');
INSERT INTO `v9_log` VALUES('566','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:21');
INSERT INTO `v9_log` VALUES('567','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:22');
INSERT INTO `v9_log` VALUES('568','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:26');
INSERT INTO `v9_log` VALUES('569','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:27');
INSERT INTO `v9_log` VALUES('570','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:28');
INSERT INTO `v9_log` VALUES('571','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:29');
INSERT INTO `v9_log` VALUES('572','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:29');
INSERT INTO `v9_log` VALUES('573','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:30');
INSERT INTO `v9_log` VALUES('574','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:31');
INSERT INTO `v9_log` VALUES('575','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:32');
INSERT INTO `v9_log` VALUES('576','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:32');
INSERT INTO `v9_log` VALUES('577','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:33');
INSERT INTO `v9_log` VALUES('578','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:34');
INSERT INTO `v9_log` VALUES('579','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:35');
INSERT INTO `v9_log` VALUES('580','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:36');
INSERT INTO `v9_log` VALUES('581','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:37');
INSERT INTO `v9_log` VALUES('582','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:37');
INSERT INTO `v9_log` VALUES('583','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:38');
INSERT INTO `v9_log` VALUES('584','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:39');
INSERT INTO `v9_log` VALUES('585','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:40');
INSERT INTO `v9_log` VALUES('586','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:41');
INSERT INTO `v9_log` VALUES('587','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:41');
INSERT INTO `v9_log` VALUES('588','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:42');
INSERT INTO `v9_log` VALUES('589','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:43');
INSERT INTO `v9_log` VALUES('590','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:44');
INSERT INTO `v9_log` VALUES('591','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:45');
INSERT INTO `v9_log` VALUES('592','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:46');
INSERT INTO `v9_log` VALUES('593','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:46');
INSERT INTO `v9_log` VALUES('594','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:47');
INSERT INTO `v9_log` VALUES('595','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:48');
INSERT INTO `v9_log` VALUES('596','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:49');
INSERT INTO `v9_log` VALUES('597','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:49');
INSERT INTO `v9_log` VALUES('598','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:50');
INSERT INTO `v9_log` VALUES('599','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:51');
INSERT INTO `v9_log` VALUES('600','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:52');
INSERT INTO `v9_log` VALUES('601','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:53');
INSERT INTO `v9_log` VALUES('602','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:53');
INSERT INTO `v9_log` VALUES('603','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:53');
INSERT INTO `v9_log` VALUES('604','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:41:53');
INSERT INTO `v9_log` VALUES('605','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:41:55');
INSERT INTO `v9_log` VALUES('606','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:41:57');
INSERT INTO `v9_log` VALUES('607','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:42:03');
INSERT INTO `v9_log` VALUES('608','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:42:08');
INSERT INTO `v9_log` VALUES('609','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:42:15');
INSERT INTO `v9_log` VALUES('610','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:42:29');
INSERT INTO `v9_log` VALUES('611','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:42:51');
INSERT INTO `v9_log` VALUES('612','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:42:57');
INSERT INTO `v9_log` VALUES('613','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:43:14');
INSERT INTO `v9_log` VALUES('614','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:43:21');
INSERT INTO `v9_log` VALUES('615','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:43:25');
INSERT INTO `v9_log` VALUES('616','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:43:29');
INSERT INTO `v9_log` VALUES('617','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:43:36');
INSERT INTO `v9_log` VALUES('618','','0','collection','','node','?m=collection&c=node&a=content_del','','1','admin','127.0.0.1','2018-02-22 11:43:43');
INSERT INTO `v9_log` VALUES('619','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:43:44');
INSERT INTO `v9_log` VALUES('620','','0','collection','','node','?m=collection&c=node&a=content_del','','1','admin','127.0.0.1','2018-02-22 11:44:02');
INSERT INTO `v9_log` VALUES('621','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:44:03');
INSERT INTO `v9_log` VALUES('622','','0','collection','','node','?m=collection&c=node&a=content_del','','1','admin','127.0.0.1','2018-02-22 11:44:13');
INSERT INTO `v9_log` VALUES('623','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:44:14');
INSERT INTO `v9_log` VALUES('624','','0','collection','','node','?m=collection&c=node&a=content_del','','1','admin','127.0.0.1','2018-02-22 11:44:21');
INSERT INTO `v9_log` VALUES('625','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:44:23');
INSERT INTO `v9_log` VALUES('626','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:44:25');
INSERT INTO `v9_log` VALUES('627','','0','collection','','node','?m=collection&c=node&a=export','','1','admin','127.0.0.1','2018-02-22 11:44:26');
INSERT INTO `v9_log` VALUES('628','','0','collection','','node','?m=collection&c=node&a=del','','1','admin','127.0.0.1','2018-02-22 11:44:41');
INSERT INTO `v9_log` VALUES('629','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:44:42');
INSERT INTO `v9_log` VALUES('630','','0','collection','','node','?m=collection&c=node&a=node_import','','1','admin','127.0.0.1','2018-02-22 11:44:44');
INSERT INTO `v9_log` VALUES('631','','0','collection','','node','?m=collection&c=node&a=node_import','','1','admin','127.0.0.1','2018-02-22 11:45:19');
INSERT INTO `v9_log` VALUES('632','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:45:19');
INSERT INTO `v9_log` VALUES('633','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:45:22');
INSERT INTO `v9_log` VALUES('634','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:45:23');
INSERT INTO `v9_log` VALUES('635','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:45:23');
INSERT INTO `v9_log` VALUES('636','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:45:23');
INSERT INTO `v9_log` VALUES('637','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:45:24');
INSERT INTO `v9_log` VALUES('638','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:45:24');
INSERT INTO `v9_log` VALUES('639','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:45:26');
INSERT INTO `v9_log` VALUES('640','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:45:28');
INSERT INTO `v9_log` VALUES('641','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:45:31');
INSERT INTO `v9_log` VALUES('642','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 11:45:35');
INSERT INTO `v9_log` VALUES('643','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:54:59');
INSERT INTO `v9_log` VALUES('644','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:55:02');
INSERT INTO `v9_log` VALUES('645','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:55:02');
INSERT INTO `v9_log` VALUES('646','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:55:02');
INSERT INTO `v9_log` VALUES('647','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:55:02');
INSERT INTO `v9_log` VALUES('648','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:55:03');
INSERT INTO `v9_log` VALUES('649','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:55:03');
INSERT INTO `v9_log` VALUES('650','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:55:05');
INSERT INTO `v9_log` VALUES('651','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:55:07');
INSERT INTO `v9_log` VALUES('652','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:55:09');
INSERT INTO `v9_log` VALUES('653','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:55:10');
INSERT INTO `v9_log` VALUES('654','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:55:11');
INSERT INTO `v9_log` VALUES('655','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:55:13');
INSERT INTO `v9_log` VALUES('656','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:55:14');
INSERT INTO `v9_log` VALUES('657','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:55:14');
INSERT INTO `v9_log` VALUES('658','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:55:15');
INSERT INTO `v9_log` VALUES('659','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:55:15');
INSERT INTO `v9_log` VALUES('660','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:55:15');
INSERT INTO `v9_log` VALUES('661','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 11:55:16');
INSERT INTO `v9_log` VALUES('662','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 11:55:18');
INSERT INTO `v9_log` VALUES('663','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 11:55:20');
INSERT INTO `v9_log` VALUES('664','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:10:16');
INSERT INTO `v9_log` VALUES('665','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:10:18');
INSERT INTO `v9_log` VALUES('666','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:10:19');
INSERT INTO `v9_log` VALUES('667','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:10:21');
INSERT INTO `v9_log` VALUES('668','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:10:23');
INSERT INTO `v9_log` VALUES('669','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:10:24');
INSERT INTO `v9_log` VALUES('670','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:10:35');
INSERT INTO `v9_log` VALUES('671','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:10:36');
INSERT INTO `v9_log` VALUES('672','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:10:38');
INSERT INTO `v9_log` VALUES('673','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:10:40');
INSERT INTO `v9_log` VALUES('674','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:10:41');
INSERT INTO `v9_log` VALUES('675','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:10:43');
INSERT INTO `v9_log` VALUES('676','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:14:39');
INSERT INTO `v9_log` VALUES('677','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:14:41');
INSERT INTO `v9_log` VALUES('678','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:14:42');
INSERT INTO `v9_log` VALUES('679','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:14:42');
INSERT INTO `v9_log` VALUES('680','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:14:42');
INSERT INTO `v9_log` VALUES('681','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:14:43');
INSERT INTO `v9_log` VALUES('682','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:14:43');
INSERT INTO `v9_log` VALUES('683','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:14:44');
INSERT INTO `v9_log` VALUES('684','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:14:45');
INSERT INTO `v9_log` VALUES('685','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:14:47');
INSERT INTO `v9_log` VALUES('686','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:15:04');
INSERT INTO `v9_log` VALUES('687','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:15:06');
INSERT INTO `v9_log` VALUES('688','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:15:06');
INSERT INTO `v9_log` VALUES('689','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:15:06');
INSERT INTO `v9_log` VALUES('690','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:15:06');
INSERT INTO `v9_log` VALUES('691','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:15:07');
INSERT INTO `v9_log` VALUES('692','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:15:07');
INSERT INTO `v9_log` VALUES('693','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:15:09');
INSERT INTO `v9_log` VALUES('694','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:15:10');
INSERT INTO `v9_log` VALUES('695','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:15:22');
INSERT INTO `v9_log` VALUES('696','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:15:23');
INSERT INTO `v9_log` VALUES('697','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:15:24');
INSERT INTO `v9_log` VALUES('698','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:15:26');
INSERT INTO `v9_log` VALUES('699','','0','collection','','node','?m=collection&c=node&a=del','','1','admin','127.0.0.1','2018-02-22 12:16:08');
INSERT INTO `v9_log` VALUES('700','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:16:10');
INSERT INTO `v9_log` VALUES('701','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:17:02');
INSERT INTO `v9_log` VALUES('702','','0','collection','','node','?m=collection&c=node&a=node_import','','1','admin','127.0.0.1','2018-02-22 12:17:04');
INSERT INTO `v9_log` VALUES('703','','0','collection','','node','?m=collection&c=node&a=node_import','','1','admin','127.0.0.1','2018-02-22 12:17:18');
INSERT INTO `v9_log` VALUES('704','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:17:18');
INSERT INTO `v9_log` VALUES('705','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:17:21');
INSERT INTO `v9_log` VALUES('706','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:17:21');
INSERT INTO `v9_log` VALUES('707','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:17:22');
INSERT INTO `v9_log` VALUES('708','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:17:22');
INSERT INTO `v9_log` VALUES('709','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:17:22');
INSERT INTO `v9_log` VALUES('710','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:17:23');
INSERT INTO `v9_log` VALUES('711','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:17:25');
INSERT INTO `v9_log` VALUES('712','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:17:26');
INSERT INTO `v9_log` VALUES('713','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:17:28');
INSERT INTO `v9_log` VALUES('714','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:17:29');
INSERT INTO `v9_log` VALUES('715','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:17:31');
INSERT INTO `v9_log` VALUES('716','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:17:31');
INSERT INTO `v9_log` VALUES('717','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:17:31');
INSERT INTO `v9_log` VALUES('718','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:17:31');
INSERT INTO `v9_log` VALUES('719','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:17:32');
INSERT INTO `v9_log` VALUES('720','','0','collection','','node','?m=collection&c=node&a=col_url_list','','1','admin','127.0.0.1','2018-02-22 12:17:32');
INSERT INTO `v9_log` VALUES('721','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:17:35');
INSERT INTO `v9_log` VALUES('722','','0','collection','','node','?m=collection&c=node&a=publist','','1','admin','127.0.0.1','2018-02-22 12:17:37');
INSERT INTO `v9_log` VALUES('723','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:17:41');
INSERT INTO `v9_log` VALUES('724','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:17:43');
INSERT INTO `v9_log` VALUES('725','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:17:44');
INSERT INTO `v9_log` VALUES('726','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:17:44');
INSERT INTO `v9_log` VALUES('727','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 12:17:47');
INSERT INTO `v9_log` VALUES('728','','0','collection','','node','?m=collection&c=node&a=edit','','1','admin','127.0.0.1','2018-02-22 12:18:08');
INSERT INTO `v9_log` VALUES('729','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:18:10');
INSERT INTO `v9_log` VALUES('730','','0','collection','','node','?m=collection&c=node&a=col_content','','1','admin','127.0.0.1','2018-02-22 12:18:11');
INSERT INTO `v9_log` VALUES('731','','0','collection','','node','?m=collection&c=node&a=manage','','1','admin','127.0.0.1','2018-02-22 12:18:12');
INSERT INTO `v9_log` VALUES('732','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2018-09-02 20:59:12');
INSERT INTO `v9_log` VALUES('733','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2018-09-02 20:59:23');
INSERT INTO `v9_log` VALUES('734','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2018-09-02 20:59:27');
INSERT INTO `v9_log` VALUES('735','','0','admin','','menu','?m=admin&c=menu&a=add','','1','admin','127.0.0.1','2018-09-02 20:59:51');
INSERT INTO `v9_log` VALUES('736','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2019-07-06 21:25:39');
INSERT INTO `v9_log` VALUES('737','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2019-07-06 21:25:53');
INSERT INTO `v9_log` VALUES('738','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-07-06 21:26:08');
INSERT INTO `v9_log` VALUES('739','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-07-06 21:26:20');
INSERT INTO `v9_log` VALUES('740','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-07-06 21:27:34');
INSERT INTO `v9_log` VALUES('741','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-07-06 21:29:57');
INSERT INTO `v9_log` VALUES('742','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-07-06 21:30:09');
INSERT INTO `v9_log` VALUES('743','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-07-07 13:40:55');
INSERT INTO `v9_log` VALUES('744','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-07-07 13:40:56');
INSERT INTO `v9_log` VALUES('745','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-07-07 13:41:07');
INSERT INTO `v9_log` VALUES('746','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-07-07 13:41:08');
INSERT INTO `v9_log` VALUES('747','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-07-07 13:41:20');
INSERT INTO `v9_log` VALUES('748','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-07-07 13:41:31');
INSERT INTO `v9_log` VALUES('749','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-07-07 13:41:39');
INSERT INTO `v9_log` VALUES('750','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-07-07 13:58:45');
INSERT INTO `v9_log` VALUES('751','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-07-09 18:39:35');
INSERT INTO `v9_log` VALUES('752','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-07-09 18:39:38');
INSERT INTO `v9_log` VALUES('753','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-07-09 18:39:49');
INSERT INTO `v9_log` VALUES('754','','0','content','','workflow','?m=content&c=workflow&a=view','','1','admin','127.0.0.1','2019-07-09 18:40:58');
INSERT INTO `v9_log` VALUES('755','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-09 18:42:00');
INSERT INTO `v9_log` VALUES('756','','0','sms','','sms','?m=sms&c=sms&a=sms_buy_history','','1','admin','127.0.0.1','2019-07-09 18:42:11');
INSERT INTO `v9_log` VALUES('757','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-07-09 18:42:14');
INSERT INTO `v9_log` VALUES('758','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-09 19:43:31');
INSERT INTO `v9_log` VALUES('759','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-09 19:45:08');
INSERT INTO `v9_log` VALUES('760','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-07-09 19:45:11');
INSERT INTO `v9_log` VALUES('761','','0','sms','','sms','?m=sms&c=sms&a=sms_buy_history','','1','admin','127.0.0.1','2019-07-09 19:45:17');
INSERT INTO `v9_log` VALUES('762','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-07-09 19:45:20');
INSERT INTO `v9_log` VALUES('763','','0','sms','','sms','?m=sms&c=sms&a=sms_sent','','1','admin','127.0.0.1','2019-07-09 19:45:23');
INSERT INTO `v9_log` VALUES('764','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-07-09 19:46:18');
INSERT INTO `v9_log` VALUES('765','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-09 19:46:22');
INSERT INTO `v9_log` VALUES('766','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-09 19:46:50');
INSERT INTO `v9_log` VALUES('767','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-09 19:46:52');
INSERT INTO `v9_log` VALUES('768','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-07-09 19:46:58');
INSERT INTO `v9_log` VALUES('769','','0','sms','','sms','?m=sms&c=sms&a=sms_buy_history','','1','admin','127.0.0.1','2019-07-09 19:46:59');
INSERT INTO `v9_log` VALUES('770','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-09 19:47:05');
INSERT INTO `v9_log` VALUES('771','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-07-09 19:47:09');
INSERT INTO `v9_log` VALUES('772','','0','sms','','sms','?m=sms&c=sms&a=sms_buy_history','','1','admin','127.0.0.1','2019-07-09 19:50:46');
INSERT INTO `v9_log` VALUES('773','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-09 19:55:57');
INSERT INTO `v9_log` VALUES('774','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-09 19:56:47');
INSERT INTO `v9_log` VALUES('775','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-09 19:56:49');
INSERT INTO `v9_log` VALUES('776','','0','member','','member_setting','?m=member&c=member_setting&a=manage','','1','admin','127.0.0.1','2019-07-09 19:57:03');
INSERT INTO `v9_log` VALUES('777','','0','member','','member_setting','?m=member&c=member_setting&a=manage','','1','admin','127.0.0.1','2019-07-09 19:57:43');
INSERT INTO `v9_log` VALUES('778','','0','member','','member_setting','?m=member&c=member_setting&a=manage','','1','admin','127.0.0.1','2019-07-09 19:57:44');
INSERT INTO `v9_log` VALUES('779','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-07-09 20:03:27');
INSERT INTO `v9_log` VALUES('780','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-07-11 18:21:43');
INSERT INTO `v9_log` VALUES('781','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-07-11 18:22:20');
INSERT INTO `v9_log` VALUES('782','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-11 18:34:07');
INSERT INTO `v9_log` VALUES('783','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-07-11 18:34:32');
INSERT INTO `v9_log` VALUES('784','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-11 18:39:19');
INSERT INTO `v9_log` VALUES('785','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-07-11 18:42:25');
INSERT INTO `v9_log` VALUES('786','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-07-11 19:52:57');
INSERT INTO `v9_log` VALUES('787','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-07-11 19:52:58');
INSERT INTO `v9_log` VALUES('788','','0','sms','','sms','?m=sms&c=sms&a=sms_buy_history','','1','admin','127.0.0.1','2019-07-11 19:53:16');
INSERT INTO `v9_log` VALUES('789','','0','sms','','sms','?m=sms&c=sms&a=sms_buy_history','','1','admin','127.0.0.1','2019-07-11 19:53:19');
INSERT INTO `v9_log` VALUES('790','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-07-11 19:53:23');
INSERT INTO `v9_log` VALUES('791','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-11 19:53:27');
INSERT INTO `v9_log` VALUES('792','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-07-11 19:53:34');
INSERT INTO `v9_log` VALUES('793','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-11 19:53:48');
INSERT INTO `v9_log` VALUES('794','','0','member','','member','?m=member&c=member&a=manage','','1','admin','127.0.0.1','2019-07-11 20:00:03');
INSERT INTO `v9_log` VALUES('795','','0','member','','member_setting','?m=member&c=member_setting&a=manage','','1','admin','127.0.0.1','2019-07-11 20:00:15');
INSERT INTO `v9_log` VALUES('796','','0','member','','member_group','?m=member&c=member_group&a=manage','','1','admin','127.0.0.1','2019-07-11 20:01:10');
INSERT INTO `v9_log` VALUES('797','','0','member','','member_group','?m=member&c=member_group&a=edit','','1','admin','127.0.0.1','2019-07-11 20:01:50');
INSERT INTO `v9_log` VALUES('798','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-11 20:07:11');
INSERT INTO `v9_log` VALUES('799','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-07-11 20:07:15');
INSERT INTO `v9_log` VALUES('800','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-07-11 20:07:21');
INSERT INTO `v9_log` VALUES('801','','0','member','','member','?m=member&c=member&a=manage','','1','admin','127.0.0.1','2019-07-11 20:30:19');
INSERT INTO `v9_log` VALUES('802','','0','member','','member_verify','?m=member&c=member_verify&a=manage','','1','admin','127.0.0.1','2019-07-11 20:30:24');
INSERT INTO `v9_log` VALUES('803','','0','member','','member_setting','?m=member&c=member_setting&a=manage','','1','admin','127.0.0.1','2019-07-11 20:30:25');
INSERT INTO `v9_log` VALUES('804','','0','member','','member_setting','?m=member&c=member_setting&a=manage','','1','admin','127.0.0.1','2019-07-11 20:30:48');
INSERT INTO `v9_log` VALUES('805','','0','member','','member_setting','?m=member&c=member_setting&a=manage','','1','admin','127.0.0.1','2019-07-11 20:30:50');
INSERT INTO `v9_log` VALUES('806','','0','member','','member_verify','?m=member&c=member_verify&a=manage','','1','admin','127.0.0.1','2019-07-11 20:35:47');
INSERT INTO `v9_log` VALUES('807','','0','member','','member_setting','?m=member&c=member_setting&a=manage','','1','admin','127.0.0.1','2019-07-11 20:35:48');
INSERT INTO `v9_log` VALUES('808','','0','member','','member_group','?m=member&c=member_group&a=manage','','1','admin','127.0.0.1','2019-07-11 20:36:06');
INSERT INTO `v9_log` VALUES('809','','0','member','','member_model','?m=member&c=member_model&a=manage','','1','admin','127.0.0.1','2019-07-11 20:36:14');
INSERT INTO `v9_log` VALUES('810','','0','member','','member_setting','?m=member&c=member_setting&a=manage','','1','admin','127.0.0.1','2019-07-11 20:36:20');
INSERT INTO `v9_log` VALUES('811','','0','member','','member_verify','?m=member&c=member_verify&a=manage','','1','admin','127.0.0.1','2019-07-11 20:36:21');
INSERT INTO `v9_log` VALUES('812','','0','member','','member','?m=member&c=member&a=manage','','1','admin','127.0.0.1','2019-07-11 20:36:23');
INSERT INTO `v9_log` VALUES('813','','0','member','','member_group','?m=member&c=member_group&a=manage','','1','admin','127.0.0.1','2019-07-11 20:36:31');
INSERT INTO `v9_log` VALUES('814','','0','member','','member_group','?m=member&c=member_group&a=edit','','1','admin','127.0.0.1','2019-07-11 20:36:43');
INSERT INTO `v9_log` VALUES('815','','0','member','','member_group','?m=member&c=member_group&a=edit','','1','admin','127.0.0.1','2019-07-11 20:36:53');
INSERT INTO `v9_log` VALUES('816','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-07-11 20:37:10');
INSERT INTO `v9_log` VALUES('817','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-07-11 20:37:13');
INSERT INTO `v9_log` VALUES('818','','0','sms','','sms','?m=sms&c=sms&a=sms_buy_history','','1','admin','127.0.0.1','2019-07-11 20:37:19');
INSERT INTO `v9_log` VALUES('819','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-07-11 20:37:22');
INSERT INTO `v9_log` VALUES('820','','0','sms','','sms','?m=sms&c=sms&a=sms_sent','','1','admin','127.0.0.1','2019-07-11 20:37:23');
INSERT INTO `v9_log` VALUES('821','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-08-10 16:18:06');
INSERT INTO `v9_log` VALUES('822','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-08-10 16:18:24');
INSERT INTO `v9_log` VALUES('823','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-08-10 16:18:35');
INSERT INTO `v9_log` VALUES('824','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-08-10 16:18:51');
INSERT INTO `v9_log` VALUES('825','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-08-10 16:18:54');
INSERT INTO `v9_log` VALUES('826','','0','sms','','sms','?m=sms&c=sms&a=sms_sent','','1','admin','127.0.0.1','2019-08-10 16:25:08');
INSERT INTO `v9_log` VALUES('827','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-08-10 16:25:10');
INSERT INTO `v9_log` VALUES('828','','0','admin','','index','?m=admin&c=index&a=login','','0','','192.168.124.5','2019-08-10 16:44:11');
INSERT INTO `v9_log` VALUES('829','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-08-12 11:54:59');
INSERT INTO `v9_log` VALUES('830','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-08-12 11:56:56');
INSERT INTO `v9_log` VALUES('831','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-08-12 11:59:58');
INSERT INTO `v9_log` VALUES('832','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-08-12 18:40:02');
INSERT INTO `v9_log` VALUES('833','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-08-12 18:40:15');
INSERT INTO `v9_log` VALUES('834','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-08-12 18:40:22');
INSERT INTO `v9_log` VALUES('835','','0','sms','','sms','?m=sms&c=sms&a=sms_buy_history','','1','admin','127.0.0.1','2019-08-12 18:41:37');
INSERT INTO `v9_log` VALUES('836','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-08-12 18:49:13');
INSERT INTO `v9_log` VALUES('837','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-08-12 18:54:47');
INSERT INTO `v9_log` VALUES('838','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-08-12 18:54:49');
INSERT INTO `v9_log` VALUES('839','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-08-12 18:55:28');
INSERT INTO `v9_log` VALUES('840','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-08-12 18:55:36');
INSERT INTO `v9_log` VALUES('841','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-08-12 18:55:39');
INSERT INTO `v9_log` VALUES('842','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-08-12 18:55:57');
INSERT INTO `v9_log` VALUES('843','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-08-12 18:56:11');
INSERT INTO `v9_log` VALUES('844','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-08-12 18:56:12');
INSERT INTO `v9_log` VALUES('845','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-08-12 18:56:13');
INSERT INTO `v9_log` VALUES('846','','0','sms','','sms','?m=sms&c=sms&a=sms_buy_history','','1','admin','127.0.0.1','2019-08-12 18:56:16');
INSERT INTO `v9_log` VALUES('847','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-08-12 18:56:20');
INSERT INTO `v9_log` VALUES('848','','0','sms','','sms','?m=sms&c=sms&a=sms_sent','','1','admin','127.0.0.1','2019-08-12 18:56:29');
INSERT INTO `v9_log` VALUES('849','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-08-12 18:56:32');
INSERT INTO `v9_log` VALUES('850','','0','sms','','sms','?m=sms&c=sms&a=sms_setting','','1','admin','127.0.0.1','2019-08-12 18:58:08');
INSERT INTO `v9_log` VALUES('851','','0','sms','','sms','?m=sms&c=sms&a=sms_pay_history','','1','admin','127.0.0.1','2019-08-12 18:58:10');
INSERT INTO `v9_log` VALUES('852','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-08-12 22:13:07');
INSERT INTO `v9_log` VALUES('853','','0','sms','','sms','?m=sms&c=sms&a=sms_api','','1','admin','127.0.0.1','2019-08-14 22:47:34');
INSERT INTO `v9_log` VALUES('854','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-01 10:48:50');
INSERT INTO `v9_log` VALUES('855','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-01 10:49:05');
INSERT INTO `v9_log` VALUES('856','','0','admin','','index','?m=admin&c=index&a=login','','1','admin','127.0.0.1','2019-09-01 10:49:05');
INSERT INTO `v9_log` VALUES('857','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-02 22:37:22');
INSERT INTO `v9_log` VALUES('858','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-02 22:37:37');
INSERT INTO `v9_log` VALUES('859','','0','member','','member','?m=member&c=member&a=manage','','1','admin','127.0.0.1','2019-09-02 22:39:29');
INSERT INTO `v9_log` VALUES('860','','0','member','','member_verify','?m=member&c=member_verify&a=manage','','1','admin','127.0.0.1','2019-09-02 22:39:34');
INSERT INTO `v9_log` VALUES('861','','0','member','','member_setting','?m=member&c=member_setting&a=manage','','1','admin','127.0.0.1','2019-09-02 22:39:37');
INSERT INTO `v9_log` VALUES('862','','0','member','','member_setting','?m=member&c=member_setting&a=manage','','1','admin','127.0.0.1','2019-09-02 22:40:30');
INSERT INTO `v9_log` VALUES('863','','0','member','','member_setting','?m=member&c=member_setting&a=manage','','1','admin','127.0.0.1','2019-09-02 22:40:31');
INSERT INTO `v9_log` VALUES('864','','0','member','','member','?m=member&c=member&a=manage','','1','admin','127.0.0.1','2019-09-02 22:42:25');
INSERT INTO `v9_log` VALUES('865','','0','member','','member','?m=member&c=member&a=manage','','1','admin','127.0.0.1','2019-09-02 22:42:35');
INSERT INTO `v9_log` VALUES('866','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-15 14:08:05');
INSERT INTO `v9_log` VALUES('867','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-15 14:08:18');
INSERT INTO `v9_log` VALUES('868','','0','content','','sitemodel','?m=content&c=sitemodel&a=add','','1','admin','127.0.0.1','2019-09-15 14:08:37');
INSERT INTO `v9_log` VALUES('869','','0','content','','sitemodel','?m=content&c=sitemodel&a=add','','1','admin','127.0.0.1','2019-09-15 14:09:10');
INSERT INTO `v9_log` VALUES('870','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=disabled','','1','admin','127.0.0.1','2019-09-15 15:55:01');
INSERT INTO `v9_log` VALUES('871','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=disabled','','1','admin','127.0.0.1','2019-09-15 15:55:16');
INSERT INTO `v9_log` VALUES('872','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=disabled','','1','admin','127.0.0.1','2019-09-15 15:55:23');
INSERT INTO `v9_log` VALUES('873','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=add','','1','admin','127.0.0.1','2019-09-15 15:55:39');
INSERT INTO `v9_log` VALUES('874','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=add','','1','admin','127.0.0.1','2019-09-15 15:58:18');
INSERT INTO `v9_log` VALUES('875','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=add','','1','admin','127.0.0.1','2019-09-15 15:58:24');
INSERT INTO `v9_log` VALUES('876','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=add','','1','admin','127.0.0.1','2019-09-15 15:58:47');
INSERT INTO `v9_log` VALUES('877','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=add','','1','admin','127.0.0.1','2019-09-15 15:58:50');
INSERT INTO `v9_log` VALUES('878','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=add','','1','admin','127.0.0.1','2019-09-15 15:59:43');
INSERT INTO `v9_log` VALUES('879','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=add','','1','admin','127.0.0.1','2019-09-15 15:59:55');
INSERT INTO `v9_log` VALUES('880','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=add','','1','admin','127.0.0.1','2019-09-15 16:03:28');
INSERT INTO `v9_log` VALUES('881','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=add','','1','admin','127.0.0.1','2019-09-15 16:03:39');
INSERT INTO `v9_log` VALUES('882','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=add','','1','admin','127.0.0.1','2019-09-15 16:04:50');
INSERT INTO `v9_log` VALUES('883','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=listorder','','1','admin','127.0.0.1','2019-09-15 16:05:51');
INSERT INTO `v9_log` VALUES('884','','0','admin','','category','?m=admin&c=category&a=delete','','1','admin','127.0.0.1','2019-09-15 16:09:45');
INSERT INTO `v9_log` VALUES('885','','0','admin','','category','?m=admin&c=category&a=delete','','1','admin','127.0.0.1','2019-09-15 16:09:50');
INSERT INTO `v9_log` VALUES('886','','0','admin','','category','?m=admin&c=category&a=delete','','1','admin','127.0.0.1','2019-09-15 16:10:04');
INSERT INTO `v9_log` VALUES('887','','0','admin','','category','?m=admin&c=category&a=delete','','1','admin','127.0.0.1','2019-09-15 16:15:46');
INSERT INTO `v9_log` VALUES('888','','0','admin','','category','?m=admin&c=category&a=delete','','1','admin','127.0.0.1','2019-09-15 16:15:53');
INSERT INTO `v9_log` VALUES('889','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2019-09-15 16:17:34');
INSERT INTO `v9_log` VALUES('890','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2019-09-15 16:19:04');
INSERT INTO `v9_log` VALUES('891','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2019-09-15 16:21:58');
INSERT INTO `v9_log` VALUES('892','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2019-09-15 16:22:45');
INSERT INTO `v9_log` VALUES('893','','0','content','','type_manage','?m=content&c=type_manage&a=add','','1','admin','127.0.0.1','2019-09-15 16:23:21');
INSERT INTO `v9_log` VALUES('894','','0','content','','type_manage','?m=content&c=type_manage&a=add','','1','admin','127.0.0.1','2019-09-15 16:24:05');
INSERT INTO `v9_log` VALUES('895','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2019-09-15 16:25:20');
INSERT INTO `v9_log` VALUES('896','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2019-09-15 16:25:31');
INSERT INTO `v9_log` VALUES('897','','0','admin','','category','?m=admin&c=category&a=edit','','1','admin','127.0.0.1','2019-09-15 16:25:43');
INSERT INTO `v9_log` VALUES('898','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2019-09-15 16:26:10');
INSERT INTO `v9_log` VALUES('899','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2019-09-15 17:36:58');
INSERT INTO `v9_log` VALUES('900','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-15 17:46:55');
INSERT INTO `v9_log` VALUES('901','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-18 23:11:14');
INSERT INTO `v9_log` VALUES('902','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-18 23:11:25');
INSERT INTO `v9_log` VALUES('903','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-18 23:11:26');
INSERT INTO `v9_log` VALUES('904','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-18 23:11:37');
INSERT INTO `v9_log` VALUES('905','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2019-09-18 23:12:07');
INSERT INTO `v9_log` VALUES('906','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-18 23:37:46');
INSERT INTO `v9_log` VALUES('907','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-18 23:37:54');
INSERT INTO `v9_log` VALUES('908','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-24 19:23:36');
INSERT INTO `v9_log` VALUES('909','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-24 19:24:18');
INSERT INTO `v9_log` VALUES('910','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=add','','1','admin','127.0.0.1','2019-09-24 19:24:39');
INSERT INTO `v9_log` VALUES('911','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=add','','1','admin','127.0.0.1','2019-09-24 19:25:44');
INSERT INTO `v9_log` VALUES('912','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=listorder','','1','admin','127.0.0.1','2019-09-24 19:26:17');
INSERT INTO `v9_log` VALUES('913','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-24 20:17:17');
INSERT INTO `v9_log` VALUES('914','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-24 20:20:57');
INSERT INTO `v9_log` VALUES('915','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-24 20:21:09');
INSERT INTO `v9_log` VALUES('916','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-24 20:21:18');
INSERT INTO `v9_log` VALUES('917','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-25 08:50:14');
INSERT INTO `v9_log` VALUES('918','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-25 08:50:37');
INSERT INTO `v9_log` VALUES('919','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-25 12:45:09');
INSERT INTO `v9_log` VALUES('920','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-25 22:15:58');
INSERT INTO `v9_log` VALUES('921','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-25 22:16:03');
INSERT INTO `v9_log` VALUES('922','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-25 22:16:16');
INSERT INTO `v9_log` VALUES('923','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-26 21:07:40');
INSERT INTO `v9_log` VALUES('924','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-26 21:07:56');
INSERT INTO `v9_log` VALUES('925','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-26 22:08:27');
INSERT INTO `v9_log` VALUES('926','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2019-09-26 22:10:31');
INSERT INTO `v9_log` VALUES('927','','0','content','','content','?m=content&c=content&a=add','','1','admin','127.0.0.1','2019-09-26 22:10:48');
INSERT INTO `v9_log` VALUES('928','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2019-09-26 22:11:21');
INSERT INTO `v9_log` VALUES('929','','0','admin','','category','?m=admin&c=category&a=add','','1','admin','127.0.0.1','2019-09-26 22:11:44');
INSERT INTO `v9_log` VALUES('930','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:13:03');
INSERT INTO `v9_log` VALUES('931','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:13:26');
INSERT INTO `v9_log` VALUES('932','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:13:36');
INSERT INTO `v9_log` VALUES('933','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:13:40');
INSERT INTO `v9_log` VALUES('934','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:13:45');
INSERT INTO `v9_log` VALUES('935','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:13:51');
INSERT INTO `v9_log` VALUES('936','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:16:25');
INSERT INTO `v9_log` VALUES('937','','0','tag','','tag','?m=tag&c=tag&a=edit','','1','admin','127.0.0.1','2019-09-26 22:19:49');
INSERT INTO `v9_log` VALUES('938','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:26:53');
INSERT INTO `v9_log` VALUES('939','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:26:56');
INSERT INTO `v9_log` VALUES('940','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:26:58');
INSERT INTO `v9_log` VALUES('941','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:27:04');
INSERT INTO `v9_log` VALUES('942','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:27:14');
INSERT INTO `v9_log` VALUES('943','','0','tag','','tag','?m=tag&c=tag&a=add','','1','admin','127.0.0.1','2019-09-26 22:28:04');
INSERT INTO `v9_log` VALUES('944','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-26 22:29:48');
INSERT INTO `v9_log` VALUES('945','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-26 22:27:17');
INSERT INTO `v9_log` VALUES('946','','0','member','','member','?m=member&c=member&a=manage','','1','admin','127.0.0.1','2019-09-26 22:28:58');
INSERT INTO `v9_log` VALUES('947','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-26 22:31:17');
INSERT INTO `v9_log` VALUES('948','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-26 22:31:38');
INSERT INTO `v9_log` VALUES('949','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-26 22:32:02');
INSERT INTO `v9_log` VALUES('950','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-26 22:32:30');
INSERT INTO `v9_log` VALUES('951','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-28 14:53:53');
INSERT INTO `v9_log` VALUES('952','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-28 14:54:19');
INSERT INTO `v9_log` VALUES('953','','0','content','','sitemodel','?m=content&c=sitemodel&a=edit','','1','admin','127.0.0.1','2019-09-28 14:57:11');
INSERT INTO `v9_log` VALUES('954','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-09-28 14:57:57');
INSERT INTO `v9_log` VALUES('955','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-09-28 14:58:12');
INSERT INTO `v9_log` VALUES('956','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-09-28 14:59:15');
INSERT INTO `v9_log` VALUES('957','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-09-28 14:59:38');
INSERT INTO `v9_log` VALUES('958','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-09-28 14:59:47');
INSERT INTO `v9_log` VALUES('959','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-09-28 15:00:11');
INSERT INTO `v9_log` VALUES('960','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-09-28 15:00:24');
INSERT INTO `v9_log` VALUES('961','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-09-28 15:00:30');
INSERT INTO `v9_log` VALUES('962','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-09-28 15:00:48');
INSERT INTO `v9_log` VALUES('963','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-28 15:16:29');
INSERT INTO `v9_log` VALUES('964','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-28 15:18:07');
INSERT INTO `v9_log` VALUES('965','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-09-28 15:19:31');
INSERT INTO `v9_log` VALUES('966','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=disabled','','1','admin','127.0.0.1','2019-09-28 15:21:40');
INSERT INTO `v9_log` VALUES('967','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=listorder','','1','admin','127.0.0.1','2019-09-28 15:22:01');
INSERT INTO `v9_log` VALUES('968','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-09-28 15:22:54');
INSERT INTO `v9_log` VALUES('969','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=disabled','','1','admin','127.0.0.1','2019-09-28 15:23:26');
INSERT INTO `v9_log` VALUES('970','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-28 15:24:37');
INSERT INTO `v9_log` VALUES('971','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-28 15:25:14');
INSERT INTO `v9_log` VALUES('972','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-28 15:27:16');
INSERT INTO `v9_log` VALUES('973','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-28 15:28:39');
INSERT INTO `v9_log` VALUES('974','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-28 15:46:34');
INSERT INTO `v9_log` VALUES('975','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-28 15:48:40');
INSERT INTO `v9_log` VALUES('976','','0','admin','','index','?m=admin&c=index&a=login','','0','','192.168.124.7','2019-09-28 17:18:26');
INSERT INTO `v9_log` VALUES('977','','0','admin','','index','?m=admin&c=index&a=login','','0','','192.168.124.7','2019-09-28 17:18:42');
INSERT INTO `v9_log` VALUES('978','','0','admin','','index','?m=admin&c=index&a=login','','0','','192.168.124.7','2019-09-28 17:18:49');
INSERT INTO `v9_log` VALUES('979','','0','admin','','index','?m=admin&c=index&a=login','','0','','192.168.124.7','2019-09-28 17:19:14');
INSERT INTO `v9_log` VALUES('980','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:27:20');
INSERT INTO `v9_log` VALUES('981','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:27:45');
INSERT INTO `v9_log` VALUES('982','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:36:41');
INSERT INTO `v9_log` VALUES('983','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:36:59');
INSERT INTO `v9_log` VALUES('984','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:39:25');
INSERT INTO `v9_log` VALUES('985','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 17:39:55');
INSERT INTO `v9_log` VALUES('986','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:40:23');
INSERT INTO `v9_log` VALUES('987','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:40:41');
INSERT INTO `v9_log` VALUES('988','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 17:42:02');
INSERT INTO `v9_log` VALUES('989','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:42:34');
INSERT INTO `v9_log` VALUES('990','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:42:42');
INSERT INTO `v9_log` VALUES('991','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 17:42:59');
INSERT INTO `v9_log` VALUES('992','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:43:23');
INSERT INTO `v9_log` VALUES('993','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:43:30');
INSERT INTO `v9_log` VALUES('994','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 17:43:46');
INSERT INTO `v9_log` VALUES('995','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 17:44:02');
INSERT INTO `v9_log` VALUES('996','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 17:44:14');
INSERT INTO `v9_log` VALUES('997','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:44:19');
INSERT INTO `v9_log` VALUES('998','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:44:28');
INSERT INTO `v9_log` VALUES('999','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 17:45:32');
INSERT INTO `v9_log` VALUES('1000','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:45:55');
INSERT INTO `v9_log` VALUES('1001','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:46:09');
INSERT INTO `v9_log` VALUES('1002','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 17:46:13');
INSERT INTO `v9_log` VALUES('1003','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 17:46:49');
INSERT INTO `v9_log` VALUES('1004','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 17:47:28');
INSERT INTO `v9_log` VALUES('1005','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 17:48:34');
INSERT INTO `v9_log` VALUES('1006','','0','attachment','','address','?m=attachment&c=address&a=update','','1','admin','127.0.0.1','2019-09-28 17:55:08');
INSERT INTO `v9_log` VALUES('1007','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:57:10');
INSERT INTO `v9_log` VALUES('1008','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:57:36');
INSERT INTO `v9_log` VALUES('1009','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:59:35');
INSERT INTO `v9_log` VALUES('1010','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 17:59:56');
INSERT INTO `v9_log` VALUES('1011','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 18:00:34');
INSERT INTO `v9_log` VALUES('1012','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 18:00:38');
INSERT INTO `v9_log` VALUES('1013','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 18:01:15');
INSERT INTO `v9_log` VALUES('1014','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 18:06:17');
INSERT INTO `v9_log` VALUES('1015','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 18:06:33');
INSERT INTO `v9_log` VALUES('1016','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 18:08:30');
INSERT INTO `v9_log` VALUES('1017','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 18:12:04');
INSERT INTO `v9_log` VALUES('1018','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-28 18:12:20');
INSERT INTO `v9_log` VALUES('1019','','0','admin','','index','?m=admin&c=index&a=login','','0','','192.168.124.6','2019-09-28 18:16:41');
INSERT INTO `v9_log` VALUES('1020','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-28 18:19:06');
INSERT INTO `v9_log` VALUES('1021','','0','admin','','index','?m=admin&c=index&a=login','','0','','192.168.124.6','2019-09-28 18:19:28');
INSERT INTO `v9_log` VALUES('1022','','0','admin','','index','?m=admin&c=index&a=login','','0','','192.168.124.6','2019-09-28 18:19:45');
INSERT INTO `v9_log` VALUES('1023','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2019-09-29 11:24:32');
INSERT INTO `v9_log` VALUES('1024','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2019-09-29 11:27:48');
INSERT INTO `v9_log` VALUES('1025','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2019-09-29 18:13:55');
INSERT INTO `v9_log` VALUES('1026','','0','admin','','index','?m=admin&c=index&a=login','','0','','127.0.0.1','2019-09-29 18:14:06');
INSERT INTO `v9_log` VALUES('1027','','0','member','','member','?m=member&c=member&a=manage','','1','admin','127.0.0.1','2019-09-29 18:19:19');
INSERT INTO `v9_log` VALUES('1028','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 20:25:56');
INSERT INTO `v9_log` VALUES('1029','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 20:26:01');
INSERT INTO `v9_log` VALUES('1030','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 20:26:06');
INSERT INTO `v9_log` VALUES('1031','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 20:26:06');
INSERT INTO `v9_log` VALUES('1032','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-29 20:30:23');
INSERT INTO `v9_log` VALUES('1033','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-29 20:33:21');
INSERT INTO `v9_log` VALUES('1034','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-29 20:34:47');
INSERT INTO `v9_log` VALUES('1035','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-29 20:35:18');
INSERT INTO `v9_log` VALUES('1036','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-29 21:45:49');
INSERT INTO `v9_log` VALUES('1037','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-29 21:45:55');
INSERT INTO `v9_log` VALUES('1038','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-29 21:46:25');
INSERT INTO `v9_log` VALUES('1039','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-29 21:47:44');
INSERT INTO `v9_log` VALUES('1040','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-29 21:48:06');
INSERT INTO `v9_log` VALUES('1041','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-29 21:48:09');
INSERT INTO `v9_log` VALUES('1042','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-29 21:48:13');
INSERT INTO `v9_log` VALUES('1043','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','127.0.0.1','2019-09-29 21:50:54');
INSERT INTO `v9_log` VALUES('1044','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-29 21:51:15');
INSERT INTO `v9_log` VALUES('1045','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-29 21:52:07');
INSERT INTO `v9_log` VALUES('1046','','0','attachment','','manage','?m=attachment&c=manage&a=dir','','1','admin','127.0.0.1','2019-09-29 21:53:16');
INSERT INTO `v9_log` VALUES('1047','','0','attachment','','address','?m=attachment&c=address&a=update','','1','admin','127.0.0.1','2019-09-29 21:53:36');
INSERT INTO `v9_log` VALUES('1048','','0','content','','create_html','?m=content&c=create_html&a=category','','1','admin','127.0.0.1','2019-09-29 21:53:58');
INSERT INTO `v9_log` VALUES('1049','','0','content','','create_html','?m=content&c=create_html&a=category','','1','admin','127.0.0.1','2019-09-29 21:54:01');
INSERT INTO `v9_log` VALUES('1050','','0','content','','create_html','?m=content&c=create_html&a=category','','1','admin','127.0.0.1','2019-09-29 21:54:04');
INSERT INTO `v9_log` VALUES('1051','','0','content','','create_html','?m=content&c=create_html&a=category','','1','admin','127.0.0.1','2019-09-29 21:54:05');
INSERT INTO `v9_log` VALUES('1052','','0','content','','create_html','?m=content&c=create_html&a=category','','1','admin','127.0.0.1','2019-09-29 21:54:05');
INSERT INTO `v9_log` VALUES('1053','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 21:54:08');
INSERT INTO `v9_log` VALUES('1054','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 21:54:14');
INSERT INTO `v9_log` VALUES('1055','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 21:54:16');
INSERT INTO `v9_log` VALUES('1056','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 21:54:16');
INSERT INTO `v9_log` VALUES('1057','','0','content','','create_html','?m=content&c=create_html&a=show','','1','admin','127.0.0.1','2019-09-29 21:54:18');
INSERT INTO `v9_log` VALUES('1058','','0','content','','create_html','?m=content&c=create_html&a=show','','1','admin','127.0.0.1','2019-09-29 21:54:20');
INSERT INTO `v9_log` VALUES('1059','','0','content','','create_html','?m=content&c=create_html&a=show','','1','admin','127.0.0.1','2019-09-29 21:54:22');
INSERT INTO `v9_log` VALUES('1060','','0','content','','create_html','?m=content&c=create_html&a=show','','1','admin','127.0.0.1','2019-09-29 21:54:23');
INSERT INTO `v9_log` VALUES('1061','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 21:54:24');
INSERT INTO `v9_log` VALUES('1062','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 21:54:27');
INSERT INTO `v9_log` VALUES('1063','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 21:54:27');
INSERT INTO `v9_log` VALUES('1064','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 21:54:27');
INSERT INTO `v9_log` VALUES('1065','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','127.0.0.1','2019-09-29 21:54:28');
INSERT INTO `v9_log` VALUES('1066','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-29 21:54:34');
INSERT INTO `v9_log` VALUES('1067','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-29 22:01:50');
INSERT INTO `v9_log` VALUES('1068','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-29 22:14:18');
INSERT INTO `v9_log` VALUES('1069','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-30 00:26:37');
INSERT INTO `v9_log` VALUES('1070','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-30 00:27:07');
INSERT INTO `v9_log` VALUES('1071','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-30 00:34:37');
INSERT INTO `v9_log` VALUES('1072','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-30 00:35:29');
INSERT INTO `v9_log` VALUES('1073','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-30 01:07:11');
INSERT INTO `v9_log` VALUES('1074','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-30 01:10:02');
INSERT INTO `v9_log` VALUES('1075','','0','content','','content','?m=content&c=content&a=edit','','1','admin','127.0.0.1','2019-09-30 01:23:45');
INSERT INTO `v9_log` VALUES('1076','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-30 01:26:34');
INSERT INTO `v9_log` VALUES('1077','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-30 01:26:54');
INSERT INTO `v9_log` VALUES('1078','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-30 11:15:40');
INSERT INTO `v9_log` VALUES('1079','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-09-30 11:15:53');
INSERT INTO `v9_log` VALUES('1080','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','127.0.0.1','2019-09-30 11:16:48');
INSERT INTO `v9_log` VALUES('1081','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2019-09-30 11:17:04');
INSERT INTO `v9_log` VALUES('1082','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2019-09-30 11:17:14');
INSERT INTO `v9_log` VALUES('1083','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2019-09-30 11:17:22');
INSERT INTO `v9_log` VALUES('1084','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2019-09-30 11:17:25');
INSERT INTO `v9_log` VALUES('1085','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2019-09-30 11:17:28');
INSERT INTO `v9_log` VALUES('1086','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2019-09-30 11:17:33');
INSERT INTO `v9_log` VALUES('1087','','0','admin','','database','?m=admin&c=database&a=import','','1','admin','127.0.0.1','2019-09-30 11:17:34');
INSERT INTO `v9_log` VALUES('1088','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2019-09-30 11:17:49');
INSERT INTO `v9_log` VALUES('1089','','0','admin','','database','?m=admin&c=database&a=import','','1','admin','127.0.0.1','2019-09-30 11:17:58');
INSERT INTO `v9_log` VALUES('1090','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-10-06 16:15:37');
INSERT INTO `v9_log` VALUES('1091','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','127.0.0.1','2019-10-06 16:15:55');
INSERT INTO `v9_log` VALUES('1092','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-10-06 16:17:36');
INSERT INTO `v9_log` VALUES('1093','','0','content','','sitemodel_field','?m=content&c=sitemodel_field&a=edit','','1','admin','127.0.0.1','2019-10-06 16:17:56');
INSERT INTO `v9_log` VALUES('1094','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2019-10-06 17:16:40');
INSERT INTO `v9_log` VALUES('1095','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2019-10-06 17:16:47');
INSERT INTO `v9_log` VALUES('1096','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','127.0.0.1','2019-10-06 17:16:53');
INSERT INTO `v9_log` VALUES('1097','','0','admin','','database','?m=admin&c=database&a=import','','1','admin','','2019-10-06 17:21:02');
INSERT INTO `v9_log` VALUES('1098','','0','admin','','database','?m=admin&c=database&a=import','','1','admin','','2019-10-06 17:21:03');
INSERT INTO `v9_log` VALUES('1099','','0','content','','content','?m=content&c=content&a=add','','1','admin','','2019-10-06 17:25:11');
INSERT INTO `v9_log` VALUES('1100','','0','content','','content','?m=content&c=content&a=edit','','1','admin','','2019-10-06 17:25:16');
INSERT INTO `v9_log` VALUES('1101','','0','content','','content','?m=content&c=content&a=add','','1','admin','','2019-10-06 17:26:23');
INSERT INTO `v9_log` VALUES('1102','','0','content','','content','?m=content&c=content&a=edit','','1','admin','','2019-10-06 17:26:33');
INSERT INTO `v9_log` VALUES('1103','','0','content','','content','?m=content&c=content&a=edit','','1','admin','','2019-10-06 17:26:44');
INSERT INTO `v9_log` VALUES('1104','','0','admin','','index','?m=admin&c=index&a=login','','0','','','2019-10-06 22:56:44');
INSERT INTO `v9_log` VALUES('1105','','0','admin','','index','?m=admin&c=index&a=login','','0','','','2019-10-06 22:56:59');
INSERT INTO `v9_log` VALUES('1106','','0','content','','content','?m=content&c=content&a=delete','','1','admin','','2019-10-06 22:57:15');
INSERT INTO `v9_log` VALUES('1107','','0','content','','content','?m=content&c=content&a=clear_data','','1','admin','','2019-10-06 22:58:33');
INSERT INTO `v9_log` VALUES('1108','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','','2019-10-06 22:58:45');
INSERT INTO `v9_log` VALUES('1109','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','','2019-10-06 22:58:48');
INSERT INTO `v9_log` VALUES('1110','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','','2019-10-06 22:58:48');
INSERT INTO `v9_log` VALUES('1111','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','','2019-10-06 22:58:49');
INSERT INTO `v9_log` VALUES('1112','','0','content','','create_html','?m=content&c=create_html&a=update_urls','','1','admin','','2019-10-06 22:58:49');
INSERT INTO `v9_log` VALUES('1113','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','','2019-10-06 22:59:10');
INSERT INTO `v9_log` VALUES('1114','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','','2019-10-06 23:00:07');
INSERT INTO `v9_log` VALUES('1115','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','','2019-10-06 23:00:48');
INSERT INTO `v9_log` VALUES('1116','','0','admin','','site','?m=admin&c=site&a=edit','','1','admin','','2019-10-06 23:01:07');
INSERT INTO `v9_log` VALUES('1117','','0','admin','','setting','?m=admin&c=setting&a=save','','1','admin','','2019-10-06 23:01:31');
INSERT INTO `v9_log` VALUES('1118','','0','admin','','index','?m=admin&c=index&a=login','','0','','','2019-10-06 23:01:41');
INSERT INTO `v9_log` VALUES('1119','','0','admin','','index','?m=admin&c=index&a=login','','0','','','2019-10-06 23:01:59');
INSERT INTO `v9_log` VALUES('1120','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','','2019-10-07 00:34:08');
INSERT INTO `v9_log` VALUES('1121','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','','2019-10-07 00:34:25');
INSERT INTO `v9_log` VALUES('1122','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','','2019-10-07 16:10:41');
INSERT INTO `v9_log` VALUES('1123','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','','2019-10-07 16:10:48');
INSERT INTO `v9_log` VALUES('1124','','0','admin','','index','?m=admin&c=index&a=login','','0','admin','','2019-10-07 16:11:04');
INSERT INTO `v9_log` VALUES('1125','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','','2019-10-07 16:34:29');
INSERT INTO `v9_log` VALUES('1126','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','','2019-10-07 16:34:35');
INSERT INTO `v9_log` VALUES('1127','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','','2019-10-07 16:34:35');
INSERT INTO `v9_log` VALUES('1128','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','','2019-10-07 16:34:37');
INSERT INTO `v9_log` VALUES('1129','','0','admin','','database','?m=admin&c=database&a=export','','1','admin','','2019-10-07 16:34:41');

DROP TABLE IF EXISTS `v9_member`;
CREATE TABLE `v9_member` (
  `userid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `phpssouid` mediumint(8) unsigned NOT NULL,
  `username` char(20) NOT NULL DEFAULT '',
  `password` char(32) NOT NULL DEFAULT '',
  `encrypt` char(6) NOT NULL,
  `nickname` char(20) NOT NULL,
  `regdate` int(10) unsigned NOT NULL DEFAULT '0',
  `lastdate` int(10) unsigned NOT NULL DEFAULT '0',
  `regip` char(15) NOT NULL DEFAULT '',
  `lastip` char(15) NOT NULL DEFAULT '',
  `loginnum` smallint(5) unsigned NOT NULL DEFAULT '0',
  `email` char(32) NOT NULL DEFAULT '',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `areaid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `amount` decimal(8,2) unsigned NOT NULL DEFAULT '0.00',
  `point` smallint(5) unsigned NOT NULL DEFAULT '0',
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `message` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `islock` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `vip` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `overduedate` int(10) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '1',
  `connectid` char(40) NOT NULL DEFAULT '',
  `from` char(10) NOT NULL DEFAULT '',
  `mobile` char(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `username` (`username`),
  KEY `email` (`email`(20)),
  KEY `phpssouid` (`phpssouid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `v9_member` VALUES('1','1','123','b3c9b7b6630e9449f5055be067a63ff1','x63AAD','aaa','1562491890','1569759434','127.0.0.1','192.168.124.6','0','844800670@qq.com','2','0','0.00','0','10','0','0','0','0','1','','','');

DROP TABLE IF EXISTS `v9_member_detail`;
CREATE TABLE `v9_member_detail` (
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `birthday` date DEFAULT NULL,
  UNIQUE KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_member_detail` VALUES('1','2019-07-01');

DROP TABLE IF EXISTS `v9_member_group`;
CREATE TABLE `v9_member_group` (
  `groupid` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(15) NOT NULL,
  `issystem` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `starnum` tinyint(2) unsigned NOT NULL,
  `point` smallint(6) unsigned NOT NULL,
  `allowmessage` smallint(5) unsigned NOT NULL DEFAULT '0',
  `allowvisit` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allowpost` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allowpostverify` tinyint(1) unsigned NOT NULL,
  `allowsearch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allowupgrade` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `allowsendmessage` tinyint(1) unsigned NOT NULL,
  `allowpostnum` smallint(5) unsigned NOT NULL DEFAULT '0',
  `allowattachment` tinyint(1) NOT NULL,
  `price_y` decimal(8,2) unsigned NOT NULL DEFAULT '0.00',
  `price_m` decimal(8,2) unsigned NOT NULL DEFAULT '0.00',
  `price_d` decimal(8,2) unsigned NOT NULL DEFAULT '0.00',
  `icon` char(30) NOT NULL,
  `usernamecolor` char(7) NOT NULL,
  `description` char(100) NOT NULL,
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `disabled` (`disabled`),
  KEY `listorder` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

INSERT INTO `v9_member_group` VALUES('8','游客','1','0','0','0','0','0','0','1','0','0','0','0','0.00','0.00','0.00','','','','0','0');
INSERT INTO `v9_member_group` VALUES('2','新手上路','1','1','50','100','1','1','0','0','0','1','0','0','50.00','10.00','1.00','','','','2','0');
INSERT INTO `v9_member_group` VALUES('6','注册会员','1','2','100','150','0','1','0','0','1','1','0','0','300.00','30.00','1.00','','','','6','0');
INSERT INTO `v9_member_group` VALUES('4','中级会员','1','3','150','500','1','1','0','1','1','1','0','0','500.00','60.00','1.00','','','','4','0');
INSERT INTO `v9_member_group` VALUES('5','高级会员','1','5','300','999','1','1','0','1','1','1','0','0','360.00','90.00','5.00','','','','5','0');
INSERT INTO `v9_member_group` VALUES('1','禁止访问','1','0','0','0','1','1','0','1','0','0','0','0','0.00','0.00','0.00','','','0','0','0');
INSERT INTO `v9_member_group` VALUES('7','邮件认证','1','0','0','0','0','0','0','0','0','0','0','0','0.00','0.00','0.00','images/group/vip.jpg','#000000','','7','0');

DROP TABLE IF EXISTS `v9_member_menu`;
CREATE TABLE `v9_member_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL DEFAULT '',
  `parentid` smallint(6) NOT NULL DEFAULT '0',
  `m` char(20) NOT NULL DEFAULT '',
  `c` char(20) NOT NULL DEFAULT '',
  `a` char(20) NOT NULL DEFAULT '',
  `data` char(100) NOT NULL DEFAULT '',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '0',
  `display` enum('1','0') NOT NULL DEFAULT '1',
  `isurl` enum('1','0') NOT NULL DEFAULT '0',
  `url` char(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `listorder` (`listorder`),
  KEY `parentid` (`parentid`),
  KEY `module` (`m`,`c`,`a`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `v9_member_menu` VALUES('1','member_init','0','member','index','init','t=0','0','1','','');
INSERT INTO `v9_member_menu` VALUES('2','account_manage','0','member','index','account_manage','t=1','0','1','','');
INSERT INTO `v9_member_menu` VALUES('3','favorite','0','member','index','favorite','t=2','0','1','','');

DROP TABLE IF EXISTS `v9_member_verify`;
CREATE TABLE `v9_member_verify` (
  `userid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(20) NOT NULL,
  `password` char(32) NOT NULL,
  `encrypt` char(6) NOT NULL,
  `nickname` char(20) NOT NULL,
  `regdate` int(10) unsigned NOT NULL,
  `regip` char(15) NOT NULL,
  `email` char(32) NOT NULL,
  `modelid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `point` smallint(5) unsigned NOT NULL DEFAULT '0',
  `amount` decimal(8,2) unsigned NOT NULL DEFAULT '0.00',
  `modelinfo` char(255) NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `siteid` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `message` char(100) DEFAULT NULL,
  `mobile` char(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `username` (`username`),
  KEY `email` (`email`(20))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_member_vip`;
CREATE TABLE `v9_member_vip` (
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_menu`;
CREATE TABLE `v9_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL DEFAULT '',
  `parentid` smallint(6) NOT NULL DEFAULT '0',
  `m` char(20) NOT NULL DEFAULT '',
  `c` char(20) NOT NULL DEFAULT '',
  `a` char(20) NOT NULL DEFAULT '',
  `data` char(100) NOT NULL DEFAULT '',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '0',
  `display` enum('1','0') NOT NULL DEFAULT '1',
  `project1` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `project2` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `project3` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `project4` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `project5` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `listorder` (`listorder`),
  KEY `parentid` (`parentid`),
  KEY `module` (`m`,`c`,`a`)
) ENGINE=MyISAM AUTO_INCREMENT=1669 DEFAULT CHARSET=utf8;

INSERT INTO `v9_menu` VALUES('1','sys_setting','0','admin','setting','init','','1','1','0','1','1','1','1');
INSERT INTO `v9_menu` VALUES('2','module','0','admin','module','init','','2','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('872','sync_release_point','873','release','index','init','','3','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('4','content','0','content','content','init','','4','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('5','members','0','member','member','init','','5','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('6','userinterface','0','template','style','init','','6','1','0','1','1','1','1');
INSERT INTO `v9_menu` VALUES('30','correlative_setting','1','admin','admin','admin','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('31','menu_manage','977','admin','menu','init','','8','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('32','posid_manage','975','admin','position','init','','7','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('29','module_list','2','admin','module','','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('82','module_manage','2','admin','module','','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('10','panel','0','admin','index','public_main','','0','1','0','1','1','1','1');
INSERT INTO `v9_menu` VALUES('35','menu_add','31','admin','menu','add','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('826','template_manager','6','','','','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('54','admin_manage','49','admin','admin_manage','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('43','category_manage','975','admin','category','init','module=admin','4','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('42','add_category','43','admin','category','add','s=0','1','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('44','edit_category','43','admin','category','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('45','badword_manage','977','admin','badword','init','','10','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('46','posid_add','32','admin','position','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('49','admin_setting','1','admin','','','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('50','role_manage','49','admin','role','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('51','role_add','50','admin','role','add','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('52','category_cache','43','admin','category','public_cache','module=admin','4','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('55','manage_member','5','member','member','manage','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('58','admin_add','54','admin','admin_manage','add','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('59','model_manage','975','content','sitemodel','init','','5','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('64','site_management','30','admin','site','init','','2','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('81','member_add','72','member','member','add','','2','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('62','add_model','59','content','sitemodel','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('65','release_point_management','30','admin','release_point','init','','3','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('66','badword_export','45','admin','badword','export','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('67','add_site','64','admin','site','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('68','badword_import','45','admin','badword','import','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('812','member_group_manage','76','member','member_group','manage','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('74','member_verify','55','member','member_verify','manage','s=0','3','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('76','manage_member_group','5','member','member_group','manage','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('77','manage_member_model','5','member','member_model','manage','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('78','member_group_add','812','member','member_group','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('79','member_model_add','813','member','member_model','add','','1','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('80','member_model_import','77','member','member_model','import','','2','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('72','member_manage','55','member','member','manage','','1','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('813','member_model_manage','77','member','member_model','manage','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('814','site_edit','64','admin','site','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('815','site_del','64','admin','site','del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('816','release_point_add','65','admin','release_point','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('817','release_point_del','65','admin','release_point','del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('818','release_point_edit','65','admin','release_point','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('821','content_publish','4','content','content','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('822','content_manage','821','content','content','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('867','linkage','977','admin','linkage','init','','13','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('827','template_style','826','template','style','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('828','import_style','827','template','style','import','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('831','template_export','827','template','style','export','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('830','template_file','827','template','file','init','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('832','template_onoff','827','template','style','disable','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('833','template_updatename','827','template','style','updatename','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('834','member_lock','72','member','member','lock','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('835','member_unlock','72','member','member','unlock','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('836','member_move','72','member','member','move','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('837','member_delete','72','member','member','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('842','verify_ignore','74','member','member_verify','manage','s=2','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('839','member_setting','55','member','member_setting','manage','','4','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('841','verify_pass','74','member','member_verify','manage','s=1','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('843','verify_delete','74','member','member_verify','manage','s=3','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('844','verify_deny','74','member','member_verify','manage','s=4','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('845','never_pass','74','member','member_verify','manage','s=5','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('846','template_file_list','827','template','file','init','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('847','template_file_edit','827','template','file','edit_file','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('848','file_add_file','827','template','file','add_file','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('850','listorder','76','member','member_group','sort','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('852','priv_setting','50','admin','role','priv_setting','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('853','role_priv','50','admin','role','role_priv','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('857','attachment_manage','821','attachment','manage','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('868','special','821','special','special','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('869','template_editor','827','template','file','edit_file','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('870','template_visualization','827','template','file','visualization','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('871','pc_tag_edit','827','template','file','edit_pc_tag','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('873','release_manage','4','release','html','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('874','type_manage','975','content','type_manage','init','','6','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('875','add_type','874','content','type_manage','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('876','linkageadd','867','admin','linkage','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('877','failure_list','872','release','index','failed','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('879','member_search','72','member','member','search','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('880','queue_del','872','release','index','del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('881','member_model_delete','813','member','member_model','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('882','member_model_edit','813','member','member_model','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('885','workflow','977','content','workflow','init','','15','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('888','add_workflow','885','content','workflow','add','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('889','member_modelfield_add','813','member','member_modelfield','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('890','member_modelfield_edit','813','member','member_modelfield','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('891','member_modelfield_delete','813','member','member_modelfield','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('892','member_modelfield_manage','813','member','member_modelfield','manage','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('895','sitemodel_import','59','content','sitemodel','import','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('896','pay','29','pay','payment','pay_list','s=3','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('897','payments','896','pay','payment','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('898','paylist','896','pay','payment','pay_list','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('899','add_content','822','content','content','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('900','modify_deposit','896','pay','payment','modify_deposit','s=1','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('901','check_content','822','content','content','pass','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('902','dbsource','29','dbsource','data','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('905','create_content_html','873','content','create_html','show','','2','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('904','external_data_sources','902','dbsource','dbsource_admin','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('906','update_urls','873','content','create_html','update_urls','','1','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('960','node_add','957','collection','node','add','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('909','fulltext_search','29','search','search_type','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('910','manage_type','909','search','search_type','init','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('911','search_setting','909','search','search_admin','setting','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('912','createindex','909','search','search_admin','createindex','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('913','add_search_type','909','search','search_type','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('914','database_toos','977','admin','database','export','','6','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('915','database_export','914','admin','database','export','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('916','database_import','914','admin','database','import','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('917','dbsource_add','902','dbsource','dbsource_admin','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('918','dbsource_edit','902','dbsource','dbsource_admin','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('919','dbsource_del','902','dbsource','dbsource_admin','del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('920','dbsource_data_add','902','dbsource','data','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('921','dbsource_data_edit','902','dbsource','data','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('922','dbsource_data_del','902','dbsource','data','del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('926','add_special','868','special','special','add','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('927','edit_special','868','special','special','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('928','special_list','868','special','special','init','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('929','special_elite','868','special','special','elite','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('930','delete_special','868','special','special','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('931','badword_add','45','admin','badword','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('932','badword_edit','45','admin','badword','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('933','badword_delete','45','admin','badword','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('934','special_listorder','868','special','special','listorder','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('935','special_content_list','868','special','content','init','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('936','special_content_add','935','special','content','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('937','special_content_list','935','special','content','init','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('938','special_content_edit','935','special','content','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('939','special_content_delete','935','special','content','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('940','special_content_listorder','935','special','content','listorder','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('941','special_content_import','935','special','special','import','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('942','history_version','827','template','template_bak','init','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('943','restore_version','827','template','template_bak','restore','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('944','del_history_version','827','template','template_bak','del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('945','block','821','block','block_admin','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('946','block_add','945','block','block_admin','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('950','block_edit','945','block','block_admin','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('951','block_del','945','block','block_admin','del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('952','block_update','945','block','block_admin','block_update','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('953','block_restore','945','block','block_admin','history_restore','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('954','history_del','945','block','block_admin','history_del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('978','urlrule_manage','977','admin','urlrule','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('957','collection_node','821','collection','node','manage','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('979','safe_config','30','admin','setting','init','&tab=2','11','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('959','basic_config','30','admin','setting','init','','10','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('961','position_edit','32','admin','position','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('962','collection_node_edit','957','collection','node','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('963','collection_node_delete','957','collection','node','del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('990','col_url_list','957','collection','node','col_url_list','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('965','collection_node_publish','957','collection','node','publist','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('966','collection_node_import','957','collection','node','node_import','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('967','collection_node_export','957','collection','node','export','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('968','collection_node_collection_content','957','collection','node','col_content','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('969','googlesitemap','977','admin','googlesitemap','set','','11','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('970','admininfo','10','admin','admin_manage','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('971','editpwd','970','admin','admin_manage','public_edit_pwd','','1','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('972','editinfo','970','admin','admin_manage','public_edit_info','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('973','keylink','977','admin','keylink','init','','12','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('974','add_keylink','973','admin','keylink','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('975','content_settings','4','content','content_settings','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('7','extend','0','admin','extend','init_extend','','7','1','0','1','1','1','1');
INSERT INTO `v9_menu` VALUES('977','extend_all','7','admin','extend_all','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('980','sso_config','30','admin','setting','init','&tab=3','12','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('981','email_config','30','admin','setting','init','&tab=4','13','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('982','module_manage','82','admin','module','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('983','ipbanned','977','admin','ipbanned','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('984','add_ipbanned','983','admin','ipbanned','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('993','collection_content_import','957','collection','node','import','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('991','copy_node','957','collection','node','copy','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('992','content_del','957','collection','node','content_del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('989','downsites','977','admin','downservers','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('994','import_program_add','957','collection','node','import_program_add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('995','import_program_del','957','collection','node','import_program_del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('996','import_content','957','collection','node','import_content','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('997','log','977','admin','log','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('998','add_page','43','admin','category','add','s=1','2','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('999','add_cat_link','43','admin','category','add','s=2','2','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1000','count_items','43','admin','category','count_items','','5','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1001','cache_all','977','admin','cache_all','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1002','create_list_html','873','content','create_html','category','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1003','create_html_quick','10','content','create_html_opt','index','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1004','create_index','1003','content','create_html','public_index','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1005','scan','977','scan','index','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1006','scan_report','1005','scan','index','scan_report','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1007','md5_creat','1005','scan','index','md5_creat','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1008','album_import','868','special','album','import','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('8','phpsso','0','admin','phpsso','menu','','7','1','0','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1011','edit_content','822','content','content','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1012','push_to_special','822','content','push','init','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1023','delete_log','997','admin','log','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1024','delete_ip','983','admin','ipbanned','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1026','delete_keylink','973','admin','keylink','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1027','edit_keylink','973','admin','keylink','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1034','operation_pass','74','member','member_verify','pass','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1035','operation_delete','74','member','member_verify','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1039','operation_ignore','74','member','member_verify','ignore','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1038','settingsave','30','admin','setting','save','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1040','admin_edit','54','admin','admin_manage','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1041','operation_reject','74','member','member_verify','reject','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1042','admin_delete','54','admin','admin_manage','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1043','card','54','admin','admin_manage','card','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1044','creat_card','54','admin','admin_manage','creat_card','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1045','remove_card','54','admin','admin_manage','remove_card','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1049','member_group_edit','812','member','member_group','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1048','member_edit','72','member','member','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1050','role_edit','50','admin','role','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1051','member_group_delete','812','member','member_group','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1052','member_manage','50','admin','role','member_manage','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1053','role_delete','50','admin','role','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1054','member_model_export','77','member','member_model','export','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1055','member_model_sort','77','member','member_model','sort','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1056','member_model_move','77','member','member_model','move','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1057','payment_add','897','pay','payment','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1058','payment_delete','897','pay','payment','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1059','payment_edit','897','pay','payment','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1060','spend_record','896','pay','spend','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1061','pay_stat','896','pay','payment','pay_stat','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1062','fields_manage','59','content','sitemodel_field','init','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1063','edit_model_content','59','content','sitemodel','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1064','disabled_model','59','content','sitemodel','disabled','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1065','delete_model','59','content','sitemodel','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1066','export_model','59','content','sitemodel','export','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1067','delete','874','content','type_manage','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1068','edit','874','content','type_manage','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1069','add_urlrule','978','admin','urlrule','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1070','edit_urlrule','978','admin','urlrule','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1071','delete_urlrule','978','admin','urlrule','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1072','edit_menu','31','admin','menu','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1073','delete_menu','31','admin','menu','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1074','edit_workflow','885','content','workflow','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1075','delete_workflow','885','content','workflow','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1076','creat_html','868','special','special','html','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1093','connect_config','30','admin','setting','init','&tab=5','14','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1102','view_modelinfo','74','member','member_verify','modelinfo','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1202','create_special_list','868','special','special','create_special_list','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1240','view_memberlinfo','72','member','member','memberinfo','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1239','copyfrom_manage','977','admin','copyfrom','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1241','move_content','822','content','content','remove','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1242','poster_template','56','poster','space','poster_template','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1243','create_index','873','content','create_html','public_index','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1244','add_othors','822','content','content','add_othors','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1295','attachment_manager_dir','857','attachment','manage','dir','','2','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1296','attachment_manager_db','857','attachment','manage','init','','1','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1346','attachment_address_replace','857','attachment','address','init','','3','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1347','attachment_address_update','857','attachment','address','update','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1348','delete_content','822','content','content','delete','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1349','member_menu_manage','977','member','member_menu','manage','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1350','member_menu_add','1349','member','member_menu','add','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1351','member_menu_edit','1349','member','member_menu','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1352','member_menu_delete','1349','member','member_menu','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1353','batch_show','822','content','create_html','batch_show','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1354','pay_delete','898','pay','payment','pay_del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1355','pay_cancel','898','pay','payment','pay_cancel','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1356','discount','898','pay','payment','discount','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1360','category_batch_edit','43','admin','category','batch_edit','','6','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1500','listorder','822','content','content','listorder','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1501','a_clean_data','873','content','content','clear_data','','0','1','0','0','0','0','0');
INSERT INTO `v9_menu` VALUES('9','video','0','video','video','init','','11','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1589','video','9','video','video','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1583','sub_delete','1589','video','video','sub_del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1582','subscribe_manage','1589','video','video','subscribe_list','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1581','video_open','1589','video','video','open','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1592','complete_info','1581','video','video','complete_info','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1591','video_inputinfo','1581','video','video','open','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1577','video_manage','1589','video','video','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1590','player_manage','1589','video','player','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1585','import_ku6_video','1589','video','video','import_ku6video','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1579','video_edit','1589','video','video','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1580','video_delete','1589','video','video','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1578','video_upload','1589','video','video','add','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1593','video_stat','1589','video','stat','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1586','video_store','1589','video','video','video2content','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1594','announce','29','announce','admin_announce','init','s=1','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1595','announce_add','1594','announce','admin_announce','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1596','edit_announce','1594','announce','admin_announce','edit','s=1','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1597','check_announce','1594','announce','admin_announce','init','s=2','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1598','overdue','1594','announce','admin_announce','init','s=3','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1599','del_announce','1594','announce','admin_announce','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1600','comment','29','comment','comment_admin','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1601','comment_manage','821','comment','comment_admin','listinfo','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1602','comment_check','1601','comment','check','checks','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1603','comment_list','1600','comment','comment_admin','lists','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1604','link','29','link','link','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1605','add_link','1604','link','link','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1606','edit_link','1604','link','link','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1607','delete_link','1604','link','link','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1608','link_setting','1604','link','link','setting','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1609','add_type','1604','link','link','add_type','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1610','list_type','1604','link','link','list_type','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1611','check_register','1604','link','link','check_register','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1612','vote','29','vote','vote','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1613','add_vote','1612','vote','vote','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1614','edit_vote','1612','vote','vote','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1615','delete_vote','1612','vote','vote','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1616','vote_setting','1612','vote','vote','setting','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1617','statistics_vote','1612','vote','vote','statistics','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1618','statistics_userlist','1612','vote','vote','statistics_userlist','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1619','create_js','1612','vote','vote','create_js','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1620','message','29','message','message','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1621','send_one','1620','message','message','send_one','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1622','delete_message','1620','message','message','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1623','message_send','1620','message','message','message_send','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1624','message_group_manage','1620','message','message','message_group_manage','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1625','mood','29','mood','mood_admin','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1626','mood_setting','1625','mood','mood_admin','setting','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1627','poster','29','poster','space','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1628','add_space','1627','poster','space','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1629','edit_space','1627','poster','space','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1630','del_space','1627','poster','space','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1631','poster_list','1627','poster','poster','init','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1632','add_poster','1627','poster','poster','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1633','edit_poster','1627','poster','poster','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1634','del_poster','1627','poster','poster','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1635','poster_stat','1627','poster','poster','stat','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1636','poster_setting','1627','poster','space','setting','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1637','create_poster_js','1627','poster','space','create_js','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1638','poster_template','1627','poster','space','poster_template','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1639','formguide','29','formguide','formguide','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1640','formguide_add','1639','formguide','formguide','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1641','formguide_edit','1639','formguide','formguide','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1642','form_info_list','1639','formguide','formguide_info','init','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1643','formguide_disabled','1639','formguide','formguide','disabled','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1644','formguide_delete','1639','formguide','formguide','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1645','formguide_stat','1639','formguide','formguide','stat','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1646','add_public_field','1639','formguide','formguide_field','add','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1647','list_public_field','1639','formguide','formguide_field','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1648','module_setting','1639','formguide','formguide','setting','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1649','wap','29','wap','wap_admin','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1650','wap_add','1649','wap','wap_admin','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1651','wap_edit','1649','wap','wap_admin','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1652','wap_delete','1649','wap','wap_admin','delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1653','wap_type_manage','1649','wap','wap_admin','type_manage','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1654','wap_type_edit','1649','wap','wap_admin','type_edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1655','wap_type_delete','1649','wap','wap_admin','type_delete','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1656','upgrade','977','upgrade','index','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1657','checkfile','1656','upgrade','index','checkfile','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1658','tag','826','tag','tag','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1659','add_tag','1658','tag','tag','add','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1660','edit_tag','1658','tag','tag','edit','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1661','delete_tag','1658','tag','tag','del','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1662','tag_lists','1658','tag','tag','lists','','0','0','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1663','sms','29','sms','sms','init','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1664','sms_setting','1663','sms','sms','sms_setting','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1665','sms_pay_history','1663','sms','sms','sms_pay_history','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1666','sms_buy_history','1663','sms','sms','sms_buy_history','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1667','sms_api','1663','sms','sms','sms_api','','0','1','1','1','1','1','1');
INSERT INTO `v9_menu` VALUES('1668','sms_sent','1663','sms','sms','sms_sent','','0','1','1','1','1','1','1');

DROP TABLE IF EXISTS `v9_message`;
CREATE TABLE `v9_message` (
  `messageid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `send_from_id` char(30) NOT NULL DEFAULT '0',
  `send_to_id` char(30) NOT NULL DEFAULT '0',
  `folder` enum('all','inbox','outbox') NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `message_time` int(10) unsigned NOT NULL DEFAULT '0',
  `subject` char(80) DEFAULT NULL,
  `content` text NOT NULL,
  `replyid` int(10) unsigned NOT NULL DEFAULT '0',
  `del_type` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`messageid`),
  KEY `msgtoid` (`send_to_id`,`folder`),
  KEY `replyid` (`replyid`),
  KEY `folder` (`send_from_id`,`folder`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_message_data`;
CREATE TABLE `v9_message_data` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `userid` mediumint(8) NOT NULL,
  `group_message_id` int(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `message` (`userid`,`group_message_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_message_group`;
CREATE TABLE `v9_message_group` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `typeid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `groupid` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '用户组id',
  `subject` char(80) DEFAULT NULL,
  `content` text NOT NULL COMMENT '内容',
  `inputtime` int(10) unsigned DEFAULT '0',
  `status` tinyint(2) unsigned DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_model`;
CREATE TABLE `v9_model` (
  `modelid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` char(30) NOT NULL,
  `description` char(100) NOT NULL,
  `tablename` char(20) NOT NULL,
  `setting` text NOT NULL,
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `items` smallint(5) unsigned NOT NULL DEFAULT '0',
  `enablesearch` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `default_style` char(30) NOT NULL,
  `category_template` char(30) NOT NULL,
  `list_template` char(30) NOT NULL,
  `show_template` char(30) NOT NULL,
  `js_template` varchar(30) NOT NULL,
  `admin_list_template` char(30) NOT NULL,
  `member_add_template` varchar(30) NOT NULL,
  `member_list_template` varchar(30) NOT NULL,
  `sort` tinyint(3) NOT NULL,
  `type` tinyint(1) NOT NULL,
  PRIMARY KEY (`modelid`),
  KEY `type` (`type`,`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

INSERT INTO `v9_model` VALUES('1','1','文章模型','','news','','0','0','1','0','ambulance','category','list','show','','','','','0','0');
INSERT INTO `v9_model` VALUES('2','1','下载模型','','download','','0','0','1','0','default','category_download','list_download','show_download','','','','','0','0');
INSERT INTO `v9_model` VALUES('3','1','图片模型','','picture','','0','0','1','0','default','category_picture','list_picture','show_picture','','','','','0','0');
INSERT INTO `v9_model` VALUES('10','1','普通会员','普通会员','member_detail','','0','0','1','0','','','','','','','','','0','2');
INSERT INTO `v9_model` VALUES('11','1','视频模型','','video','','0','0','1','0','default','category_video','list_video','show_video','','','','','0','0');
INSERT INTO `v9_model` VALUES('12','1','直播模型','用于发布直播的模型','live','','0','0','1','0','dzwn_v1','category','list','show','','content_list','','','0','0');

DROP TABLE IF EXISTS `v9_model_field`;
CREATE TABLE `v9_model_field` (
  `fieldid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `field` varchar(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  `tips` text NOT NULL,
  `css` varchar(30) NOT NULL,
  `minlength` int(10) unsigned NOT NULL DEFAULT '0',
  `maxlength` int(10) unsigned NOT NULL DEFAULT '0',
  `pattern` varchar(255) NOT NULL,
  `errortips` varchar(255) NOT NULL,
  `formtype` varchar(20) NOT NULL,
  `setting` mediumtext NOT NULL,
  `formattribute` varchar(255) NOT NULL,
  `unsetgroupids` varchar(255) NOT NULL,
  `unsetroleids` varchar(255) NOT NULL,
  `iscore` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `issystem` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isunique` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isbase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `issearch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isfulltext` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isposition` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `listorder` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isomnipotent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fieldid`),
  KEY `modelid` (`modelid`,`disabled`),
  KEY `field` (`field`,`modelid`)
) ENGINE=MyISAM AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;

INSERT INTO `v9_model_field` VALUES('1','1','1','catid','栏目','','','1','6','/^[0-9]{1,6}$/','请选择栏目','catid','array (\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','1','0','1','1','1','0','0','1','0','0');
INSERT INTO `v9_model_field` VALUES('2','1','1','typeid','类别','','','0','0','','','typeid','array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','','','0','1','0','1','1','1','0','0','2','0','0');
INSERT INTO `v9_model_field` VALUES('3','1','1','title','标题','','inputtitle','1','80','','请输入标题','title','','','','','0','1','0','1','1','1','1','1','4','0','0');
INSERT INTO `v9_model_field` VALUES('4','1','1','thumb','缩略图','','','0','100','','','image','array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'\',\n  \'show_type\' => \'1\',\n  \'upload_maxsize\' => \'1024\',\n  \'upload_allowext\' => \'jpg|jpeg|gif|png|bmp\',\n  \'watermark\' => \'0\',\n  \'isselectimage\' => \'1\',\n  \'images_width\' => \'\',\n  \'images_height\' => \'\',\n)','','','','0','1','0','0','0','1','0','1','14','0','0');
INSERT INTO `v9_model_field` VALUES('5','1','1','keywords','关键词','多关键词之间用空格或者“,”隔开','','0','40','','','keyword','array (\r\n  \'size\' => \'100\',\r\n  \'defaultvalue\' => \'\',\r\n)','','-99','-99','0','1','0','1','1','1','1','0','7','0','0');
INSERT INTO `v9_model_field` VALUES('6','1','1','description','摘要','','','0','255','','','textarea','array (\r\n  \'width\' => \'98\',\r\n  \'height\' => \'46\',\r\n  \'defaultvalue\' => \'\',\r\n  \'enablehtml\' => \'0\',\r\n)','','','','0','1','0','1','0','1','1','1','10','0','0');
INSERT INTO `v9_model_field` VALUES('7','1','1','updatetime','更新时间','','','0','0','','','datetime','array (\r\n  \'dateformat\' => \'int\',\r\n  \'format\' => \'Y-m-d H:i:s\',\r\n  \'defaulttype\' => \'1\',\r\n  \'defaultvalue\' => \'\',\r\n)','','','','1','1','0','1','0','0','0','0','12','0','0');
INSERT INTO `v9_model_field` VALUES('8','1','1','content','内容','<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>','','1','999999','','内容不能为空','editor','array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n)','','','','0','0','0','1','0','1','1','0','13','0','0');
INSERT INTO `v9_model_field` VALUES('9','1','1','voteid','添加投票','','','0','0','','','omnipotent','array (\n  \'formtext\' => \'<input type=\\\'text\\\' name=\\\'info[voteid]\\\' id=\\\'voteid\\\' value=\\\'{FIELD_VALUE}\\\' size=\\\'3\\\'> \r\n<input type=\\\'button\\\' value=\"选择已有投票\" onclick=\"omnipotent(\\\'selectid\\\',\\\'?m=vote&c=vote&a=public_get_votelist&from_api=1\\\',\\\'选择已有投票\\\')\" class=\"button\">\r\n<input type=\\\'button\\\' value=\"新增投票\" onclick=\"omnipotent(\\\'addvote\\\',\\\'?m=vote&c=vote&a=add&from_api=1\\\',\\\'添加投票\\\',0)\" class=\"button\">\',\n  \'fieldtype\' => \'mediumint\',\n  \'minnumber\' => \'1\',\n)','','','','0','0','0','1','0','0','1','0','21','0','0');
INSERT INTO `v9_model_field` VALUES('10','1','1','pages','分页方式','','','0','0','','','pages','','','-99','-99','0','0','0','1','0','0','0','0','16','0','0');
INSERT INTO `v9_model_field` VALUES('11','1','1','inputtime','发布时间','','','0','0','','','datetime','array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)','','','','0','1','0','0','0','0','0','1','17','0','0');
INSERT INTO `v9_model_field` VALUES('12','1','1','posids','推荐位','','','0','0','','','posid','array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)','','','','0','1','0','1','0','0','0','0','18','0','0');
INSERT INTO `v9_model_field` VALUES('13','1','1','url','URL','','','0','100','','','text','','','','','1','1','0','1','0','0','0','0','50','0','0');
INSERT INTO `v9_model_field` VALUES('14','1','1','listorder','排序','','','0','6','','','number','','','','','1','1','0','1','0','0','0','0','51','0','0');
INSERT INTO `v9_model_field` VALUES('15','1','1','status','状态','','','0','2','','','box','','','','','1','1','0','1','0','0','0','0','55','0','0');
INSERT INTO `v9_model_field` VALUES('16','1','1','template','内容页模板','','','0','30','','','template','array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','0','0','0','0','0','0','0','53','0','0');
INSERT INTO `v9_model_field` VALUES('17','1','1','groupids_view','阅读权限','','','0','0','','','groupid','array (\n  \'groupids\' => \'\',\n)','','','','0','0','0','1','0','0','0','0','19','0','0');
INSERT INTO `v9_model_field` VALUES('18','1','1','readpoint','阅读收费','','','0','5','','','readpoint','array (\n  \'minnumber\' => \'1\',\n  \'maxnumber\' => \'99999\',\n  \'decimaldigits\' => \'0\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','0','0','0','0','0','0','0','55','0','0');
INSERT INTO `v9_model_field` VALUES('19','1','1','relation','相关文章','','','0','0','','','omnipotent','array (\n  \'formtext\' => \'<input type=\\\'hidden\\\' name=\\\'info[relation]\\\' id=\\\'relation\\\' value=\\\'{FIELD_VALUE}\\\' style=\\\'50\\\' >\r\n<ul class=\"list-dot\" id=\"relation_text\"></ul>\r\n<div>\r\n<input type=\\\'button\\\' value=\"添加相关\" onclick=\"omnipotent(\\\'selectid\\\',\\\'?m=content&c=content&a=public_relationlist&modelid={MODELID}\\\',\\\'添加相关文章\\\',1)\" class=\"button\" style=\"width:66px;\">\r\n<span class=\"edit_content\">\r\n<input type=\\\'button\\\' value=\"显示已有\" onclick=\"show_relation({MODELID},{ID})\" class=\"button\" style=\"width:66px;\">\r\n</span>\r\n</div>\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n)','','2,6,4,5,1,17,18,7','','0','0','0','0','0','0','1','0','15','0','0');
INSERT INTO `v9_model_field` VALUES('20','1','1','allow_comment','允许评论','','','0','0','','','box','array (\n  \'options\' => \'允许评论|1\r\n不允许评论|0\',\n  \'boxtype\' => \'radio\',\n  \'fieldtype\' => \'tinyint\',\n  \'minnumber\' => \'1\',\n  \'width\' => \'88\',\n  \'size\' => \'1\',\n  \'defaultvalue\' => \'1\',\n  \'outputtype\' => \'1\',\n  \'filtertype\' => \'0\',\n)','','','','0','0','0','0','0','0','0','0','54','0','0');
INSERT INTO `v9_model_field` VALUES('21','1','1','copyfrom','来源','','','0','100','','','copyfrom','array (\n  \'defaultvalue\' => \'\',\n)','','','','0','0','0','1','0','1','0','0','8','0','0');
INSERT INTO `v9_model_field` VALUES('80','1','1','username','用户名','','','0','20','','','text','','','','','1','1','0','1','0','0','0','0','98','0','0');
INSERT INTO `v9_model_field` VALUES('22','2','1','catid','栏目','','','1','6','/^[0-9]{1,6}$/','请选择栏目','catid','array (\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','1','0','1','1','1','0','0','1','0','0');
INSERT INTO `v9_model_field` VALUES('23','2','1','typeid','类别','','','0','0','','','typeid','array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','','','0','1','0','1','1','1','0','0','2','1','0');
INSERT INTO `v9_model_field` VALUES('24','2','1','title','标题','','inputtitle','1','80','','请输入标题','title','','','','','0','1','0','1','1','1','1','1','4','0','0');
INSERT INTO `v9_model_field` VALUES('25','2','1','keywords','关键词','多关键词之间用空格或者“,”隔开','','0','40','','','keyword','array (\r\n  \'size\' => \'100\',\r\n  \'defaultvalue\' => \'\',\r\n)','','-99','-99','0','1','0','1','1','1','1','0','7','0','0');
INSERT INTO `v9_model_field` VALUES('26','2','1','description','摘要','','','0','255','','','textarea','array (\r\n  \'width\' => \'98\',\r\n  \'height\' => \'46\',\r\n  \'defaultvalue\' => \'\',\r\n  \'enablehtml\' => \'0\',\r\n)','','','','0','1','0','1','0','1','1','1','10','0','0');
INSERT INTO `v9_model_field` VALUES('27','2','1','updatetime','更新时间','','','0','0','','','datetime','array (\r\n  \'dateformat\' => \'int\',\r\n  \'format\' => \'Y-m-d H:i:s\',\r\n  \'defaulttype\' => \'1\',\r\n  \'defaultvalue\' => \'\',\r\n)','','','','1','1','0','1','0','0','0','0','12','0','0');
INSERT INTO `v9_model_field` VALUES('28','2','1','content','内容','<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>','','1','999999','','内容不能为空','editor','array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n  \'height\' => \'\',\n  \'disabled_page\' => \'1\',\n)','','','','0','0','0','1','0','1','1','0','13','0','0');
INSERT INTO `v9_model_field` VALUES('29','2','1','thumb','缩略图','','','0','100','','','image','array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'\',\n  \'show_type\' => \'1\',\n  \'upload_maxsize\' => \'1024\',\n  \'upload_allowext\' => \'jpg|jpeg|gif|png|bmp\',\n  \'watermark\' => \'0\',\n  \'isselectimage\' => \'1\',\n  \'images_width\' => \'\',\n  \'images_height\' => \'\',\n)','','','','0','1','0','0','0','1','0','1','14','0','0');
INSERT INTO `v9_model_field` VALUES('30','2','1','relation','相关文章','','','0','0','','','omnipotent','array (\n  \'formtext\' => \'<input type=\\\'hidden\\\' name=\\\'info[relation]\\\' id=\\\'relation\\\' value=\\\'{FIELD_VALUE}\\\' style=\\\'50\\\' >\r\n<ul class=\"list-dot\" id=\"relation_text\"></ul>\r\n<div>\r\n<input type=\\\'button\\\' value=\"添加相关\" onclick=\"omnipotent(\\\'selectid\\\',\\\'?m=content&c=content&a=public_relationlist&modelid={MODELID}\\\',\\\'添加相关文章\\\',1)\" class=\"button\" style=\"width:66px;\">\r\n<span class=\"edit_content\">\r\n<input type=\\\'button\\\' value=\"显示已有\" onclick=\"show_relation({MODELID},{ID})\" class=\"button\" style=\"width:66px;\">\r\n</span>\r\n</div>\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n)','','2,6,4,5,1,17,18,7','','0','0','0','0','0','0','1','0','15','0','0');
INSERT INTO `v9_model_field` VALUES('31','2','1','pages','分页方式','','','0','0','','','pages','','','-99','-99','0','0','0','1','0','0','0','0','16','1','0');
INSERT INTO `v9_model_field` VALUES('32','2','1','inputtime','发布时间','','','0','0','','','datetime','array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)','','','','0','1','0','0','0','0','0','1','17','0','0');
INSERT INTO `v9_model_field` VALUES('33','2','1','posids','推荐位','','','0','0','','','posid','array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)','','','','0','1','0','1','0','0','0','0','18','0','0');
INSERT INTO `v9_model_field` VALUES('34','2','1','groupids_view','阅读权限','','','0','0','','','groupid','array (\n  \'groupids\' => \'\',\n)','','','','0','0','0','1','0','0','0','0','19','0','0');
INSERT INTO `v9_model_field` VALUES('35','2','1','url','URL','','','0','100','','','text','','','','','1','1','0','1','0','0','0','0','50','0','0');
INSERT INTO `v9_model_field` VALUES('36','2','1','listorder','排序','','','0','6','','','number','','','','','1','1','0','1','0','0','0','0','51','0','0');
INSERT INTO `v9_model_field` VALUES('37','2','1','template','内容页模板','','','0','30','','','template','array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','0','0','0','0','0','0','0','53','0','0');
INSERT INTO `v9_model_field` VALUES('38','2','1','allow_comment','允许评论','','','0','0','','','box','array (\n  \'options\' => \'允许评论|1\r\n不允许评论|0\',\n  \'boxtype\' => \'radio\',\n  \'fieldtype\' => \'tinyint\',\n  \'minnumber\' => \'1\',\n  \'width\' => \'88\',\n  \'size\' => \'1\',\n  \'defaultvalue\' => \'1\',\n  \'outputtype\' => \'1\',\n  \'filtertype\' => \'0\',\n)','','','','0','0','0','0','0','0','0','0','54','0','0');
INSERT INTO `v9_model_field` VALUES('39','2','1','status','状态','','','0','2','','','box','','','','','1','1','0','1','0','0','0','0','55','0','0');
INSERT INTO `v9_model_field` VALUES('40','2','1','readpoint','阅读收费','','','0','5','','','readpoint','array (\n  \'minnumber\' => \'1\',\n  \'maxnumber\' => \'99999\',\n  \'decimaldigits\' => \'0\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','0','0','0','0','0','0','0','55','0','0');
INSERT INTO `v9_model_field` VALUES('41','2','1','username','用户名','','','0','20','','','text','','','','','1','1','0','1','0','0','0','0','98','0','0');
INSERT INTO `v9_model_field` VALUES('42','2','1','downfiles','本地下载','','','0','0','','','downfiles','array (\n  \'upload_allowext\' => \'rar|zip\',\n  \'isselectimage\' => \'0\',\n  \'upload_number\' => \'10\',\n  \'downloadlink\' => \'1\',\n  \'downloadtype\' => \'1\',\n)','','','','0','0','0','1','0','1','0','0','8','0','0');
INSERT INTO `v9_model_field` VALUES('43','2','1','downfile','镜像下载','','','0','0','','','downfile','array (\n  \'downloadlink\' => \'1\',\n  \'downloadtype\' => \'1\',\n  \'upload_allowext\' => \'rar|zip\',\n  \'isselectimage\' => \'0\',\n  \'upload_number\' => \'1\',\n)','','','','0','0','0','1','0','1','0','0','9','0','0');
INSERT INTO `v9_model_field` VALUES('44','2','1','systems','软件平台','<select name=\'selectSystem\' onchange=\"ChangeInput(this,document.myform.systems,\'/\')\">\r\n	<option value=\'WinXP\'>WinXP</option>\r\n	<option value=\'Vista\'>Windows 7</option>\r\n	<option value=\'Win2000\'>Win2000</option>\r\n	<option value=\'Win2003\'>Win2003</option>\r\n	<option value=\'Unix\'>Unix</option>\r\n	<option value=\'Linux\'>Linux</option>\r\n	<option value=\'MacOS\'>MacOS</option>\r\n</select>','','0','100','','','text','array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'Win2000/WinXP/Win2003\',\n  \'ispassword\' => \'0\',\n)','','','','0','1','0','1','0','1','1','0','14','0','0');
INSERT INTO `v9_model_field` VALUES('45','2','1','copytype','软件授权形式','','','0','15','','','box','array (\n  \'options\' => \'免费版|免费版\r\n共享版|共享版\r\n试用版|试用版\r\n演示版|演示版\r\n注册版|注册版\r\n破解版|破解版\r\n零售版|零售版\r\nOEM版|OEM版\',\n  \'boxtype\' => \'select\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n  \'cols\' => \'5\',\n  \'width\' => \'80\',\n  \'size\' => \'1\',\n  \'default_select_value\' => \'免费版\',\n)','','','','0','1','0','1','0','1','0','0','12','0','0');
INSERT INTO `v9_model_field` VALUES('46','2','1','language','软件语言','','','0','16','','','box','array (\n  \'options\' => \'英文|英文\r\n简体中文|简体中文\r\n繁体中文|繁体中文\r\n简繁中文|简繁中文\r\n多国语言|多国语言\r\n其他语言|其他语言\',\n  \'boxtype\' => \'select\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n  \'cols\' => \'5\',\n  \'width\' => \'80\',\n  \'size\' => \'1\',\n  \'default_select_value\' => \'简体中文\',\n)','','','','0','1','0','1','0','1','0','0','13','0','0');
INSERT INTO `v9_model_field` VALUES('47','2','1','classtype','软件类型','','','0','20','','','box','array (\n  \'options\' => \'国产软件|国产软件\r\n国外软件|国外软件\r\n汉化补丁|汉化补丁\r\n程序源码|程序源码\r\n其他|其他\',\n  \'boxtype\' => \'radio\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n  \'cols\' => \'5\',\n  \'width\' => \'80\',\n  \'size\' => \'1\',\n  \'default_select_value\' => \'国产软件\',\n)','','','','0','1','0','1','0','1','0','0','17','0','0');
INSERT INTO `v9_model_field` VALUES('48','2','1','version','版本号','','','0','20','','','text','array (\n  \'size\' => \'10\',\n  \'defaultvalue\' => \'\',\n  \'ispassword\' => \'0\',\n)','','','','0','1','0','0','0','1','1','0','13','0','0');
INSERT INTO `v9_model_field` VALUES('49','2','1','filesize','文件大小','','','0','10','','','text','array (\n  \'size\' => \'10\',\n  \'defaultvalue\' => \'未知\',\n  \'ispassword\' => \'0\',\n)','','','','0','1','0','0','0','1','1','0','14','0','0');
INSERT INTO `v9_model_field` VALUES('50','2','1','stars','评分等级','','','0','20','','','box','array (\n  \'options\' => \'★☆☆☆☆|★☆☆☆☆\r\n★★☆☆☆|★★☆☆☆\r\n★★★☆☆|★★★☆☆\r\n★★★★☆|★★★★☆\r\n★★★★★|★★★★★\',\n  \'boxtype\' => \'radio\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n  \'cols\' => \'5\',\n  \'width\' => \'88\',\n  \'size\' => \'1\',\n  \'default_select_value\' => \'★★★☆☆\',\n)','','','','0','1','0','1','0','1','0','0','17','0','0');
INSERT INTO `v9_model_field` VALUES('51','3','1','allow_comment','允许评论','','','0','0','','','box','array (\n  \'options\' => \'允许评论|1\r\n不允许评论|0\',\n  \'boxtype\' => \'radio\',\n  \'fieldtype\' => \'tinyint\',\n  \'minnumber\' => \'1\',\n  \'width\' => \'88\',\n  \'size\' => \'1\',\n  \'defaultvalue\' => \'1\',\n  \'outputtype\' => \'1\',\n  \'filtertype\' => \'0\',\n)','','','','0','0','0','0','0','0','0','0','54','0','0');
INSERT INTO `v9_model_field` VALUES('52','3','1','template','内容页模板','','','0','30','','','template','array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','0','0','0','0','0','0','0','53','0','0');
INSERT INTO `v9_model_field` VALUES('53','3','1','url','URL','','','0','100','','','text','','','','','1','1','0','1','0','0','0','0','50','0','0');
INSERT INTO `v9_model_field` VALUES('54','3','1','listorder','排序','','','0','6','','','number','','','','','1','1','0','1','0','0','0','0','51','0','0');
INSERT INTO `v9_model_field` VALUES('55','3','1','posids','推荐位','','','0','0','','','posid','array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)','','','','0','1','0','1','0','0','0','0','18','0','0');
INSERT INTO `v9_model_field` VALUES('56','3','1','groupids_view','阅读权限','','','0','0','','','groupid','array (\n  \'groupids\' => \'\',\n)','','','','0','0','0','1','0','0','0','0','19','0','0');
INSERT INTO `v9_model_field` VALUES('57','3','1','inputtime','发布时间','','','0','0','','','datetime','array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)','','','','0','1','0','0','0','0','0','1','17','0','0');
INSERT INTO `v9_model_field` VALUES('58','3','1','pages','分页方式','','','0','0','','','pages','','','-99','-99','0','0','0','1','0','0','0','0','16','0','0');
INSERT INTO `v9_model_field` VALUES('59','3','1','relation','相关组图','','','0','0','','','omnipotent','array (\n  \'formtext\' => \'<input type=\\\'hidden\\\' name=\\\'info[relation]\\\' id=\\\'relation\\\' value=\\\'{FIELD_VALUE}\\\' style=\\\'50\\\' >\r\n<ul class=\"list-dot\" id=\"relation_text\"></ul>\r\n<div>\r\n<input type=\\\'button\\\' value=\"添加相关\" onclick=\"omnipotent(\\\'selectid\\\',\\\'?m=content&c=content&a=public_relationlist&modelid={MODELID}\\\',\\\'添加相关文章\\\',1)\" class=\"button\" style=\"width:66px;\">\r\n<span class=\"edit_content\">\r\n<input type=\\\'button\\\' value=\"显示已有\" onclick=\"show_relation({MODELID},{ID})\" class=\"button\" style=\"width:66px;\">\r\n</span>\r\n</div>\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n)','','2,6,4,5,1,17,18,7','','0','0','0','0','0','0','1','0','15','0','0');
INSERT INTO `v9_model_field` VALUES('60','3','1','thumb','缩略图','','','0','100','','','image','array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'\',\n  \'show_type\' => \'1\',\n  \'upload_maxsize\' => \'1024\',\n  \'upload_allowext\' => \'jpg|jpeg|gif|png|bmp\',\n  \'watermark\' => \'0\',\n  \'isselectimage\' => \'1\',\n  \'images_width\' => \'\',\n  \'images_height\' => \'\',\n)','','','','0','1','0','0','0','1','0','1','14','0','0');
INSERT INTO `v9_model_field` VALUES('61','3','1','content','内容','<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>','','0','999999','','','editor','array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n  \'height\' => \'\',\n  \'disabled_page\' => \'1\',\n)','','','','0','0','0','1','0','1','1','0','13','0','0');
INSERT INTO `v9_model_field` VALUES('62','3','1','updatetime','更新时间','','','0','0','','','datetime','array (\r\n  \'dateformat\' => \'int\',\r\n  \'format\' => \'Y-m-d H:i:s\',\r\n  \'defaulttype\' => \'1\',\r\n  \'defaultvalue\' => \'\',\r\n)','','','','1','1','0','1','0','0','0','0','12','0','0');
INSERT INTO `v9_model_field` VALUES('63','3','1','description','摘要','','','0','255','','','textarea','array (\r\n  \'width\' => \'98\',\r\n  \'height\' => \'46\',\r\n  \'defaultvalue\' => \'\',\r\n  \'enablehtml\' => \'0\',\r\n)','','','','0','1','0','1','0','1','1','1','10','0','0');
INSERT INTO `v9_model_field` VALUES('64','3','1','title','标题','','inputtitle','1','80','','请输入标题','title','','','','','0','1','0','1','1','1','1','1','4','0','0');
INSERT INTO `v9_model_field` VALUES('65','3','1','keywords','关键词','多关键词之间用空格或者“,”隔开','','0','40','','','keyword','array (\r\n  \'size\' => \'100\',\r\n  \'defaultvalue\' => \'\',\r\n)','','-99','-99','0','1','0','1','1','1','1','0','7','0','0');
INSERT INTO `v9_model_field` VALUES('66','3','1','typeid','类别','','','0','0','','','typeid','array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','','','0','1','0','1','1','1','0','0','2','0','0');
INSERT INTO `v9_model_field` VALUES('67','3','1','catid','栏目','','','1','6','/^[0-9]{1,6}$/','请选择栏目','catid','array (\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','1','0','1','1','1','0','0','1','0','0');
INSERT INTO `v9_model_field` VALUES('68','3','1','status','状态','','','0','2','','','box','','','','','1','1','0','1','0','0','0','0','55','0','0');
INSERT INTO `v9_model_field` VALUES('69','3','1','readpoint','阅读收费','','','0','5','','','readpoint','array (\n  \'minnumber\' => \'1\',\n  \'maxnumber\' => \'99999\',\n  \'decimaldigits\' => \'0\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','0','0','0','0','0','0','0','55','0','0');
INSERT INTO `v9_model_field` VALUES('70','3','1','username','用户名','','','0','20','','','text','','','','','1','1','0','1','0','0','0','0','98','0','0');
INSERT INTO `v9_model_field` VALUES('71','3','1','pictureurls','组图','','','0','0','','','images','array (\n  \'upload_allowext\' => \'gif|jpg|jpeg|png|bmp\',\n  \'isselectimage\' => \'1\',\n  \'upload_number\' => \'50\',\n)','','','','0','0','0','1','0','1','0','0','15','0','0');
INSERT INTO `v9_model_field` VALUES('72','3','1','copyfrom','来源','','','0','0','','','copyfrom','array (\n  \'defaultvalue\' => \'\',\n)','','','','0','0','0','1','0','1','0','0','8','0','0');
INSERT INTO `v9_model_field` VALUES('73','1','1','islink','转向链接','','','0','0','','','islink','','','','','0','1','0','0','0','1','0','0','30','0','0');
INSERT INTO `v9_model_field` VALUES('74','2','1','islink','转向链接','','','0','0','','','islink','','','','','0','1','0','0','0','1','0','0','30','0','0');
INSERT INTO `v9_model_field` VALUES('75','3','1','islink','转向链接','','','0','0','','','islink','','','','','0','1','0','0','0','1','0','0','30','0','0');
INSERT INTO `v9_model_field` VALUES('83','10','1','birthday','生日','','','0','0','','生日格式错误','datetime','array (\n  \'fieldtype\' => \'date\',\n  \'format\' => \'Y-m-d\',\n  \'defaulttype\' => \'0\',\n)','','','','0','0','0','0','0','1','1','0','0','0','0');
INSERT INTO `v9_model_field` VALUES('84','11','1','catid','栏目','','','1','6','/^[0-9]{1,6}$/','请选择栏目','catid','array (\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','1','0','1','1','1','0','0','1','0','0');
INSERT INTO `v9_model_field` VALUES('85','11','1','typeid','类别','','','0','0','','','typeid','array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','','','0','1','0','1','1','1','0','0','2','0','0');
INSERT INTO `v9_model_field` VALUES('86','11','1','title','标题','','inputtitle','1','80','','请输入标题','title','array (\n)','','','','0','1','0','1','1','1','1','1','4','0','0');
INSERT INTO `v9_model_field` VALUES('87','11','1','keywords','关键词','多关键词之间用空格或者“,”隔开','','0','40','','','keyword','array (\n  \'size\' => \'100\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','1','0','1','1','1','1','0','7','0','0');
INSERT INTO `v9_model_field` VALUES('88','11','1','description','摘要','','','0','255','','','textarea','array (\n  \'width\' => \'98\',\n  \'height\' => \'46\',\n  \'defaultvalue\' => \'\',\n  \'enablehtml\' => \'0\',\n)','','','','0','1','0','1','0','1','1','1','10','0','0');
INSERT INTO `v9_model_field` VALUES('89','11','1','updatetime','更新时间','','','0','0','','','datetime','array (\n  \'dateformat\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'1\',\n  \'defaultvalue\' => \'\',\n)','','','','1','1','0','1','0','0','0','0','12','0','0');
INSERT INTO `v9_model_field` VALUES('90','11','1','content','内容','<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>','','0','999999','','内容不能为空','editor','array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n  \'height\' => \'\',\n  \'disabled_page\' => \'0\',\n)','','','','0','0','0','1','0','1','1','0','13','0','0');
INSERT INTO `v9_model_field` VALUES('91','11','1','thumb','缩略图','','','0','100','','','image','array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'\',\n  \'show_type\' => \'1\',\n  \'upload_maxsize\' => \'1024\',\n  \'upload_allowext\' => \'jpg|jpeg|gif|png|bmp\',\n  \'watermark\' => \'0\',\n  \'isselectimage\' => \'1\',\n  \'images_width\' => \'\',\n  \'images_height\' => \'\',\n)','','','','0','1','0','0','0','1','0','1','14','0','0');
INSERT INTO `v9_model_field` VALUES('92','11','1','relation','相关文章','','','0','0','','','omnipotent','array (\n  \'formtext\' => \'<input type=\\\'hidden\\\' name=\\\'info[relation]\\\' id=\\\'relation\\\' value=\\\'{FIELD_VALUE}\\\' style=\\\'50\\\' >\r\n<ul class=\"list-dot\" id=\"relation_text\"></ul>\r\n<div>\r\n<input type=\\\'button\\\' value=\"添加相关\" onclick=\"omnipotent(\\\'selectid\\\',\\\'?m=content&c=content&a=public_relationlist&modelid={MODELID}\\\',\\\'添加相关文章\\\',1)\" class=\"button\" style=\"width:66px;\">\r\n<span class=\"edit_content\">\r\n<input type=\\\'button\\\' value=\"显示已有\" onclick=\"show_relation({MODELID},{ID})\" class=\"button\" style=\"width:66px;\">\r\n</span>\r\n</div>\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n)','','2,6,4,5,1,17,18,7','','0','0','0','0','0','0','1','0','15','0','0');
INSERT INTO `v9_model_field` VALUES('93','11','1','pages','分页方式','','','0','0','','','pages','array (\n)','','-99','-99','0','0','0','1','0','0','0','0','16','0','0');
INSERT INTO `v9_model_field` VALUES('94','11','1','inputtime','发布时间','','','0','0','','','datetime','array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)','','','','0','1','0','0','0','0','0','1','17','0','0');
INSERT INTO `v9_model_field` VALUES('95','11','1','posids','推荐位','','','0','0','','','posid','array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)','','','','0','1','0','1','0','0','0','0','18','0','0');
INSERT INTO `v9_model_field` VALUES('96','11','1','groupids_view','阅读权限','','','0','100','','','groupid','array (\n  \'groupids\' => \'\',\n)','','','','0','0','0','1','0','0','0','0','19','0','0');
INSERT INTO `v9_model_field` VALUES('97','11','1','url','URL','','','0','100','','','text','array (\n)','','','','1','1','0','1','0','0','0','0','50','0','0');
INSERT INTO `v9_model_field` VALUES('98','11','1','listorder','排序','','','0','6','','','number','array (\n)','','','','1','1','0','1','0','0','0','0','51','0','0');
INSERT INTO `v9_model_field` VALUES('99','11','1','template','内容页模板','','','0','30','','','template','array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','0','0','0','0','0','0','0','53','0','0');
INSERT INTO `v9_model_field` VALUES('100','11','1','allow_comment','允许评论','','','0','0','','','box','array (\n  \'options\' => \'允许评论|1\r\n不允许评论|0\',\n  \'boxtype\' => \'radio\',\n  \'fieldtype\' => \'tinyint\',\n  \'minnumber\' => \'1\',\n  \'width\' => \'88\',\n  \'size\' => \'1\',\n  \'defaultvalue\' => \'1\',\n  \'outputtype\' => \'0\',\n)','','','','0','0','0','0','0','0','0','0','54','0','0');
INSERT INTO `v9_model_field` VALUES('101','11','1','status','状态','','','0','2','','','box','array (\n)','','','','1','1','0','1','0','0','0','0','55','0','0');
INSERT INTO `v9_model_field` VALUES('102','11','1','readpoint','阅读收费','','','0','5','','','readpoint','array (\n  \'minnumber\' => \'1\',\n  \'maxnumber\' => \'99999\',\n  \'decimaldigits\' => \'0\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','0','0','0','0','0','0','0','55','0','0');
INSERT INTO `v9_model_field` VALUES('103','11','1','username','用户名','','','0','20','','','text','array (\n)','','','','1','1','0','1','0','0','0','0','98','0','0');
INSERT INTO `v9_model_field` VALUES('104','11','1','islink','转向链接','','','0','0','','','islink','array (\n)','','','','0','1','0','1','0','1','0','0','20','0','0');
INSERT INTO `v9_model_field` VALUES('105','11','1','video','视频上传','','','0','0','','','video','array (\n  \'upload_allowext\' => \'flv|rm|mp4|rmv\',\n)','','','','0','0','0','1','0','1','0','0','8','0','0');
INSERT INTO `v9_model_field` VALUES('106','11','1','vision','画质','','','0','0','','','box','array (\n  \'options\' => \'高清|1\r\n普通|2\',\n  \'boxtype\' => \'select\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n  \'width\' => \'80\',\n  \'size\' => \'1\',\n  \'defaultvalue\' => \'0\',\n  \'outputtype\' => \'1\',\n  \'filtertype\' => \'1\',\n)','','','','0','1','0','1','0','1','0','0','9','0','0');
INSERT INTO `v9_model_field` VALUES('107','11','1','video_category','视频分类','','','0','0','','','box','array (\n  \'options\' => \'喜剧|1\r\n爱情|2\r\n科幻|3\r\n剧情|4\r\n动作|5\r\n伦理|6\',\n  \'boxtype\' => \'select\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n  \'width\' => \'80\',\n  \'size\' => \'1\',\n  \'defaultvalue\' => \'1\',\n  \'outputtype\' => \'1\',\n  \'filtertype\' => \'1\',\n)','','','','0','1','0','1','0','1','0','0','9','0','0');
INSERT INTO `v9_model_field` VALUES('108','12','1','catid','栏目','','','1','6','/^[0-9]{1,6}$/','请选择栏目','catid','array (\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','1','0','1','1','1','0','0','1','0','0');
INSERT INTO `v9_model_field` VALUES('109','12','1','typeid','类别','','','0','0','','','typeid','array (\n  \'minnumber\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','','','0','1','0','1','1','1','0','0','2','0','0');
INSERT INTO `v9_model_field` VALUES('110','12','1','title','标题','','inputtitle','1','80','','请输入标题','title','','','','','0','1','0','1','1','1','1','1','3','0','0');
INSERT INTO `v9_model_field` VALUES('111','12','1','keywords','关键词','多关键词之间用空格或者“,”隔开','','0','40','','','keyword','array (\r\n  \'size\' => \'100\',\r\n  \'defaultvalue\' => \'\',\r\n)','','-99','-99','0','1','0','1','1','1','1','0','7','0','0');
INSERT INTO `v9_model_field` VALUES('112','12','1','description','摘要','','','0','255','','','textarea','array (\r\n  \'width\' => \'98\',\r\n  \'height\' => \'46\',\r\n  \'defaultvalue\' => \'\',\r\n  \'enablehtml\' => \'0\',\r\n)','','','','0','1','0','1','0','1','1','1','10','1','0');
INSERT INTO `v9_model_field` VALUES('113','12','1','updatetime','更新时间','','','0','0','','','datetime','array (\r\n  \'dateformat\' => \'int\',\r\n  \'format\' => \'Y-m-d H:i:s\',\r\n  \'defaulttype\' => \'1\',\r\n  \'defaultvalue\' => \'\',\r\n)','','','','1','1','0','1','0','0','0','0','12','0','0');
INSERT INTO `v9_model_field` VALUES('114','12','1','content','内容','<div class=\"content_attr\"><label><input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked>是否截取内容</label><input type=\"text\" name=\"introcude_length\" value=\"200\" size=\"3\">字符至内容摘要\r\n<label><input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked>是否获取内容第</label><input type=\"text\" name=\"auto_thumb_no\" value=\"1\" size=\"2\" class=\"\">张图片作为标题图片\r\n</div>','','1','999999','','内容不能为空','editor','array (\n  \'toolbar\' => \'full\',\n  \'defaultvalue\' => \'\',\n  \'enablekeylink\' => \'1\',\n  \'replacenum\' => \'2\',\n  \'link_mode\' => \'0\',\n  \'enablesaveimage\' => \'1\',\n)','','','','0','0','0','1','0','1','1','0','13','1','0');
INSERT INTO `v9_model_field` VALUES('115','12','1','thumb','缩略图','','','0','100','','','image','array (\n  \'size\' => \'50\',\n  \'defaultvalue\' => \'\',\n  \'show_type\' => \'1\',\n  \'upload_maxsize\' => \'1024\',\n  \'upload_allowext\' => \'jpg|jpeg|gif|png|bmp\',\n  \'watermark\' => \'0\',\n  \'isselectimage\' => \'1\',\n  \'images_width\' => \'\',\n  \'images_height\' => \'\',\n)','','','','0','1','0','0','0','1','0','1','9','0','0');
INSERT INTO `v9_model_field` VALUES('116','12','1','relation','相关文章','','','0','0','','','omnipotent','array (\n  \'formtext\' => \'<input type=\\\'hidden\\\' name=\\\'info[relation]\\\' id=\\\'relation\\\' value=\\\'{FIELD_VALUE}\\\' style=\\\'50\\\' >\r\n<ul class=\"list-dot\" id=\"relation_text\"></ul>\r\n<div>\r\n<input type=\\\'button\\\' value=\"添加相关\" onclick=\"omnipotent(\\\'selectid\\\',\\\'?m=content&c=content&a=public_relationlist&modelid={MODELID}\\\',\\\'添加相关文章\\\',1)\" class=\"button\" style=\"width:66px;\">\r\n<span class=\"edit_content\">\r\n<input type=\\\'button\\\' value=\"显示已有\" onclick=\"show_relation({MODELID},{ID})\" class=\"button\" style=\"width:66px;\">\r\n</span>\r\n</div>\',\n  \'fieldtype\' => \'varchar\',\n  \'minnumber\' => \'1\',\n)','','2,6,4,5,1,17,18,7','','0','0','0','0','0','0','1','0','15','0','0');
INSERT INTO `v9_model_field` VALUES('117','12','1','pages','分页方式','','','0','0','','','pages','','','-99','-99','0','0','0','1','0','0','0','0','16','0','0');
INSERT INTO `v9_model_field` VALUES('118','12','1','inputtime','发布时间','','','0','0','','','datetime','array (\n  \'fieldtype\' => \'int\',\n  \'format\' => \'Y-m-d H:i:s\',\n  \'defaulttype\' => \'0\',\n)','','','','0','1','0','0','0','0','0','1','17','0','0');
INSERT INTO `v9_model_field` VALUES('119','12','1','posids','推荐位','','','0','0','','','posid','array (\n  \'cols\' => \'4\',\n  \'width\' => \'125\',\n)','','','','0','1','0','1','0','0','0','0','18','0','0');
INSERT INTO `v9_model_field` VALUES('120','12','1','groupids_view','阅读权限','','','0','100','','','groupid','array (\n  \'groupids\' => \'\',\n)','','','','0','0','0','1','0','0','0','0','19','0','0');
INSERT INTO `v9_model_field` VALUES('121','12','1','url','URL','','','0','100','','','text','','','','','1','1','0','1','0','0','0','0','50','0','0');
INSERT INTO `v9_model_field` VALUES('122','12','1','listorder','排序','','','0','6','','','number','','','','','1','1','0','1','0','0','0','0','51','0','0');
INSERT INTO `v9_model_field` VALUES('123','12','1','template','内容页模板','','','0','30','','','template','array (\n  \'size\' => \'\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','0','0','0','0','0','0','0','53','0','0');
INSERT INTO `v9_model_field` VALUES('124','12','1','allow_comment','允许评论','','','0','0','','','box','array (\n  \'options\' => \'允许评论|1\r\n不允许评论|0\',\n  \'boxtype\' => \'radio\',\n  \'fieldtype\' => \'tinyint\',\n  \'minnumber\' => \'1\',\n  \'width\' => \'88\',\n  \'size\' => \'1\',\n  \'defaultvalue\' => \'1\',\n  \'outputtype\' => \'0\',\n)','','','','0','0','0','0','0','0','0','0','54','0','0');
INSERT INTO `v9_model_field` VALUES('125','12','1','status','状态','','','0','2','','','box','','','','','1','1','0','1','0','0','0','0','55','0','0');
INSERT INTO `v9_model_field` VALUES('126','12','1','readpoint','阅读收费','','','0','5','','','readpoint','array (\n  \'minnumber\' => \'1\',\n  \'maxnumber\' => \'99999\',\n  \'decimaldigits\' => \'0\',\n  \'defaultvalue\' => \'\',\n)','','-99','-99','0','0','0','0','0','0','0','0','55','0','0');
INSERT INTO `v9_model_field` VALUES('127','12','1','username','用户名','','','0','20','','','text','','','','','1','1','0','1','0','0','0','0','98','0','0');
INSERT INTO `v9_model_field` VALUES('128','12','1','islink','转向链接','','','0','0','','','islink','','','','','0','1','0','1','0','1','0','0','20','0','0');
INSERT INTO `v9_model_field` VALUES('129','12','1','APPID','应用ID','','','1','0','','','text','{\"size\":\"100\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}','','','','0','1','0','1','0','1','1','0','4','0','0');
INSERT INTO `v9_model_field` VALUES('130','12','1','channel','频道','','','1','0','','','text','{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}','','','','0','1','0','1','0','1','1','0','6','0','0');
INSERT INTO `v9_model_field` VALUES('131','12','1','mainPicture','主图','','','1','0','','','image','{\"size\":\"\",\"defaultvalue\":\"\",\"show_type\":\"1\",\"upload_maxsize\":\"\",\"upload_allowext\":\"gif|jpg|jpeg|png|bmp\",\"watermark\":\"0\",\"isselectimage\":\"1\",\"images_width\":\"\",\"images_height\":\"\"}','','','','0','1','0','1','0','1','0','0','14','1','0');
INSERT INTO `v9_model_field` VALUES('132','12','1','infomation','资讯','','','1','0','','','textarea','{\"width\":\"100\",\"height\":\"46\",\"defaultvalue\":\"\",\"enablehtml\":\"0\"}','','','','0','0','0','1','0','1','1','0','8','0','0');
INSERT INTO `v9_model_field` VALUES('133','12','1','substance','详细内容','','','0','0','','','editor','{\"toolbar\":\"basic\",\"defaultvalue\":\"\",\"enablekeylink\":\"0\",\"replacenum\":\"1\",\"link_mode\":\"0\",\"enablesaveimage\":\"1\",\"height\":\"200\"}','','','','0','0','0','1','0','1','1','0','11','0','0');
INSERT INTO `v9_model_field` VALUES('134','12','1','certificate','证书','','','0','0','','','text','{\"size\":\"50\",\"defaultvalue\":\"\",\"ispassword\":\"0\"}','','','','0','1','0','1','0','1','1','0','5','0','0');

DROP TABLE IF EXISTS `v9_module`;
CREATE TABLE `v9_module` (
  `module` varchar(15) NOT NULL,
  `name` varchar(20) NOT NULL,
  `url` varchar(50) NOT NULL,
  `iscore` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `version` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL,
  `setting` mediumtext NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `installdate` date NOT NULL DEFAULT '0000-00-00',
  `updatedate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_module` VALUES('admin','admin','','1','1.0','','{\"admin_email\":\"phpcms@phpcms.cn\",\"maxloginfailedtimes\":\"8\",\"minrefreshtime\":\"2\",\"mail_type\":\"1\",\"mail_server\":\"smtp.qq.com\",\"mail_port\":\"25\",\"category_ajax\":\"0\",\"mail_user\":\"phpcms.cn@foxmail.com\",\"mail_auth\":\"1\",\"mail_from\":\"phpcms.cn@foxmail.com\",\"mail_password\":\"\",\"errorlog_size\":\"20\"}','0','0','2010-10-18','2010-10-18');
INSERT INTO `v9_module` VALUES('member','会员','','1','1.0','','{\"allowregister\":\"1\",\"choosemodel\":\"1\",\"enablemailcheck\":\"0\",\"enablcodecheck\":\"0\",\"mobile_checktype\":\"2\",\"user_sendsms_title\":\"\",\"registerverify\":\"0\",\"showapppoint\":\"0\",\"rmb_point_rate\":\"10\",\"defualtpoint\":\"0\",\"defualtamount\":\"0\",\"showregprotocol\":\"0\",\"regprotocol\":\"\\t\\t \\u6b22\\u8fce\\u60a8\\u6ce8\\u518c\\u6210\\u4e3aphpcms\\u7528\\u6237\\r\\n\\u8bf7\\u4ed4\\u7ec6\\u9605\\u8bfb\\u4e0b\\u9762\\u7684\\u534f\\u8bae\\uff0c\\u53ea\\u6709\\u63a5\\u53d7\\u534f\\u8bae\\u624d\\u80fd\\u7ee7\\u7eed\\u8fdb\\u884c\\u6ce8\\u518c\\u3002 \\r\\n1\\uff0e\\u670d\\u52a1\\u6761\\u6b3e\\u7684\\u786e\\u8ba4\\u548c\\u63a5\\u7eb3\\r\\n\\u3000\\u3000phpcms\\u7528\\u6237\\u670d\\u52a1\\u7684\\u6240\\u6709\\u6743\\u548c\\u8fd0\\u4f5c\\u6743\\u5f52phpcms\\u62e5\\u6709\\u3002phpcms\\u6240\\u63d0\\u4f9b\\u7684\\u670d\\u52a1\\u5c06\\u6309\\u7167\\u6709\\u5173\\u7ae0\\u7a0b\\u3001\\u670d\\u52a1\\u6761\\u6b3e\\u548c\\u64cd\\u4f5c\\u89c4\\u5219\\u4e25\\u683c\\u6267\\u884c\\u3002\\u7528\\u6237\\u901a\\u8fc7\\u6ce8\\u518c\\u7a0b\\u5e8f\\u70b9\\u51fb\\u201c\\u6211\\u540c\\u610f\\u201d \\u6309\\u94ae\\uff0c\\u5373\\u8868\\u793a\\u7528\\u6237\\u4e0ephpcms\\u8fbe\\u6210\\u534f\\u8bae\\u5e76\\u63a5\\u53d7\\u6240\\u6709\\u7684\\u670d\\u52a1\\u6761\\u6b3e\\u3002\\r\\n2\\uff0e phpcms\\u670d\\u52a1\\u7b80\\u4ecb\\r\\n\\u3000\\u3000phpcms\\u901a\\u8fc7\\u56fd\\u9645\\u4e92\\u8054\\u7f51\\u4e3a\\u7528\\u6237\\u63d0\\u4f9b\\u65b0\\u95fb\\u53ca\\u6587\\u7ae0\\u6d4f\\u89c8\\u3001\\u56fe\\u7247\\u6d4f\\u89c8\\u3001\\u8f6f\\u4ef6\\u4e0b\\u8f7d\\u3001\\u7f51\\u4e0a\\u7559\\u8a00\\u548cBBS\\u8bba\\u575b\\u7b49\\u670d\\u52a1\\u3002\\r\\n\\u3000\\u3000\\u7528\\u6237\\u5fc5\\u987b\\uff1a \\r\\n\\u3000\\u30001)\\u8d2d\\u7f6e\\u8bbe\\u5907\\uff0c\\u5305\\u62ec\\u4e2a\\u4eba\\u7535\\u8111\\u4e00\\u53f0\\u3001\\u8c03\\u5236\\u89e3\\u8c03\\u5668\\u4e00\\u4e2a\\u53ca\\u914d\\u5907\\u4e0a\\u7f51\\u88c5\\u7f6e\\u3002 \\r\\n\\u3000\\u30002)\\u4e2a\\u4eba\\u4e0a\\u7f51\\u548c\\u652f\\u4ed8\\u4e0e\\u6b64\\u670d\\u52a1\\u6709\\u5173\\u7684\\u7535\\u8bdd\\u8d39\\u7528\\u3001\\u7f51\\u7edc\\u8d39\\u7528\\u3002\\r\\n\\u3000\\u3000\\u7528\\u6237\\u540c\\u610f\\uff1a \\r\\n\\u3000\\u30001)\\u63d0\\u4f9b\\u53ca\\u65f6\\u3001\\u8be6\\u5c3d\\u53ca\\u51c6\\u786e\\u7684\\u4e2a\\u4eba\\u8d44\\u6599\\u3002 \\r\\n\\u3000\\u30002)\\u4e0d\\u65ad\\u66f4\\u65b0\\u6ce8\\u518c\\u8d44\\u6599\\uff0c\\u7b26\\u5408\\u53ca\\u65f6\\u3001\\u8be6\\u5c3d\\u3001\\u51c6\\u786e\\u7684\\u8981\\u6c42\\u3002\\u6240\\u6709\\u539f\\u59cb\\u952e\\u5165\\u7684\\u8d44\\u6599\\u5c06\\u5f15\\u7528\\u4e3a\\u6ce8\\u518c\\u8d44\\u6599\\u3002 \\r\\n\\u3000\\u30003)\\u7528\\u6237\\u540c\\u610f\\u9075\\u5b88\\u300a\\u4e2d\\u534e\\u4eba\\u6c11\\u5171\\u548c\\u56fd\\u4fdd\\u5b88\\u56fd\\u5bb6\\u79d8\\u5bc6\\u6cd5\\u300b\\u3001\\u300a\\u4e2d\\u534e\\u4eba\\u6c11\\u5171\\u548c\\u56fd\\u8ba1\\u7b97\\u673a\\u4fe1\\u606f\\u7cfb\\u7edf\\u5b89\\u5168\\u4fdd\\u62a4\\u6761\\u4f8b\\u300b\\u3001\\u300a\\u8ba1\\u7b97\\u673a\\u8f6f\\u4ef6\\u4fdd\\u62a4\\u6761\\u4f8b\\u300b\\u7b49\\u6709\\u5173\\u8ba1\\u7b97\\u673a\\u53ca\\u4e92\\u8054\\u7f51\\u89c4\\u5b9a\\u7684\\u6cd5\\u5f8b\\u548c\\u6cd5\\u89c4\\u3001\\u5b9e\\u65bd\\u529e\\u6cd5\\u3002\\u5728\\u4efb\\u4f55\\u60c5\\u51b5\\u4e0b\\uff0cphpcms\\u5408\\u7406\\u5730\\u8ba4\\u4e3a\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u53ef\\u80fd\\u8fdd\\u53cd\\u4e0a\\u8ff0\\u6cd5\\u5f8b\\u3001\\u6cd5\\u89c4\\uff0cphpcms\\u53ef\\u4ee5\\u5728\\u4efb\\u4f55\\u65f6\\u5019\\uff0c\\u4e0d\\u7ecf\\u4e8b\\u5148\\u901a\\u77e5\\u7ec8\\u6b62\\u5411\\u8be5\\u7528\\u6237\\u63d0\\u4f9b\\u670d\\u52a1\\u3002\\u7528\\u6237\\u5e94\\u4e86\\u89e3\\u56fd\\u9645\\u4e92\\u8054\\u7f51\\u7684\\u65e0\\u56fd\\u754c\\u6027\\uff0c\\u5e94\\u7279\\u522b\\u6ce8\\u610f\\u9075\\u5b88\\u5f53\\u5730\\u6240\\u6709\\u6709\\u5173\\u7684\\u6cd5\\u5f8b\\u548c\\u6cd5\\u89c4\\u3002\\r\\n3\\uff0e \\u670d\\u52a1\\u6761\\u6b3e\\u7684\\u4fee\\u6539\\r\\n\\u3000\\u3000phpcms\\u4f1a\\u4e0d\\u5b9a\\u65f6\\u5730\\u4fee\\u6539\\u670d\\u52a1\\u6761\\u6b3e\\uff0c\\u670d\\u52a1\\u6761\\u6b3e\\u4e00\\u65e6\\u53d1\\u751f\\u53d8\\u52a8\\uff0c\\u5c06\\u4f1a\\u5728\\u76f8\\u5173\\u9875\\u9762\\u4e0a\\u63d0\\u793a\\u4fee\\u6539\\u5185\\u5bb9\\u3002\\u5982\\u679c\\u60a8\\u540c\\u610f\\u6539\\u52a8\\uff0c\\u5219\\u518d\\u4e00\\u6b21\\u70b9\\u51fb\\u201c\\u6211\\u540c\\u610f\\u201d\\u6309\\u94ae\\u3002 \\u5982\\u679c\\u60a8\\u4e0d\\u63a5\\u53d7\\uff0c\\u5219\\u53ca\\u65f6\\u53d6\\u6d88\\u60a8\\u7684\\u7528\\u6237\\u4f7f\\u7528\\u670d\\u52a1\\u8d44\\u683c\\u3002\\r\\n4\\uff0e \\u670d\\u52a1\\u4fee\\u8ba2\\r\\n\\u3000\\u3000phpcms\\u4fdd\\u7559\\u968f\\u65f6\\u4fee\\u6539\\u6216\\u4e2d\\u65ad\\u670d\\u52a1\\u800c\\u4e0d\\u9700\\u77e5\\u7167\\u7528\\u6237\\u7684\\u6743\\u5229\\u3002phpcms\\u884c\\u4f7f\\u4fee\\u6539\\u6216\\u4e2d\\u65ad\\u670d\\u52a1\\u7684\\u6743\\u5229\\uff0c\\u4e0d\\u9700\\u5bf9\\u7528\\u6237\\u6216\\u7b2c\\u4e09\\u65b9\\u8d1f\\u8d23\\u3002\\r\\n5\\uff0e \\u7528\\u6237\\u9690\\u79c1\\u5236\\u5ea6\\r\\n\\u3000\\u3000\\u5c0a\\u91cd\\u7528\\u6237\\u4e2a\\u4eba\\u9690\\u79c1\\u662fphpcms\\u7684 \\u57fa\\u672c\\u653f\\u7b56\\u3002phpcms\\u4e0d\\u4f1a\\u516c\\u5f00\\u3001\\u7f16\\u8f91\\u6216\\u900f\\u9732\\u7528\\u6237\\u7684\\u6ce8\\u518c\\u4fe1\\u606f\\uff0c\\u9664\\u975e\\u6709\\u6cd5\\u5f8b\\u8bb8\\u53ef\\u8981\\u6c42\\uff0c\\u6216phpcms\\u5728\\u8bda\\u4fe1\\u7684\\u57fa\\u7840\\u4e0a\\u8ba4\\u4e3a\\u900f\\u9732\\u8fd9\\u4e9b\\u4fe1\\u606f\\u5728\\u4ee5\\u4e0b\\u4e09\\u79cd\\u60c5\\u51b5\\u662f\\u5fc5\\u8981\\u7684\\uff1a \\r\\n\\u3000\\u30001)\\u9075\\u5b88\\u6709\\u5173\\u6cd5\\u5f8b\\u89c4\\u5b9a\\uff0c\\u9075\\u4ece\\u5408\\u6cd5\\u670d\\u52a1\\u7a0b\\u5e8f\\u3002 \\r\\n\\u3000\\u30002)\\u4fdd\\u6301\\u7ef4\\u62a4phpcms\\u7684\\u5546\\u6807\\u6240\\u6709\\u6743\\u3002 \\r\\n\\u3000\\u30003)\\u5728\\u7d27\\u6025\\u60c5\\u51b5\\u4e0b\\u7aed\\u529b\\u7ef4\\u62a4\\u7528\\u6237\\u4e2a\\u4eba\\u548c\\u793e\\u4f1a\\u5927\\u4f17\\u7684\\u9690\\u79c1\\u5b89\\u5168\\u3002 \\r\\n\\u3000\\u30004)\\u7b26\\u5408\\u5176\\u4ed6\\u76f8\\u5173\\u7684\\u8981\\u6c42\\u3002 \\r\\n6\\uff0e\\u7528\\u6237\\u7684\\u5e10\\u53f7\\uff0c\\u5bc6\\u7801\\u548c\\u5b89\\u5168\\u6027\\r\\n\\u3000\\u3000\\u4e00\\u65e6\\u6ce8\\u518c\\u6210\\u529f\\u6210\\u4e3aphpcms\\u7528\\u6237\\uff0c\\u60a8\\u5c06\\u5f97\\u5230\\u4e00\\u4e2a\\u5bc6\\u7801\\u548c\\u5e10\\u53f7\\u3002\\u5982\\u679c\\u60a8\\u4e0d\\u4fdd\\u7ba1\\u597d\\u81ea\\u5df1\\u7684\\u5e10\\u53f7\\u548c\\u5bc6\\u7801\\u5b89\\u5168\\uff0c\\u5c06\\u5bf9\\u56e0\\u6b64\\u4ea7\\u751f\\u7684\\u540e\\u679c\\u8d1f\\u5168\\u90e8\\u8d23\\u4efb\\u3002\\u53e6\\u5916\\uff0c\\u6bcf\\u4e2a\\u7528\\u6237\\u90fd\\u8981\\u5bf9\\u5176\\u5e10\\u6237\\u4e2d\\u7684\\u6240\\u6709\\u6d3b\\u52a8\\u548c\\u4e8b\\u4ef6\\u8d1f\\u5168\\u8d23\\u3002\\u60a8\\u53ef\\u968f\\u65f6\\u6839\\u636e\\u6307\\u793a\\u6539\\u53d8\\u60a8\\u7684\\u5bc6\\u7801\\uff0c\\u4e5f\\u53ef\\u4ee5\\u7ed3\\u675f\\u65e7\\u7684\\u5e10\\u6237\\u91cd\\u5f00\\u4e00\\u4e2a\\u65b0\\u5e10\\u6237\\u3002\\u7528\\u6237\\u540c\\u610f\\u82e5\\u53d1\\u73b0\\u4efb\\u4f55\\u975e\\u6cd5\\u4f7f\\u7528\\u7528\\u6237\\u5e10\\u53f7\\u6216\\u5b89\\u5168\\u6f0f\\u6d1e\\u7684\\u60c5\\u51b5\\uff0c\\u7acb\\u5373\\u901a\\u77e5phpcms\\u3002\\r\\n7\\uff0e \\u514d\\u8d23\\u6761\\u6b3e\\r\\n\\u3000\\u3000\\u7528\\u6237\\u660e\\u786e\\u540c\\u610f\\u7f51\\u7ad9\\u670d\\u52a1\\u7684\\u4f7f\\u7528\\u7531\\u7528\\u6237\\u4e2a\\u4eba\\u627f\\u62c5\\u98ce\\u9669\\u3002 \\u3000\\u3000 \\r\\n\\u3000\\u3000phpcms\\u4e0d\\u4f5c\\u4efb\\u4f55\\u7c7b\\u578b\\u7684\\u62c5\\u4fdd\\uff0c\\u4e0d\\u62c5\\u4fdd\\u670d\\u52a1\\u4e00\\u5b9a\\u80fd\\u6ee1\\u8db3\\u7528\\u6237\\u7684\\u8981\\u6c42\\uff0c\\u4e5f\\u4e0d\\u62c5\\u4fdd\\u670d\\u52a1\\u4e0d\\u4f1a\\u53d7\\u4e2d\\u65ad\\uff0c\\u5bf9\\u670d\\u52a1\\u7684\\u53ca\\u65f6\\u6027\\uff0c\\u5b89\\u5168\\u6027\\uff0c\\u51fa\\u9519\\u53d1\\u751f\\u90fd\\u4e0d\\u4f5c\\u62c5\\u4fdd\\u3002\\u7528\\u6237\\u7406\\u89e3\\u5e76\\u63a5\\u53d7\\uff1a\\u4efb\\u4f55\\u901a\\u8fc7phpcms\\u670d\\u52a1\\u53d6\\u5f97\\u7684\\u4fe1\\u606f\\u8d44\\u6599\\u7684\\u53ef\\u9760\\u6027\\u53d6\\u51b3\\u4e8e\\u7528\\u6237\\u81ea\\u5df1\\uff0c\\u7528\\u6237\\u81ea\\u5df1\\u627f\\u62c5\\u6240\\u6709\\u98ce\\u9669\\u548c\\u8d23\\u4efb\\u3002 \\r\\n8\\uff0e\\u6709\\u9650\\u8d23\\u4efb\\r\\n\\u3000\\u3000phpcms\\u5bf9\\u4efb\\u4f55\\u76f4\\u63a5\\u3001\\u95f4\\u63a5\\u3001\\u5076\\u7136\\u3001\\u7279\\u6b8a\\u53ca\\u7ee7\\u8d77\\u7684\\u635f\\u5bb3\\u4e0d\\u8d1f\\u8d23\\u4efb\\u3002\\r\\n9\\uff0e \\u4e0d\\u63d0\\u4f9b\\u96f6\\u552e\\u548c\\u5546\\u4e1a\\u6027\\u670d\\u52a1 \\r\\n\\u3000\\u3000\\u7528\\u6237\\u4f7f\\u7528\\u7f51\\u7ad9\\u670d\\u52a1\\u7684\\u6743\\u5229\\u662f\\u4e2a\\u4eba\\u7684\\u3002\\u7528\\u6237\\u53ea\\u80fd\\u662f\\u4e00\\u4e2a\\u5355\\u72ec\\u7684\\u4e2a\\u4f53\\u800c\\u4e0d\\u80fd\\u662f\\u4e00\\u4e2a\\u516c\\u53f8\\u6216\\u5b9e\\u4f53\\u5546\\u4e1a\\u6027\\u7ec4\\u7ec7\\u3002\\u7528\\u6237\\u627f\\u8bfa\\u4e0d\\u7ecfphpcms\\u540c\\u610f\\uff0c\\u4e0d\\u80fd\\u5229\\u7528\\u7f51\\u7ad9\\u670d\\u52a1\\u8fdb\\u884c\\u9500\\u552e\\u6216\\u5176\\u4ed6\\u5546\\u4e1a\\u7528\\u9014\\u3002\\r\\n10\\uff0e\\u7528\\u6237\\u8d23\\u4efb \\r\\n\\u3000\\u3000\\u7528\\u6237\\u5355\\u72ec\\u627f\\u62c5\\u4f20\\u8f93\\u5185\\u5bb9\\u7684\\u8d23\\u4efb\\u3002\\u7528\\u6237\\u5fc5\\u987b\\u9075\\u5faa\\uff1a \\r\\n\\u3000\\u30001)\\u4ece\\u4e2d\\u56fd\\u5883\\u5185\\u5411\\u5916\\u4f20\\u8f93\\u6280\\u672f\\u6027\\u8d44\\u6599\\u65f6\\u5fc5\\u987b\\u7b26\\u5408\\u4e2d\\u56fd\\u6709\\u5173\\u6cd5\\u89c4\\u3002 \\r\\n\\u3000\\u30002)\\u4f7f\\u7528\\u7f51\\u7ad9\\u670d\\u52a1\\u4e0d\\u4f5c\\u975e\\u6cd5\\u7528\\u9014\\u3002 \\r\\n\\u3000\\u30003)\\u4e0d\\u5e72\\u6270\\u6216\\u6df7\\u4e71\\u7f51\\u7edc\\u670d\\u52a1\\u3002 \\r\\n\\u3000\\u30004)\\u4e0d\\u5728\\u8bba\\u575bBBS\\u6216\\u7559\\u8a00\\u7c3f\\u53d1\\u8868\\u4efb\\u4f55\\u4e0e\\u653f\\u6cbb\\u76f8\\u5173\\u7684\\u4fe1\\u606f\\u3002 \\r\\n\\u3000\\u30005)\\u9075\\u5b88\\u6240\\u6709\\u4f7f\\u7528\\u7f51\\u7ad9\\u670d\\u52a1\\u7684\\u7f51\\u7edc\\u534f\\u8bae\\u3001\\u89c4\\u5b9a\\u3001\\u7a0b\\u5e8f\\u548c\\u60ef\\u4f8b\\u3002\\r\\n\\u3000\\u30006)\\u4e0d\\u5f97\\u5229\\u7528\\u672c\\u7ad9\\u5371\\u5bb3\\u56fd\\u5bb6\\u5b89\\u5168\\u3001\\u6cc4\\u9732\\u56fd\\u5bb6\\u79d8\\u5bc6\\uff0c\\u4e0d\\u5f97\\u4fb5\\u72af\\u56fd\\u5bb6\\u793e\\u4f1a\\u96c6\\u4f53\\u7684\\u548c\\u516c\\u6c11\\u7684\\u5408\\u6cd5\\u6743\\u76ca\\u3002\\r\\n\\u3000\\u30007)\\u4e0d\\u5f97\\u5229\\u7528\\u672c\\u7ad9\\u5236\\u4f5c\\u3001\\u590d\\u5236\\u548c\\u4f20\\u64ad\\u4e0b\\u5217\\u4fe1\\u606f\\uff1a \\r\\n\\u3000\\u3000\\u30001\\u3001\\u717d\\u52a8\\u6297\\u62d2\\u3001\\u7834\\u574f\\u5baa\\u6cd5\\u548c\\u6cd5\\u5f8b\\u3001\\u884c\\u653f\\u6cd5\\u89c4\\u5b9e\\u65bd\\u7684\\uff1b\\r\\n\\u3000\\u3000\\u30002\\u3001\\u717d\\u52a8\\u98a0\\u8986\\u56fd\\u5bb6\\u653f\\u6743\\uff0c\\u63a8\\u7ffb\\u793e\\u4f1a\\u4e3b\\u4e49\\u5236\\u5ea6\\u7684\\uff1b\\r\\n\\u3000\\u3000\\u30003\\u3001\\u717d\\u52a8\\u5206\\u88c2\\u56fd\\u5bb6\\u3001\\u7834\\u574f\\u56fd\\u5bb6\\u7edf\\u4e00\\u7684\\uff1b\\r\\n\\u3000\\u3000\\u30004\\u3001\\u717d\\u52a8\\u6c11\\u65cf\\u4ec7\\u6068\\u3001\\u6c11\\u65cf\\u6b67\\u89c6\\uff0c\\u7834\\u574f\\u6c11\\u65cf\\u56e2\\u7ed3\\u7684\\uff1b\\r\\n\\u3000\\u3000\\u30005\\u3001\\u634f\\u9020\\u6216\\u8005\\u6b6a\\u66f2\\u4e8b\\u5b9e\\uff0c\\u6563\\u5e03\\u8c23\\u8a00\\uff0c\\u6270\\u4e71\\u793e\\u4f1a\\u79e9\\u5e8f\\u7684\\uff1b\\r\\n\\u3000\\u3000\\u30006\\u3001\\u5ba3\\u626c\\u5c01\\u5efa\\u8ff7\\u4fe1\\u3001\\u6deb\\u79fd\\u3001\\u8272\\u60c5\\u3001\\u8d4c\\u535a\\u3001\\u66b4\\u529b\\u3001\\u51f6\\u6740\\u3001\\u6050\\u6016\\u3001\\u6559\\u5506\\u72af\\u7f6a\\u7684\\uff1b\\r\\n\\u3000\\u3000\\u30007\\u3001\\u516c\\u7136\\u4fae\\u8fb1\\u4ed6\\u4eba\\u6216\\u8005\\u634f\\u9020\\u4e8b\\u5b9e\\u8bfd\\u8c24\\u4ed6\\u4eba\\u7684\\uff0c\\u6216\\u8005\\u8fdb\\u884c\\u5176\\u4ed6\\u6076\\u610f\\u653b\\u51fb\\u7684\\uff1b\\r\\n\\u3000\\u3000\\u30008\\u3001\\u635f\\u5bb3\\u56fd\\u5bb6\\u673a\\u5173\\u4fe1\\u8a89\\u7684\\uff1b\\r\\n\\u3000\\u3000\\u30009\\u3001\\u5176\\u4ed6\\u8fdd\\u53cd\\u5baa\\u6cd5\\u548c\\u6cd5\\u5f8b\\u884c\\u653f\\u6cd5\\u89c4\\u7684\\uff1b\\r\\n\\u3000\\u3000\\u300010\\u3001\\u8fdb\\u884c\\u5546\\u4e1a\\u5e7f\\u544a\\u884c\\u4e3a\\u7684\\u3002\\r\\n\\u3000\\u3000\\u7528\\u6237\\u4e0d\\u80fd\\u4f20\\u8f93\\u4efb\\u4f55\\u6559\\u5506\\u4ed6\\u4eba\\u6784\\u6210\\u72af\\u7f6a\\u884c\\u4e3a\\u7684\\u8d44\\u6599\\uff1b\\u4e0d\\u80fd\\u4f20\\u8f93\\u957f\\u56fd\\u5185\\u4e0d\\u5229\\u6761\\u4ef6\\u548c\\u6d89\\u53ca\\u56fd\\u5bb6\\u5b89\\u5168\\u7684\\u8d44\\u6599\\uff1b\\u4e0d\\u80fd\\u4f20\\u8f93\\u4efb\\u4f55\\u4e0d\\u7b26\\u5408\\u5f53\\u5730\\u6cd5\\u89c4\\u3001\\u56fd\\u5bb6\\u6cd5\\u5f8b\\u548c\\u56fd\\u9645\\u6cd5 \\u5f8b\\u7684\\u8d44\\u6599\\u3002\\u672a\\u7ecf\\u8bb8\\u53ef\\u800c\\u975e\\u6cd5\\u8fdb\\u5165\\u5176\\u5b83\\u7535\\u8111\\u7cfb\\u7edf\\u662f\\u7981\\u6b62\\u7684\\u3002\\u82e5\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u4e0d\\u7b26\\u5408\\u4ee5\\u4e0a\\u7684\\u6761\\u6b3e\\uff0cphpcms\\u5c06\\u53d6\\u6d88\\u7528\\u6237\\u670d\\u52a1\\u5e10\\u53f7\\u3002\\r\\n11\\uff0e\\u7f51\\u7ad9\\u5185\\u5bb9\\u7684\\u6240\\u6709\\u6743\\r\\n\\u3000\\u3000phpcms\\u5b9a\\u4e49\\u7684\\u5185\\u5bb9\\u5305\\u62ec\\uff1a\\u6587\\u5b57\\u3001\\u8f6f\\u4ef6\\u3001\\u58f0\\u97f3\\u3001\\u76f8\\u7247\\u3001\\u5f55\\u8c61\\u3001\\u56fe\\u8868\\uff1b\\u5728\\u5e7f\\u544a\\u4e2d\\u5168\\u90e8\\u5185\\u5bb9\\uff1b\\u7535\\u5b50\\u90ae\\u4ef6\\u7684\\u5168\\u90e8\\u5185\\u5bb9\\uff1bphpcms\\u4e3a\\u7528\\u6237\\u63d0\\u4f9b\\u7684\\u5546\\u4e1a\\u4fe1\\u606f\\u3002\\u6240\\u6709\\u8fd9\\u4e9b\\u5185\\u5bb9\\u53d7\\u7248\\u6743\\u3001\\u5546\\u6807\\u3001\\u6807\\u7b7e\\u548c\\u5176\\u5b83\\u8d22\\u4ea7\\u6240\\u6709\\u6743\\u6cd5\\u5f8b\\u7684\\u4fdd\\u62a4\\u3002\\u6240\\u4ee5\\uff0c\\u7528\\u6237\\u53ea\\u80fd\\u5728phpcms\\u548c\\u5e7f\\u544a\\u5546\\u6388\\u6743\\u4e0b\\u624d\\u80fd\\u4f7f\\u7528\\u8fd9\\u4e9b\\u5185\\u5bb9\\uff0c\\u800c\\u4e0d\\u80fd\\u64c5\\u81ea\\u590d\\u5236\\u3001\\u7be1\\u6539\\u8fd9\\u4e9b\\u5185\\u5bb9\\u3001\\u6216\\u521b\\u9020\\u4e0e\\u5185\\u5bb9\\u6709\\u5173\\u7684\\u6d3e\\u751f\\u4ea7\\u54c1\\u3002\\r\\n12\\uff0e\\u9644\\u52a0\\u4fe1\\u606f\\u670d\\u52a1\\r\\n\\u3000\\u3000\\u7528\\u6237\\u5728\\u4eab\\u7528phpcms\\u63d0\\u4f9b\\u7684\\u514d\\u8d39\\u670d\\u52a1\\u7684\\u540c\\u65f6\\uff0c\\u540c\\u610f\\u63a5\\u53d7phpcms\\u63d0\\u4f9b\\u7684\\u5404\\u7c7b\\u9644\\u52a0\\u4fe1\\u606f\\u670d\\u52a1\\u3002\\r\\n13\\uff0e\\u89e3\\u91ca\\u6743\\r\\n\\u3000\\u3000\\u672c\\u6ce8\\u518c\\u534f\\u8bae\\u7684\\u89e3\\u91ca\\u6743\\u5f52phpcms\\u6240\\u6709\\u3002\\u5982\\u679c\\u5176\\u4e2d\\u6709\\u4efb\\u4f55\\u6761\\u6b3e\\u4e0e\\u56fd\\u5bb6\\u7684\\u6709\\u5173\\u6cd5\\u5f8b\\u76f8\\u62b5\\u89e6\\uff0c\\u5219\\u4ee5\\u56fd\\u5bb6\\u6cd5\\u5f8b\\u7684\\u660e\\u6587\\u89c4\\u5b9a\\u4e3a\\u51c6\\u3002 \",\"registerverifymessage\":\" \\u6b22\\u8fce\\u60a8\\u6ce8\\u518c\\u6210\\u4e3aphpcms\\u7528\\u6237\\uff0c\\u60a8\\u7684\\u8d26\\u53f7\\u9700\\u8981\\u90ae\\u7bb1\\u8ba4\\u8bc1\\uff0c\\u70b9\\u51fb\\u4e0b\\u9762\\u94fe\\u63a5\\u8fdb\\u884c\\u8ba4\\u8bc1\\uff1a{click}\\r\\n\\u6216\\u8005\\u5c06\\u7f51\\u5740\\u590d\\u5236\\u5230\\u6d4f\\u89c8\\u5668\\uff1a{url}\",\"forgetpassword\":\" phpcms\\u5bc6\\u7801\\u627e\\u56de\\uff0c\\u8bf7\\u5728\\u4e00\\u5c0f\\u65f6\\u5185\\u70b9\\u51fb\\u4e0b\\u9762\\u94fe\\u63a5\\u8fdb\\u884c\\u64cd\\u4f5c\\uff1a{click}\\r\\n\\u6216\\u8005\\u5c06\\u7f51\\u5740\\u590d\\u5236\\u5230\\u6d4f\\u89c8\\u5668\\uff1a{url}\"}','0','0','2010-09-06','2010-09-06');
INSERT INTO `v9_module` VALUES('pay','支付','','1','1.0','','','0','0','2010-09-06','2010-09-06');
INSERT INTO `v9_module` VALUES('digg','顶一下','','0','1.0','','','0','0','2010-09-06','2010-09-06');
INSERT INTO `v9_module` VALUES('special','专题','','0','1.0','','','0','0','2010-09-06','2010-09-06');
INSERT INTO `v9_module` VALUES('content','内容模块','','1','1.0','','','0','0','2010-09-06','2010-09-06');
INSERT INTO `v9_module` VALUES('search','全站搜索','','0','1.0','','array (\n  \'fulltextenble\' => \'1\',\n  \'relationenble\' => \'1\',\n  \'suggestenable\' => \'1\',\n  \'sphinxenable\' => \'0\',\n  \'sphinxhost\' => \'10.228.134.102\',\n  \'sphinxport\' => \'9312\',\n)','0','0','2010-09-06','2010-09-06');
INSERT INTO `v9_module` VALUES('scan','木马扫描','scan','0','1.0','','','0','0','2010-09-01','2010-09-06');
INSERT INTO `v9_module` VALUES('attachment','附件','attachment','1','1.0','','','0','0','2010-09-01','2010-09-06');
INSERT INTO `v9_module` VALUES('block','碎片','','1','1.0','','','0','0','2010-09-01','2010-09-06');
INSERT INTO `v9_module` VALUES('collection','采集模块','collection','1','1.0','','','0','0','2010-09-01','2010-09-06');
INSERT INTO `v9_module` VALUES('dbsource','数据源','','1','','','','0','0','2010-09-01','2010-09-06');
INSERT INTO `v9_module` VALUES('template','模板风格','','1','1.0','','','0','0','2010-09-01','2010-09-06');
INSERT INTO `v9_module` VALUES('release','发布点','','1','1.0','','','0','0','2010-09-01','2010-09-06');
INSERT INTO `v9_module` VALUES('video','视频库','','0','1.0','','','0','0','2012-09-28','2012-09-28');
INSERT INTO `v9_module` VALUES('announce','公告','announce/','0','1.0','公告','','0','0','2018-01-28','2018-01-28');
INSERT INTO `v9_module` VALUES('comment','评论','comment/','0','1.0','评论','','0','0','2018-01-28','2018-01-28');
INSERT INTO `v9_module` VALUES('link','友情链接','','0','1.0','','array (\n  1 => \n  array (\n    \'is_post\' => \'1\',\n    \'enablecheckcode\' => \'0\',\n  ),\n)','0','0','2010-09-06','2010-09-06');
INSERT INTO `v9_module` VALUES('vote','投票','','0','1.0','','array (\r\n  1 => \r\n  array (\r\n    \'default_style\' => \'default\',\r\n    \'vote_tp_template\' => \'vote_tp\',\r\n    \'allowguest\' => \'1\',\r\n    \'enabled\' => \'1\',\r\n    \'interval\' => \'1\',\r\n    \'credit\' => \'1\',\r\n  ),\r\n)','0','0','2010-09-06','2010-09-06');
INSERT INTO `v9_module` VALUES('message','短消息','','0','1.0','','','0','0','2010-09-06','2010-09-06');
INSERT INTO `v9_module` VALUES('mood','新闻心情','mood/','0','1.0','新闻心情','','0','0','2018-01-28','2018-01-28');
INSERT INTO `v9_module` VALUES('poster','广告模块','poster/','0','1.0','广告模块','','0','0','2018-01-28','2018-01-28');
INSERT INTO `v9_module` VALUES('formguide','表单向导','formguide/','0','1.0','formguide','array (\n  \'allowmultisubmit\' => \'1\',\n  \'interval\' => \'30\',\n  \'allowunreg\' => \'0\',\n  \'mailmessage\' => \'用户向我们提交了表单数据，赶快去看看吧。\',\n)','0','0','2010-10-20','2010-10-20');
INSERT INTO `v9_module` VALUES('wap','手机门户','wap/','0','1.0','手机门户','','0','0','2018-01-28','2018-01-28');
INSERT INTO `v9_module` VALUES('upgrade','在线升级','','0','1.0','','','0','0','2011-05-18','2011-05-18');
INSERT INTO `v9_module` VALUES('tag','标签向导','tag/','0','1.0','标签向导','','0','0','2018-01-28','2018-01-28');
INSERT INTO `v9_module` VALUES('sms','短信平台','sms/','0','1.0','短信平台','{\"sms_enable\":\"1\",\"userid\":\"dazuiwoniu\",\"productid\":\"dzwn\",\"sms_key\":\"tmnt1992\"}','0','0','2011-09-02','2011-09-02');

DROP TABLE IF EXISTS `v9_mood`;
CREATE TABLE `v9_mood` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `catid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '栏目id',
  `siteid` mediumint(6) unsigned NOT NULL DEFAULT '0' COMMENT '站点ID',
  `contentid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章id',
  `total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '总数',
  `n1` int(10) unsigned NOT NULL DEFAULT '0',
  `n2` int(10) unsigned NOT NULL DEFAULT '0',
  `n3` int(10) unsigned NOT NULL DEFAULT '0',
  `n4` int(10) unsigned NOT NULL DEFAULT '0',
  `n5` int(10) unsigned NOT NULL DEFAULT '0',
  `n6` int(10) unsigned NOT NULL DEFAULT '0',
  `n7` int(10) unsigned NOT NULL DEFAULT '0',
  `n8` int(10) unsigned NOT NULL DEFAULT '0',
  `n9` int(10) unsigned NOT NULL DEFAULT '0',
  `n10` int(10) unsigned NOT NULL DEFAULT '0',
  `lastupdate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `total` (`total`),
  KEY `lastupdate` (`lastupdate`),
  KEY `catid` (`catid`,`siteid`,`contentid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_news`;
CREATE TABLE `v9_news` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` varchar(80) NOT NULL DEFAULT '',
  `style` char(24) NOT NULL DEFAULT '',
  `thumb` varchar(100) NOT NULL DEFAULT '',
  `keywords` char(40) NOT NULL DEFAULT '',
  `description` mediumtext NOT NULL,
  `posids` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(100) NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `sysadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_news_data`;
CREATE TABLE `v9_news_data` (
  `id` mediumint(8) unsigned DEFAULT '0',
  `content` mediumtext NOT NULL,
  `readpoint` smallint(5) unsigned NOT NULL DEFAULT '0',
  `groupids_view` varchar(100) NOT NULL,
  `paginationtype` tinyint(1) NOT NULL,
  `maxcharperpage` mediumint(6) NOT NULL,
  `template` varchar(30) NOT NULL,
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `relation` varchar(255) NOT NULL DEFAULT '',
  `voteid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `allow_comment` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `copyfrom` varchar(100) NOT NULL DEFAULT '',
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_page`;
CREATE TABLE `v9_page` (
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `title` varchar(160) NOT NULL,
  `style` varchar(24) NOT NULL,
  `keywords` varchar(40) NOT NULL,
  `content` text NOT NULL,
  `template` varchar(30) NOT NULL,
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `catid` (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_page` VALUES('2','关于我们',';','关于我们','共计风骚和家私发我就饿哦季度服务费','','0');
INSERT INTO `v9_page` VALUES('3','联系我们',';','联系','傻大姐佛挖掘发顺丰','','0');

DROP TABLE IF EXISTS `v9_pay_account`;
CREATE TABLE `v9_pay_account` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `trade_sn` char(50) NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `contactname` char(50) NOT NULL,
  `email` char(40) NOT NULL,
  `telephone` char(20) NOT NULL,
  `discount` float(8,2) NOT NULL DEFAULT '0.00',
  `money` char(8) NOT NULL,
  `quantity` int(8) unsigned NOT NULL DEFAULT '1',
  `addtime` int(10) NOT NULL DEFAULT '0',
  `paytime` int(10) NOT NULL DEFAULT '0',
  `usernote` char(255) NOT NULL,
  `pay_id` tinyint(3) NOT NULL,
  `pay_type` enum('offline','recharge','selfincome','online') NOT NULL DEFAULT 'recharge',
  `payment` char(90) NOT NULL,
  `type` tinyint(3) NOT NULL DEFAULT '1',
  `ip` char(15) NOT NULL DEFAULT '0.0.0.0',
  `status` enum('succ','failed','error','progress','timeout','cancel','waitting','unpay') NOT NULL DEFAULT 'unpay',
  `adminnote` char(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `userid` (`userid`),
  KEY `trade_sn` (`trade_sn`,`money`,`status`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_pay_payment`;
CREATE TABLE `v9_pay_payment` (
  `pay_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `pay_name` varchar(120) NOT NULL,
  `pay_code` varchar(20) NOT NULL,
  `pay_desc` text NOT NULL,
  `pay_method` tinyint(1) DEFAULT NULL,
  `pay_fee` varchar(10) NOT NULL,
  `config` text NOT NULL,
  `is_cod` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_online` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pay_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `author` varchar(100) NOT NULL,
  `website` varchar(100) NOT NULL,
  `version` varchar(20) NOT NULL,
  PRIMARY KEY (`pay_id`),
  KEY `pay_code` (`pay_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_pay_spend`;
CREATE TABLE `v9_pay_spend` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `creat_at` int(10) unsigned NOT NULL DEFAULT '0',
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `username` varchar(20) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `logo` varchar(20) NOT NULL,
  `value` int(5) NOT NULL,
  `op_userid` int(10) unsigned NOT NULL DEFAULT '0',
  `op_username` char(20) NOT NULL,
  `msg` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `creat_at` (`creat_at`),
  KEY `logo` (`logo`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_picture`;
CREATE TABLE `v9_picture` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` char(80) NOT NULL DEFAULT '',
  `style` char(24) NOT NULL DEFAULT '',
  `thumb` char(100) NOT NULL DEFAULT '',
  `keywords` char(40) NOT NULL DEFAULT '',
  `description` char(255) NOT NULL DEFAULT '',
  `posids` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(100) NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `sysadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_picture_data`;
CREATE TABLE `v9_picture_data` (
  `id` mediumint(8) unsigned DEFAULT '0',
  `content` text NOT NULL,
  `readpoint` smallint(5) unsigned NOT NULL DEFAULT '0',
  `groupids_view` varchar(100) NOT NULL,
  `paginationtype` tinyint(1) NOT NULL,
  `maxcharperpage` mediumint(6) NOT NULL,
  `template` varchar(30) NOT NULL,
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `relation` varchar(255) NOT NULL DEFAULT '',
  `pictureurls` mediumtext NOT NULL,
  `copyfrom` varchar(255) NOT NULL DEFAULT '',
  `allow_comment` tinyint(1) unsigned NOT NULL DEFAULT '1',
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_position`;
CREATE TABLE `v9_position` (
  `posid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `modelid` smallint(5) unsigned DEFAULT '0',
  `catid` smallint(5) unsigned DEFAULT '0',
  `name` char(30) NOT NULL DEFAULT '',
  `maxnum` smallint(5) NOT NULL DEFAULT '20',
  `extention` char(100) DEFAULT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `thumb` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`posid`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

INSERT INTO `v9_position` VALUES('1','0','0','首页焦点图推荐','20','','1','1','');
INSERT INTO `v9_position` VALUES('2','0','0','首页头条推荐','20','','4','1','');
INSERT INTO `v9_position` VALUES('13','82','0','栏目页焦点图','20','','0','1','');
INSERT INTO `v9_position` VALUES('5','69','0','推荐下载','20','','0','1','');
INSERT INTO `v9_position` VALUES('8','30','54','图片频道首页焦点图','20','','0','1','');
INSERT INTO `v9_position` VALUES('9','0','0','网站顶部推荐','20','','0','1','');
INSERT INTO `v9_position` VALUES('10','0','0','栏目首页推荐','20','','0','1','');
INSERT INTO `v9_position` VALUES('12','0','0','首页图片推荐','20','','0','1','');
INSERT INTO `v9_position` VALUES('14','0','0','视频首页焦点图','20','','0','1','');
INSERT INTO `v9_position` VALUES('15','0','0','视频首页头条推荐','20','','0','1','');
INSERT INTO `v9_position` VALUES('16','0','0','视频首页每日热点','20','','0','1','');
INSERT INTO `v9_position` VALUES('17','0','0','视频栏目精彩推荐','20','','0','1','');

DROP TABLE IF EXISTS `v9_position_data`;
CREATE TABLE `v9_position_data` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `posid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `module` char(20) DEFAULT NULL,
  `modelid` smallint(6) unsigned DEFAULT '0',
  `thumb` tinyint(1) NOT NULL DEFAULT '0',
  `data` mediumtext,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '1',
  `listorder` mediumint(8) DEFAULT '0',
  `expiration` int(10) NOT NULL,
  `extention` char(30) DEFAULT NULL,
  `synedit` tinyint(1) DEFAULT '0',
  KEY `posid` (`posid`),
  KEY `listorder` (`listorder`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_position_data` VALUES('2','6','1','content','1','1','{\"title\":\"\\u963f\\u7d22\\u52a0\\u4e0a\\u70b9\\u9644\\u8fd1\\u556a\\u70af\\u70af\\u989d\",\"description\":\"\\r\\n\\r\\n\\u7231\\u4e0a\\u4e86\\u4e09\\u529b\\u5ea6\\u56de\\u590d\\u62c9\\u592b\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204062025580.jpg\",\"inputtime\":\"1517660023\",\"style\":\"\"}','1','2','0','','0');
INSERT INTO `v9_position_data` VALUES('3','8','1','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f661\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063257442.jpg\",\"inputtime\":\"1517740352\",\"style\":\"\"}','1','3','0','','0');
INSERT INTO `v9_position_data` VALUES('4','8','1','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f662\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063342124.jpg\",\"inputtime\":\"1517740401\",\"style\":\"\"}','1','4','0','','0');
INSERT INTO `v9_position_data` VALUES('5','8','1','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f663\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063415757.jpg\",\"inputtime\":\"1517740436\",\"style\":\"\"}','1','5','0','','0');
INSERT INTO `v9_position_data` VALUES('6','8','1','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f664\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063437958.jpg\",\"inputtime\":\"1517740465\",\"style\":\"\"}','1','6','0','','0');
INSERT INTO `v9_position_data` VALUES('6','8','2','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f664\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063437958.jpg\",\"inputtime\":\"1517740465\",\"style\":\"\"}','1','6','0','','0');
INSERT INTO `v9_position_data` VALUES('6','8','12','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f664\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063437958.jpg\",\"inputtime\":\"1517740465\",\"style\":\"\"}','1','6','0','','0');
INSERT INTO `v9_position_data` VALUES('6','8','10','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f664\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063437958.jpg\",\"inputtime\":\"1517740465\",\"style\":\"\"}','1','6','0','','0');
INSERT INTO `v9_position_data` VALUES('5','8','2','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f663\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063415757.jpg\",\"inputtime\":\"1517740436\",\"style\":\"\"}','1','5','0','','0');
INSERT INTO `v9_position_data` VALUES('4','8','2','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f662\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063342124.jpg\",\"inputtime\":\"1517740401\",\"style\":\"\"}','1','4','0','','0');
INSERT INTO `v9_position_data` VALUES('3','8','2','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f661\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063257442.jpg\",\"inputtime\":\"1517740352\",\"style\":\"\"}','1','3','0','','0');
INSERT INTO `v9_position_data` VALUES('5','8','12','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f663\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063415757.jpg\",\"inputtime\":\"1517740436\",\"style\":\"\"}','1','5','0','','0');
INSERT INTO `v9_position_data` VALUES('4','8','12','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f662\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063342124.jpg\",\"inputtime\":\"1517740401\",\"style\":\"\"}','1','4','0','','0');
INSERT INTO `v9_position_data` VALUES('3','8','12','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f661\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063257442.jpg\",\"inputtime\":\"1517740352\",\"style\":\"\"}','1','3','0','','0');
INSERT INTO `v9_position_data` VALUES('5','8','10','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f663\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063415757.jpg\",\"inputtime\":\"1517740436\",\"style\":\"\"}','1','5','0','','0');
INSERT INTO `v9_position_data` VALUES('4','8','10','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f662\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063342124.jpg\",\"inputtime\":\"1517740401\",\"style\":\"\"}','1','4','0','','0');
INSERT INTO `v9_position_data` VALUES('3','8','10','content','3','1','{\"title\":\"\\u6551\\u62a4\\u8f661\",\"thumb\":\"http:\\/\\/localhost\\/ambulance\\/uploadfile\\/2018\\/0204\\/20180204063257442.jpg\",\"inputtime\":\"1517740352\",\"style\":\"\"}','1','3','0','','0');
INSERT INTO `v9_position_data` VALUES('2','13','2','content','12','1','{\"title\":\"\\u5c0f\\u7c73\\u96f7\\u519b\\u7684Are you OK ok ok\\uff1f\",\"thumb\":\"http:\\/\\/localhost\\/test\\/uploadfile\\/2019\\/1006\\/20191006052618929.jpg\",\"inputtime\":\"1570353911\",\"style\":\"\"}','1','2','0','','0');
INSERT INTO `v9_position_data` VALUES('2','13','1','content','12','1','{\"title\":\"\\u5c0f\\u7c73\\u96f7\\u519b\\u7684Are you OK ok ok\\uff1f\",\"thumb\":\"http:\\/\\/localhost\\/test\\/uploadfile\\/2019\\/1006\\/20191006052618929.jpg\",\"inputtime\":\"1570353911\",\"style\":\"\"}','1','2','0','','0');
INSERT INTO `v9_position_data` VALUES('2','13','9','content','12','1','{\"title\":\"\\u5c0f\\u7c73\\u96f7\\u519b\\u7684Are you OK ok ok\\uff1f\",\"thumb\":\"http:\\/\\/localhost\\/test\\/uploadfile\\/2019\\/1006\\/20191006052618929.jpg\",\"inputtime\":\"1570353911\",\"style\":\"\"}','1','2','0','','0');
INSERT INTO `v9_position_data` VALUES('2','13','10','content','12','1','{\"title\":\"\\u5c0f\\u7c73\\u96f7\\u519b\\u7684Are you OK ok ok\\uff1f\",\"thumb\":\"http:\\/\\/localhost\\/test\\/uploadfile\\/2019\\/1006\\/20191006052618929.jpg\",\"inputtime\":\"1570353911\",\"style\":\"\"}','1','2','0','','0');
INSERT INTO `v9_position_data` VALUES('2','13','12','content','12','1','{\"title\":\"\\u5c0f\\u7c73\\u96f7\\u519b\\u7684Are you OK ok ok\\uff1f\",\"thumb\":\"http:\\/\\/localhost\\/test\\/uploadfile\\/2019\\/1006\\/20191006052618929.jpg\",\"inputtime\":\"1570353911\",\"style\":\"\"}','1','2','0','','0');
INSERT INTO `v9_position_data` VALUES('2','13','14','content','12','1','{\"title\":\"\\u5c0f\\u7c73\\u96f7\\u519b\\u7684Are you OK ok ok\\uff1f\",\"thumb\":\"http:\\/\\/localhost\\/test\\/uploadfile\\/2019\\/1006\\/20191006052618929.jpg\",\"inputtime\":\"1570353911\",\"style\":\"\"}','1','2','0','','0');
INSERT INTO `v9_position_data` VALUES('2','13','15','content','12','1','{\"title\":\"\\u5c0f\\u7c73\\u96f7\\u519b\\u7684Are you OK ok ok\\uff1f\",\"thumb\":\"http:\\/\\/localhost\\/test\\/uploadfile\\/2019\\/1006\\/20191006052618929.jpg\",\"inputtime\":\"1570353911\",\"style\":\"\"}','1','2','0','','0');
INSERT INTO `v9_position_data` VALUES('2','13','16','content','12','1','{\"title\":\"\\u5c0f\\u7c73\\u96f7\\u519b\\u7684Are you OK ok ok\\uff1f\",\"thumb\":\"http:\\/\\/localhost\\/test\\/uploadfile\\/2019\\/1006\\/20191006052618929.jpg\",\"inputtime\":\"1570353911\",\"style\":\"\"}','1','2','0','','0');
INSERT INTO `v9_position_data` VALUES('2','13','17','content','12','1','{\"title\":\"\\u5c0f\\u7c73\\u96f7\\u519b\\u7684Are you OK ok ok\\uff1f\",\"thumb\":\"http:\\/\\/localhost\\/test\\/uploadfile\\/2019\\/1006\\/20191006052618929.jpg\",\"inputtime\":\"1570353911\",\"style\":\"\"}','1','2','0','','0');

DROP TABLE IF EXISTS `v9_poster`;
CREATE TABLE `v9_poster` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` varchar(40) NOT NULL,
  `spaceid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `type` varchar(10) NOT NULL,
  `setting` text NOT NULL,
  `startdate` int(10) unsigned NOT NULL DEFAULT '0',
  `enddate` int(10) unsigned NOT NULL DEFAULT '0',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `hits` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `clicks` smallint(5) unsigned NOT NULL DEFAULT '0',
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `spaceid` (`spaceid`,`siteid`,`disabled`,`listorder`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

INSERT INTO `v9_poster` VALUES('1','1','banner','1','images','array (\n  1 => \n  array (\n    \'linkurl\' => \'http://www.phpcms.cn\',\n    \'imageurl\' => \'http://www.dazuiwoniuyuanxuezhi.com/uploadfile/poster/2.png\',\n    \'alt\' => \'\',\n  ),\n)','1285813808','1446249600','1285813833','0','1','0','0');
INSERT INTO `v9_poster` VALUES('2','1','phpcmsv9','2','images','array (\n  1 => \n  array (\n    \'linkurl\' => \'http://www.phpcms.cn\',\n    \'imageurl\' => \'http://localhost/ambulance/statics/images/v9/ad_login.jpg\',\n    \'alt\' => \'phpcms专业建站系统\',\n  ),\n)','1285816298','1446249600','1285816310','0','1','0','0');
INSERT INTO `v9_poster` VALUES('3','1','phpcms下载推荐','3','images','array (\n  1 => \n  array (\n    \'linkurl\' => \'http://www.phpcms.cn\',\n    \'imageurl\' => \'http://www.dazuiwoniuyuanxuezhi.com/uploadfile/poster/3.png\',\n    \'alt\' => \'phpcms官方\',\n  ),\n)','1286504815','1446249600','1286504865','0','1','0','0');
INSERT INTO `v9_poster` VALUES('4','1','phpcms广告','4','images','array (\n  1 => \n  array (\n    \'linkurl\' => \'http://www.phpcms.cn\',\n    \'imageurl\' => \'http://www.dazuiwoniuyuanxuezhi.com/uploadfile/poster/4.gif\',\n    \'alt\' => \'phpcms官方\',\n  ),\n)','1286505141','1446249600','1286505178','0','0','0','0');
INSERT INTO `v9_poster` VALUES('5','1','phpcms下载','5','images','array (\n  1 => \n  array (\n    \'linkurl\' => \'http://www.phpcms.cn\',\n    \'imageurl\' => \'http://www.dazuiwoniuyuanxuezhi.com/uploadfile/poster/5.gif\',\n    \'alt\' => \'官方\',\n  ),\n)','1286509363','1446249600','1286509401','0','0','0','0');
INSERT INTO `v9_poster` VALUES('6','1','phpcms下载推荐1','6','images','array (\n  1 => \n  array (\n    \'linkurl\' => \'http://www.phpcms.cn\',\n    \'imageurl\' => \'http://www.dazuiwoniuyuanxuezhi.com/uploadfile/poster/5.gif\',\n    \'alt\' => \'官方\',\n  ),\n)','1286510183','1446249600','1286510227','0','0','0','0');
INSERT INTO `v9_poster` VALUES('7','1','phpcms下载详情','7','images','array (\n  1 => \n  array (\n    \'linkurl\' => \'http://www.phpcms.cn\',\n    \'imageurl\' => \'http://www.dazuiwoniuyuanxuezhi.com/uploadfile/poster/5.gif\',\n    \'alt\' => \'官方\',\n  ),\n)','1286510314','1446249600','1286510341','0','0','0','0');
INSERT INTO `v9_poster` VALUES('8','1','phpcms下载页','8','images','array (\n  1 => \n  array (\n    \'linkurl\' => \'http://www.phpcms.cn\',\n    \'imageurl\' => \'http://www.dazuiwoniuyuanxuezhi.com/uploadfile/poster/1.jpg\',\n    \'alt\' => \'官方站\',\n  ),\n)','1286522084','1446249600','1286522125','0','0','0','0');
INSERT INTO `v9_poster` VALUES('9','1','phpcms v9广告','9','images','array (\n  1 => \n  array (\n    \'linkurl\' => \'http://www.phpcms.cn\',\n    \'imageurl\' => \'http://www.dazuiwoniuyuanxuezhi.com/uploadfile/poster/4.gif\',\n    \'alt\' => \'\',\n  ),\n)','1287041759','1446249600','1287041804','0','0','0','0');
INSERT INTO `v9_poster` VALUES('10','1','phpcms','10','images','array (\n  1 => \n  array (\n    \'linkurl\' => \'http://www.phpcms.cn\',\n    \'imageurl\' => \'http://www.dazuiwoniuyuanxuezhi.com/uploadfile/poster/6.jpg\',\n    \'alt\' => \'phpcms官方\',\n  ),\n)','1289270509','1446249600','1289270541','1','0','0','0');

DROP TABLE IF EXISTS `v9_poster_201801`;
CREATE TABLE `v9_poster_201801` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spaceid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `area` char(40) NOT NULL,
  `ip` char(15) NOT NULL,
  `referer` char(120) NOT NULL,
  `clicktime` int(10) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`,`type`,`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_poster_201802`;
CREATE TABLE `v9_poster_201802` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spaceid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `area` char(40) NOT NULL,
  `ip` char(15) NOT NULL,
  `referer` char(120) NOT NULL,
  `clicktime` int(10) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`,`type`,`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_poster_201907`;
CREATE TABLE `v9_poster_201907` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spaceid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `area` char(40) NOT NULL,
  `ip` char(15) NOT NULL,
  `referer` char(120) NOT NULL,
  `clicktime` int(10) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`,`type`,`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_poster_201909`;
CREATE TABLE `v9_poster_201909` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spaceid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `area` char(40) NOT NULL,
  `ip` char(15) NOT NULL,
  `referer` char(120) NOT NULL,
  `clicktime` int(10) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`,`type`,`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_poster_201910`;
CREATE TABLE `v9_poster_201910` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spaceid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `area` char(40) NOT NULL,
  `ip` char(15) NOT NULL,
  `referer` char(120) NOT NULL,
  `clicktime` int(10) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`,`type`,`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_poster_space`;
CREATE TABLE `v9_poster_space` (
  `spaceid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` char(50) NOT NULL,
  `type` char(30) NOT NULL,
  `path` char(40) NOT NULL,
  `width` smallint(4) unsigned NOT NULL DEFAULT '0',
  `height` smallint(4) unsigned NOT NULL DEFAULT '0',
  `setting` char(100) NOT NULL,
  `description` char(100) NOT NULL,
  `items` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`spaceid`),
  KEY `disabled` (`disabled`,`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

INSERT INTO `v9_poster_space` VALUES('1','1','顶部搜索右侧广告位','banner','poster_js/1.js','430','63','array (\n  \'paddleft\' => \'\',\n  \'paddtop\' => \'\',\n)','','1','0');
INSERT INTO `v9_poster_space` VALUES('2','1','会员登陆页广告','banner','poster_js/2.js','310','304','array (\n  \'paddleft\' => \'\',\n  \'paddtop\' => \'\',\n)','会员登陆页广告右侧代替外部通行证广告','1','0');
INSERT INTO `v9_poster_space` VALUES('3','1','图片频道图片排行下方','banner','poster_js/3.js','249','87','array (\n  \'paddleft\' => \'\',\n  \'paddtop\' => \'\',\n)','','1','0');
INSERT INTO `v9_poster_space` VALUES('4','1','新闻中心推荐链接左侧','banner','poster_js/4.js','748','91','array (\n  \'paddleft\' => \'\',\n  \'paddtop\' => \'\',\n)','','1','0');
INSERT INTO `v9_poster_space` VALUES('5','1','下载列表页右侧顶部','banner','poster_js/5.js','248','162','array (\n  \'paddleft\' => \'\',\n  \'paddtop\' => \'\',\n)','','1','0');
INSERT INTO `v9_poster_space` VALUES('6','1','下载详情页右侧顶部','banner','poster_js/6.js','248','162','array (\n  \'paddleft\' => \'\',\n  \'paddtop\' => \'\',\n)','','1','0');
INSERT INTO `v9_poster_space` VALUES('7','1','下载详情页右侧下部','banner','poster_js/7.js','248','162','array (\n  \'paddleft\' => \'\',\n  \'paddtop\' => \'\',\n)','','1','0');
INSERT INTO `v9_poster_space` VALUES('8','1','下载频道首页','banner','poster_js/8.js','698','80','array (\n  \'paddleft\' => \'\',\n  \'paddtop\' => \'\',\n)','','1','0');
INSERT INTO `v9_poster_space` VALUES('9','1','下载详情页地址列表右侧','banner','poster_js/12.js','330','50','array (\n  \'paddleft\' => \'\',\n  \'paddtop\' => \'\',\n)','','1','0');
INSERT INTO `v9_poster_space` VALUES('10','1','首页关注下方广告','banner','poster_js/10.js','307','60','array (\n  \'paddleft\' => \'\',\n  \'paddtop\' => \'\',\n)','','1','0');

DROP TABLE IF EXISTS `v9_queue`;
CREATE TABLE `v9_queue` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` char(5) DEFAULT NULL,
  `siteid` smallint(5) unsigned DEFAULT '0',
  `path` varchar(100) DEFAULT NULL,
  `status1` tinyint(1) DEFAULT '0',
  `status2` tinyint(1) DEFAULT '0',
  `status3` tinyint(1) DEFAULT '0',
  `status4` tinyint(1) DEFAULT '0',
  `times` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `siteid` (`siteid`),
  KEY `times` (`times`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_release_point`;
CREATE TABLE `v9_release_point` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `host` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `port` varchar(10) DEFAULT '21',
  `pasv` tinyint(1) DEFAULT '0',
  `ssl` tinyint(1) DEFAULT '0',
  `path` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_search`;
CREATE TABLE `v9_search` (
  `searchid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `typeid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `adddate` int(10) unsigned NOT NULL,
  `data` text NOT NULL,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`searchid`),
  KEY `typeid` (`typeid`,`id`),
  KEY `siteid` (`siteid`),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

INSERT INTO `v9_search` VALUES('1','1','1','1517660006','士大夫大佛寺 大佛寺 士大夫 来说','1');
INSERT INTO `v9_search` VALUES('2','1','2','1517660023','阿索加上点附近啪炯炯额 阿索 回复 力度 爱上 加上 附近','1');
INSERT INTO `v9_search` VALUES('3','1','3','1517662852','difopasjsfa difopasjsfa ','1');
INSERT INTO `v9_search` VALUES('4','1','4','1517662876','sajflajfalsf sajflajfalsfjsjif ','1');
INSERT INTO `v9_search` VALUES('5','1','5','1517716997','abc abc 是否 第三','1');
INSERT INTO `v9_search` VALUES('6','1','6','1517717010','bcd bcd ','1');
INSERT INTO `v9_search` VALUES('13','3','7','1517832506','jsaifdklfjaew jsaifdklfjaew ','1');
INSERT INTO `v9_search` VALUES('9','3','3','1517740352','救护车1 救护车 ','1');
INSERT INTO `v9_search` VALUES('10','3','4','1517740401','救护车2 救护车 ','1');
INSERT INTO `v9_search` VALUES('11','3','5','1517740436','救护车3 救护车 ','1');
INSERT INTO `v9_search` VALUES('12','3','6','1517740465','救护车4 救护车 ','1');
INSERT INTO `v9_search` VALUES('15','53','2','1570353911','小米雷军的Are you OK ok ok？  ','1');

DROP TABLE IF EXISTS `v9_search_keyword`;
CREATE TABLE `v9_search_keyword` (
  `keyword` char(20) NOT NULL,
  `pinyin` char(20) NOT NULL,
  `searchnums` int(10) unsigned NOT NULL,
  `data` char(20) NOT NULL,
  UNIQUE KEY `keyword` (`keyword`),
  UNIQUE KEY `pinyin` (`pinyin`),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_session`;
CREATE TABLE `v9_session` (
  `sessionid` char(32) NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ip` char(15) NOT NULL,
  `lastvisit` int(10) unsigned NOT NULL DEFAULT '0',
  `roleid` tinyint(3) unsigned DEFAULT '0',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `m` char(20) NOT NULL,
  `c` char(20) NOT NULL,
  `a` char(20) NOT NULL,
  `data` char(255) NOT NULL,
  PRIMARY KEY (`sessionid`),
  KEY `lastvisit` (`lastvisit`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

INSERT INTO `v9_session` VALUES('kpi2m9q9cp3n4krm57c2hgnpe5','1','','1570437277','1','0','admin','database','export','code|s:0:\"\";userid|s:1:\"1\";roleid|s:1:\"1\";pc_hash|s:6:\"5GS7WO\";lock_screen|i:0;');

DROP TABLE IF EXISTS `v9_site`;
CREATE TABLE `v9_site` (
  `siteid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(30) DEFAULT '',
  `dirname` char(255) DEFAULT '',
  `domain` char(255) DEFAULT '',
  `site_title` char(255) DEFAULT '',
  `keywords` char(255) DEFAULT '',
  `description` char(255) DEFAULT '',
  `release_point` text,
  `default_style` char(50) DEFAULT NULL,
  `template` text,
  `setting` mediumtext,
  `uuid` char(40) DEFAULT '',
  PRIMARY KEY (`siteid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `v9_site` VALUES('1','大嘴蜗牛网','','http://localhost/test/','大嘴蜗牛','大嘴蜗牛','一个优质UGC网站','','dzwn_v1','dzwn_v1','{\"upload_maxsize\":\"2048\",\"upload_allowext\":\"jpg|jpeg|gif|bmp|png|doc|docx|xls|xlsx|ppt|pptx|pdf|txt|rar|zip|swf\",\"watermark_enable\":\"1\",\"watermark_minwidth\":\"300\",\"watermark_minheight\":\"300\",\"watermark_img\":\"statics\\/images\\/water\\/\\/mark.png\",\"watermark_pct\":\"85\",\"watermark_quality\":\"80\",\"watermark_pos\":\"9\"}','6df16bc5-03fc-11e8-8f26-00245427aa68');

DROP TABLE IF EXISTS `v9_sms_report`;
CREATE TABLE `v9_sms_report` (
  `id` bigint(15) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(11) NOT NULL,
  `posttime` int(10) unsigned NOT NULL DEFAULT '0',
  `id_code` varchar(10) NOT NULL,
  `msg` varchar(90) NOT NULL,
  `send_userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `return_id` varchar(30) NOT NULL,
  `ip` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mobile` (`mobile`,`posttime`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

INSERT INTO `v9_sms_report` VALUES('1','18610062316','1562673599','284527','284527','0','0','0','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('2','18610062316','1562673746','284527','284527','0','5','5','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('3','18610062316','1562673637','284527','284527','0','5','5','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('4','18610062316','1562674204','284527','284527','0','0','0','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('5','18610062316','1562843394','610570','610570','0','0','0','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('6','18610062316','1562844604','037994','037994','0','0','0','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('7','18610062316','1562846115','373317','373317','0','0','0','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('8','18610062316','1562848278','579937','579937','0','0','0','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('9','18610062316','1565424084','901402','901402','0','5','5','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('10','18610062316','1565425406','442349','442349','0','5','5','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('11','18610062316','1565426341','068940','068940','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('12','18610062316','1565426416','068940','068940','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('13','18610062316','1565581968','974842','974842','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('14','18610062316','1565582279','974842','974842','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('15','18610062316','1565608390','','121782','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('16','18610062316','1565608516','','839164','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('17','18610062316','1567080631','992241','992241','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('18','18610062316','1567080668','992241','992241','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('19','18610062316','1567301934','','237399','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('20','18610062316','1567305721','','382182','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('21','18610062316','1567306205','751892','751892','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('22','18610062316','1567307021','','935444','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('23','18610062316','1567433689','829404','829404','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('24','18610062316','1567434120','829404','829404','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('25','18610062316','1567434450','829404','829404','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('26','18610062316','1567435272','738018','738018','0','0','','127.0.0.1');
INSERT INTO `v9_sms_report` VALUES('27','18610062316','1569508103','243598','243598','0','0','','127.0.0.1');

DROP TABLE IF EXISTS `v9_special`;
CREATE TABLE `v9_special` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `aid` int(10) unsigned NOT NULL DEFAULT '0',
  `title` char(60) NOT NULL,
  `typeids` char(100) NOT NULL,
  `thumb` char(100) NOT NULL,
  `banner` char(100) NOT NULL,
  `description` char(255) NOT NULL,
  `url` char(100) NOT NULL,
  `ishtml` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ispage` tinyint(1) unsigned NOT NULL,
  `filename` char(40) NOT NULL,
  `pics` char(100) NOT NULL,
  `voteid` char(60) NOT NULL,
  `style` char(20) NOT NULL,
  `index_template` char(40) NOT NULL,
  `list_template` char(40) NOT NULL,
  `show_template` char(60) NOT NULL,
  `css` text NOT NULL,
  `username` char(40) NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `listorder` smallint(5) unsigned NOT NULL,
  `elite` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isvideo` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `disabled` (`disabled`,`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_special_c_data`;
CREATE TABLE `v9_special_c_data` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `author` varchar(40) NOT NULL,
  `content` text NOT NULL,
  `paginationtype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `maxcharperpage` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `style` char(20) NOT NULL,
  `show_template` varchar(30) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_special_content`;
CREATE TABLE `v9_special_content` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `specialid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `title` char(80) NOT NULL,
  `style` char(24) NOT NULL,
  `typeid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `thumb` char(100) NOT NULL,
  `keywords` char(40) NOT NULL,
  `description` char(255) NOT NULL,
  `url` char(100) NOT NULL,
  `curl` char(15) NOT NULL,
  `listorder` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  `searchid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isdata` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `videoid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `specialid` (`specialid`,`typeid`,`isdata`),
  KEY `typeid` (`typeid`,`isdata`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_sphinx_counter`;
CREATE TABLE `v9_sphinx_counter` (
  `counter_id` int(11) unsigned NOT NULL,
  `max_doc_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`counter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_sso_admin`;
CREATE TABLE `v9_sso_admin` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `username` char(20) NOT NULL,
  `password` char(32) NOT NULL,
  `encrypt` char(6) DEFAULT NULL,
  `issuper` tinyint(1) DEFAULT '0',
  `lastlogin` int(10) DEFAULT NULL,
  `ip` char(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `v9_sso_admin` VALUES('1','admin','2950c02e403ad7eb2a68efc8c39d3e55','dVGd4Y','1','1567435106','127.0.0.1');

DROP TABLE IF EXISTS `v9_sso_applications`;
CREATE TABLE `v9_sso_applications` (
  `appid` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `type` char(16) NOT NULL DEFAULT '',
  `name` char(20) NOT NULL DEFAULT '',
  `url` char(255) NOT NULL DEFAULT '',
  `authkey` char(255) NOT NULL DEFAULT '',
  `ip` char(15) NOT NULL DEFAULT '',
  `apifilename` char(30) NOT NULL DEFAULT 'phpsso.php',
  `charset` char(8) NOT NULL DEFAULT '',
  `synlogin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`appid`),
  KEY `synlogin` (`synlogin`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `v9_sso_applications` VALUES('1','phpcms_v9','phpcms v9','http://localhost/ambulance/','SPd8zCLfQS96IEFE4FgZ91Lh2IHw2Dl9','','api.php?op=phpsso','utf-8','1');

DROP TABLE IF EXISTS `v9_sso_members`;
CREATE TABLE `v9_sso_members` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(20) NOT NULL DEFAULT '',
  `password` char(32) NOT NULL DEFAULT '',
  `random` char(8) NOT NULL DEFAULT '',
  `email` char(32) NOT NULL DEFAULT '',
  `regip` char(15) NOT NULL DEFAULT '',
  `regdate` int(10) unsigned NOT NULL DEFAULT '0',
  `lastip` char(15) NOT NULL DEFAULT '0',
  `lastdate` int(10) unsigned NOT NULL DEFAULT '0',
  `appname` char(15) NOT NULL,
  `type` enum('app','connect') DEFAULT NULL,
  `avatar` tinyint(1) NOT NULL DEFAULT '0',
  `ucuserid` mediumint(8) unsigned DEFAULT '0',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`),
  KEY `email` (`email`),
  KEY `ucuserid` (`ucuserid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `v9_sso_members` VALUES('1','123','b3c9b7b6630e9449f5055be067a63ff1','x63AAD','844800670@qq.com','127.0.0.1','1562491890','127.0.0.1','1569759434','phpcms v9','app','0','0');

DROP TABLE IF EXISTS `v9_sso_messagequeue`;
CREATE TABLE `v9_sso_messagequeue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `operation` char(32) NOT NULL,
  `succeed` tinyint(1) NOT NULL DEFAULT '0',
  `totalnum` smallint(6) unsigned NOT NULL DEFAULT '0',
  `noticedata` mediumtext NOT NULL,
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  `appstatus` mediumtext,
  PRIMARY KEY (`id`),
  KEY `dateline` (`dateline`),
  KEY `succeed` (`succeed`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `v9_sso_messagequeue` VALUES('1','member_add','0','1','{\"username\":\"123\",\"password\":\"b3c9b7b6630e9449f5055be067a63ff1\",\"email\":\"844800670@qq.com\",\"regip\":\"127.0.0.1\",\"regdate\":\"1562491890\",\"lastdate\":\"1562491890\",\"appname\":\"phpcms v9\",\"type\":\"app\",\"random\":\"x63AAD\",\"ucuserid\":\"0\",\"uid\":\"1\",\"action\":\"member_add\"}','1562491890','{\"1\":1}');

DROP TABLE IF EXISTS `v9_sso_session`;
CREATE TABLE `v9_sso_session` (
  `sessionid` char(32) NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ip` char(15) NOT NULL,
  `lastvisit` int(10) unsigned NOT NULL DEFAULT '0',
  `roleid` tinyint(3) unsigned DEFAULT '0',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `m` char(20) NOT NULL,
  `c` char(20) NOT NULL,
  `a` char(20) NOT NULL,
  `data` char(255) NOT NULL,
  PRIMARY KEY (`sessionid`),
  KEY `lastvisit` (`lastvisit`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_sso_settings`;
CREATE TABLE `v9_sso_settings` (
  `name` varchar(32) NOT NULL DEFAULT '',
  `data` text NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_sso_settings` VALUES('denyemail','');
INSERT INTO `v9_sso_settings` VALUES('denyusername','');
INSERT INTO `v9_sso_settings` VALUES('creditrate','');
INSERT INTO `v9_sso_settings` VALUES('sp4','');
INSERT INTO `v9_sso_settings` VALUES('ucenter','');

DROP TABLE IF EXISTS `v9_tag`;
CREATE TABLE `v9_tag` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `tag` text NOT NULL,
  `name` char(40) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `module` char(20) NOT NULL,
  `action` char(20) NOT NULL,
  `data` text NOT NULL,
  `page` char(15) NOT NULL,
  `return` char(20) NOT NULL,
  `cache` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `num` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `v9_tag` VALUES('1','1','{pc:content action=\"lists\" catid=\"13\" order=\"updatetime DESC\" thumb=\"1\" moreinfo=\"1\"  num=\"4\" }\n{loop $data $n $r}\n<li><a href=\"{$r[\'url\']}\" title=\"{$r[\'title\']}\">{$r[\'title\']}</a></li>\n{/loop}\n{/pc}','littleCourt','0','content','lists','{\"catid\":\"13\",\"order\":\"updatetime DESC\",\"thumb\":\"1\",\"moreinfo\":\"1\"}','','','0','4');
INSERT INTO `v9_tag` VALUES('2','1','{pc:content action=\"position\" posid=\"1\" catid=\"13\" thumb=\"\" order=\"id DESC\"  num=\"4\" }\n{loop $data $n $r}\n<li><a href=\"{$r[\'url\']}\" title=\"{$r[\'title\']}\">{$r[\'title\']}</a></li>\n{/loop}\n{/pc}','littleCourt1','0','content','position','{\"posid\":\"1\",\"catid\":\"13\",\"thumb\":\"\",\"order\":\"id DESC\"}','','','0','4');

DROP TABLE IF EXISTS `v9_template_bak`;
CREATE TABLE `v9_template_bak` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `creat_at` int(10) unsigned DEFAULT '0',
  `fileid` char(50) DEFAULT NULL,
  `userid` mediumint(8) DEFAULT NULL,
  `username` char(20) DEFAULT NULL,
  `template` text,
  PRIMARY KEY (`id`),
  KEY `fileid` (`fileid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `v9_template_bak` VALUES('1','1517716474','ambulance_content_list.html','1','admin','{template \"content\",\"header\"}\r\n		<div class=\"row\">\r\n			<div class=\"col-md-4\">\r\n				<br/>\r\n				<div class=\"list-group\">\r\n					<a href=\"#\" class=\"list-group-item active\">Cras justo odio</a>\r\n					<a href=\"#\" class=\"list-group-item\">Dapibus ac facilisis in</a>\r\n					<a href=\"#\" class=\"list-group-item\">Morbi leo risus</a>\r\n					<a href=\"#\" class=\"list-group-item\">Porta ac consectetur ac</a>\r\n					<a href=\"#\" class=\"list-group-item\">Vestibulum at eros</a>\r\n					<a href=\"#\" class=\"list-group-item\">Cras justo odio</a>\r\n				</div>\r\n				<!--\r\n				<br/>\r\n				<div class=\"list-group\">\r\n					<a href=\"#\" class=\"list-group-item active\">Cras justo odio</a>\r\n					<a href=\"#\" class=\"list-group-item\">Dapibus ac facilisis in</a>\r\n					<a href=\"#\" class=\"list-group-item\">Morbi leo risus</a>\r\n					<a href=\"#\" class=\"list-group-item\">Porta ac consectetur ac</a>\r\n					<a href=\"#\" class=\"list-group-item\">Vestibulum at eros</a>\r\n				</div>\r\n				-->\r\n			</div>\r\n		    <div class=\"col-md-8\">\r\n				<br/>\r\n				{pc:content action=\"lists\" catid=\"$catid\" num=\"25\" order=\"id DESC\" page=\"$page\"}\r\n				<ul class=\"list-group\">\r\n					<li class=\"list-group-item\" style=\"background-color:#27B;\"><a href=\"#\" style=\"color:white\"><b>Cras justo odio</b></a></li>\r\n					{loop $data $r}\r\n					<li class=\"list-group-item\"><a href=\"{$r[url]}\" target=\"_blank\"{title_style($r[style])}> {$r[title]}</a></li>\r\n					{/loop}\r\n				</ul>\r\n				{/pc}\r\n		    </div>\r\n		</div>\r\n{template \"content\",\"footer\"}');
INSERT INTO `v9_template_bak` VALUES('2','1517740690','ambulance_content_index.html','1','admin','{template \"content\",\"header\"}\r\n		<div class=\"row\">\r\n		    <div class=\"col-md-12\">\r\n			    <div id=\"carousel-example-generic\" class=\"carousel slide\" data-ride=\"carousel\">\r\n			        <!-- 轮播（Carousel）指标 -->\r\n			        <ol class=\"carousel-indicators\">\r\n					<li data-target=\"#carousel-example-generic\" data-slide-to=\"0\" class=\"active\"></li>\r\n					<li data-target=\"#carousel-example-generic\" data-slide-to=\"1\"></li>\r\n					<li data-target=\"#carousel-example-generic\" data-slide-to=\"2\"></li>\r\n					<li data-target=\"#carousel-example-generic\" data-slide-to=\"3\"></li>\r\n				</ol>\r\n\r\n				<!-- 轮播（Carousel）项目内容 -->\r\n				{pc:content  action=\"position\" posid=\"1\"  order=\"listorder DESC\" num=\"5\"}\r\n				<div class=\"carousel-inner\" role=\"listbox\">\r\n					<!-- 默认显示图片 -->\r\n					{loop $data $r}\r\n					<div class=\"item\" style=\"text-align:center\">\r\n						<img src=\"{thumb($r[\'thumb\'],1920,600)}\" alt=\"救护车1\">\r\n					 <!-- 图片描述内容 -->\r\n						<div class=\"carousel-caption\">\r\n							{str_cut($r[\'title\'],30)}\r\n						</div>\r\n					</div>\r\n					{/loop}\r\n				</div>\r\n				{/pc}\r\n			  \r\n				<!-- 轮播（Carousel）导航(控制左右移动) -->\r\n				<a class=\"left carousel-control\" href=\"#carousel-example-generic\" role=\"button\" data-slide=\"prev\">\r\n					<span class=\"glyphicon glyphicon-chevron-left\"></span>\r\n					<span class=\"sr-only\">Previous</span>\r\n				</a>\r\n				<a class=\"right carousel-control\" href=\"#carousel-example-generic\" role=\"button\" data-slide=\"next\">\r\n					<span class=\"glyphicon glyphicon-chevron-right\"></span>\r\n					<span class=\"sr-only\">Next</span>\r\n				</a>\r\n			</div>	  \r\n		</div>\r\n		</div>\r\n		<div class=\"row\">\r\n			{loop subcat(0,0,0,$siteid) $r}\r\n			{if $r[catid]==6}\r\n			<div class=\"col-md-4\">\r\n				<br/>\r\n				<div class=\"list-group\">\r\n					<a href=\"{$r[url]}\" class=\"list-group-item active\">{$r[catname]}&nbsp;&nbsp;&nbsp;&nbsp;更多>></a>\r\n					{pc:content  action=\"lists\" catid=\"$r[catid]\" order=\"id DESC\" page=\"$page\" num=\"25\" return=\"info\"}\r\n					{loop $info $v}\r\n					<a href=\"{$v[\'url\']}\" class=\"list-group-item\">{str_cut($v[\'title\'],28)}</a>\r\n					{/loop}\r\n					{/pc}\r\n				</div>\r\n				<br/>\r\n			</div>\r\n			{/if}\r\n			{if $r[catid]==8}\r\n		    <div class=\"col-md-8\">\r\n				<br/>\r\n				<div class=\"col-md-12 col-xs-12\" style=\"background-color:#27B;\">\r\n					<h5 style=\"color:#FFF;\">产品列表&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"{$r[url]}\" style=\"white\">更多>></a></h5>\r\n				</div>\r\n				<div class=\"row\">\r\n					{pc:content  action=\"lists\" catid=\"$r[catid]\" order=\"id DESC\" page=\"$page\" num=\"25\" return=\"info\"}\r\n					{loop $info $v}\r\n					<div class=\"col-xs-6 col-md-3\">\r\n						<a href=\"{$v[\'url\']}\" class=\"thumbnail\">\r\n						  <img src=\"{thumb($v[thumb],90,0)}\" alt=\"...\">\r\n						</a>\r\n					</div>\r\n					{/loop}\r\n					{/pc}\r\n				</div>\r\n		    </div>\r\n			{/if}\r\n			{/loop}\r\n		</div>\r\n{template \"content\",\"footer\"}		');

DROP TABLE IF EXISTS `v9_times`;
CREATE TABLE `v9_times` (
  `username` char(40) NOT NULL,
  `ip` char(15) NOT NULL,
  `logintime` int(10) unsigned NOT NULL DEFAULT '0',
  `isadmin` tinyint(1) NOT NULL DEFAULT '0',
  `times` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`,`isadmin`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_type`;
CREATE TABLE `v9_type` (
  `typeid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `module` char(15) NOT NULL,
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` char(30) NOT NULL,
  `parentid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typedir` char(20) NOT NULL,
  `url` char(100) NOT NULL,
  `template` char(30) NOT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`typeid`),
  KEY `module` (`module`,`parentid`,`siteid`,`listorder`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

INSERT INTO `v9_type` VALUES('52','1','search','0','专题','0','special','','','4','专题');
INSERT INTO `v9_type` VALUES('1','1','search','1','新闻','0','','','','1','新闻模型搜索');
INSERT INTO `v9_type` VALUES('2','1','search','2','下载','0','','','','3','下载模型搜索');
INSERT INTO `v9_type` VALUES('3','1','search','3','图片','0','','','','2','图片模型搜索');
INSERT INTO `v9_type` VALUES('53','1','search','12','直播模型','0','','','','0','');
INSERT INTO `v9_type` VALUES('54','1','content','0','友情大类','0','','','','0','测试用');

DROP TABLE IF EXISTS `v9_urlrule`;
CREATE TABLE `v9_urlrule` (
  `urlruleid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(15) NOT NULL,
  `file` varchar(20) NOT NULL,
  `ishtml` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `urlrule` varchar(255) NOT NULL,
  `example` varchar(255) NOT NULL,
  PRIMARY KEY (`urlruleid`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

INSERT INTO `v9_urlrule` VALUES('1','content','category','1','{$categorydir}{$catdir}/index.html|{$categorydir}{$catdir}/{$page}.html','news/china/1000.html');
INSERT INTO `v9_urlrule` VALUES('6','content','category','0','index.php?m=content&c=index&a=lists&catid={$catid}|index.php?m=content&c=index&a=lists&catid={$catid}&page={$page}','index.php?m=content&c=index&a=lists&catid=1&page=1');
INSERT INTO `v9_urlrule` VALUES('11','content','show','1','{$year}/{$catdir}_{$month}{$day}/{$id}.html|{$year}/{$catdir}_{$month}{$day}/{$id}_{$page}.html','2010/catdir_0720/1_2.html');
INSERT INTO `v9_urlrule` VALUES('12','content','show','1','{$categorydir}{$catdir}/{$year}/{$month}{$day}/{$id}.html|{$categorydir}{$catdir}/{$year}/{$month}{$day}/{$id}_{$page}.html','it/product/2010/0720/1_2.html');
INSERT INTO `v9_urlrule` VALUES('16','content','show','0','index.php?m=content&c=index&a=show&catid={$catid}&id={$id}|index.php?m=content&c=index&a=show&catid={$catid}&id={$id}&page={$page}','index.php?m=content&c=index&a=show&catid=1&id=1');
INSERT INTO `v9_urlrule` VALUES('17','content','show','0','show-{$catid}-{$id}-{$page}.html','show-1-2-1.html');
INSERT INTO `v9_urlrule` VALUES('18','content','show','0','content-{$catid}-{$id}-{$page}.html','content-1-2-1.html');
INSERT INTO `v9_urlrule` VALUES('30','content','category','0','list-{$catid}-{$page}.html','list-1-1.html');

DROP TABLE IF EXISTS `v9_video`;
CREATE TABLE `v9_video` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` char(80) NOT NULL DEFAULT '',
  `style` char(24) NOT NULL DEFAULT '',
  `thumb` char(100) NOT NULL DEFAULT '',
  `keywords` char(40) NOT NULL DEFAULT '',
  `description` char(255) NOT NULL DEFAULT '',
  `posids` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `url` char(100) NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `sysadd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `username` char(20) NOT NULL,
  `inputtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  `vision` varchar(255) NOT NULL DEFAULT '',
  `video_category` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_video_content`;
CREATE TABLE `v9_video_content` (
  `contentid` int(10) unsigned NOT NULL DEFAULT '0',
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `videoid` int(10) unsigned NOT NULL DEFAULT '0',
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  KEY `videoid` (`videoid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_video_data`;
CREATE TABLE `v9_video_data` (
  `id` mediumint(8) unsigned DEFAULT '0',
  `content` text NOT NULL,
  `readpoint` smallint(5) unsigned NOT NULL DEFAULT '0',
  `groupids_view` varchar(100) NOT NULL,
  `paginationtype` tinyint(1) NOT NULL,
  `maxcharperpage` mediumint(6) NOT NULL,
  `template` varchar(30) NOT NULL,
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allow_comment` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `relation` varchar(255) NOT NULL DEFAULT '',
  `video` tinyint(3) unsigned NOT NULL DEFAULT '0',
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_video_store`;
CREATE TABLE `v9_video_store` (
  `videoid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(60) NOT NULL,
  `vid` char(40) NOT NULL,
  `keywords` char(40) NOT NULL,
  `description` char(255) NOT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '0',
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `picpath` char(120) NOT NULL,
  `size` char(20) NOT NULL,
  `timelen` mediumint(9) NOT NULL DEFAULT '0',
  `userupload` tinyint(1) NOT NULL DEFAULT '0',
  `channelid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`videoid`),
  KEY `videoid` (`videoid`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_vote_data`;
CREATE TABLE `v9_vote_data` (
  `userid` mediumint(8) unsigned DEFAULT '0',
  `username` char(20) NOT NULL,
  `subjectid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `ip` char(15) NOT NULL,
  `data` text NOT NULL,
  `userinfo` text NOT NULL,
  KEY `subjectid` (`subjectid`),
  KEY `userid` (`userid`),
  KEY `ip` (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_vote_option`;
CREATE TABLE `v9_vote_option` (
  `optionid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned DEFAULT '0',
  `subjectid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `option` varchar(255) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `listorder` tinyint(2) unsigned DEFAULT '0',
  PRIMARY KEY (`optionid`),
  KEY `subjectid` (`subjectid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_vote_subject`;
CREATE TABLE `v9_vote_subject` (
  `subjectid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned DEFAULT '0',
  `subject` char(255) NOT NULL,
  `ismultiple` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ischeckbox` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `credit` smallint(5) unsigned NOT NULL DEFAULT '0',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `fromdate` date NOT NULL DEFAULT '0000-00-00',
  `todate` date NOT NULL DEFAULT '0000-00-00',
  `interval` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `template` char(20) NOT NULL,
  `description` text NOT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `allowguest` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `maxval` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `minval` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `allowview` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `optionnumber` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `votenumber` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`subjectid`),
  KEY `enabled` (`enabled`),
  KEY `fromdate` (`fromdate`,`todate`),
  KEY `todate` (`todate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_wap`;
CREATE TABLE `v9_wap` (
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '1',
  `sitename` char(30) NOT NULL,
  `logo` char(100) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL,
  `setting` mediumtext,
  `status` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`siteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `v9_wap` VALUES('1','PHPCMS手机门户','/statics/images/wap/wlogo.gif','','array (\n  \'listnum\' => \'10\',\n  \'thumb_w\' => \'220\',\n  \'thumb_h\' => \'0\',\n  \'c_num\' => \'1000\',\n  \'index_template\' => \'index\',\n  \'category_template\' => \'category\',\n  \'list_template\' => \'list\',\n  \'show_template\' => \'show\',\n)','0');

DROP TABLE IF EXISTS `v9_wap_type`;
CREATE TABLE `v9_wap_type` (
  `typeid` smallint(5) NOT NULL AUTO_INCREMENT,
  `cat` smallint(5) NOT NULL,
  `parentid` smallint(5) NOT NULL,
  `typename` varchar(30) NOT NULL,
  `siteid` smallint(5) NOT NULL,
  `listorder` smallint(5) DEFAULT '0',
  PRIMARY KEY (`typeid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `v9_workflow`;
CREATE TABLE `v9_workflow` (
  `workflowid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `siteid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `steps` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `workname` varchar(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `setting` text NOT NULL,
  `flag` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`workflowid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `v9_workflow` VALUES('1','1','1','一级审核','审核一次','','0');
INSERT INTO `v9_workflow` VALUES('2','1','2','二级审核','审核两次','','0');
INSERT INTO `v9_workflow` VALUES('3','1','3','三级审核','审核三次','','0');
INSERT INTO `v9_workflow` VALUES('4','1','4','四级审核','四级审核','','0');

