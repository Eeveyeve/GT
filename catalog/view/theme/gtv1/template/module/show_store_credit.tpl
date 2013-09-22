<?php if ($this->customer->isLogged() && $this->config->get('credit_status')) { ?>
<?php /*if ((float)$this->customer->getBalance() <= 0) { return; }*/ ?>
<?php echo $balance; ?>
<?php } ?>