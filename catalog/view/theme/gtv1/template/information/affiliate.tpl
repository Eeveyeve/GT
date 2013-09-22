<?php echo $header; ?>
<div id="content">
  <div id="affiliate-explanation">
  
    <div class="boxy">
      <div class="cont black">
        <h1><?php echo $text_heading; ?></h1>
        <h2><?php echo $text_underheading; ?></h2>
      </div>
      <!--<div class="blueline"></div>-->
      <div class="cont">
        <div class="step">
          <img src="catalog/view/theme/gtv1/image/affiliate-explanation/step1.png" alt="<?php echo $text_bubble1; ?>" />
          <p class="first"><?php echo $text_bubble1; ?></p>
        </div>
        <div class="step">
          <img src="catalog/view/theme/gtv1/image/affiliate-explanation/step2.png" alt="<?php echo $text_bubble2; ?>" />
          <p class="first"><?php echo $text_bubble2; ?></p>
        </div>
        <div class="step">
          <img src="catalog/view/theme/gtv1/image/affiliate-explanation/step3.png" alt="<?php echo $text_bubble3; ?>" />
          <p class="first"><?php echo $text_bubble3; ?></p>
        </div>
      </div>
    </div>
    <br />
    
    <div class="middle">
      <h2><?php echo $text_middle; ?></h2>
    </div>  

    <br />
    <div class="boxy">
      <div class="cont" style="padding:30px 15px;">
        <div class="step bot">
          <h3><?php echo $text_colhead1; ?></h3>
          <p><?php echo $text_coltext1; ?></p>
          <p class="est"><?php echo $text_est; ?></p>
          <span><b><?php echo $text_colmoney1; ?></b><strong><?php echo $text_month; ?></strong></span>
          <span><?php echo $text_colunder1; ?></span>
          <a class="greenybutton" href="<?php echo $link_affiliate; ?>#reseller"><?php echo $text_partner; ?></a>
        </div>
        <div class="step bot" style="width:35%;">
          <h3><?php echo $text_colhead2; ?></h3>
          <p><?php echo $text_coltext2; ?></p>
          <p class="est"><?php echo $text_est; ?></p>
          <span><b><?php echo $text_colmoney2; ?></b><strong><?php echo $text_month; ?></strong></span>
          <span><?php echo $text_colunder2; ?></span>
          <a class="greenybutton" href="<?php echo $link_affiliate; ?>#reseller"><?php echo $text_partner; ?></a>
        </div>
        <div class="step bot">
          <h3><?php echo $text_colhead3; ?></h3>
          <p><?php echo $text_coltext3; ?></p>
          <p class="est"><?php echo $text_est; ?></p>
          <span><b><?php echo $text_colmoney3; ?></b><strong><?php echo $text_month; ?></strong></span>
          <span><?php echo $text_colunder3; ?></span>
          <a class="greenybutton" href="<?php echo $link_affiliate; ?>#reseller"><?php echo $text_partner; ?></a>
        </div>
      </div>
    </div>
    
    <!--<div class="heading"><h1><?php echo $heading_title; ?> Troll</h1></div>
    <div class="underheading"><?php echo $description; ?><br />
    </div><br />-->
  </div>
</div>
<script type="text/javascript">
$(document).ready(function () {
  $('#bgoverlap').hide();
});
</script>   
<?php echo $footer; ?>
