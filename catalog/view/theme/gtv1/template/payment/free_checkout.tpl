<!--<div class="buttons">
  <div class="right">
    <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="button" />
  </div>
</div>
<br />
<div style="float:right;">
<a href="javascript:void(0);" id="button-confirm" class="roundbutton largerbutton darkgreenbutton" style="color:#ffffff;"><?php echo $button_confirm; ?></a>
</div>-->
<script type="text/javascript"><!--
/*$('#button-confirm').bind('click', function() {*/
$(document).ready(function() {
	$.ajax({ 
		type: 'get',
		url: 'index.php?route=payment/free_checkout/confirm',
		success: function() {
			location = '<?php echo $continue; ?>';
		}		
	});
});
//--></script> 
