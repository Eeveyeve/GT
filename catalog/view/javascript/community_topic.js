$(document).ready(function() {
	
	$("#que_piensas").keyup(function(event){
    if(event.keyCode == 13){
        $("#crear_mensaje").click();
    }
  });
  
  setInterval(function() {
		var parametros = {
			"action"		: 'get_messages',
			"last_message"	: $('#last_message').val(),
			"topic"			: $('#topic_id').val()
        };

		$.ajax({
                data:  parametros,
                url:   'index.php?route=community/topic',
                type:  'post',

               success:  function (response) {
               		var obj = jQuery.parseJSON(response);
					if (obj.reply == 'success') {
						for (index = 0; index < obj.how_much; ++index) {
						$clone = $('#clone_base').clone().attr('id', 'clone_base_' + obj.messages[index].id_msg).appendTo('#messages');
						$(".gravatar", $clone).html('<img src="http://www.gravatar.com/avatar/' + obj.messages[index].gravatar + '?s=25" />');
						$(".message_title", $clone).html('<strong>' + obj.messages[index].body + '</strong>');
						$(".message_by", $clone).html('By ' + obj.messages[index].poster_name + ', <span class="moment" id="' + obj.messages[index].poster_time +'"></span>');
						var actions = '';
						if (obj.actions == 'true') {
							actions = ' - <span id="remove_post_' + obj.messages[index].id_msg + '"><a href="#" class="remove_post" id="' + obj.messages[index].id_msg + '">Remove Post</a></span> - <span id="block_user_' + obj.messages[index].id_msg + '"><a href="#" class="block_user" id="' + obj.messages[index].id_msg + '">Block User</a></span>';
						}
						$(".message_actions", $clone).html('<span id="helpful_' + obj.messages[index].id_msg + '"><a href="#" class="helpful" id="' + obj.messages[index].id_msg + '">Helpful</a></span>' + actions);
						$clone.fadeIn();
						$("input[name='last_message']").val(obj.messages[index].id_msg);
						}
					}
                },
				error: function() {
					$('#status_msg').html('<span class="error">Unable to load the last messages.</span>');
				}
        });
	}, 1000 * 10 * 1);
});