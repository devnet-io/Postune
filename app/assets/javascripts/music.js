$(function() {
	$(".collapsable-title").live("click", function() {
		$(this).next().slideToggle();
	});
});