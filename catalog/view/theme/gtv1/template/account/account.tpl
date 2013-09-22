<?php echo $header; ?>
<script type="text/javascript" src="catalog/view/theme/gtv1/javascript/jquery.jeditable.js"></script>
<div class="aboveheading">
  <img src="http://www.gravatar.com/avatar/<?php echo md5($customer_email); ?>?s=60" width="60px" height="60px" alt="profilepicture" />
  <h1 class="margtop"><?php echo $customer_name; ?></h1>
  <p class="margbot"><?php echo $customer_email; ?></p>
  <div style="clear:both;"></div>  
</div>
<div id="wrap" class="checkout-wrap">
  <!--<?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>-->
  <div class="black-heading">
    <a class="part active lic" href="javascript:$('a.acc').removeClass('active');$('a.lic').addClass('active');$('#accountinfo').hide();$('#licenses').show();"><?php echo $text_my_profile; ?></a>
    <a class="part acc" href="javascript:$('a.lic').removeClass('active');$('a.acc').addClass('active');$('#licenses').hide();$('#accountinfo').show();"><?php echo $text_my_account; ?></a>
    <div style="clear:both;"></div>
  </div>
  <div id="column-right" class="whity account">
    <h2 class="black"><?php echo $text_in_my_account; ?></h2>
    <h3 class="bgreen"><?php echo $balance; ?></h3>
    <p class="lower" id="customer_paypal_email"><?php echo $text_withdraw_to; ?></p>
    <br />
    <form method="post" enctype="multipart/form-data" id="withdraw_form">
      <input type="email" name="paypal_email" placeholder="<?php echo $text_paypal_email; ?>" class="accinput paypal_email" />
      <a href="javascript:Withdraw();" class="darkestbluebutton withdraw" ><?php echo $text_withdraw; ?></a>
      <input type="hidden" value="<?php echo $customer_name; ?>" name="name" />
      <input type="hidden" value="<?php echo $customer_email; ?>" name="email" />
      <input type="hidden" value="<?php echo $customer_id; ?>" name="id" />
      <input type="hidden" value="<?php echo $customer_balance; ?>" name="balance" id="customer_balance" />
      <div style="clear:both;"></div>
    </form>
    <br />
    <p class="grey">&nbsp;<?php echo $text_under1; ?></p>
    <p class="grey">&nbsp;<?php echo $text_under2; ?></p>
    <br />
    <?php if($affiliate_logged){ ?>
      <!--<div class="greybuttonbase" style="display:block;text-align:left;">
        <a href="<?php echo $my_store; ?>" class="greenbutton"><?php echo $text_my_store; ?></a>
      </div>-->
    <?php } else { ?>
      <a href="<?php echo $link_contact; ?>#reseller" class="sgreen"><?php echo $text_partner; ?></a>
      <a href="<?php echo $affiliate_explanation; ?>" class="low" ><?php echo $text_howitworks; ?></a>
    <?php } ?>  
    <br />
    <!--<div class="greybuttonbase" style="display:block;text-align:left;">
      <a href="<?php echo $my_account; ?>" class="bluelabel"><?php echo $text_my_profile; ?></a>
    </div>
    <br />-->
    <?php echo $column_right; ?>
  </div>
  <div id="content" class="whity account">
    <?php echo $column_left; ?>
        <!--<div class="inner imageblock inline-block fleft fullheight" id="imagewrap">
          <img src="http://www.gravatar.com/avatar/<?php echo md5($customer_email); ?>?s=133" alt="profilepicture" />
          <a target="_blank" href="http://www.gravatar.com/">+ <span><?php echo $text_picture; ?></span></a>
        </div>-->
        <?php echo $content_top; ?>
        <div id="accountinfo">
          <h2><?php echo $heading_title; ?></h2>
          <h4><?php echo $text_edit; ?></h4>
          <br />
          <?php echo $edit; ?>
          <br />
          <br />
          <h2><?php echo $text_my_newsletter; ?></h2>
          <h3><?php echo $text_newsletter; ?></h3>
          <?php echo $newsletter; ?>
          <br />
          <br />
          <br />
          <a href="javascript:SaveAccount();" class="darkestbluebutton savebutton"><?php echo $text_save; ?></a>
        </div>
        <!--<h2><?php echo $text_my_orders; ?></h2>-->
        <div id="licenses">
          <?php echo $order; ?>
        </div>  
        <!--<ul style="display:none;">
          <li><a href="<?php echo $edit_address; ?>"><?php echo $text_address; ?></a></li>
          <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
          <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
          <?php if ($reward) { ?>
          <li><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
          <?php } ?>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
        </ul>-->
        <?php echo $content_bottom; ?>
        <div style="clear:both;"></div>  
      
  </div>
