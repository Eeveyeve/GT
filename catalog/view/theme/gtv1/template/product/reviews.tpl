<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="wrap">
  <div id="content"><?php echo $content_top; ?>
    <!--<div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
    </div>-->
    <div class="heading">
      <h1><?php echo $heading_title; ?></h1>
    </div>  
    <?php if ($reviews) { ?>
    <div class="product-list" id="product-list">
      <?php foreach ($reviews as $review) { ?>
        <div class="product">
          <div class="flleft">
            <?php if ($review['prod_thumb']) { ?>
              <div class="image"><a href="<?php echo $review['prod_href']; ?>"><img src="<?php echo $review['prod_thumb']; ?>" title="<?php echo $review['prod_name']; ?>" alt="<?php echo $review['prod_name']; ?>" /></a></div>
            <?php } ?>
            <div class="revname">
              <a href="<?php echo $review['prod_href']; ?>"><?php echo $review['prod_name']; ?></a>
            </div>
            <div class="revrating">
              <?php if ($review['rating']) { ?>
                <span style="margin-right:8px;"><img src="catalog/view/theme/gtv1/image/stars-<?php echo $review['rating']; ?>.png" alt="<?php echo $review['prod_name']; ?>" /></span>
              <?php } ?>
            </div>
            <div class="revauthor">
              <span style="font-weight:bold;"><?php echo $review["author"];?></span><br />
              <?php echo $review["date_added"];?>
            </div>
          </div>
          <div class="flright">  
            <div class="description" style="font-style:italic;"><?php echo $review['description']; ?></div>
          </div>
        </div>
      <?php } ?>
    </div>
    <!--<div class="pagination"><?php echo $pagination; ?></div>-->
    <h3 class="reverseheading" id="loadmore" style="cursor:pointer;"><?php echo $text_showmore; ?></h3>
    <div id="preloader" style="display:none;"></div>
    <?php } else { ?>
    <div class="content"><?php echo $text_empty; ?></div>
    <?php }?>
    <?php echo $content_bottom; ?>
  </div>
</div>  
<?php echo $footer; ?>
<script type="text/javascript"><!--
$(document).ready(function(){
  var pagetoload = 2;
  var waslastpage = false;
  var loadisrunning = false;
  $('.home-icon').addClass('active').parent().addClass('active');
  $("#loadmore").click(function() {
    var myUrl = window.location.href + "?page=" + pagetoload + " #product-list";
    if(waslastpage == false && loadisrunning == false) {
      loadisrunning = true;
      $('#loadmore').text('<?php echo $text_loading; ?>').css('cursor','wait');  
      $("#preloader").load(myUrl, function(){
        if ($('#preloader').is(':empty')){
          waslast = true;
          $('#loadmore').text('<?php echo $text_nomore; ?>').css('cursor','default');
        } else {
          var loadcontent = $("#preloader").find('#product-list').html();
          $("#product-list").append(loadcontent);
          $('#loadmore').text('<?php echo $text_showmore; ?>').css('cursor','pointer');
          Evenize();
          pagetoload++;
          loadisrunning = false;
        }
      });
    }  
    return false;
  });
  function Evenize () {
    $('.product-list').find('.product:even').css("background-color", "#f7f7f7");
  }
  Evenize();
});
//--></script>