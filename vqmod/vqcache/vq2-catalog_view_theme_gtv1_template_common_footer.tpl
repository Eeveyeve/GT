

<?php echo $aff_script; ?>

<div id="footer">
  <div class="commfooter">
    <div class="left"><img src="catalog/view/theme/gtv1/image/cm-icon-big.png" alt="Community" style="width:51px;height:70px;"></div>
    <div class="right">
      <strong>Community</strong>
      <p>Join our Live Community to<br />
      get Support and information.</p>
    </div>
    <div style="clear:both;"></div>
  </div>
  <div class="twitterfooter">
    <div class="left"><img src="catalog/view/theme/gtv1/image/twitter-icon-big.png" alt="Twitter" style="width:73px;height:60px;"></div>
    <div class="right">
      <p>Talk and Tweet about deals<br />
      that you want!</p>
      <a href="https://twitter.com/gogamingtitans" class="twitter-follow-button" data-show-count="false">Follow @gogamingtitans</a>
      <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
    </div>
    <div style="clear:both;"></div>
  </div>
  <div class="facebookfooter">
    <div class="left"><img src="catalog/view/theme/gtv1/image/fb-icon-big.png" alt="Facebook" style="width:33px;height:70px;"></div>
    <div class="right">
      <p>Stay updated with the<br />
      <b>Best Deals and Promotions!</b></p>
      <div class="fb-like" data-href="https://www.facebook.com/gamingtitans?ref=hl#" data-send="true" data-layout="button_count" data-width="300" data-show-faces="false"></div>
    </div>
    <div style="clear:both;"></div>
  </div>
  <div id="footerline">
    <div class="column">
      <h4>New Releases</h4>
      <!--<?php if ($informations) { ?>
      <?php foreach ($informations as $information) { ?><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a><?php } ?>
      <?php } ?>-->
      <?php if ($newreleases) { ?>
        <?php foreach ($newreleases as $newrelease) { ?>
          <a href="<?php echo $newrelease['href']; ?>" id="<?php echo $newrelease['product_id']; ?>"><?php echo $newrelease['name']; ?></a>
        <?php } ?>
      <?php } ?>
    </div>
    <div class="column">
      <h4>Bestsellers</h4>
      <?php if ($bestsellers) { ?>
        <?php foreach ($bestsellers as $bestseller) { ?>
          <a href="<?php echo $bestseller['href']; ?>" id="<?php echo $bestseller['product_id']; ?>"><?php echo $bestseller['name']; ?></a>
        <?php } ?>
      <?php } ?>
    </div>
    <!--<div class="column">
      <h4>Platforms</h4>
      <?php if ($manufacturers) { ?>
        <?php foreach ($manufacturers as $manufacturer) { ?>
          <a href="" id="<?php echo $manufacturer['manufacturer_id']; ?>"><?php echo $manufacturer['name']; ?></a>
        <?php } ?>
      <?php } ?>
    </div>
    <div class="column">
      <h4>Categories</h4>
      <?php if ($categories) { ?>
        <?php foreach ($categories as $category) { ?>
          <a href="" id="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></a>
        <?php } ?>
      <?php } ?>
    </div>-->
    <div class="column">
      <h4>Publishers</h4>
      <p>Electronic Arts</p>
      <p>Blizzard / Activition</p>
      <p>UbiSoft</p>
      <p>Square Enix</p>
      <p>2K</p>
      <p>Bethesda</p>
      <p>SEGA</p>
    </div>
    <div class="column">
      <h4> </h4>
      <p>Paradox</p>
      <p>Warner Brothers</p>
      <p>Nordic Games</p>
      <p>TAKE 2 Interactive</p>
      <p>Konami</p>
    </div>
    <div class="column">
      <h4>Help</h4>
      <a href="<?php echo $resolution; ?>"><?php echo $text_resolution; ?></a>
      <a href="<?php echo $community; ?>"><?php echo $text_community; ?></a>
      <a href="<?php echo $live_support; ?>"><?php echo $text_live_support; ?></a>
      <a href="<?php echo $faq; ?>"><?php echo $text_delivery; ?></a>
    </div>
    <div class="column">
      <h4>Information</h4>
      <a href="<?php echo $about; ?>#1" class="infofooterhash" id="1"><?php echo $text_about; ?></a>
      <a href="<?php echo $about; ?>#2" class="infofooterhash" id="2"><?php echo $text_privacy; ?></a>
      <a href="<?php echo $about; ?>#3" class="infofooterhash" id="3"><?php echo $text_conditions; ?></a>
      <a href="<?php echo $reseller; ?>"><?php echo $text_reseller; ?></a>
      <a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a>
      <a style="display:none;" href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a>
    </div>
    <div style="clear:both;"></div>
  </div>
  <div id="footersecure">
    <span>We accept the following payment methods <img style="height:30px;position:relative;top:10px;left:10px;" src="catalog/view/theme/gtv1/image/cc-footer.png" /></span>
  </div>
  <p id="footerbot"><em style="display:none;"></em><?php echo $text_copyright; ?></p>
</div>
</div>
<div id="loadingoverlap"></div>
</body></html>