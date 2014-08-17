$(document).ready(function(){
	$('.like-btn').on('click', function(event) {
		event.preventDefault();

		var url = $(this).attr('href')
		$.post(url, function(error) {
			if(error.message !== undefined {
				alert(error.message);
			})
		})
	}) //	$('.like-btn').on('click', function(event) {

	var connection = new WebSocketRails(window.location.host + '/websocket');

	var likesChannel = connection.subscribe('likes');
	likesChannel.bind('new', function(post){
		$('.like-btn[data-post-id=' + post.id + ']' ).text('❤ ' + post.new_like_count);
	})
})