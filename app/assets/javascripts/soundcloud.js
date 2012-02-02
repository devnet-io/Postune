var consumerkey = "33f255a6f2a015cd2bf4c80dc37ebcf7";

soundManager.url = '/swf/';
soundManager.flashVersion = 9;
soundManager.useFlashBlock = false;
soundManager.useHighPerformance = true;
soundManager.wmode = 'transparent';
soundManager.useFastPolling = true;

function scStartSong(url) {
	$.getJSON('http://api.soundcloud.com/resolve?url=' + url + '&format=json&consumer_key=' + consumerkey + '&callback=?', function(track) {
		url = track.stream_url;		
		(url.indexOf("secret_token") == -1) ? url = url + '?' : url = url + '&';
		url = url + 'consumer_key=' + consumerkey;
		soundManager.createSound({
			id: 'track_' + track.id,
			url: url,
			autoPlay: true,
			onfinish: function() {
				nextSong();
			}
		});	
	});
};

function scStopSong() {
	soundManager.stopAll();
}