function appendPlaylists(id, link, name) {
	$("#user-playlists").append("<li id='playlist-" + id + "' class='playlist-item'><a href='" + link + "'>" + name + "</a></li>");
	changeToPlaylist($("#playlist-" + id + " a"));
	$("#user-playlist-wrapper").scrollTop($("#user-playlist-wrapper").outerHeight());
}
