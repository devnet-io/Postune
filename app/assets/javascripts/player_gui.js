/*
 * Postune
 * Javascript
 * Player GUI JS
 * Methods that relate to the GUI of the music player
 * Version 1.0
 */
 /*
  * Makes the main div the height of the screen
  */
 function calibrateMain() {
	$("#main-library-window").height($(window).height() - ($("header").outerHeight(true) + $("#actions").outerHeight() + $("#player").height() + 35));
	$("#user-playlist-wrapper").height($(window).height() - ($("header").outerHeight(true) + $("#actions").outerHeight() + $("#player").height() + 35));
}
/*
 * Removes selected class from playlist
 */
function clearSelected() {
	$(".selected").removeClass("selected");
}
/*
 * Makes a playlist sortable
 */
function makeSortable() {
	$(".playlist-sortable").sortable({
		items: "tr:not(.table-sort-disable)",
		axis: "y",
		update: function() {
			var p = $(".playlist-sortable").sortable("serialize");
			$.post("sort", p);
		}
	});
}
/*
 * Marks a song in the playlist as playing
 */
function changeNowPlaying(div) {
	$(".playlist-playing").removeClass("playlist-playing");
	div.toggleClass("playlist-playing");
}

