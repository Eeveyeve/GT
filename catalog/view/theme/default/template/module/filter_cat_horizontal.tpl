<?php if ($filter_view) { ?>
<div id="filter-cat">
    <input id="f-special" type="hidden" value="<?php echo $special ? 1 : 0;?>" />
    <input id="f-search" type="hidden" value="<?php echo $search ? $search : 0;?>" />
    <input id="f-sort" type="hidden" name="sort" value="<?php echo $sort;?>" />
    <input id="f-order" type="hidden" name="order" value="<?php echo $order ;?>" />
    <input id="f-cat" type="hidden" name="dcat" value="<?php echo $category_id; ?>" />
    <div class="filter-block">
    <?php if($filter['sub']) { ?>
        <div class="body-block">
            <select id="f-sub" name="cat" onchange="filterCat();">
            <option value="<?php echo $category_id; ?>"><?php echo $text_subcat;?></option>
            <?php foreach ($categories as $category) { ?>
                <option value="<?php echo $category['id'];?>"><?php echo $category['name']; ?></option>
            <?php } ?>
            </select>
        </div>
    <?php } ?>
    
    <?php if($filter['brand']) { ?>
        <div class="body-block">
            <select id="f-man" name="man" onchange="filterCat();">
            <option value="0"><?php echo $text_brand;?></option>
            <?php foreach ($manufacturers as $manufacturer) { ?>
            	<option value="<?php echo $manufacturer['id'];?>"><?php echo $manufacturer['name']; ?></option>
            <?php } ?>
            </select>
        </div>
    <?php } ?> 
    
    <?php if(isset($this->request->get['manufacturer_id'])) { ?>
        <div class="body-block">
            <select id="f-man" name="man" onchange="filterCat();">
            <option selected="selected" value="<?php echo $this->request->get['manufacturer_id'];?>"><?php echo $m_name; ?></option>
            </select>
        </div>
        
    <?php } ?>
    
    <?php if ($filter['price']) { ?>
    <script>
    $(function() {
        $( "#slider-range" ).slider({
            range: true,
            min: <?php echo round($prices['min']);?>,
            max: <?php echo round($prices['max']);?>,
            values: [ <?php echo round($prices['min']);?>, <?php echo round($prices['max']);?> ],
            slide: function( event, ui ) {
                $('#filter-pmin').val(ui.values[ 0 ]);
                $('#filter-pmax').val(ui.values[ 1 ]);
            },
            stop:function( event, ui ) { filterCat()}
        });
        
    });
    </script>
    
    <div class="p-filter body-block">
    <span><?php echo $text_price.' '.$text_priceof;?></span><input onchange="filterCat()" id="filter-pmin" name="pmin" type="text" value="<?php echo round($prices['min']);?>" />&nbsp;
    <span><?php echo $text_priceto;?></span><input onchange="filterCat();" id="filter-pmax" name="pmax" type="text" value="<?php echo round($prices['max']);?>" />
    <div id="slider-range"></div>
    </div>
    
    <?php } ?>
    
    </div>
    <div class="filter-block"> 
        <?php if(!empty($atributes)) { ?>
        <?php $i=0; foreach($atributes as $key=>$value) { ?>
        <?php if(isset($value['values'])){ ?>
        <div class="body-block">
        <select class="f-atr" name="atributes" onchange="filterCat();">
        <option value="0"><?php echo $value['name'];?></option>
        
        <?php foreach ($value['values'] as $val) { ?>
            <option value="<?php echo $value['id'].'||'.$val;?>"><?php echo $val; ?></option>
        <?php } ?>
        
        </select>
        </div>
        <?php } ?>
        <?php } ?>
        <?php } ?>
    </div>
    
</div>

<?php } ?>