</div>    
<br /><br /><br />  
<?php echo $footer; ?>    
<script type="text/javascript">
$('.accountmark').addClass('active').parent().addClass('active');
function SaveAccount () {
  $('#loadingoverlap').show();
  $.post($('#edit_edit').action, $('#edit_edit').serialize(), function( data ) {
    //$.post(addressupdatelink, $('#city').serialize()+'&'+$('#country_id').serialize(), function( data ) {
      $.post($('#edit_newsletter').action, $('#edit_newsletter').serialize(), function( data ) {
        if ($('#password').val() != "" && $('#confirm').val() != "" && $('#password').val() == $('#confirm').val()) {
          $.post($('#edit_password').action, $('#edit_password').serialize(), function( data ) {
            location.reload();
          });
        } else {
          location.reload();
        }  
      });
    //});
  });
  /*$.post($('#edit_newsletter').action, $('#edit_newsletter').serialize());
  $.post($('#edit_edit').action, $('#edit_edit').serialize());
  $.post($('#edit_address').action, $('#edit_address').serialize());
  if ($('#password').val() != "" && $('#confirm').val() != "" && $('#password').val() == $('#confirm').val()) {
    $.post($('#edit_password').action, $('#edit_password').serialize());
  }
  $('#loadingoverlap').show();
  setTimeout(function(){
   location.reload();
  }, 5000);*/  
}
/*$(document).ready(function() {
  $(".edit_firstname").editable(function(value, settings) { 
       $.ajax({
              url:'<?php echo $edit_account; ?>',
              type:'post',
              data:'firstname='+value
          });
        return value;
    }, { 
       type      : 'text',
       cancel    : 'Cancel',
       submit    : 'OK',
       indicator : 'Saving...',
       cssclass     : 'inline-edit-styling'
  });
  
  $(".edit_lastname").editable(function(value, settings) { 
       $.ajax({
              url:'<?php echo $edit_account; ?>',
              type:'post',
              data:'lastname='+value
          });
        return value;
    }, { 
       type      : 'text',
       cancel    : 'Cancel',
       submit    : 'OK',
       indicator : 'Saving...',
       cssclass     : 'inline-edit-styling'
  });
  
  $(".edit_email").editable(function(value, settings) { 
       $.ajax({
              url:'<?php echo $edit_account; ?>',
              type:'post',
              data:'email='+value
          });
        return value;
    }, { 
       type      : 'text',
       cancel    : 'Cancel',
       submit    : 'OK',
       indicator : 'Saving...',
       cssclass  : 'inline-edit-styling'
  });
  
  $(".edit_telephone").editable(function(value, settings) { 
       $.ajax({
              url:'<?php echo $edit_account; ?>',
              type:'post',
              data:'telephone='+value
          });
        return value;
    }, {
       type      : 'text', 
       cancel    : 'Cancel',
       submit    : 'OK',
       indicator : 'Saving...',
       cssclass     : 'inline-edit-styling'
  });
  
  /*$(".edit_fax").editable(function(value, settings) { 
       $.ajax({
              url:'<?php echo $edit_account; ?>',
              type:'post',
              data:'fax='+value
          });
        return value;
    }, { 
       type      : 'text',
       cancel    : 'Cancel',
       submit    : 'OK',
       indicator : 'Saving...',
       cssclass     : 'inline-edit-styling'
  });*/
  
  /*$(".edit_password").editable(function(value, settings) { 
       if(value != "") {
       $.ajax({
              url:'<?php echo $edit_password; ?>',
              type:'post',
              data:'password='+value
          });
        var result = "*Your New Password*";  
        return result;
    }}, {
       type      : 'text',
       data      : '', 
       cancel    : 'Cancel',
       submit    : 'OK',
       indicator : 'Saving...',
       cssclass  : 'inline-edit-styling'
  });*/
  
  /*$('.edit_newsletter').change('changecheck', function() {
  	$.post('<?php echo $edit_newsletter; ?>', $('#edit_newsletter').serialize());
  });*/

    //var addressupdatelink = $('#address_update_link').val();
    var addressupdatelink = '<?php echo $edit_address; ?>/update&address_id=1';
    //$('#address_block').load(addressupdatelink, function(){
      //var extform = $('#address_block').html();
      //$('#form_table').append(extform);
      /*$(".edit_city").editable(function(value, settings) { 
           $.ajax({
                  url:addressupdatelink,
                  type:'post',
                  data:'city='+value
              });
            return value;
        }, {
           type      : 'text', 
           cancel    : 'Cancel',
           submit    : 'OK',
           indicator : 'Saving...',
           cssclass     : 'inline-edit-styling'
      });*/
      
      /*$('.country_id').change('changeform', function() {
  	    $.post(addressupdatelink, $('#edit_address').serialize());
      });*/
    //}); 
  
  //$('#bgoverlap').hide();
  /*function RewriteCheckboxes() {  
    $('input[type=checkbox]').each(function(){
      var cb = $(this);
      var nm = cb.attr("name");
      nm = "cbmac-"+nm;
      cb.attr("id", nm);
      cb.after($('<label class="css-checkbox" />').attr("for", cb.attr("id")) );
    });
  }*/
  //RewriteCheckboxes();
  /*var upcontheight = $("#upcontent").height();
  $("#imagewrap").height(upcontheight-30);    
});*/
var wasSent = false;
function Withdraw() {
  var serializedwithdraw = $('#withdraw_form').serialize();
  if (wasSent == false && parseFloat($('#customer_balance').val()) >= 30 && $('input[name="paypal_email"]').val() != "") {
    $.ajax({
  		url: 'index.php?route=account/transaction/withdrawBalance',
  		type: 'post',
  		data: serializedwithdraw,
  		dataType: 'json',		
  		beforeSend: function() {
        wasSent = true;
  		},
  		/*complete: function() {
  		},*/
      error: function(json) {
        $('#customer_paypal_email').text('<?php echo $text_toolow; ?>').addClass('emitblue');
      },		
  		success: function(json) {
        if (json['error']) {
          $('#customer_paypal_email').text('<?php echo $text_toolow; ?>').addClass('emitblue');
        } else {
          $('#customer_paypal_email').text('<?php echo $text_request_sent; ?>').addClass('emitblue');
        }
  		}
  	});
  }
}
</script> 
