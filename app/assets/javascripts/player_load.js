/*
 * Postune
 * Javascript
 * Player Load JS
 * What to do when the player first loads. Also binds various event handlers.
 * Version 1.0
 */
/*
 * Initialize values for the currently playing item
 */
var cur = 	{
				"id": 0, 
				"position": 0, 
				"playlist": null, 
				"url": "", 
				"type": 0,
				"sort": "position",
				"dir": "asc"
			};
/*
 * Songs holds the songs of the playlist that is currently playing
 */
var songs = { };
/* 
 * Cur_loaded_playlist holds the songs of the playlist that is currently loaded in the window
 */
var cur_loaded_playlist = { };
	
$(function() {
	/*
	 * Set the main to take up the full window, make the initial song table sortable, and toggle selected on the library playlist 
	 */
	$(document).ready(function() {
		calibrateMain();
		makeSortable();
		$(".playlist-item:first").toggleClass("selected");
	}); 
	/*
	 * Start playing a song on click
	 */
	$(".playlist-list-song").live("click", function(event) {
		$.get($(this).find(".playlist-song").attr("href"));
		changeNowPlaying($(this));
		event.preventDefault();
	});
	/*=
	 * Load the user's menu on click
	 */
	$(".user-nav").live("click", function() {
		$("#user-hidden-menu").css("left", $(document).outerWidth() - $("#user-hidden-menu").outerWidth() - 10 + "px");
		$("#user-hidden-menu").toggle();
		$(".user-nav").toggleClass("user-nav-open");
	});
	/* 
	 * Reload playlist based on sort parameters
	 */
	$(".sortable_column").live("click", function(event) {
		processSort(GET($(this).attr("href")));
		playlist_id = link.attr("href").split("player/")[1];
		$.get($(this).attr("href"), function(playlist) {
			$("#playlist-loaded").html(playlist);
			if(cur.playlist == playlist_id) {
				$(".pos_" + cur.position).toggleClass("playlist-playing");
			}
		});
		event.preventDefault();
	});
	$(".playlist-playing").live("click", function(event) {
		/* Fill out*/
		event.preventDefault();
	});
	/*
	 * Show new search results form
	 */
	$(".show-new-form").live("click", function(event) {
		$(this).parent().prev().slideToggle();
		event.preventDefault();
	});
	/* 
	 * Calibrate the window whenever the window is resized
	 */
	$(window).resize(function() {
		calibrateMain();
	});
});
/*
 * Returns params from a url
 */
function GET(url) {
	var params = url.split("?")[1].split("&");
	var json_param = "";
	for(var i = 0; i < params.length; i++) {
		var val = params[i].split("=");
		json_param = json_param + "\"" + val[0] + "\"" + ": \"" + val[1] + "\",";
	}
	return "{" + json_param.substr(0, json_param.length - 1) + "}";
}
/*
 * Processes the new sort variables and stores them into the corresponding current variables
 */
function processSort(json) {
	var sortParams = $.parseJSON(json);
	cur.sort = sortParams.sort;
	cur.dir = sortParams.dir;
}