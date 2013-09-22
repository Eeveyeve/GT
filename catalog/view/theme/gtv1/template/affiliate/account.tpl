<?php echo $header; ?>
<script type="text/javascript" src="catalog/view/theme/gtv1/javascript/jquery.jeditable.js"></script>
<?php if ($success) { ?>
<!--<div class="success"><?php echo $success; ?></div>-->
<?php } ?>
<?php echo $column_left; ?>
<div class="content-block">
  <div class="inner">
    <div class="rsidebar fullheight">
      <div class="darkblock fullheight">
        <div class="inner heading" style="border:0px;">
          <span class="calibri large whitetext emitblue fleft bold"><?php echo $text_in_my_account; ?></span>
          <span class="calibri large whitetext fright bold"><?php echo $total_balance; ?></span>
          <div style="clear:both;"></div>
        </div>
        <div class="inner fullheight">
          <p class="arial small whitetext bold nomargin" id="customer_paypal_email"><?php echo $text_withdraw_to; ?></p>
          <br />
          <form method="post" enctype="multipart/form-data" id="withdraw_form">
            <input type="email" name="paypal_email" placeholder="<?php echo $text_paypal_email; ?>" class="fleft leftbutton darkinput paypal_email" />
              <a href="javascript:Withdraw();" class="greybutton greysubmitbutton rightbutton fleft withdraw" ><?php echo $text_withdraw; ?></a>
            <input type="hidden" value="<?php echo $customer_name; ?>" name="name" />
            <input type="hidden" value="<?php echo $customer_email; ?>" name="email" />
            <input type="hidden" value="<?php echo $customer_id; ?>" name="id" />
            <input type="hidden" value="<?php echo $customer_balance; ?>" name="balance" id="customer_balance" />
            <input type="hidden" value="<?php echo $affiliate_id; ?>" name="affiliate_id" />
            <div style="clear:both;"></div>
          </form>
          <br />
          <p class="arial tiny greytext nomargin">&nbsp;<?php echo $text_under1; ?></p>
          <p class="arial tiny greytext nomargin">&nbsp;<?php echo $text_under2; ?></p>
        </div>      
      </div>      
    </div>
    <div class="content darkblock" id="upcontent">
      <div class="inner imageblock inline-block fleft fullheight" id="imagewrap">
        <img src="http://www.gravatar.com/avatar/<?php echo md5($customer_email); ?>?s=133" alt="profilepicture" />
        <a target="_blank" href="http://www.gravatar.com/">+ <span><?php echo $text_picture; ?></span></a>
      </div>
      <?php echo $content_top; ?>
      <div class="inline-block inner">
        <table id="form_table">
          <?php echo $edit; ?>
        </table>
      </div>
      <div style="clear:both;"></div>      
    </div>
    <div style="clear:both;"></div>  
  </div>
</div>
<br />
<div class="content-block">
  <div class="inner">
    <div class="rsidebar">
      <div class="greybuttonbase" style="display:block;text-align:left;">
        <a href="<?php echo $my_store; ?>" class="greenbutton active"><?php echo $text_my_store; ?></a>
        <a href="<?php echo $my_store; ?>" class="linklist active" ><?php echo $text_dashboard; ?></a>
        <a href="<?php echo $my_account; ?>" class="linklist" ><?php echo $text_back; ?></a>
      </div> 
      <br />
      <?php echo $column_right; ?>      
    </div>
    <div class="content">
      <div class="greybuttonbase affiliate-stats" style="display:block;">
        <div><h2><?php echo $text_orders; ?></h2><p><?php echo $total_transactions; ?></p></div>
        <div><h2><?php echo $text_profit; ?></h2><p><?php echo $text_profitinner; ?></p></div>
        <div><h2><?php echo $text_totalbalance; ?></h2><p><?php echo $total_balance; ?></p></div>
        <div><h2><?php echo $text_totalearnings; ?></h2><p><?php echo $total_earnings; ?></p></div>
      </div>
      <br />
      <div class="affiliate-instructions">
        <h3><?php echo $text_advertise; ?></h3>
        <p><?php echo $text_underadvertise; ?></p>
      </div>
      <?php echo $tracking; ?>
      <br />
      <?php echo $transaction; ?>
      <!--<h1><?php echo $heading_title; ?></h1>
      <h2><?php echo $text_my_account; ?></h2>
      <h2><?php echo $text_my_tracking; ?></h2>
      <h2><?php echo $text_my_transactions; ?></h2>
      <ul>
        <li><a href="<?php echo $edit_account; ?>"><?php echo $text_edit; ?></a></li>
        <li><a href="<?php echo $edit_password; ?>"><?php echo $text_password; ?></a></li>
        <li><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
      </ul>-->
      <?php echo $content_bottom; ?>      
    </div>
    <div style="clear:both;"></div>  
  </div>
</div>
<br /><br /><br />  
<?php echo $footer; ?>
<div style="display:none;" id="adress_block"></div>
<script>
$(document).ready(function() {
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
       cssclass     : 'inline-edit-styling'
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
  
  $(".edit_password").editable(function(value, settings) { 
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
       cssclass     : 'inline-edit-styling'
  });
  
  $(".edit_city").editable(function(value, settings) { 
           $.ajax({
                  url:'<?php echo $edit_account; ?>',
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
      });
  
  $('.country_id').change('changeform', function() {
    $.post('<?php echo $edit_account; ?>', $('#edit_address').serialize());
  });  
  
  $('#bgoverlap').hide();
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
  var upcontheight = $("#upcontent").height();
  $("#imagewrap").height(upcontheight-30);    
});
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