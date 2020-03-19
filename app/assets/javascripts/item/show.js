$(function(){ 
	var mySwiper1 = new Swiper('.swiper1', {
		loop: true,
		loopedSlides: (".swiper1").length,
		navigation: {
			nextEl: '.next1',
			prevEl: '.prev1',
		},
		pagination: {
			el: '.swiper-pagination',
			type: 'bullets',
			clickable: true,
		},
	});
	var mySwiper2 = new Swiper('.swiper2', {
		loop: true,
		loopedSlides: (".swiper2").length,
		slideToClickedSlide: true,
		centeredSlides: true,
		slidesPerView: 3,
		controller: {
			control: mySwiper1,
			by: 'slide',
		},
	});
	mySwiper1.controller.control = mySwiper2;
});