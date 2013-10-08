$(function() {
  if ($(".post-area").length > 0) {
    setTimeout(updateMessages, 1000);
  }

	$(".message").click(function(){
		window.location.href = "/messages/"+$(this).attr('data-id');
	})
});

function updateMessages () {
	$(".date").timeago();
  	if ($(".message").length > 0) {
    	var after = $(".message:first-child").attr("data-time");
  	} else {
    	var after = "0";
  	}
	$.getScript("/messages.js?after=" + after)
  	setTimeout(updateMessages, 1000);
}