<!--<div id="content">
  <h1><?php echo $heading_title; ?></h1>
  <p><?php echo $text_description; ?></p>
  <p><?php echo $text_code; ?><br />
    <textarea cols="40" rows="5"><?php echo $code; ?></textarea>
  </p><?php echo $text_generator; ?><?php echo $text_link; ?><br />
    <input type="text" name="product" placeholder="Choose product to promote" value="" />
</div>-->
<div class="affiliate-linkbuilder">
  <h3><?php echo $text_specific; ?></h3><input type="text" name="product" placeholder="<?php echo $text_choose; ?>" value="" />
</div>
<div class="affiliate-linkcurrent">
  <h3><?php echo $text_yourlink; ?></h3><a id="current-link"><?php echo $text_nochoosen; ?></a>
  <div style="clear:both;"></div>
</div>
<div class="affiliate-linkhome">
  <h3><?php echo $text_homepage; ?></h3><a><?php echo $home_track; ?></a>
  <div style="clear:both;"></div>
</div>
<script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=affiliate/tracking/autocomplete&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
        $('.ui-autocomplete').appendTo('.affiliate-linkbuilder').css({
          "left": "175px",
          "top": "40px"
        });		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.link
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'product\']').attr('value', ui.item.label);
		//$('textarea[name=\'link\']').attr('value', ui.item.value);
    $('#current-link').text(ui.item.value).attr('href',ui.item.value);
						
		return false;
	},
	focus: function(event, ui) {
      return false;
   }
});
//--></script>