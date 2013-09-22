<?php echo $header; ?>
<div class="checkoutsteps">
  <ul>
    <li class="step"><a class="active" href="javascript:void(0);" style="cursor:default;">My Shopping Cart</a></li>
    <li class="step"><a href="javascript:void(0);" style="cursor:no-drop;">User Verification</a></li>
    <li class="step"><a href="javascript:void(0);" style="cursor:no-drop;">Payment</a></li>
    <li class="step last"><a href="javascript:void(0);" style="cursor:no-drop;">Confirmation</a></li>
  </ul>
  <div style="clear:both;"></div>
</div>
<div id="wrap" class="checkout-wrap">
  <?php echo $column_left; ?>
  <div id="column-right" class="checkout-sidebar"><?php echo $column_right; ?></div>
  <div id="content" class="content-wrap"><?php echo $content_top; ?>
    <!--<div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
    </div>-->
    <!--<h1 class="floatheading"><?php echo $heading_title; ?></h1>
    <h2 class="underheading"><?php echo $text_error; ?></h2>-->
    <div class="cart-info">
      <table>
        <tbody>
          <tr class="cartproduct">
            <td class="name" colspan="2" style="padding:40px 30px;"><a class="game" href="javascript:void(0);"><?php echo $text_error; ?></a></td>
            <td class="price"><span class="lower"><?php echo $this->currency->format(0); ?>&nbsp;x0</span><br /><?php echo $this->currency->format(0); ?></td>
            <td class="remove"></td>
          </tr>
          <tr class="subtotalrow">
            <td colspan="2" class="subtotalleft">Total</td>
            <td colspan="2" class="subtotalright"><?php echo $this->currency->format(0); ?></td>
          </tr>
        </tbody>
      </table>
    </div>
    <br />
    <div id="checkout-buttons">
      <a href="javascript:void(0);" class="checkout-button roundbutton lotlargerbutton darkgreenbutton" style="float:right;cursor:no-drop;"><img style="width:10px;margin-right:7px;" src="catalog/view/theme/gtv1/image/lock-white.png" /><?php echo $button_checkout; ?></a>
      <a href="<?php echo $continue; ?>" class="checkout-button roundbutton lotlargerbutton darkbluebutton" style="float:left;"><?php echo $button_shopping; ?></a>
      <div style="clear:both;"></div>
    </div>
    <!--<div class="buttons">
      <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
    </div>-->
    <div id="checkout-support">
      <img src="catalog/view/theme/gtv1/image/help.png" />
      <h4>Got questions? We&rsquo;re here for you.</h4>
      <p>Use <a href="<?php echo $this->url->link('information/information', 'information_id=3'); ?>" target="_blank">FAQ,</a> <a href="<?php echo $this->url->link('community/community'); ?>" target="_blank">Community Live Support</a> or <a href="<?php echo $this->url->link('information/contact'); ?>" target="_blank">Email</a> to get answer anytime!</p>
    </div>
    <?php echo $content_bottom; ?>
    <div style="clear:both;"></div>
  </div>
</div>
<script type="text/javascript"><!--
$(document).ready( function() { 
  /*$('#wrap').addClass('clearbg wrapme');
  $('#header').addClass('clearbg wrapme nopaddingheader');
  $('#notification').addClass('wrapme');
  $('.wrapme').wrapAll('<div class="bigwrap"></div>');
  $('.bigwrap').addClass('toppagemargin nopadding');*/
  $('#bgoverlap').hide();
});
//--></script>
<?php echo $footer; ?>