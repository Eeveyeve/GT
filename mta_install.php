<?php

/*

create table if not exists mta_scheme (
	mta_scheme_id int(6) unsigned not null auto_increment,
	scheme_name varchar(100) not null default '',
	description text not null,
	max_levels smallint(3) unsigned not null default '1',
	is_default tinyint(1) unsigned not null default '0', 
	all_commissions text not null,	
	all_autoadd text not null,	
	commission_type enum('percentage','fixed') not null default 'percentage',
	before_shipping tinyint(1) unsigned not null default '1',
	eternal smallint(3) unsigned not null default '0',
	signup_code char(13) not null default '',
	primary key (mta_scheme_id),
	unique key (`scheme_name`),
	unique key (`signup_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
create table if not exists mta_scheme_levels (
	mta_scheme_level_id int(8) unsigned not null auto_increment,
	mta_scheme_id int(6) unsigned not null default '1',
	num_levels smallint(3) unsigned not null default '1',	
	level smallint(3) unsigned not null default '1',	
	commission decimal(15,4) NOT NULL DEFAULT '0.0000',
	autoadd smallint(2) unsigned not null default '1',
	primary key (mta_scheme_level_id),
	unique key (mta_scheme_id, num_levels, level),
	CONSTRAINT `mta_scheme_level_ibfk_1` FOREIGN KEY (`mta_scheme_id`) REFERENCES `mta_scheme` (`mta_scheme_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table if not exists mta_autoapprove (
	mta_autoapprove_id int(8) unsigned not null auto_increment,
	mta_scheme_id int(6) unsigned not null default '1',
	signup_level smallint(3) unsigned not null default '1',	
	autoapprove smallint(2) unsigned not null default '1',
	primary key (mta_autoapprove_id),
	unique key (mta_scheme_id, signup_level),
	CONSTRAINT `mta_autoapprove_ibfk_1` FOREIGN KEY (`mta_scheme_id`) REFERENCES `mta_scheme` (`mta_scheme_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create table if not exists mta_affiliate (	
	affiliate_id int(10) unsigned not null default '0',
	mta_scheme_id int(6) unsigned default null,
	parent_affiliate_id int(10) unsigned not null default '0',
	all_parent_ids text not null,		
	level_original smallint(3) unsigned not null default '1',		
	primary key (affiliate_id),
  KEY `FK_mta_scheme_id` (`mta_scheme_id`),
	CONSTRAINT `mta_affiliate_ibfk_1` FOREIGN KEY (`mta_scheme_id`) REFERENCES `mta_scheme` (`mta_scheme_id`) ON DELETE SET NULL ON UPDATE CASCADE  	
) ENGINE=InnoDB DEFAULT CHARSET=utf8;		

create table if not exists mta_product (
	mta_product_id int(11) unsigned NOT NULL auto_increment,
	product_id int(11) unsigned NOT NULL default '0',	
	price_mod_type enum('','coupon','special','discount') not null default '',
	price_mod_id int(11) unsigned NOT NULL default '0',	
	mta_scheme_id int(6) unsigned default null,
	primary key (mta_product_id),
	unique key (product_id, price_mod_type, price_mod_id),
	KEY `FK_mta_product_mta_scheme_id` (`mta_scheme_id`),
	CONSTRAINT `mta_product_ibfk_1` FOREIGN KEY (`mta_scheme_id`) REFERENCES `mta_scheme` (`mta_scheme_id`) ON DELETE CASCADE ON UPDATE CASCADE  	
) ENGINE=InnoDB DEFAULT CHARSET=utf8;	

create table if not exists mta_product_affiliate (
	mta_product_affiliate_id int(10) unsigned not null auto_increment,	
	product_id int(11) unsigned NOT NULL default '0',
	affiliate_id int(10) unsigned not null default '0',
	price_mod_type enum('','coupon','special','discount') not null default '',
	price_mod_id int(11) unsigned NOT NULL default '0',	
	mta_scheme_id int(6) unsigned default null,
	primary key (mta_product_affiliate_id),
	unique key (product_id,affiliate_id,price_mod_type, price_mod_id),
	CONSTRAINT `mta_product_affiliate_ibfk_1` FOREIGN KEY (`affiliate_id`) REFERENCES `mta_affiliate` (`affiliate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `mta_product_affiliate_ibfk_2` FOREIGN KEY (`mta_scheme_id`) REFERENCES `mta_scheme` (`mta_scheme_id`) ON DELETE CASCADE ON UPDATE CASCADE  	
) ENGINE=InnoDB DEFAULT CHARSET=utf8;	

create table if not exists mta_order (
	mta_order_id int(11) unsigned not null auto_increment,		
	order_id int(11) not null default '0',  	
	affiliate_id int(10) unsigned default null,
	commission decimal(15,4) NOT NULL DEFAULT '0.0000',
	commission_added tinyint(1) unsigned not null default '0', 
	autoadd tinyint(1) unsigned not null default '0', 
	primary key (mta_order_id),
	unique key (affiliate_id, order_id),
	CONSTRAINT `mta_order_ibfk_1` FOREIGN KEY (`affiliate_id`) REFERENCES `mta_affiliate` (`affiliate_id`) ON DELETE set null ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;	

create table if not exists mta_order_product (
	mta_order_product_id int(11) unsigned not null auto_increment,		
	mta_order_id int(11) unsigned default null,
	product_id int(11) unsigned NOT NULL default '0',	
	order_product_id int(11) unsigned NOT NULL default '0',	
	affiliate_id int(10) unsigned default null,	
	commission decimal(15,4) NOT NULL DEFAULT '0.0000',
	mta_scheme_id int(6) unsigned default null,
	num_levels smallint(3) unsigned not null default '1',	
	level smallint(3) unsigned not null default '1',
	autoadd tinyint(1) unsigned not null default '0', 
	primary key (mta_order_product_id),
	unique key (affiliate_id, order_product_id),
	KEY `FK_mta_order_id` (`mta_order_id`),
	CONSTRAINT `mta_order_product_ibfk_1` FOREIGN KEY (`mta_order_id`) REFERENCES `mta_order` (`mta_order_id`) ON DELETE CASCADE ON UPDATE CASCADE  	
) ENGINE=InnoDB DEFAULT CHARSET=utf8;	


*/


