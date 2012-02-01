/*
 * Postune
 * Javascript
 * Player Load JS
 * What to do when the player first loads. Also binds various event handlers.
 * Version 1.0
 */
var cur = ({"id": 0, "position": 0, "playlist": null, "url": "", "type": 0});
	
$(function() {
	$(document).ready(function() {
		calibrateMain();
		makeSortable();
		$(".playlist-item:first").toggleClass("selected");
	}); 
	$(".playlist-item a").live("click", function(event) {
		event.preventDefault();
		changeToPlaylist($(this));
	});
	$(".playlist-list-song").live("click", function(event) {
		$.get($(this).find(".playlist-song").attr("href"));
		changeNowPlaying($(this));
		event.preventDefault();
	});
	$(".user-nav").live("click", function() {
		$("#user-hidden-menu").css("left", $(document).outerWidth() - $("#user-hidden-menu").outerWidth() - 10 + "px");
		$("#user-hidden-menu").toggle();
		$(".user-nav").toggleClass("user-nav-open");
	});
	$(".sortable_column").live("click", function(event) {
		$.get($(this).attr("href"), function(playlist) {
			$("#playlist-loaded").html(playlist);
			if(cur.playlist == playlist_id) {
				$(".pos_" + cur.position).toggleClass("playlist-playing");
			}
		});
		event.preventDefault();
	});
	$(window).resize(function() {
		calibrateMain();
	});
});
