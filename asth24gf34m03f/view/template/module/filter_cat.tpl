<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
  <div class="box">
    <div class="heading">
        <h1><img src="view/image/module.png" alt="" /> <?php echo $text_option; ?></h1>
        <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
        <table id="option" class="list">
            <thead>
                <tr>
                  <td class="left"><?php echo $entry_filter_cat; ?></td>
                  <td class="left"><?php echo $entry_sub; ?></td>
                  <td class="left"><?php echo $entry_brand; ?></td>
                  <td class="left"><?php echo $entry_price; ?></td>
                  <td class="left"><?php echo $entry_attribute; ?></td>
                  <td></td>
                </tr>
            </thead>
            <tbody id="manufacturer">
                <tr>
                    <td class="left"><?php echo $text_manufacturer;?></td>
                    <td class="left">&nbsp;</td>
                    <td class="left">&nbsp;</td>
                    <td class="left"><select name="filter_cat_manufacturer[price]">
                      <?php if ($filter_cat_manufacturer['price']) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select></td>
                    <td class="left"><select size="3" multiple="multiple" name="filter_cat_manufacturer[attribute_id][]">
                <?php foreach ($attribute as $attribut) { ?>
                <?php if(in_array($attribut['attribute_id'],$filter_cat_manufacturer['attribute_id'])) { ?>
                    <option selected="selected" value="<?php echo $attribut['attribute_id']; ?>"><?php echo $attribut['name']; ?></option>
                    <?php } else { ?>
	               <option value="<?php echo $attribut['attribute_id']; ?>"><?php echo $attribut['name']; ?></option>
               <?php } ?>
	           <?php } ?>
                </select></td>
                    <td class="left">&nbsp;</td>
                </tr>
            </tbody>
            <tbody id="special">
                <tr>
                    <td class="left"><?php echo $text_special;?></td>
                    <td class="left">&nbsp;</td>
                    <td class="left">&nbsp;</td>
                    <td class="left"><select name="filter_cat_special[price]">
                      <?php if ($filter_cat_special['price']) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select></td>
                    <td class="left"><select size="3" multiple="multiple" name="filter_cat_special[attribute_id][]">
                <?php foreach ($attribute as $attribut) { ?>
                <?php if(in_array($attribut['attribute_id'],$filter_cat_special['attribute_id'])) { ?>
                    <option selected="selected" value="<?php echo $attribut['attribute_id']; ?>"><?php echo $attribut['name']; ?></option>
                    <?php } else { ?>
	               <option value="<?php echo $attribut['attribute_id']; ?>"><?php echo $attribut['name']; ?></option>
               <?php } ?>
	           <?php } ?>
                </select></td>
                    <td class="left">&nbsp;</td>
                </tr>
            </tbody>
            <tbody id="search">
                <tr>
                    <td class="left"><?php echo $text_search;?></td>
                    <td class="left">&nbsp;</td>
                    <td class="left">&nbsp;</td>
                    <td class="left"><select name="filter_cat_search[price]">
                      <?php if ($filter_cat_search['price']) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select></td>
                    <td class="left"><select size="3" multiple="multiple" name="filter_cat_search[attribute_id][]">
                <?php foreach ($attribute as $attribut) { ?>
                <?php if(in_array($attribut['attribute_id'],$filter_cat_search['attribute_id'])) { ?>
                    <option selected="selected" value="<?php echo $attribut['attribute_id']; ?>"><?php echo $attribut['name']; ?></option>
                    <?php } else { ?>
	               <option value="<?php echo $attribut['attribute_id']; ?>"><?php echo $attribut['name']; ?></option>
               <?php } ?>
	           <?php } ?>
                </select></td>
                    <td class="left">&nbsp;</td>
                </tr>
            </tbody>
            <?php $option_row = 0; ?>
            <?php foreach ($options as $option) { ?>
            <tbody id="option-row<?php echo $option_row; ?>">
                <tr>
                  <td class="left"><select name="filter_cat_option[<?php echo $option_row; ?>][cat_id]">
                  <option value="0"><?php echo $entry_all_cat; ?></option>
                  <?php foreach ($categories as $category) { ?>
                  <?php if ($option['cat_id'] == $category['category_id']) { ?>
                  <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
                <td class="left"><select name="filter_cat_option[<?php echo $option_row; ?>][sub]">
                    <?php if ($option['sub']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
                <td class="left"><select name="filter_cat_option[<?php echo $option_row; ?>][brand]">
                    <?php if ($option['brand']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
                <td class="left"><select name="filter_cat_option[<?php echo $option_row; ?>][price]">
                    <?php if ($option['price']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
                <td class="left"><select size="3" multiple="multiple" name="filter_cat_option[<?php echo $option_row; ?>][attribute_id][]">
                <?php foreach ($attribute as $attribut) { ?>
                <?php if(in_array($attribut['attribute_id'],$option['attribute_id'])) { ?>
                    <option selected="selected" value="<?php echo $attribut['attribute_id']; ?>"><?php echo $attribut['name']; ?></option>
                    <?php } else { ?>
	               <option value="<?php echo $attribut['attribute_id']; ?>"><?php echo $attribut['name']; ?></option>
               <?php } ?>
	           <?php } ?>
                </select></td> 
                <td class="left"><a onclick="$('#option-row<?php echo $option_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
                </tr>
            </tbody>
            <?php $option_row++; ?>
            <?php } ?>
            <tfoot>
                <tr>
                  <td colspan="5"></td>
                  <td class="left"><a onclick="addOption();" class="button"><?php echo $text_add_option; ?></a></td>
                </tr>
            </tfoot>        
        </table>
    </div>
  </div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      
    </div>
    <div class="content">
      
        <table id="module" class="list">
          <thead>
            <tr>
              <td class="left"><?php echo $entry_layout; ?></td>
              <td class="left"><?php echo $entry_position; ?></td>
              <td class="left"><?php echo $entry_status; ?></td>
              <td class="right"><?php echo $entry_sort_order; ?></td>
              <td></td>
            </tr>
          </thead>
          <?php $module_row = 0; ?>
          <?php foreach ($modules as $module) { ?>
          <tbody id="module-row<?php echo $module_row; ?>">
            <tr>
              <td class="left"><select name="filter_cat_module[<?php echo $module_row; ?>][layout_id]">
                  <?php foreach ($layouts as $layout) { ?>
                  <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
              <td class="left"><select name="filter_cat_module[<?php echo $module_row; ?>][position]">
                  <?php if ($module['position'] == 'content_top') { ?>
                  <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                  <?php } else { ?>
                  <option value="content_top"><?php echo $text_content_top; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'content_bottom') { ?>
                  <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                  <?php } else { ?>
                  <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_left') { ?>
                  <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                  <?php } else { ?>
                  <option value="column_left"><?php echo $text_column_left; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_right') { ?>
                  <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                  <?php } else { ?>
                  <option value="column_right"><?php echo $text_column_right; ?></option>
                  <?php } ?>
                </select></td>
              <td class="left"><select name="filter_cat_module[<?php echo $module_row; ?>][status]">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
              <td class="right"><input type="text" name="filter_cat_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
              <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
            </tr>
                        
          </tbody>
          <?php $module_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="4"></td>
              <td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="filter_cat_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="filter_cat_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="filter_cat_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="right"><input type="text" name="filter_cat_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script> 
<script type="text/javascript"><!--
var option_row = <?php echo $option_row; ?>;

function addOption() {	
	html  = '<tbody id="option-row' + option_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="filter_cat_option[' + option_row + '][cat_id]">';
    html += '      <option value="0" selected="selected"><?php echo $entry_all_cat; ?></option>';
    <?php foreach ($categories as $category) { ?>
	html += '      <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
    html += '    <td class="left"><select name="filter_cat_option[' + option_row + '][sub]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="left"><select name="filter_cat_option[' + option_row + '][brand]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
    html += '    <td class="left"><select name="filter_cat_option[' + option_row + '][price]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
    html += '    <td class="left"><select size="3" multiple="multiple" name="filter_cat_option[' + option_row + '][attribute_id][]">';
    <?php foreach ($attribute as $attribut) { ?>
	html += '      <option value="<?php echo $attribut['attribute_id']; ?>"><?php echo $attribut['name']; ?></option>';
	<?php } ?>
    html += '    </select></td>';
	html += '    <td class="left"><a onclick="$(\'#option-row' + option_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#option tfoot').before(html);
	
	option_row++;
}
//--></script> 
<?php echo $footer; ?>