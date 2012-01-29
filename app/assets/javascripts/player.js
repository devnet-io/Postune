var cur = ({"id": 0, "position": 0, "playlist": 0, "url": "", "type": 0});
	
$(function() {
	$(document).ready(function() {
		calibrateMain();
		$("#user-playlists a:first").parent().toggleClass("selected");
	}); 
	$("#user-playlists a").live("click", function(event) {
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
	$(window).resize(function() {
		calibrateMain();
	});
});

function calibrateMain() {
	$("#playlist-loaded").height($(window).height() - ($("header").outerHeight(true) + $("#actions").outerHeight() + $("#player").height()));
	$("#user-playlist-wrapper").height($(window).height() - ($("header").outerHeight(true) + $("#actions").outerHeight() + $("#player").height()));
}

function changeSong(id, url, type, playlist, position) {
	play(type, url, id);
	storeNowPlaying(position, playlist, url, id, type);
}

function storeNowPlaying(position, playlist, url, id, type) {
	cur.playlist = playlist;
	cur.position = position;
	cur.url = url;
	cur.id = id;
	cur.type = type;
}

function play(type, url, id) {
	if(cur.type == 1) {
		ytplayer.stopVideo();
	} else if(cur.type == 2) {
		soundManager.stopAll();
	}	
	if(type == 1) {
		ytplayer.cueVideoById(id);
		ytplayer.playVideo();
	} else if(type == 2) {
		startSong(url);
	}	
}

function clearNowPlaying() {
	curPlaylist = 0;
	curSong = 0;
}

function clearSelected() {
	$(".selected").removeClass("selected");
}

function changeNowPlaying(div) {
	$(".playlist-playing").removeClass("playlist-playing");
	div.toggleClass("playlist-playing");
}

function changeWindow(div) {
	$.get(div, function(html) {
		clearSelected();
		$("#main-library-window").html(html);
	});
}

function changeToPlaylist(link) {
	if($("#playlist-loaded").length == 0) {
		$("#main-library-window").html("<div id='playlist-loaded'></div>");
		calibrateMain();
	}
	playlist_id = link.attr("href").split("player/")[1];
	$.get(link.attr("href"), function(playlist) {
		$("#playlist-loaded").html(playlist);
		if(cur.playlist == playlist_id) {
			$("#" + curSong).toggleClass("playlist-playing");
		}
	});
	clearSelected();
	$(link).parent().toggleClass("selected");
}
