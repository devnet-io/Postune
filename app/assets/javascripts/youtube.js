function onPlayerError(errorCode) {
	alert("An error occured of type:" + errorCode);
}

function onPlayerStateChange(newState) {
	if(newState == 0) {
		nextSong();
	} else if(newState == 1) {
		
	}
}

function updatePlayerInfo() {
	if(ytplayer && ytplayer.getDuration) {
		
	}
}

function setVideoVolume() {
	if(ytplayer){
		ytplayer.setVolume();
	}
}

function pauseVideo() {
	if (ytplayer) {
		ytplayer.pauseVideo();
	}
}

function muteVideo() {
	if(ytplayer) {
		ytplayer.mute();
	}
}

function unMuteVideo() {
	if(ytplayer) {
		ytplayer.unMute();
	}
}

function onYouTubePlayerReady(playerId) {
	ytplayer = document.getElementById("ytPlayer");
	setInterval(updatePlayerInfo, 250);
	updatePlayerInfo();
	ytplayer.addEventListener("onStateChange", "onPlayerStateChange");
	ytplayer.addEventListener("onError", "onPlayerError");
}

function loadPlayer() {
	var params = {allowScriptAccess: "always"};
	var atts = {id: "ytPlayer"};
	swfobject.embedSWF("http://www.youtube.com/apiplayer?" + "version=3&enablejsapi=1&playerapiid=player1", "youtube-player", "1", "1", "9", null, null, params, atts);
}

function _run() {
	loadPlayer();
}
google.setOnLoadCallback(_run);
