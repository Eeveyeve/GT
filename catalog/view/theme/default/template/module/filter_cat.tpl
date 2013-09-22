<?php if ($filter_view) { ?>
<div id="filter-cat">
    <input id="f-special" type="hidden" value="<?php echo $special ? 1 : 0;?>" />
    <input id="f-search" type="hidden" value="<?php echo $search ? $search : 0;?>" />
    <input id="f-sort" type="hidden" name="sort" value="<?php echo $sort;?>" />
    <input id="f-order" type="hidden" name="order" value="<?php echo $order ;?>" />
    <input id="f-cat" type="hidden" name="dcat" value="<?php echo $category_id; ?>" />
    <?php if($filter['brand']) { ?>
        <div class="filter-block">
        <h4><?php echo $text_brand;?></h4>
        <div class="top-close-block"></div>
        <div class="body-block f-man">
        <?php foreach ($manufacturers as $manufacturer) { ?>
            <input value="<?php echo $manufacturer['id'];?>" type="checkbox" id="m<?php echo $manufacturer['id'];?>" /><label for="m<?php echo $manufacturer['id'];?>"><?php echo $manufacturer['name']; ?></label><br />
        	
        <?php } ?>
        </div>
        <div class="bot-close-block"></div>
        </div>
    <?php } ?>    
    <?php if(isset($this->request->get['manufacturer_id'])) { ?>
        <div class="filter-block">
        <h4><?php echo $text_brand;?></h4>
        <div class="top-close-block"></div>
        <div class="body-block f-man">
        
            <input checked="checked" disabled="disabled" value="<?php echo $this->request->get['manufacturer_id'];?>" type="checkbox" id="m<?php echo $this->request->get['manufacturer_id'];?>" /><label for="m<?php echo $this->request->get['manufacturer_id'];?>"><?php echo $m_name; ?></label><br />
        	
        
        </div>
        <div class="bot-close-block"></div>
        </div>
    <?php } ?>
   <?php if($filter['sub']) { ?>
    <div class="filter-block">
        <h4><?php echo $text_subcat;?></h4>
        <div class="top-close-block"></div>
        <div class="body-block f-sub">
    <?php foreach ($categories as $category) { ?>
        <input value="<?php echo $category['id'];?>" type="checkbox" id="c<?php echo $category['id'];?>" /><label for="c<?php echo $category['id'];?>"><?php echo $category['name']; ?></label><br />
        
    <?php } ?>
    </div>
        <div class="bot-close-block"></div>
        </div>
    <?php } ?>
    <?php if(!empty($atributes)) { ?>
    <?php $i=0; foreach($atributes as $key=>$value) { ?>
    <?php if(isset($value['values'])){ ?>
    <div class="filter-block">
    <h4><?php echo $value['name'];?></h4>
    <div class="top-close-block"></div>
        <div class="body-block f-atr">
        
    <?php foreach ($value['values'] as $val) { ?>
        <input value="<?php echo $value['id'].'||'.$val;?>" type="checkbox" id="a<?php echo $i.$value['id'];?>" /><label for="a<?php echo $i.$value['id'];?>"><?php echo $val; ?></label><br />
    <?php $i++; } ?>
       
    </div>
    <div class="bot-close-block"></div>
    </div>
    <?php } ?> 
    <?php } ?>
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
    
    <div class="filter-block">
    <h4><?php echo $text_price;?></h4>
    <div class="p-filter">
    <span><?php echo $text_priceof;?></span><input onchange="filterCat()" id="filter-pmin" name="pmin" type="text" value="<?php echo round($prices['min']);?>" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <span><?php echo $text_priceto;?></span><input onchange="filterCat();" id="filter-pmax" name="pmax" type="text" value="<?php echo round($prices['max']);?>" />
    <div id="slider-range"></div>
    </div>
    </div>
    
    <?php } ?>
</div>
<div id="filter-data"></div>
<div id="filter-result"></div>
<?php } ?>