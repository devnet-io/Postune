 $(function() {
	$(".playlist-sortable").sortable({
		items: "tr:not(.table-sort-disable)",
		update: function() {
			var p = $(".playlist-sortable").sortable("serialize")	
			$.post("sort", p)
		}
	});
});
