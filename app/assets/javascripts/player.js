/*
 * Postune
 * Javascript
 * Player JS
 * Music player application javascript
 * Version 1.0
 */
/*
 * Changes to a song with parameters
 */
function changeSong(id, url, type, playlist, position) {
	storeNowPlaying(id, url, type, playlist, position);
	play(type, url, id);
	songs = cur_loaded_playlist;
}
/*
 * Stores information about song in javascript variable
 */
function storeNowPlaying(id, url, type, playlist, position) {
	cur.playlist = playlist;
	cur.position = position;
	cur.url = url;
	cur.id = id;
	cur.type = type;
}
/*
 * Plays a song
 */
function play(type, url, id) {
	if(type == 1) {
		ytplayer.loadVideoById(id);
	} else if(type == 2) {
		scStartSong(url);
	}	
}
/*
 * Stops all currently playing music
 */
function stopAll() {
	if(cur.type == 1) {
		ytplayer.stopVideo();
	} else if(cur.type == 2) {
		scStopAll();
	}		
}
/*
 * Change to next song
 */
function nextSong() {
	for(var i = 0; i < songs.length; i++) {
		if(cur.position == songs[i].position) {
			$.get("/change/" + songs[i+1].playlist_id + "?song=" + songs[i+1].position);
			break;
		}
	}
}
/*
 * Change to previous song
 */
function previousSong() {
	for(var i = 0; i < songs.length; i++) {
		if(cur.position == songs[i].position) {
			$.get("/change/" + songs[i-1].playlist_id + "?song=" + songs[i-1].position);
			break;
		}
	}
}

/*
 * Event Handlers for the Music Player
 */
 $(function() {
 	$("#next-song").live("click", function() {
		nextSong();
	});
	$("#previous-song").live("click", function() {
		previousSong();
	});
	$("#stop-song").live("click", function() {
		stopAll();
	});
 });
