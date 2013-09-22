<div class="drop-login-box">
  <?php if (!$logged) { ?>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
      <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" />
      <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" />
      <input type="submit" value="<?php echo $button_login; ?>" class="regbutton button darkestbluebutton" />
      <a class="forgotten" href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
      <a class="registertext fancylink" href="<?php echo $register; ?>?iframe=1"><?php echo $text_register; ?></a>
      <div class="fbwrap"><a class="fbconnectbutton2" href="<?php echo $fbconnect; ?>"><?php echo $text_connect; ?></a></div>
      <!--<a href="<?php echo $register; ?>?iframe=1" rel="nofollow" class="regbutton rightbutton bluebutton fancylink"><?php echo $text_register; ?></a>-->
      <div style="clear:both;"></div>
    </form> 
  <?php } else { ?>
    <h4><?php echo $text_islogged; ?></h4>
    <div class="side-infobox-login-black">
      <!--<h5><img src="catalog/view/theme/gtv1/image/profile-big-pic.png" alt="profile" style="float:left;width:35px;" />&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $firstname; ?> <?php echo $lastname; ?></h5>-->
      <h5><img src="http://www.gravatar.com/avatar/<?php echo md5($customer_email); ?>?s=35" alt="profile" style="float:left;width:35px;border-radius:3px;" />&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $firstname; ?> <?php echo $lastname; ?><a><a href="<?php echo $logout; ?>"><span>&nbsp;<?php echo $text_logout; ?></span></a></a></h5>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<?php echo $account; ?>"><?php echo $text_account; ?>&nbsp;|&nbsp;</a><a href="<?php echo $account; ?>"><?php echo $text_history; ?></a>
    </div>
    <!--<div class="side-infobox-login">
      <div class="content">
        <a href="<?php echo $mystore; ?>" class="regbutton leftbutton darkestbluebutton"><?php echo $text_mystore; ?></a>
        <a href="<?php echo $howitworks; ?>" class="regbutton rightbutton bluebutton"><?php echo $text_howitworks; ?></a>
        <div style="clear:both;"></div>
      </div>
    </div>-->
    <!--<div class="side-infobox-login-middle">
      <div class="content">
        <a href="<?php echo $account; ?>"><img src="catalog/view/theme/gtv1/image/history-buys.png" alt="history" style="float:left;width:35px;" /><h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $text_history; ?></h5></a>
        <div style="clear:both;"></div>
      </div>
    </div>-->
    <div class="side-infobox-login-bottom">
      <div class="content">
        <h5><?php echo $text_in_my_account; ?>&nbsp;<b><?php echo $show_store_credit; ?></b></h5>
        <!--<?php if($affiliate_logged){ ?>
          <h5><?php echo $text_in_affiliate_account; ?>&nbsp;<?php echo $show_affiliate_credit; ?></h5>  
        <?php }?>-->
      </div>
    </div>
  <?php } ?>
</div>