// Configuration
require_once('config.php');

// Install 
if (!defined('DIR_APPLICATION')) {
	header('Location: ../install/index.php');
	exit;
}

// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Application Classes
require_once(DIR_SYSTEM . 'library/currency.php');
require_once(DIR_SYSTEM . 'library/user.php');
require_once(DIR_SYSTEM . 'library/weight.php');
require_once(DIR_SYSTEM . 'library/length.php');

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Config
$config = new Config();
$registry->set('config', $config);

// Database
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);


$db->query("create table if not exists " . DB_PREFIX . "mta_scheme (
	mta_scheme_id int(6) unsigned not null auto_increment,
	scheme_name varchar(100) not null default '',
	description text not null,
	max_levels smallint(3) unsigned not null default '1',
	is_default tinyint(1) unsigned not null default '0', 
	all_commissions text not null,	
	all_autoadd text not null,	
	commission_type enum('percentage','fixed') not null default 'percentage',
	before_shipping tinyint(1) unsigned not null default '1',
	eternal smallint(3) unsigned not null default '0',
	signup_code char(13) not null default '',
	primary key (mta_scheme_id),
	unique key (`scheme_name`),
	unique key (`signup_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8");
	
$db->query("create table if not exists " . DB_PREFIX . "mta_scheme_levels (
	mta_scheme_level_id int(8) unsigned not null auto_increment,
	mta_scheme_id int(6) unsigned not null default '1',
	num_levels smallint(3) unsigned not null default '1',	
	level smallint(3) unsigned not null default '1',	
	commission decimal(15,4) NOT NULL DEFAULT '0.0000',
	autoadd smallint(2) unsigned not null default '1',
	primary key (mta_scheme_level_id),
	unique key (mta_scheme_id, num_levels, level),
	CONSTRAINT `mta_scheme_level_ibfk_1` FOREIGN KEY (`mta_scheme_id`) REFERENCES `" .  DB_PREFIX . "mta_scheme` (`mta_scheme_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8");

$db->query("create table if not exists " . DB_PREFIX . "mta_autoapprove (
	mta_autoapprove_id int(8) unsigned not null auto_increment,
	mta_scheme_id int(6) unsigned not null default '1',
	signup_level smallint(3) unsigned not null default '1',	
	autoapprove smallint(2) unsigned not null default '1',
	primary key (mta_autoapprove_id),
	unique key (mta_scheme_id, signup_level),
	CONSTRAINT `mta_autoapprove_ibfk_1` FOREIGN KEY (`mta_scheme_id`) REFERENCES `" .  DB_PREFIX . "mta_scheme` (`mta_scheme_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8");


$db->query("create table if not exists " . DB_PREFIX . "mta_affiliate (	
	affiliate_id int(10) unsigned not null default '0',
	mta_scheme_id int(6) unsigned default null,
	parent_affiliate_id int(10) unsigned not null default '0',
	all_parent_ids text not null,		
	level_original smallint(3) unsigned not null default '1',		
	primary key (affiliate_id),
  KEY `FK_mta_scheme_id` (`mta_scheme_id`),
	CONSTRAINT `mta_affiliate_ibfk_1` FOREIGN KEY (`mta_scheme_id`) REFERENCES `" .  DB_PREFIX . "mta_scheme` (`mta_scheme_id`) ON DELETE SET NULL ON UPDATE CASCADE  	
) ENGINE=InnoDB DEFAULT CHARSET=utf8");

$db->query("create table if not exists " . DB_PREFIX . "mta_product (
	mta_product_id int(11) unsigned NOT NULL auto_increment,
	product_id int(11) unsigned NOT NULL default '0',	
	price_mod_type enum('','coupon','special','discount') not null default '',
	price_mod_id int(11) unsigned NOT NULL default '0',	
	mta_scheme_id int(6) unsigned default null,
	primary key (mta_product_id),
	unique key (product_id, price_mod_type, price_mod_id),
	KEY `FK_mta_product_mta_scheme_id` (`mta_scheme_id`),
	CONSTRAINT `mta_product_ibfk_1` FOREIGN KEY (`mta_scheme_id`) REFERENCES `" .  DB_PREFIX . "mta_scheme` (`mta_scheme_id`) ON DELETE CASCADE ON UPDATE CASCADE  	
) ENGINE=InnoDB DEFAULT CHARSET=utf8");

$db->query("create table if not exists " . DB_PREFIX . "mta_product_affiliate (
	mta_product_affiliate_id int(10) unsigned not null auto_increment,	
	product_id int(11) unsigned NOT NULL default '0',
	affiliate_id int(10) unsigned not null default '0',
	price_mod_type enum('','coupon','special','discount') not null default '',
	price_mod_id int(11) unsigned NOT NULL default '0',	
	mta_scheme_id int(6) unsigned default null,
	primary key (mta_product_affiliate_id),
	unique key (product_id,affiliate_id,price_mod_type, price_mod_id),
	CONSTRAINT `mta_product_affiliate_ibfk_1` FOREIGN KEY (`affiliate_id`) REFERENCES `" .  DB_PREFIX . "mta_affiliate` (`affiliate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `mta_product_affiliate_ibfk_2` FOREIGN KEY (`mta_scheme_id`) REFERENCES `" .  DB_PREFIX . "mta_scheme` (`mta_scheme_id`) ON DELETE CASCADE ON UPDATE CASCADE  	
) ENGINE=InnoDB DEFAULT CHARSET=utf8");

$db->query("create table if not exists " . DB_PREFIX . "mta_order (
	mta_order_id int(11) unsigned not null auto_increment,		
	order_id int(11) not null default '0',  	
	affiliate_id int(10) unsigned default null,
	commission decimal(15,4) NOT NULL DEFAULT '0.0000',
	commission_added tinyint(1) unsigned not null default '0', 
	autoadd tinyint(1) unsigned not null default '0', 
	primary key (mta_order_id),
	unique key (affiliate_id, order_id),
	CONSTRAINT `mta_order_ibfk_1` FOREIGN KEY (`affiliate_id`) REFERENCES `" .  DB_PREFIX . "mta_affiliate` (`affiliate_id`) ON DELETE set null ON UPDATE CASCADE  	
) ENGINE=InnoDB DEFAULT CHARSET=utf8");

$db->query("create table if not exists " . DB_PREFIX . "mta_order_product (
	mta_order_product_id int(11) unsigned not null auto_increment,		
	mta_order_id int(11) unsigned default null,
	product_id int(11) unsigned NOT NULL default '0',	
	order_product_id int(11) unsigned NOT NULL default '0',	
	affiliate_id int(10) unsigned default null,	
	commission decimal(15,4) NOT NULL DEFAULT '0.0000',
	mta_scheme_id int(6) unsigned default null,
	num_levels smallint(3) unsigned not null default '1',	
	level smallint(3) unsigned not null default '1',
	autoadd tinyint(1) unsigned not null default '0', 
	primary key (mta_order_product_id),
	unique key (affiliate_id, order_product_id),
	KEY `FK_mta_order_id` (`mta_order_id`),
	CONSTRAINT `mta_order_product_ibfk_1` FOREIGN KEY (`mta_order_id`) REFERENCES `" .  DB_PREFIX . "mta_order` (`mta_order_id`) ON DELETE CASCADE ON UPDATE CASCADE  	
) ENGINE=InnoDB DEFAULT CHARSET=utf8");

try {
	$_hasc = false;
	$res = $db->query("show columns from " . DB_PREFIX . "customer");
	foreach($res->rows as $_r) {
		if($_r['Field'] == 'affiliate_id') {
			$_hasc = true;
			break;
		}		
	}
	if(!$_hasc) $db->query("alter table " . DB_PREFIX . "customer add affiliate_id int(11) unsigned not null default '0'");
	$_res = $db->query("select customer_id, affiliate_id from `" . DB_PREFIX . "order` where affiliate_id > 0 group by customer_id");
	$res = $_res->num_rows > 0 ? $_res->rows : array();
} catch(Exception $_exc) {
	$res = array();
}

foreach($res as $_r) {
	$db->query("update " . DB_PREFIX . "customer set affiliate_id='" . (int) $_r['affiliate_id'] . "' where customer_id='" . (int) $_r['customer_id'] . "'");
}

if(!defined('HTTP_ADMIN') && file_exists('vqmod/install/index.php')) {
	$_vqi = @file_get_contents('vqmod/install/index.php');
	if(preg_match("/u->addFile\('([^\/]+)\/index\.php'\)\;/", $_vqi, $_ar)) define('HTTP_ADMIN', '/' . $_ar[1] . '/');
}

if(defined('HTTP_ADMIN') && preg_match("/\/([^\/]+)\/$/", HTTP_ADMIN, $_ar) && $_ar[1] && $_ar[1] != 'admin') {
	foreach(array('multi_tier_affiliate_system.xml', 'mta_for_simplecheckout', 'mta_for_ubercheckout') as $_f) {
		$_fc = file_get_contents('vqmod/xml/' . $_f);
		$_fp = fopen('vqmod/xml/' . $_f, 'w');
		fwrite($_fp, str_replace('<file name="admin/', '<file name="' . $_ar[1] . '/', $_fc));
		fclose($_fp);
	}
}

if(file_exists(DIR_APPLICATION . 'controller/checkout/checkout_one.php')) {
	if(!file_exists('vqmod/xml/mta_for_ubercheckout.xml')) @copy('vqmod/xml/mta_for_ubercheckout', 'vqmod/xml/mta_for_ubercheckout.xml');
} else if(file_exists('vqmod/xml/mta_for_ubercheckout.xml')) {
	@unlink('vqmod/xml/mta_for_ubercheckout.xml');
}

if(file_exists(DIR_APPLICATION . 'controller/checkout/simplecheckout.php')) {
	if(!file_exists('vqmod/xml/mta_for_simplecheckout.xml')) @copy('vqmod/xml/mta_for_simplecheckout', 'vqmod/xml/mta_for_simplecheckout.xml');
} else if(file_exists('vqmod/xml/mta_for_simplecheckout.xml')) {
	@unlink('vqmod/xml/mta_for_simplecheckout.xml');
}

die('Done!');