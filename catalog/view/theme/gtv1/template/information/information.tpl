<?php echo $header; ?>
<div class="aboveheading">
  <a href="<?php echo $link_contact; ?>" class="darkestbluebutton rightbut"><?php echo $text_contact_box; ?></a>
  <p class="margtop"><?php echo $text_needhelp; ?> &raquo; <span id="titling"></span></p>
  <h1 class="margbot"><?php echo $heading_title; ?></h1>
</div>
<div class="content-block">
  <div class="content">
    <?php echo $content_top; ?>
    <div class="black-heading">
      <a class="part" id="top-box-info-3" href="<?php echo $link_faq; ?>"><?php echo $text_faq_box; ?></a>
      <a class="part" id="top-box-info-4" href="<?php echo $link_policies; ?>"><?php echo $text_policies_box; ?></a>
      <a class="part marked" href="<?php echo $link_livesupport; ?>"><?php echo $text_livesupport; ?></a>
      <a class="part" href="<?php echo $link_community; ?>"><?php echo $text_askcommunity; ?></a>
      <a class="part" href="<?php echo $link_contact; ?>"><?php echo $text_contact_box; ?></a>
      <div style="clear:both;"></div>
    </div>
    <div style="display:none;" class="content">
      <div class="heading"><h1 style="padding:5px;color:#a4a4a4;font-size:18px;"><?php echo $heading_title; ?> &raquo; <span style="color:#27292e;" id="titling"></span></h1></div>
    </div>
    <div class="content">
      <div class="rsidebar fullheight infosidebar">
        <!--<a href="<?php echo $link_contact; ?>"><?php echo $text_resolution_side; ?></a>-->
        <br />
        <h3><?php if ($information_id == 4) {echo $text_categories_side;} else if ($information_id == 3) {echo $text_sections_side;} ?></h3>
        <ul>
          <?php $themost = explode("*separate-2-blocks*", $description);
            $id = 0;
            foreach($themost as $themostone) {
              $id++;
              $heading = explode("*heading-to-text*", $themostone);
                ?><li class="linker" id="link-<?php echo $id; ?>"><a href="javascript:OpenBlock(<?php echo $id; ?>);"><?php echo $heading[0]; ?></a></li><?php
            } 
          ?>
        </ul>
        <?php echo $column_right; ?>  
      </div>
      <div class="content inner"  style="padding:20px;">
        <div id="search-text">
          <h4><?php echo $text_howcan; ?></h4>
          <input type="text" id="faq-filter" value="" placeholder="<?php echo $text_search; ?>">
        </div>
        <?php $themost = explode("*separate-2-blocks*", $description);
          $id = 0;
          foreach($themost as $themostone) {
            $id++;
            ?><div class="text-wrap-content" id="block-<?php echo $id; ?>"><?php
            $heading = explode("*heading-to-text*", $themostone);
              $wholeblock = $heading[1];
              $blocks = explode(";;", $wholeblock);
                $iterator = 0;
                foreach($blocks as $block) {
                  $iterator++;
                  if($iterator % 2 == 1 && $block != "") {
                    ?><div class="text-content"><h4 class="smalltitle" style="font-size:16px !important;"><?php echo $block; ?></h4><?php
                  }
                  elseif($iterator % 2 == 0 && $block != "") {
                    ?><div class="texty" style="font-size:16px !important;"><?php echo $block; ?></div></div><?php
                  }
                }
              ?></div><?php
          } 
        ?>
        <div id="about" style="display:none;">
          <div class="bluetextblock"><?php echo $text_blue_block;?></div>
          <br />
          <h4 style="margin-bottom:5px;"><?php echo $text_features;?></h4>
          <div class="aboutwrapper">
            <img src="catalog/view/theme/gtv1/image/information/platforms.png" alt="platforms" /><br /><?php echo $text_about1;?>
            <img src="catalog/view/theme/gtv1/image/information/community.png" alt="community" /><br /><?php echo $text_about2;?>
            <img src="catalog/view/theme/gtv1/image/information/secure.png" alt="secure" /><br /><?php echo $text_about3;?>
            <img src="catalog/view/theme/gtv1/image/information/partner.png" alt="partner" /><br /><?php echo $text_about4;?>
          </div>
          <br />
        </div>
      </div>
      <div style="clear:both"></div>
    </div>
    <br /><br /><br /><br />
  </div>
</div>
<br />
<br />  
<?php echo $footer; ?>
<script>
$(document).ready(function() {
  $('.customermark').addClass('active').parent().addClass('active');
  var whash = window.location.hash.replace("#","");
  if (whash != "") {
    OpenBlock(whash);
  } else {
    OpenBlock(1);
  }
  $('.linker').find('a').find('p').css('font-size','14px');
  var currenttitle = $('.linker').first().find('a').text();
  $('#top-box-info-<?php echo $information_id; ?>').addClass('active');
  $("p").each(function() {
    var ptext = $(this).text();
    if(ptext == "") {
      $(this).remove();
    }
  });
  $(".linker a").each(function() {
    ptext = $(this).find('p').text();
    $(this).empty().text(ptext);
  });
  $(".smalltitle").each(function() {
    ptext = $(this).find('p').text();
    $(this).empty().text(ptext);
  });
  $('.smalltitle br').remove();
  $('#about').hide();
  $('#search-text').hide();
  $('#about').remove();
  /*var $about = $('#about');
  if(<?php echo $information_id; ?> == 4) {
    $('.text-wrap-content').first().append($about);
    $('#about').show();
  }
  else {
    $('#about').remove();
  }*/
  if(<?php echo $information_id; ?> == 3) {
    $('#search-text').show();
    $("#faq-filter").keyup(function(){
 
        // Retrieve the input field text and reset the count to zero
        var filter = $(this).val(), count = 0;
 
        // Loop through the comment list
        $(".text-content").each(function(){
 
            // If the list item does not contain the text phrase fade it out
            if ($(this).text().search(new RegExp(filter, "i")) < 0) {
                $(this).fadeOut();
 
            // Show the list item if the phrase matches and increase the count by 1
            } else {
                $(this).show();
                count++;
            }
        });
 
        // Update the count
        var numberItems = count;
        //$("#filter-count").text("Number of Comments = "+count);
    });
  } else {
    $('#search-text').remove();
  }
});
<!--
$(document).ready(function() {  
  $('#bgoverlap').hide();
  $('.text-wrap-content').hide().first().show();
  if(<?php echo $information_id; ?> == 3) {
    $('.texty').hide();
  } else if (<?php echo $information_id; ?> == 4) {
    $('.smalltitle').css('cursor', 'default');
  }    
});
function OpenBlock(id) {
  $('.text-wrap-content').hide('fast');
  $('#block-'+id).show('fast');
  $('.linker').removeClass('active');
  $('#link-'+id).addClass('active');
  currenttitle = $('#link-'+id).find('a').text();
  $('#titling').text(currenttitle);
}
if(<?php echo $information_id; ?> == 3) {
  $('.smalltitle').click(function() {
    $(this).closest('.text-content').find('.texty').toggle('fast');
  });
}
$('.infofooterhash').click(function() {
  OpenBlock($(this).attr('id'));
});
//--></script>
