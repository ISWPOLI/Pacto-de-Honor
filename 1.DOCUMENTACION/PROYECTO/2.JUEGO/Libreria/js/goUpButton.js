$(document).ready(function(){
	$(".goUp").click(function(){
		$("body, html").animate({
			scrollTop:"0px"
		}, 300);
	});
	
	$(window).scroll(function(){
		if($(this).scrollTop() > 200){
			$(".goUp").slideDown(300);
		}else{
			$(".goUp").slideUp(300);
		}
	});
	
});