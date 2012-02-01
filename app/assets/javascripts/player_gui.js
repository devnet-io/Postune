/*
 * Postune
 * Javascript
 * Player GUI JS
 * Methods that relate to the GUI of the music player
 * Version 1.0
 */

 function calibrateMain() {
	$("#playlist-loaded").height($(window).height() - ($("header").outerHeight(true) + $("#actions").outerHeight() + $("#player").height() + 35));
	$("#user-playlist-wrapper").height($(window).height() - ($("header").outerHeight(true) + $("#actions").outerHeight() + $("#player").height() + 35));
}

function clearSelected() {
	$(".selected").removeClass("selected");
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
			$(".pos_" + cur.position).toggleClass("playlist-playing");
		}
		makeSortable();
	});
	clearSelected();
	link.parent().toggleClass("selected");
}

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
