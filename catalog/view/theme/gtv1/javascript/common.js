var decodeEntities = (function() {
  // this prevents any overhead from creating the object each time
  var element = document.createElement('div');

  function decodeHTMLEntities (str) {
    if(str && typeof str === 'string') {
      // strip script/html tags
      str = str.replace(/<script[^>]*>([\S\s]*?)<\/script>/gmi, '');
      str = str.replace(/<\/?\w(?:[^"'>]|"[^"]*"|'[^']*')*>/gmi, '');
      element.innerHTML = str;
      str = element.textContent;
      element.textContent = '';
    }

    return str;
  }

  return decodeHTMLEntities;
})();

$(document).ready(function() {
	/* Search */
	$('.button-search').bind('click', function() {
		url = $('base').attr('href') + 'index.php?route=product/search';
				 
		var search = $('input[name=\'search\']').attr('value');
		
		if (search) {
			url += '&search=' + encodeURIComponent(search);
		}
		
		location = url;
	});
	
	$('#header input[name=\'search\']').bind('keydown', function(e) {
		if (e.keyCode == 13) {
			url = $('base').attr('href') + 'index.php?route=product/search';
			 
			var search = $('input[name=\'search\']').attr('value');
			
			if (search) {
				url += '&search=' + encodeURIComponent(search);
			}
			
			location = url;
		}
	});
	
	/* Ajax Cart */
	$('#cart > .heading a').live('click', function() {
		$('#cart').addClass('active');
		
		$('#cart').load('index.php?route=module/cart #cart > *');
		
	});
  $('#cart').live('mouseleave', function() {
		$(this).removeClass('active');
	});
	
	/* Mega Menu */
	$('#menu ul > li > a + div').each(function(index, element) {
		// IE6 & IE7 Fixes
		if ($.browser.msie && ($.browser.version == 7 || $.browser.version == 6)) {
			var category = $(element).find('a');
			var columns = $(element).find('ul').length;
			
			$(element).css('width', (columns * 143) + 'px');
			$(element).find('ul').css('float', 'left');
		}		
		
		var menu = $('#menu').offset();
		var dropdown = $(this).parent().offset();
		
		i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());
		
		if (i > 0) {
			$(this).css('margin-left', '-' + (i + 5) + 'px');
		}
	});

	// IE6 & IE7 Fixes
	if ($.browser.msie) {
		if ($.browser.version <= 6) {
			$('#column-left + #column-right + #content, #column-left + #content').css('margin-left', '195px');
			
			$('#column-right + #content').css('margin-right', '195px');
		
			$('.box-category ul li a.active + ul').css('display', 'block');	
		}
		
		if ($.browser.version <= 7) {
			$('#menu > ul > li').bind('mouseover', function() {
				$(this).addClass('active');
			});
				
			$('#menu > ul > li').bind('mouseout', function() {
				$(this).removeClass('active');
			});	
		}
	}
	
	$('.success img, .warning img, .attention img, .information img').live('click', function() {
		$(this).parent().fadeOut('slow', function() {
			$(this).remove();
		});
	});	
});

/* Uber Slider */

function RhinoOn() {
    $('#uberslider-content').rhinoslider({
        showBullets            : 'never',
        changeBullets          : 'after',
        showControls           : 'always',
        effect                 : 'fade',
        autoPlay               : true,
        showTime               : 4850,
        effectTime             : 450,
        pauseOnHover           : true
    });
    /*$('#uberslider-content .uberslider-product').each(function(){
        var thumb_src = $(this).find('.uberslider-thumbnail').attr('src');
        var thumb_alt = $(this).find('.uberslider-thumbnail').attr('alt');
        var panel_id = $(this).attr('id');
        //$('.rhino-bullets li').find("#"+panel_id+"-bullet").html("<img src='"+thumb_src+"' alt='"+thumb_alt+"' title='"+thumb_alt+"' />");
        $('.rhino-bullets li').find("#"+panel_id+"-bullet").attr('href', $('#'+panel_id).find('a').attr('href')).attr('onclick', 'return false;').html("<img src='"+thumb_src+"' alt='"+thumb_alt+"' title='"+thumb_alt+"' />");
    });
    $('#uberslider').find('.rhino-bullets').css("display","inline-block");
    var thumbs_width = $('#uberslider').find('.rhino-bullets').width();
    $('#uberslider').find('.rhino-bullets').width(thumbs_width).css("display","block");*/
    /*$('.rhino-active-bullet').live('click', function() {
      var href_id = $(this).attr('id').replace('-bullet','');
      window.location.href = $('#'+href_id).find('a').attr('href');
    });*/
}

/* Popups */

$(document).ready( function (){
  $(".fancylink").fancybox({
    'width'           : 350,
    'height'          : 570,
    'autoScale'       : false,
    'centerOnScroll'  : true,
    'showCloseButton' : true,
    'scrolling'       : 'auto',
    'type'            : 'iframe',
    'autoDimensions'  : 'false',
    'onClosed'	     	: function() {
      window.location = location.href;
    }                   
  })
});

/* Design */

/*$(document).ready(function(){
  $('input[type=checkbox]').each(function(){
    var cb = $(this);
    var nm = cb.attr("name");
    nm = "cbmac-"+nm;
    cb.attr("id", nm);
    cb.after($('<label class="css-checkbox" />').attr("for", cb.attr("id")) );
  }); 
});*/

/* Platform sliding */

$(document).ready(function(){
  $('#platform-highlight').hide();
  $('#platforms>ul>li').mouseenter(function () {
    var plindex = $(this).index();
    $('#platform-highlight').stop();
    $('#platform-highlight').fadeIn('fast', function() {
        var plpos = (plindex*167) - ((4-plindex)*1);
        $('#platform-highlight').animate({
          left: plpos
        }, 350);
      });
  });
  $('#platforms').mouseleave(function () {
    $('#platform-highlight').fadeOut('fast');
  });
});

function getURLVar(key) {
	var value = [];
	
	var query = String(document.location).split('?');
	
	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');
			
			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}
		
		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
} 

function addToCart(product_id, quantity) {
	quantity = typeof(quantity) != 'undefined' ? quantity : 1;

	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: 'product_id=' + product_id + '&quantity=' + quantity,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information, .error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['success']) {
				//$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				//$('.success').fadeIn('slow');
				
				//$('#cart-total').html(json['total']);
				//instead of it this:
        $('#header>#cart>.content').show('blind','fast');
        $('#header>#cart').addClass('active');
        $('#cart').load('index.php?route=module/cart #cart > *');
        
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
}
function addToWishList(product_id) {
	$.ajax({
		url: 'index.php?route=account/wishlist/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				$('.success').fadeIn('slow');
				
				$('#wishlist-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}	
		}
	});
}

function addToCompare(product_id) { 
	$.ajax({
		url: 'index.php?route=product/compare/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				$('.success').fadeIn('slow');
				
				$('#compare-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
}

/* FILTERING */

var waslastpage = false;
var loadisrunning = false;
var myUrl = "";

function Evenize () {
  $('.product-list').find('.product:even').css("background-color", "#f7f7f7");
}

function EvenizeOrderHistory () {
  $('.order-history').find('.order-list:even').css("background-color", "#f7f7f7");
}

function ScrollToProducts () {
  $('html, body').animate({ scrollTop: $('#product-list').offset().top - 67 }, 600);
}

function ScrollToLastProducts () {
  var productcount = $("#preloader2 .product").length;
  if(productcount < 5) {
    $('html, body').animate({ scrollTop: $('#footer').offset().top-$(window).height()}, 600);
  } else if(productcount == 0) {
  } else {
    $('html, body').animate({ scrollTop: $('#product-list .product:nth-last-child(10)').offset().top}, 600);
  }
}

$(document).ready(function(){
  $("#loadmore").click(function() {
    if(waslastpage == false && loadisrunning == false) {
      loadisrunning = true;
      page++;
      homelink = homelink.replace("?route=common/home","");      
      $('#loadingoverlap').show();
      $('#loadmore').text(textloading).css('cursor','wait');
      myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";  
      $("#preloader").load(myUrl, function(){
        var loadcontent = $("#preloader").find('#product-list').html();
        $("#preloader2").empty().append(loadcontent);
        $("#preloader").empty();
        loadcontent = $("#preloader2").html();
        $("#product-list").append(loadcontent);
        ScrollToLastProducts();        
        $("#preloader2").empty();
        WasLastProducts();                
        CheckboxAllProducts();
        $('#loadingoverlap').hide();
        pagetoload++;
        loadisrunning = false;
      });
    }  
    return false;
  });
});

function ChangeManufacturer (id,name) {
  waslastpage = false;
  if(loadisrunning == false) {
    homelink = homelink.replace("?route=common/home","");
    if(filter_manufacturer_id != id) {
      filter_manufacturer_id = id;
      filter_category_id = "";
      filter_special = "";
      filter_shown = "";
      filter_cheap = "";
      filter_preorder = "";
      filter_bestseller = "";
      pagetoload = 1;
      page = 1;      
      loadisrunning = true;
      $('#loadingoverlap').show();
      $('#platforms').find('.plat-but').css('cursor','wait');
      $('#loadmore').text(textloading).css('cursor','wait');
      myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
      $("#preloader").load(myUrl, function(){
        var loadcontent = $("#preloader").find('#product-list').html();
        $("#preloader2").empty().append(loadcontent);
        $("#preloader").empty();
        loadcontent = $("#preloader2").html();
        $("#product-list").empty().append(loadcontent);
        $("#preloader2").empty();
        WasLastProducts();
        pagetoload++;
        CheckboxAllProducts();
        $('#ch-filter_platform p span').text(decodeEntities(name+' &blacktriangledown;'));
        $('#loadingoverlap').hide();
        ScrollToProducts();
        loadisrunning = false;
      });
    } else {
      filter_manufacturer_id = "";
      pagetoload = 1;
      page = 1;      
      loadisrunning = true;
      $('#loadingoverlap').show();
      $('#platforms').find('.plat-but').css('cursor','wait');
      $('#loadmore').text(textloading).css('cursor','wait');
      myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
      $("#preloader").load(myUrl, function(){
        var loadcontent = $("#preloader").find('#product-list').html();
        $("#preloader2").empty().append(loadcontent);
        $("#preloader").empty();
        loadcontent = $("#preloader2").html();
        $("#product-list").empty().append(loadcontent);
        $("#preloader2").empty();
        WasLastProducts();
        pagetoload++;
        CheckboxAllProducts();
        $('#loadingoverlap').hide();
        ScrollToProducts();
        loadisrunning = false;
      });
    }    
  }  
}

function ChangeCategory (id,name) {
  /*if (window.location.href != homelink+"/") {
    window.location.href = homelink+"/?filter_category_id=" + id;
  } else {*/  
    waslastpage = false;
    if(loadisrunning == false) {
      homelink = homelink.replace("?route=common/home","");
      if(id == 0) {
        id = "";
      }
      if(filter_category_id != id && id != "") {
        filter_category_id = id;
        filter_manufacturer_id = "";
        filter_special = "";
        filter_shown = "";
        filter_cheap = "";
        filter_preorder = "";
        filter_bestseller = "";
        pagetoload = 1;
        page = 1;        
        loadisrunning = true;
        $('#loadingoverlap').show();
        $('#platforms').find('.plat-but').css('cursor','wait');
        $('#loadmore').text(textloading).css('cursor','wait');
        myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
        $("#preloader").load(myUrl, function(){
          var loadcontent = $("#preloader").find('#product-list').html();
          $("#preloader2").empty().append(loadcontent);
          $("#preloader").empty();
          loadcontent = $("#preloader2").html();
          $("#product-list").empty().append(loadcontent);
          $("#preloader2").empty();
          WasLastProducts();
          pagetoload++;
          CheckboxAllProducts();
          $('#ch-filter_category p span').text(decodeEntities(name+' &blacktriangledown;'));
          $('#loadingoverlap').hide();
          ScrollToProducts();
          loadisrunning = false;
        });
      } else {
        filter_category_id = "";
        pagetoload = 1;
        page = 1;        
        loadisrunning = true;
        $('#loadingoverlap').show();
        $('#platforms').find('.plat-but').css('cursor','wait');
        $('#loadmore').text(textloading).css('cursor','wait');
        myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
        $("#preloader").load(myUrl, function(){
          var loadcontent = $("#preloader").find('#product-list').html();
          $("#preloader2").empty().append(loadcontent);
          $("#preloader").empty();
          loadcontent = $("#preloader2").html();
          $("#product-list").empty().append(loadcontent);
          $("#preloader2").empty();
          WasLastProducts();
          pagetoload++;
          CheckboxAllProducts();
          $('#loadingoverlap').hide();
          ScrollToProducts();
          loadisrunning = false;
        });
      }    
    }
  //}    
}

function FilterSpecials () {
  waslastpage = false;
  if(loadisrunning == false) {
    homelink = homelink.replace("?route=common/home","");
    if(filter_special != "true") {
      filter_special = "true";
      filter_manufacturer_id = "";
      filter_category_id = "";
      filter_shown = "";
      filter_cheap = "";
      filter_preorder = "";
      filter_bestseller = "";
      pagetoload = 1;
      page = 1;      
      loadisrunning = true;
      $('#loadingoverlap').show();
      $('.spotlight-button').css('cursor','wait');
      $('#loadmore').text(textloading).css('cursor','wait');
      myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
      $("#preloader").load(myUrl, function(){
        var loadcontent = $("#preloader").find('#product-list').html();
        $("#preloader2").empty().append(loadcontent);
        $("#preloader").empty();
        loadcontent = $("#preloader2").html();
        $("#product-list").empty().append(loadcontent);
        $("#preloader2").empty();
        WasLastProducts();
        pagetoload++;
        CheckboxAllProducts();
        $('#loadingoverlap').hide();
        ScrollToProducts();
        loadisrunning = false;
      });
    } else {
      filter_special = "";
      pagetoload = 1;
      page = 1;      
      loadisrunning = true;
      $('#loadingoverlap').show();
      $('.spotlight-button').css('cursor','wait');
      $('#loadmore').text(textloading).css('cursor','wait');
      myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
      $("#preloader").load(myUrl, function(){
        var loadcontent = $("#preloader").find('#product-list').html();
        $("#preloader2").empty().append(loadcontent);
        $("#preloader").empty();
        loadcontent = $("#preloader2").html();
        $("#product-list").empty().append(loadcontent);
        $("#preloader2").empty();
        WasLastProducts();
        pagetoload++;
        CheckboxAllProducts();
        $('#loadingoverlap').hide();
        ScrollToProducts();
        loadisrunning = false;
      });
    }    
  }  
}

function FilterBestsellers () {
  waslastpage = false;
  if(loadisrunning == false) {
    homelink = homelink.replace("?route=common/home","");
    if(filter_bestseller != "true") {
      filter_bestseller = "true";
      filter_manufacturer_id = "";
      filter_category_id = "";
      filter_special = "";
      filter_shown = "";
      filter_cheap = "";
      filter_preorder = "";
      pagetoload = 1;
      page = 1;      
      loadisrunning = true;
      $('#loadingoverlap').show();
      $('#loadmore').text(textloading).css('cursor','wait');
      myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
      $("#preloader").load(myUrl, function(){
        var loadcontent = $("#preloader").find('#product-list').html();
        $("#preloader2").empty().append(loadcontent);
        $("#preloader").empty();
        loadcontent = $("#preloader2").html();
        $("#product-list").empty().append(loadcontent);
        $("#preloader2").empty();
        WasLastProducts();
        pagetoload++;
        CheckboxAllProducts();
        $('#loadingoverlap').hide();
        ScrollToProducts();
        loadisrunning = false;
      });
    } else {
      filter_bestseller = "";
      pagetoload = 1;
      page = 1;      
      loadisrunning = true;
      $('#loadingoverlap').show();
      $('#loadmore').text(textloading).css('cursor','wait');
      myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
      $("#preloader").load(myUrl, function(){
        var loadcontent = $("#preloader").find('#product-list').html();
        $("#preloader2").empty().append(loadcontent);
        $("#preloader").empty();
        loadcontent = $("#preloader2").html();
        $("#product-list").empty().append(loadcontent);
        $("#preloader2").empty();
        WasLastProducts();
        pagetoload++;
        CheckboxAllProducts();
        $('#loadingoverlap').hide();
        ScrollToProducts();
        loadisrunning = false;
      });
    }    
  }  
}

function FilterPreorders () {
  waslastpage = false;
  if(loadisrunning == false) {
    homelink = homelink.replace("?route=common/home","");
    if(filter_preorder != "true") {
      filter_preorder = "true";
      filter_manufacturer_id = "";
      filter_category_id = "";
      filter_special = "";
      filter_shown = "";
      filter_cheap = "";
      filter_bestseller = "";
      pagetoload = 1;
      page = 1;      
      loadisrunning = true;
      $('#loadingoverlap').show();
      $('#loadmore').text(textloading).css('cursor','wait');
      myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
      $("#preloader").load(myUrl, function(){
        var loadcontent = $("#preloader").find('#product-list').html();
        $("#preloader2").empty().append(loadcontent);
        $("#preloader").empty();
        loadcontent = $("#preloader2").html();
        $("#product-list").empty().append(loadcontent);
        $("#preloader2").empty();
        WasLastProducts();
        pagetoload++;
        CheckboxAllProducts();
        $('#loadingoverlap').hide();
        ScrollToProducts();
        loadisrunning = false;
      });
    } else {
      filter_preorder = "";
      pagetoload = 1;
      page = 1;      
      loadisrunning = true;
      $('#loadingoverlap').show();
      $('#loadmore').text(textloading).css('cursor','wait');
      myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
      $("#preloader").load(myUrl, function(){
        var loadcontent = $("#preloader").find('#product-list').html();
        $("#preloader2").empty().append(loadcontent);
        $("#preloader").empty();
        loadcontent = $("#preloader2").html();
        $("#product-list").empty().append(loadcontent);
        $("#preloader2").empty();
        WasLastProducts();
        pagetoload++;
        CheckboxAllProducts();
        $('#loadingoverlap').hide();
        ScrollToProducts();
        loadisrunning = false;
      });
    }    
  }  
}

function FilterCheap () {
  waslastpage = false;
  if(loadisrunning == false) {
    homelink = homelink.replace("?route=common/home","");
    if(filter_cheap != "true") {
      filter_cheap = "true";
      filter_manufacturer_id = "";
      filter_category_id = "";
      filter_special = "";
      filter_shown = "";
      filter_preorder = "";
      filter_bestseller = "";
      pagetoload = 1;
      page = 1;      
      loadisrunning = true;
      $('#loadingoverlap').show();
      $('#loadmore').text(textloading).css('cursor','wait');
      myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
      $("#preloader").load(myUrl, function(){
        var loadcontent = $("#preloader").find('#product-list').html();
        $("#preloader2").empty().append(loadcontent);
        $("#preloader").empty();
        loadcontent = $("#preloader2").html();
        $("#product-list").empty().append(loadcontent);
        $("#preloader2").empty();
        WasLastProducts();
        pagetoload++;
        CheckboxAllProducts();
        $('#loadingoverlap').hide();
        ScrollToProducts();
        loadisrunning = false;
      });
    } else {
      filter_cheap = "";
      pagetoload = 1;
      page = 1;      
      loadisrunning = true;
      $('#loadingoverlap').show();
      $('#loadmore').text(textloading).css('cursor','wait');
      myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
      $("#preloader").load(myUrl, function(){
        var loadcontent = $("#preloader").find('#product-list').html();
        $("#preloader2").empty().append(loadcontent);
        $("#preloader").empty();
        loadcontent = $("#preloader2").html();
        $("#product-list").empty().append(loadcontent);
        $("#preloader2").empty();
        WasLastProducts();
        pagetoload++;
        CheckboxAllProducts();
        $('#loadingoverlap').hide();
        ScrollToProducts();
        loadisrunning = false;
      });
    }    
  }  
}

function ResetFilters () {
  waslastpage = false;
  if(loadisrunning == false) {
    homelink = homelink.replace("?route=common/home","");
    filter_manufacturer_id = "";
    filter_category_id = "";
    filter_special = "";
    filter_shown = "";
    filter_cheap = "";
    filter_preorder = "";
    filter_bestseller = "";
    pagetoload = 1;
    page = 1;    
    loadisrunning = true;
    $('#loadingoverlap').show();
    $('#loadmore').text(textloading).css('cursor','wait');
    myUrl = homelink + "?route=common/home&filtering=1&filter_bestseller=" + filter_bestseller + "&filter_preorder=" + filter_preorder + "&filter_cheap=" + filter_cheap + "&filter_shown=" + filter_shown + "&filter_category_id=" + filter_category_id + "&filter_manufacturer_id=" + filter_manufacturer_id + "&filter_special=" + filter_special + "&page=" + pagetoload + " #product-list";
    $("#preloader").load(myUrl, function(){
      var loadcontent = $("#preloader").find('#product-list').html();
      $("#preloader2").empty().append(loadcontent);
      $("#preloader").empty();
      loadcontent = $("#preloader2").html();
      $("#product-list").empty().append(loadcontent);
      $("#preloader2").empty();
      WasLastProducts();
      pagetoload++;
      $('.menu > ul > li > div > ul > li > a').removeClass('active');
      $('.menu > ul > li > div > ul > li > a#0').addClass('active');
      CheckboxAllProducts();
      $('#loadingoverlap').hide();
      ScrollToProducts();
      loadisrunning = false;
    });    
  }  
}

function CheckboxSessionProducts () {
  $('#ch-filter_reset').removeClass('active');
  $('#ch-filter_special').removeClass('active');
  $('#ch-filter_cheap').removeClass('active');
  $('#ch-filter_preorder').removeClass('active');
  $('#ch-filter_bestseller').removeClass('active');
  $('#ch-filter_platform').removeClass('active');
  $('#ch-filter_category').removeClass('active');
  $('#ch-filter_platform p span').text(decodeEntities(textselect+' &blacktriangledown;'));
  $('#ch-filter_category p span').text(decodeEntities(textselect+' &blacktriangledown;'));
  if (filter_manufacturer_id != "") {
    $('#ch-filter_platform').addClass('active');
  }
  if (filter_category_id != "") {
    $('.menu > ul > li > div > ul > li > a').removeClass('active');
    $('.menu > ul > li > div > ul > li > a#'+ filter_category_id).addClass('active');
    $('#ch-filter_category').addClass('active');
  } else {
    $('.menu > ul > li > div > ul > li > a').removeClass('active');
    $('.menu > ul > li > div > ul > li > a#0').addClass('active');
  }
  if (filter_special != "") {
    $('#ch-filter_special').addClass('active');
  }
  if (filter_cheap != "") {
    $('#ch-filter_cheap').addClass('active');
  }
  if (filter_preorder != "") {
    $('#ch-filter_preorder').addClass('active');
  }
  if (filter_bestseller != "") {
    $('#ch-filter_bestseller').addClass('active');
  }            
  if (filter_manufacturer_id == "" && filter_category_id == "" && filter_special == "" && filter_shown == "" && filter_cheap == "" && filter_preorder == "" && filter_bestseller == "") {
    $('#ch-filter_reset').addClass('active');
  }
}

function CheckboxAllProducts () {
  if (filter_manufacturer_id == "" && filter_category_id == "" && filter_special == "" && filter_shown == "" && filter_cheap == "" && filter_preorder == "" && filter_bestseller == "") {
    $('#ch-filter_reset').addClass('active');
  } else {
    $('#ch-filter_reset').removeClass('active');
  }
  CheckboxSessionProducts();
}

function WasLastProducts () {
  var productremainder = $('#product-list .product').length % origlimit;  
  if (productremainder == 1) {
    waslastpage = false;
    $('.product').last().remove();
    $('#loadmore').text(textshowmore).css('cursor','pointer').show();        
  } else {
    waslastpage = true;
    $('#loadmore').text(textnomore).css('cursor','default').hide();    
  }
}