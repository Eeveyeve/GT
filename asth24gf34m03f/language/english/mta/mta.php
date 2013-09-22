<?php
// Heading  
$_['heading_title']       = 'MultiTier Affiliate System';
$_['heading_title_insert']       = 'MultiTier Affiliate System - Create Scheme';
$_['heading_title_update']       = 'MultiTier Affiliate System - Edit Scheme';

// Entry
$_['entry_name']          = 'Affiliate Scheme Name:';
$_['entry_is_default']          = 'Default:<br /><span class="help">Use this scheme as default</span>';
$_['entry_before_shipping'] = 'No Shipping:<br /><span class="help">Deduct shipping, handling &amp; taxes from the total price before calculating commission</span>';
$_['entry_autoadd'] = '<span class="help"></strong>Add Commission</strong> - add commissions to affiliate balance automatically</span>';
$_['entry_autoapprove'] = 'Auto Approve:<br /><span class="help">Approve new affiliates automatically</span>';
$_['entry_tiers'] = 'Tiers:';
$_['entry_tier'] = 'Tier';
$_['entry_level'] = 'Level';
$_['entry_add_tier'] = 'Add Tier';
$_['entry_remove_tier'] = 'remove';
$_['entry_eternal'] = 'Always Include in Commission:';
$_['entry_commission_type'] = 'Commission Type:';
$_['entry_description'] = 'Description:';
$_['entry_new_name'] = 'New name';

// Column
$_['column_commission'] = 'Commission';
$_['column_autoadd'] = 'Add Commission';
$_['column_autoapprove'] = 'Auto Approve';
$_['column_action']       = 'Action';
$_['column_name']         = 'Scheme';
$_['column_code']         = 'Signup Code';

// Text
$_['text_success']        = 'Success: You have modified affiliate schemes!';
$_['text_default_value'] = 'Default';
$_['text_percent']        = 'Percentage';
$_['text_amount']         = 'Fixed Amount';
$_['text_eternal_description'] = '<span class="help">Normally when current sale&apos;s affiliate level is higher than the number of tiers, affiliates at lower level don&apos;t get any commission. E.g. if you have 4 tier setup, and the affiliate is at 6th level, affiliates at level 6,5,4,3 will get commission, and affiliates at level 2 and 1 will not get anything. However, if you set <strong>Always Include in Commission</strong> to 2, in the same situation commission will be distributed  between 6,5,2,1, while 4 and 3 will not get commission.</span>';
$_['text_unconverted_affiliates'] = 'Affiliates not yet converted to mulitier system';
$_['text_convert_affiliates'] = 'Click here to convert';
$_['text_convert_success'] = 'Affiliates converted successfully !';
$_['text_hide'] = 'Hide';
$_['text_show_usage'] = 'Show Usage';
$_['text_delete_scheme_warning'] = 'Are you really going to delete this affiliate scheme? It is not recommended!';
$_['text_copy_scheme'] = 'Copy to New Scheme';
$_['text_move_users'] = 'Move selected to another scheme:';
$_['text_move'] = 'Move';
$_['text_select_scheme'] = 'Select Scheme';
$_['text_no_fixed_for_affs'] = 'This scheme is used as custom for some affiliates, its commission type can not be Fixed amount';
// Error
$_['error_permission']    = 'Warning: You do not have permission to modify affiliate schemes!';
$_['error_name']          = 'Affiliate Scheme Name must be between 3 and 100 characters!';
$_['error_duplicate_name']          = 'Affiliate Scheme with this Name already exists, please choose another name';
$_['error_invalid_percent'] = 'Total percentage must not exceed 100% or be negative!';
$_['error_invalid_commission'] = 'Some commission values are incorrect';
$_['error_invalid_request'] = 'Invalid request';
$_['error_unknown'] = 'Unknown error';
$_['error_database'] = 'Database error';
$_['error_all'] = 'The following errors have occured:';
$_['error_validation'] = 'Validation Error!';
$_['error_no_default'] = 'Please create Default Scheme !';
$_['error_no_default_unconverted'] = 'Please create Default Scheme to be able to convert affiliates !';
$_['error_fixed_aff_commission'] = 'Product-unrelated (affiliate) commission can not be fixed amount!';

