$(document).ready(function(){
    $(function() {
        window.selectBox = $("#filter-cat select").selectBoxIt().data("selectBoxIt");
    });
    $('.filter-pag a').live('click',function(){
        var u = $(this).attr('href');
        var d = u.split(',');
        filterCat(d[0],d[1],d[2]);
        return false;
    });
});

$('.f-sub .filter-block').livequery(function(){
    $('.f-sub .filter-block input[type=checkbox]').checkBox();
    }
);

function filterCat(start,sort,order) {
    var sub = $('#filter-cat #f-sub option:selected').not('[value = "0"]').toArray();
    var filterCat = [];
    $.each(sub, function(index){
        filterCat[index] = $(this).val();
        
    });
    
    var ssub = $('#filter-cat .f-ssub input:checked').not('[value = "0"]').toArray();
    var filterCats = [];
    $.each(ssub, function(index){
        filterCats[index] = $(this).val();
        
    });
    
    var man = $('#filter-cat #f-man option:selected').not('[value = "0"]').toArray();
    var filterMan = [];
    $.each(man, function(index){
        filterMan[index] = $(this).val();
        
    });
    
    var atr = $('#filter-cat .f-atr option:selected').not('[value = "0"]').toArray();
    var atrArray = [];
    $.each(atr, function(index){
        atrArray[index] = encodeURIComponent($(this).val());
        //alert($(this).val());
    });
    
    var filterPmin = $('#filter-pmin').val() || 0;
    var filterPmax = $('#filter-pmax').val() || 10000;
    
    
    
    
    var filterSort = sort || 'pd.name';
    var filterOrder = order || 'ASC';
    var filterSpecial = $('#f-special').val();
    var filterSearch = $('#f-search').val();
    var start = start || 1;
    var defCat = $('#f-cat').val();
    
    $.ajax({
        url: 'index.php?route=module/filter_cat/ajax_filter',
		type: 'post',
		data: 'filterCat=' + filterCat + '&filterMan=' + filterMan + '&filterAtr=' + atrArray + '&filterPmin=' + filterPmin + '&filterPmax=' +filterPmax + '&filterSort=' + filterSort + '&filterOrder=' + filterOrder + '&defCat=' + defCat + '&start=' + start + '&filterSpecial=' + filterSpecial + '&filterSearch=' + filterSearch + '&filterCats=' + filterCats,
		dataType: 'json',
		success: function(json) {
		  if(json['result'] ) {
		      $.cookie('display', 'grid');
              $('.product-list').addClass('product-grid').removeClass('product-list');
		      $('.product-filter .pagination').html('<span class="filter-pag">'+json['pagination']+'</span>');
              $('.product-filter .sort').html('<span id="filter-sort">'+json['sort']+'</span>');
              $('#column-center .pagination').html('<span class="filter-pag">'+json['pagination']+'</span>');
              $('#f-sort').val(json['filterSort']);
              $('#f-order').val(json['filterOrder']);
              $('.f-sub .filter-block').remove();
              $('.product-grid').html(json['result']);
              
		  }
		}
        
        
        });
    
    
}

