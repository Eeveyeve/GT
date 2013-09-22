<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/gtv1/stylesheet/stylesheet.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/gtv1/stylesheet/jquery.fancybox-1.3.4.css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<!--<script type="text/javascript" src="catalog/view/javascript/jquery/tabs.js"></script>-->
<script type="text/javascript" src="catalog/view/theme/gtv1/javascript/jquery.fancybox-1.3.4.pack.js"></script>
<script type="text/javascript" src="catalog/view/theme/gtv1/javascript/common.js"></script>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<!--[if IE 7]> 
<link rel="stylesheet" type="text/css" href="catalog/view/theme/gtv1/stylesheet/ie7.css" />
<![endif]-->
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/gtv1/stylesheet/ie6.css" />
<script type="text/javascript" src="catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('#logo img');
</script>
<![endif]-->
<?php if ($stores) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
<?php foreach ($stores as $store) { ?>
$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
<?php } ?>
});
//--></script>        
<?php } ?>
<script>
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
</script>
<?php echo $google_analytics; ?>
<script type="text/javascript">
var homelink = "<?php echo $home; ?>";
</script>
</head>
<body>
<div id="container">
<div id="header">
  <div class="links" id="header-toplinks">
    <?php if (!$logged) { ?>
      <?php echo $text_welcome; ?><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a>
    <?php } else { ?>
      <?php echo $text_logged; ?></a><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
    <?php } ?>
  </div>
  <div class="toper">  
    <div id="fb-root"></div>
    <?php if ($logo) { ?>
    <div id="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" style="height:37px;" /></a></div>
    <?php } ?>
    <?php echo $language; ?>
    <!--<?php echo $currency; ?>-->
    <div id="cartleft">
      <a style="cursor:default;" href="javascript:void(0);"><img align="bottom" src="catalog/view/theme/gtv1/image/verisign-black.png" alt="Verisign" style="width:60px;position:relative;top:3px;"/>&nbsp;&nbsp;<img align="bottom" src="catalog/view/theme/gtv1/image/green-lock.png" alt="Secured" style="height:15px;position:relative;"/></a>
    </div>
    <?php echo $cart; ?>
  </div>  
  <div id="menu" class="menu">
    <ul>
      <!--<li><a class="home-link" href="<?php echo $home; ?>"><span class="home-icon"></span></a></li>-->
      <li><a class="home-link" href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" style="height:14px;" /></a></li>
      <?php if ($categories) { ?>
      <li><a href="javascript:ChangeCategory(0);" class="nonactive"><?php echo $text_catalogue; ?><span class="arrow-categories"></span></a>
        <div class="categories">
          <ul>
            <li><a href="javascript:ChangeCategory(0);" id="0"><?php echo $text_all_categories; ?></a></li>
            <?php foreach ($categories as $category) { ?>
              <li><a href="javascript:ChangeCategory(<?php echo $category['category_id']; ?>,'<?php echo $category['name']; ?>');" id="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></a></li>
              <!--<li><a href="<?php echo $category['href']; ?>" id="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></a></li>-->
            <?php } ?>
          </ul>
        </div>
      </li>
      <?php } ?>
      <li><a href="<?php echo $cst_s; ?>" class="customermark"><?php echo $text_customer_services; ?></a></li>
      <li><a href="<?php echo $community; ?>" class="communitymark"><?php echo $text_community; ?></a></li>
      <?php if (!$logged) { ?>
      <li><a href="<?php echo $login; ?>" class="login-drop nonactive"><?php echo $text_login; ?></a>
        <?php echo $sidebarloginbox; ?>
      </li>
      <?php } else { ?>
      <li><a href="<?php echo $account; ?>" class="accountmark"><img src="http://www.gravatar.com/avatar/<?php echo md5($customer_email); ?>?s=23" alt="profile" style="float:left;margin:-5px 5px 0 -5px;border-radius:3px;" /><!--<img src="catalog/view/theme/gtv1/image/profile-pic-header.png" alt="profile" style="float:left;margin:-5px 5px 0 -5px;" />--><?php echo $firstname; ?>&nbsp;<?php echo $lastname; ?></a></li>
      <?php } ?>
    </ul>
    <a class="greenybutton cartbutton" href="<?php echo $link_cart; ?>"><?php echo $text_mycart; ?></a>
    <div id="search">
      <div class="button-search"></div>
      <input type="text" name="search" placeholder="<?php echo $text_search_in_store; ?>" value="<?php echo $search; ?>" />
    </div>
    <div style="clear:both;"></div>
  </div>  
</div>
<div id="notification"></div>
