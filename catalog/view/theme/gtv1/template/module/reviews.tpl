<div class="side-infobox reviews-box">
  <?php if ($header) {?>
  <h4><?php echo $header; ?></h4>
  <?}?>
  <div class="side-infobox-reviews">
      <?php foreach ($reviews as $review) { ?>
      <div class="review">
        <?php if ($review['product_id']) {?>
          <?php if ($review['prod_thumb']) { ?>
          <div class="image" style="float:left;"><a href="<?php echo $review['prod_href']; ?>">
            <img src="<?php echo $review['prod_thumb']; ?>" alt="<?php echo $review['prod_name']; ?>" title="<?php echo $review['prod_name']; ?>"/>
          </a></div>
          <?php } ?>          
          <?}?>
      <b><?php echo $review['author']?></b>
      <em><?php echo $review['date_added']; ?></em>
      <span><?php echo $review['description']?> <a href="<?php echo $review['href']?>">&raquo;</a></span>
      <div class="rating"><img src="catalog/view/theme/gtv1/image/stars-<?php echo $review['rating']; ?>.png"/></div>
      <div style="clear: both;"></div>
      </div>
      <?php } ?>
  </div>
  <a href="<?php echo $link_all_reviews; ?>" class="side-infobox-content-foot more-reviews"><span><?php echo $text_all_reviews;?></span></a>
</div>
