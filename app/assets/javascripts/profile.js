$(function() {
	$("#user-playlists a").live("click", function(event) {
		$.get(this.href, function(test) {
			$("#playlist-loaded").html(test);
		});
		$(".selected").removeClass("selected");
		$(this).toggleClass("selected");
		event.preventDefault();
	});
});

$(function() {
	$(document).ready(function() {
		$("#user-playlists a:first").toggleClass("selected");
		resize();
	});
	$(window).resize(function() {
		resize();
	});
});

function resize() {
	$("#main").height($(window).height() - $("header").height() - 150);
	$("#user-playlist-wrapper").height($("#main").height());
	$("#playlist-loaded").height($("#main").height());
}
