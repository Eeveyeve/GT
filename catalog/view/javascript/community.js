$(document).ready(function() {
	
	setInterval(function() {
		$('.moment').each(function() {
			$(this).html(moment(this.id, "X").fromNow())
		});
	}, 1000 * 5 * 1);
	
	$('.block_user').live("click", (function (event) {
		event.preventDefault();
		var msg = this.id;
        var parametros = {
			"action"	: 'blockUser',
			"mensaje"	: msg,
        };

		$.ajax({
                data:  parametros,
                url:   'index.php?route=community/community',
                type:  'post',
                beforeSend: function () {
					$('#block_user_' + msg).hide();
                },
               success:  function (response) {
               		var obj = jQuery.parseJSON(response);
					if (obj.reply == 'success') {
						$('#block_user_' + msg).html('<span class="was_helpful">The user has been blocked</span>');
						$('#block_user_' + msg).show('slow');
					} else {
						$('#block_user_' + msg).html('<span class="error">An error has ocurred</span>');
						$('#block_user_' + msg).show('slow');
					}
                },
				error: function() {
					$('#block_user_' + msg).html('<span class="error">An error has ocurred, please try again later.</span>');
				}
        });		
	}));
	
	$('.remove_topic').live("click", (function (event) {
		event.preventDefault();
		var msg = this.id;
        var parametros = {
			"action"	: 'removeTopic',
			"topic"	: msg,
        };

		$.ajax({
                data:  parametros,
                url:   'index.php?route=community/community',
                type:  'post',
                beforeSend: function () {
					$('#remove_topic_' + msg).hide();
                },
               success:  function (response) {
               		var obj = jQuery.parseJSON(response);
					if (obj.reply == 'success') {
						$('#clone_base_' + msg).hide('slow');
					} else {
						$('#remove_topic_' + msg).html('<span class="error">An error has ocurred</span>');
						$('#remove_topic_' + msg).show('slow');
					}
                },
				error: function() {
					$('#remove_topic_' + msg).html('<span class="error">An error has ocurred, please try again later.</span>');
				}
        });
	}));
	
	$('.remove_post').live("click", (function (event) {
		event.preventDefault();
		var msg = this.id;
        var parametros = {
			"action"	: 'removePost',
			"mensaje"	: msg,
        };

		$.ajax({
                data:  parametros,
                url:   'index.php?route=community/community',
                type:  'post',
                beforeSend: function () {
					$('#remove_post_' + msg).hide();
                },
               success:  function (response) {
               		var obj = jQuery.parseJSON(response);
					if (obj.reply == 'success') {
						$('#clone_base_' + msg).hide('slow');
					} else {
						$('#remove_post_' + msg).html('<span class="error">An error has ocurred</span>');
						$('#remove_post_' + msg).show('slow');
					}
                },
				error: function() {
					$('#remove_post_' + msg).html('<span class="error">An error has ocurred, please try again later.</span>');
				}
        });
	}));
	
	$('.helpful').live("click", (function (event) {
		event.preventDefault();
		var msg = this.id;
        var parametros = {
			"action"	: 'helpful',
			"mensaje"	: msg,
        };

		$.ajax({
                data:  parametros,
                url:   'index.php?route=community/community',
                type:  'post',
                beforeSend: function () {
					$('#helpful_' + msg).hide();
                },
               success:  function (response) {
               		var obj = jQuery.parseJSON(response);
					if (obj.reply == 'success') {
						$('#helpful_' + msg).html('<span class="was_helpful">This was helpful to you</span>');
						$('#helpful_' + msg).show('slow');
					} else {
						$('#helpful_' + msg).html('<span class="error">' + obj.reason +'</span>');
						$('#helpful_' + msg).show('slow');
					}
                },
				error: function() {
					$('#helpful_' + msg).html('<span class="error">An error has ocurred, please try again later.</span>');
				}
        });		
	}));
	
	$('.moment').each(function() {
		$(this).html(moment(this.id, "X").fromNow())
	});

	$('#crear_mensaje').click(function () {
        var parametros = {
			"action"	: 'post_message',
			"mensaje"	: $('#que_piensas').val(),
			"topic"		: $('#topic_id').val()
        };
		
		$.ajax({
        data:  parametros,
        url:   'index.php?route=community/topic',
        type:  'post',
        beforeSend: function () {
	       $('#send_button').hide();
        	 $('#status_msg').html('<img src="catalog/view/theme/gtv1/image/loading.gif" />');
         },
        success:  function (response) {
       		var obj = jQuery.parseJSON(response);
					if (obj.reply == 'success') {
						$clone = $('#clone_base').clone().attr('id', 'clone_base_' + obj.message_id).appendTo('#messages');
						$(".gravatar", $clone).html('<img src="http://www.gravatar.com/avatar/' + obj.gravatar + '?s=25" />');
						$(".message_title", $clone).html('<span class="message_body">' + parametros.mensaje + '</span>');
						$(".message_by", $clone).html('By ' + obj.who + ', <span class="moment" id="' +obj.poster_time +'">a few seconds ago</span>');
						$(".message_actions", $clone).html('<span id="helpful_' + obj.message_id + '"><a href="#" class="helpful" id="' + obj.message_id + '">Helpful</a></span>' + obj.actions);
						$clone.fadeIn();
						$("input[name='last_message']").val(obj.message_id);
						$('#status_msg').html('');
            $('#que_piensas').val('');
					} else {
						$('#status_msg').html('<span class="error">' + obj.reason + '</span>');
					}
					$('#send_button').show();
        },
        error: function() {
	        $('#status_msg').html('<span class="error">An error has ocurred, please try again.</span>');
        }
    });
	});
	
	
	$('#crear_topic').click(function () {
        var parametros = {
			"action"	: 'post_topic',
			"mensaje"	: $('#que_piensas').val(),
			"board"		: $('#board_id').val()
        };

		$.ajax({
        data:  parametros,
        url:   'index.php?route=community/community',
        type:  'post',
        beforeSend: function () {
	        $('#send_button').hide();
        	$('#status_msg').html('<img src="catalog/view/theme/gtv1/image/loading.gif" />');
        },
        success:  function (response) {
       		var obj = jQuery.parseJSON(response);
					if (obj.reply == 'success') {
						$clone = $('#clone_base').clone().attr('id', 'clone_base_' + obj.id_topic).prependTo('#topics');
						$(".gravatar", $clone).html('<img src="http://www.gravatar.com/avatar/' + obj.gravatar + '?s=50" />');
						$(".topic_title", $clone).html('<a href="index.php?route=community/topic&id=' + obj.topic_id +'">' + parametros.mensaje + '</a>');
						$(".topic_by", $clone).html(obj.who);
						var actions = '';
						if (obj.actions == 'true') {
							actions = ' &bull; <span id="remove_topic_' + obj.id_topic + '"><a href="#" class="remove_topic" id="' + obj.id_topic + '">Remove Topic</a></span> &bull; <span id="block_user_' + obj.id_first_msg + '"><a href="#" class="block_user" id="' + obj.id_first_msg + '">Block User</a></span>';
						}
						$(".topic_actions", $clone).html('<a href="index.php?route=community/topic&id=' + obj.topic_id +'#reply">Reply</a> &bull; <a href="#" class="helpful" id="' +obj.id_first_msg +'">Helpful</a> ' + actions + ' &bull; just now <img class="helpfulicon" src="catalog/view/theme/gtv1/image/helpful.png" />0');
						$clone.fadeIn();
						$("input[name='last_topic']").val(obj.id_topic);
						$('#status_msg').html('');
            $('#que_piensas').val('');
					} else {
						$('#status_msg').html('<span class="error">' + obj.reason + '</span>');
					}
					$('#send_button').show();
        },
       	error: function() {
	        $('#status_msg').html('An error has ocurred, please try again.');
        }
    });
	});
});