<?php echo $header; ?>
<style type="text/css">
    table.form > tbody > tr > td:first-child { vertical-align: top; }
</style>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <?php if ($error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
            <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
        </div>
        <div class="content">
            
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                
                <div id="tabs" class="htabs">
                    <a href="#tab-settings"><?php echo $entry_general_settings; ?></a>
                    <a href="#tab-position"><?php echo $entry_position; ?></a>
                    <a href="#tab-attribute"><?php echo $entry_attributes; ?></a>
                    <a href="#tab-manufacturer"><?php echo $entry_manufacturers; ?></a>
                    <a href="#tab-price"><?php echo $entry_prices; ?></a>
                </div>
                
                <div id="tab-settings">
                    <table class="form">

                        <tr>
                            <td><?php echo $entry_status; ?></td>
                            <td>
                                <select name="an_filters_status">
                                    <?php if ($an_filters_status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td><?php echo $entry_ajax_status; ?><br/><?php echo $entry_ajax_status_info ?></td>
                            <td>
                                <select name="an_filters_ajax_status">
                                    <?php if ($an_filters_ajax_status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td><?php echo $entry_collapsible_status; ?><br/>
                            <td>
                                <select name="an_filters_collapsible_status">
                                    <?php if ($an_filters_collapsible_status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <td><?php echo $entry_collapsible_hidden_by_default; ?><br/>
                            <td>
                                <select name="an_filters_collapsible_hidden_by_default">
                                    <?php if ($an_filters_collapsible_hidden_by_default) { ?>
                                        <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                                        <option value="0"><?php echo $text_no; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_yes; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_no; ?></option>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <td><?php echo $entry_list_max_height; ?><br/>
                            <td>
                                <input type="text" name="an_filters_list_max_height" value="<?php echo $an_filters_list_max_height; ?>" size="5"/>px
                            </td>
                        </tr>
                    </table>
                </div>
                
                <div id="tab-position">
                    <table id="module" class="list">
                        <thead>
                            <tr>
                                <td class="left"><?php echo $entry_layout; ?> <i style="font-weight: normal;">This module is only intended to be used on the 'category' layout</i></td>
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
                                    <td class="left"><select name="an_filters_module[<?php echo $module_row; ?>][layout_id]">
                                            <?php foreach ($layouts as $layout) { ?>
                                                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                                                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                                <?php } else { ?>
                                                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                                <?php } ?>
                                            <?php } ?>
                                        </select></td>
                                    <td class="left"><select name="an_filters_module[<?php echo $module_row; ?>][position]">
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
                                    <td class="left"><select name="an_filters_module[<?php echo $module_row; ?>][status]">
                                            <?php if ($module['status']) { ?>
                                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                                <option value="0"><?php echo $text_disabled; ?></option>
                                            <?php } else { ?>
                                                <option value="1"><?php echo $text_enabled; ?></option>
                                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                            <?php } ?>
                                        </select></td>
                                    <td class="right"><input type="text" name="an_filters_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
                                    <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>
                                </tr>
                            </tbody>
                            <?php $module_row++; ?>
                        <?php } ?>
                        <tfoot>
                            <tr>
                                <td colspan="4"></td>
                                <td class="left"><a onclick="addModule();" class="button"><span><?php echo $button_add_module; ?></span></a></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                
                <div id="tab-attribute">
                    <table class="form">
                        <tbody>
                            
                            <tr>
                                <td><?php echo $entry_attributes_filters_status; ?><br/>
                                <td>
                                    <select name="an_filters_attributes_filters_status">
                                        <?php if ($an_filters_attributes_filters_status) { ?>
                                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                            <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                            <option value="1"><?php echo $text_enabled; ?></option>
                                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    
                                    <?php echo $entry_attributes_filters_allow_multiple_values; ?>
                                    <span class="error"><?php echo $error_an_filters_attributes_filters_allow_multiple_values; ?></span>
                                </td>
                                
                                <td>
                                    <select name="an_filters_attributes_filters_allow_multiple_values">
                                        <?php if ($an_filters_attributes_filters_allow_multiple_values) { ?>
                                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                            <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                            <option value="1"><?php echo $text_enabled; ?></option>
                                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                                
                            </tr>
                            
                            <tr>
                                <td><?php echo $entry_attributes_hidden_by_default; ?></td>
                                
                                <td>
                                    <select name="an_filters_attributes_hidden_by_default">
                                        <?php if ($an_filters_attributes_hidden_by_default == 1) { ?>
                                            <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                                            <option value="0"><?php echo $text_no; ?></option>
                                        <?php } else { ?>
                                            <option value="1"><?php echo $text_yes; ?></option>
                                            <option value="0" selected="selected"><?php echo $text_no; ?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>
                            
                            
                            <tr>
                                <td>
                                    <?php echo $text_sort_order_tab; ?>
                                </td>
                                <td>
                                    <table class="list" id="attribute-sort-order-table">
                                        <thead>
                                            <tr>
                                                <td class="left"><?php echo $entry_attribute_value; ?></td>
                                                <td class="left">
                                                    <?php echo $entry_sort_order . $text_hide_with_negative_value; ?>
                                                        <a class="button" style="float: right; margin-left: 10px;" onclick="$('#attribute-sort-order-table input[type=text]').val('-1'); return false;"><span><?php echo $text_hide_all; ?></span></a>
                                                        <a class="button" style="float: right;" onclick="$('#attribute-sort-order-table input[type=text]').val('1'); return false;"><span><?php echo $text_show_all; ?></span></a>
                                                </td>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <?php foreach ($productAttributes as $attribute): ?>
                                            <tr>
                                                <td class="left"><?php echo $attribute['text'] ?></td>
                                                <td class="left">
                                                    <input type="text" name="attributeTextSortOrder_<?php echo md5($attribute['text']) ?>" value="<?php echo ($attribute['sort_order'] != null) ? $attribute['sort_order'] : '-1'; ?>" />
                                                </td>
                                            </tr>
                                            <?php endforeach; ?>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            
                        </tbody>
                    </table>
                    
                        
                    
                    
                </div>
                
                <div id="tab-manufacturer">
                    <table class="form">
                        <tbody>
                            
                            <tr>
                                <td><?php echo $entry_manufacturers_filters_status; ?><br/>
                                <td>
                                    <select name="an_filters_manufacturers_filters_status">
                                        <?php if ($an_filters_manufacturers_filters_status) { ?>
                                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                            <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                            <option value="1"><?php echo $text_enabled; ?></option>
                                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td><?php echo $entry_label; ?></td>
                                <td><input type="text" value="<?php echo $an_filters_manufacturer_label; ?>" name="an_filters_manufacturer_label"/></td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                
                <div id="tab-price">
                    <table class="form">
                        <tbody>
                            
                            <tr>
                                <td><?php echo $entry_price_filters_status; ?><br/>
                                <td>
                                    <select name="an_filters_price_filters_status">
                                        <?php if ($an_filters_price_filters_status) { ?>
                                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                            <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                            <option value="1"><?php echo $text_enabled; ?></option>
                                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td><?php echo $entry_price_bands_status; ?><br/>
                                <td>
                                    <select name="an_filters_price_bands_status">
                                        <?php if ($an_filters_price_bands_status) { ?>
                                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                            <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                            <option value="1"><?php echo $text_enabled; ?></option>
                                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td><?php echo $entry_price_slider_status; ?><br/>
                                <td>
                                    <select name="an_filters_price_slider_status">
                                        <?php if ($an_filters_price_slider_status) { ?>
                                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                            <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                            <option value="1"><?php echo $text_enabled; ?></option>
                                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <?php echo $entry_price_band_steps; ?>
                                </td>
                                <td>
                                    <table class="list">
                                        <thead>
                                            <tr>
                                                <td class="left"><?php echo $entry_price_bands_status; ?></td>
                                                <td class="left"><?php echo $entry_price_steps; ?></td>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <tr>
                                                <td class="left">0 - 99</td>
                                                <td class="left"><input type="text" name="an_filters_price_bands_upto_10" value="<?php echo $an_filters_price_bands_upto_10; ?>" /></td>
                                            </tr>
                                            <tr>
                                                <td class="left">100 - 999</td>
                                                <td class="left"><input type="text" name="an_filters_price_bands_upto_100" value="<?php echo $an_filters_price_bands_upto_100; ?>" /></td>
                                            </tr>
                                            <tr>
                                                <td class="left">1000 - 9999</td>
                                                <td class="left"><input type="text" name="an_filters_price_bands_upto_1000" value="<?php echo $an_filters_price_bands_upto_1000; ?>" /></td>
                                            </tr>
                                            <tr>
                                                <td class="left">10000+</td>
                                                <td class="left"><input type="text" name="an_filters_price_bands_upto_10000" value="<?php echo $an_filters_price_bands_upto_10000; ?>" /></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                
                
            </form>
        </div>
    </div>
    <script type="text/javascript">
        var module_row = <?php echo $module_row; ?>;

        function addModule() {	
            html  = '<tbody id="module-row' + module_row + '">';
            html += '  <tr>';
            html += '    <td class="left"><select name="an_filters_module[' + module_row + '][layout_id]">';
<?php foreach ($layouts as $layout) { ?>
            html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
<?php } ?>
        html += '    </select></td>';
        html += '    <td class="left"><select name="an_filters_module[' + module_row + '][position]">';
        html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
        html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
        html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
        html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
        html += '    </select></td>';
        html += '    <td class="left"><select name="an_filters_module[' + module_row + '][status]">';
        html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
        html += '      <option value="0"><?php echo $text_disabled; ?></option>';
        html += '    </select></td>';
        html += '    <td class="right"><input type="text" name="an_filters_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
        html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
        html += '  </tr>';
        html += '</tbody>';
	
        $('#module tfoot').before(html);
	
        module_row++;
    }
    
    $('#tabs a').tabs();
    
    
    
    function disableInputs() {
        if ($('select[name=an_filters_price_filters_status]').val() == 0) {
            $('select[name=an_filters_price_slider_status]').attr('disabled', 'disabled').val(0);
            $('select[name=an_filters_price_bands_status]').attr('disabled', 'disabled').val(0);
        } else {
            $('select[name=an_filters_price_slider_status]').removeAttr('disabled');
            $('select[name=an_filters_price_bands_status]').removeAttr('disabled');
        }
    }
    
    $('select[name=an_filters_price_filters_status]').change(function() {
        disableInputs();
    })
    
    disableInputs();
    </script>
    <?php echo $footer; ?>