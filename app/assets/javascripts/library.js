/*
 * Postune
 * Javascript
 * Library JS
 * Code related to general library functions
 * Version 1.0
 */
/*
 * Adds a newly created playlist to the playlist list and focuses it
 */
function appendPlaylists(id, link, name) {
	$("#user-playlists").append("<li id='playlist-" + id + "' class='playlist-item'><a href='" + link + "'>" + name + "</a></li>");
	changeToPlaylist($("#playlist-" + id + " a"));
	$("#user-playlist-wrapper").scrollTop($("#user-playlist-wrapper").outerHeight());
}
