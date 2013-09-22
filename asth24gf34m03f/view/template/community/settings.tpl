<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if (isset($error_warning)) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if (isset($success)) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
	<div class="heading"><h1>Community Settings</h1><div class="buttons"><a href="<?php echo $insert; ?>" class="button">Insert</a><a onclick="$('#form').submit();" class="button">Delete</a></div>
</div>
    <div class="content">
    	<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left">Word/URL String</td>
            </tr>
          </thead>
          <tbody>
          <?php if (isset($words) and $words) { ?>
            <?php foreach ($words as $word) { ?>
            <tr>
              <td style="text-align: center;"><input type="checkbox" name="selected[]" value="<?php echo $word['id']; ?>" /></td>
              <td class="left"><?php echo $word['block_word']; ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4">No words found!</td>
            </tr>
          <?php } ?>
          </tbody>
          </table>
          </form>
    </div>
    </div>  
  </div>
</div>
<?php echo $footer; ?>