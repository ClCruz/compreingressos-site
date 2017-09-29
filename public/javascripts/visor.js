jQuery(document).ready(function(){
	jQuery('#imagemVisor1').fadeIn();
});

var intervalo = window.setInterval(visorSlideShow, 4000);

function changeVisor(imagem,button) {
	jQuery('.botaoVisor').removeClass('selected');
	jQuery(button).addClass('selected');
	jQuery(button).blur();
	clearInterval(intervalo);
	jQuery('.imagemVisor').hide();
	jQuery(imagem).fadeIn('slow');
}

function visorSlideShow() {
	if (typeof visorSlideShow.imagemAtiva == 'undefined') {
		visorSlideShow.imagemAtiva = 1;
	}

	var selector = '#imagemVisor'+visorSlideShow.imagemAtiva;
	jQuery(selector).hide();
	visorSlideShow.imagemAtiva++;
	selector = '#imagemVisor'+visorSlideShow.imagemAtiva;
	
	if (jQuery(selector).length == 0) {
		visorSlideShow.imagemAtiva = 1;
		selector = '#imagemVisor'+visorSlideShow.imagemAtiva;
	}
	jQuery(selector).fadeIn('slow');
}