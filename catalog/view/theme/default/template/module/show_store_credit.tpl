<?php if ($this->customer->isLogged() && $this->config->get('credit_status')) { ?>
<?php if ((float)$this->customer->getBalance() <= 0 && $hide_zero) { return; } ?>
<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <div class="box-product">
      <div style="text-align:center; width:100%;margin:auto;" >
        
		<?php echo $text_balance; ?>
		
		<br />
		
		<span style="font-weight:bold;font-size:18px;line-height:40px;"><?php echo $balance; ?></span>
		
		<br />
		
		<span style="font-size:9px;font-style:italic;"><?php echo $text_note; ?></span>
		
      </div>
    </div>
  </div>
</div>
<?php } ?>