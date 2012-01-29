var curPlaylist = 0,
	curSong = 0;

$(function() {
	$(document).ready(function() {
		calibrateMain();
		$("#user-playlists a:first").parent().toggleClass("selected");
	}); 
	$("#user-playlists a").live("click", function(event) {
		playlist_id = this.href.split("player/")[1]
		$.get(this.href, function(playlist) {
			$("#playlist-loaded").html(playlist);
			if(curPlaylist == playlist_id) {
				$("#" + curSong).toggleClass("playlist-playing");
			}
		});
		$(".selected").removeClass("selected");
		$(this).parent().toggleClass("selected");
		event.preventDefault();
	});
	$(".playlist-song").live("click", function(event) {
		$.get(this.href);
		changeNowPlaying($(this).parent().parent());
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
	storeNowPlaying(position, playlist);
	if(type == 1) {
		ytplayer.cueVideoById(id);
		ytplayer.playVideo();
	} else if(type == 2) {
		$("#soundcloud-player .sc-player").scPlayer({
			links: [{url: url}],
			autoPlay: true
		});
	}
}

function storeNowPlaying(position, playlist) {
	curPlaylist = playlist;
	curSong = position;
}

function clearNowPlaying() {
	curPlaylist = 0;
	curSong = 0;
}

function changeNowPlaying(div) {
	$(".playlist-playing").removeClass("playlist-playing");
	div.toggleClass("playlist-playing");
}

function play() {
	
}

function pause() {
	
}
