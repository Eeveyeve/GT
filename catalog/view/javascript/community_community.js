$(document).ready(function() {
	
	$("#que_piensas").keyup(function(event){
    if(event.keyCode == 13){
        $("#crear_topic").click();
    }
  });
  
  setInterval(function() {

		var parametros = {
			"action"		: 'getTopics',
			"last_topic"	: $('#last_topic').val(),
			"board"			: $('#board_id').val()
        };

		$.ajax({
                data:  parametros,
                url:   'index.php?route=community/community',
                type:  'post',

               success:  function (response) {
			   
               		var obj = jQuery.parseJSON(response);
					if (obj.reply == 'success') {
						for (index = 0; index < obj.how_much; ++index) {
						$clone = $('#clone_base').clone().attr('id', 'clone_base_' + obj.topics[index].id_topic).prependTo('#topics');
						$(".gravatar", $clone).html('<img src="http://www.gravatar.com/avatar/' + obj.topics[index].gravatar + '?s=50" />');
						$(".topic_title", $clone).html('<a href="index.php?route=community/topic&id=' + obj.topics[index].id_topic + '">' + obj.topics[index].body + '</a>');
						$(".topic_by", $clone).html(obj.topics[index].poster_name);
						var actions = '';
						if (obj.actions == 'true') {
							actions = ' &bull; <span id="remove_topic_' + obj.topics[index].id_topic + '"><a href="#" class="remove_post" id="' + obj.topics[index].id_topic + '">Remove Post</a></span> &bull; <span id="block_user_' + obj.topics[index].id_first_msg + '"><a href="#" class="block_user" id="' + obj.topics[index].id_first_msg + '">Block User</a></span>';
						}
						$(".topic_actions", $clone).html('<a href="index.php?route=community/topic&id=' + obj.topics[index].id_topic +'#reply">Reply</a> &bull; <a href=""<span id="helpful_' + obj.topics[index].id_first_msg + '"><a href="#" class="helpful" id="' + obj.topics[index].id_first_msg + '">Helpful</a></span>' + actions + ' &bull; <span class="moment" id="' + obj.topics[index].poster_time +'"></span> <img class="helpfulicon" src="catalog/view/theme/gtv1/image/helpful.png" />'+ obj.topics[index].helpful);
						$clone.fadeIn();
						$("input[name='last_topic']").val(obj.topics[index].id_topic);
						}
					} 
                },
				error: function() {
					$('#status_msg').html('<span class="error">Unable to load the last topics.</span>');
				}
        });
	}, 1000 * 10 * 1);
});