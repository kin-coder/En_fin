main()

function main(){
	let zone = sessionStorage.getItem("zone");
	if (zone == null) {
		$("#number-cart-ok").html(0);
	}else{
		zone = JSON.parse(sessionStorage.getItem("zone"));
		$("#number-cart-ok").html(zone.nbr_spa + zone.nbr_massage);
	}
}

$("#cart-btn-ok").click(function(){
	let zone = sessionStorage.getItem("zone")
	let prestationDom = "<ul class=\"ul-btn\">";
	if (zone === null) {
		prestationDom = "Vous n'avez pas encore reserver une prestation";
		$("#promo-code").html("Vous n'avez pas inseré un code promo");
		$("#number-cart-ok").html(0)
	}else{
		zone = JSON.parse(zone);
		$("#number-cart-ok").html(zone.nbr_spa + zone.nbr_massage);
		if (  (zone.nbr_spa == 0 && zone.nbr_massage == 0) ) {
			prestationDom = "Vous n'avez pas encore reserver une prestation";
			$("#number-cart-ok").html(0)
		}else{
			if (zone.nbr_spa > 0) {
				prestationDom += "<li>Location spa: "+zone.nbr_spa+" <br> Prix : "+zone.price_spa+"€</li>";
			}
			if (zone.nbr_massage > 0) {
				prestationDom += "<li>Massage : "+zone.nbr_massage+" personne(s) <br>Prix : "+zone.price_massage+"€</li>";
			}
			$("#number-cart-ok").html(zone.nbr_spa + zone.nbr_massage)
		}
		if(zone.code == null){
			$("#promo-code").html("Vous n'avez pas inseré un code promo");
		}else{
			$("#promo-code").html("Votre code promo "+ zone.code[0] +" est valide.");
		}
		$("#price-modal-cart").html(zone.price_spa + zone.price_massage)
	}
	$("#cart-inner-prestation").html(prestationDom+"</ul>");
});
