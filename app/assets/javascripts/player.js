/*
 * Postune
 * Javascript
 * Player JS
 * Music player application javascript
 * Version 1.0
 */


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


function changeNowPlaying(div) {
	$(".playlist-playing").removeClass("playlist-playing");
	div.toggleClass("playlist-playing");
}

