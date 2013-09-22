<tr>
  <td><span id="firstname" class="edit edit_firstname whitetext large calibri"><?php echo $firstname; ?></span>&nbsp;
  <span id="lastname" class="edit edit_lastname whitetext large calibri"><?php echo $lastname; ?></span></td>
</tr>
<tr>
  <td><span id="email" class="edit edit_email greytext small calibri"><?php echo $email; ?></span><br /><br /></td>
</tr>
<?php echo $password; ?>
<tr>
  <td><span class="whitetext small calibri"><?php echo $entry_telephone; ?></span>&nbsp;
  <span id="telephone" class="edit edit_telephone greytext small calibri"><?php if($telephone){ echo $telephone;} else{ echo('xxx-xxx-xxx');} ?></span></td>
</tr>
<tr>
  <td><span class="whitetext small calibri"><?php echo $entry_city; ?></span>&nbsp;  
  <span id="city" class="edit edit_city greytext small calibri"><?php if($city){ echo $city;} else{ echo('Your City');} ?></span></td>
</tr>
<tr>
  <td><span class="whitetext small calibri"><?php echo $entry_country; ?></span>&nbsp;
  <form method="post" enctype="multipart/form-data" id="edit_address">  
    <select name="country_id" id="country_id" class="country_id darkinput roundbutton">
        <option value=""><?php echo $text_select; ?></option>
        <?php foreach ($countries as $country) { ?>
        <?php if ($country['country_id'] == $country_id) { ?>
        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </form></td>
</tr>
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=affiliate/edit/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			/*if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'zone_id\']').html(html);
		*/},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country_id\']').trigger('change');
//--></script>