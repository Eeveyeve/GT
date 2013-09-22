<?php if ($reviews) { ?>
  <?php foreach ($reviews as $review) { ?>
  <div class="review">
    <div class="image" style="float:left;"><img src="" title="" alt="" id="image" width="80px" height="80px" /></div>          
  <b><?php echo $review['author']?></b>
  <em><?php echo $review['date_added']; ?></em>
  <span><?php echo $review['text']?></span>
  <div class="rating"><img src="catalog/view/theme/gtv1/image/stars-<?php echo $review['rating']; ?>.png"/></div>
  <div style="clear: both;"></div>
  </div>
  <?php } ?>
<?php } else { ?>
  <div class="review">
  <b style="text-align:center;"><?php echo $text_no_reviews; ?></b>
  <div style="clear: both;"></div>
  </div>
<?php } ?>
<script type="text/javascript">
$(document).ready(function() {
  var product_name = $('#product_name').val();
  var product_thumb = $('#product_thumb').val();
	$('.side-infobox-reviews').find('.image img').each(function () {
		$(this).attr('alt', product_name);
    $(this).attr('title', product_name);
    $(this).attr('src', product_thumb);
	});
});
</script>
