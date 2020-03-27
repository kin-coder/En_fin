document.getElementById('cart-btn-ok').addEventListener('click',showCart)
numberOrder()
function numberOrder(){
	let spa = JSON.parse(sessionStorage.getItem("spa"))
	let massages = JSON.parse(sessionStorage.getItem("massages"))
	let cadeau = JSON.parse(sessionStorage.getItem("cadeau"))
	let prestations = JSON.parse(sessionStorage.getItem("prestations"))
	let number = 0
	let totalPrice = 0
	let spaAndMassage = "<ul class=\"ul-btn\">"
	if (spa) {
		for (var i = spa.length - 1; i >= 0; i--) {
			if(spa[i].time != ""){
				number++
			}
		}
	}
	if (number > 0) {
		spaAndMassage += "<li>Location spa: "+number+" <br> Prix : "+prestations.priceSpa+"€</li>"
		totalPrice+= Number(prestations.priceSpa)
	}

	let numberMassage = 0
	if (massages) {
		for (var i = massages.length - 1; i >= 0; i--) {
			if(typeof(massages[i].sub) != "string"){
				numberMassage++
				number++
			}
		}
	}
	if (numberMassage > 0) {
		spaAndMassage += "<li>Massage : "+numberMassage+" personnes <br>Prix : "+prestations.priceMassage+"€</li>"
		totalPrice+= Number(prestations.priceMassage)
	}
	document.getElementById("cart-inner-prestation").innerHTML = spaAndMassage+"</ul>"

	let htmlCadeau = "<ul class=\"ul-btn\">"
	if (cadeau) {
		for (var i = cadeau.length - 1; i >= 0; i--) {
			number += cadeau[i][1]
			totalPrice += Number(cadeau[i][3])*Number(cadeau[i][1])
			htmlCadeau += "<li>"+cadeau[i][2]+" : "+ Number(cadeau[i][3])*Number(cadeau[i][1]) +"€</li>"
		}
	}

let product=document.getElementById("cart-inner-produit")
if (htmlCadeau != "<ul class=\"ul-btn\">") {
	
	product.innerHTML = htmlCadeau+"</ul>"
	if (prestations.codePromo) {
		document.getElementById("promo-code").innerHTML = prestations.codePromo
	}else{
		document.getElementById("promo-code").innerHTML = "<ul class=\"ul-btn\">Vous n'avez pas inseré un code promo</ul>"
	}
	if (typeof(totalPrice)!= "number") {
		document.getElementById("price-modal-cart").innerHTML = 0+"€"
	}else{
		document.getElementById("price-modal-cart").innerHTML = totalPrice+"€"
	}
	document.getElementById("number-cart-ok").innerHTML = number

} 

else {
	product.innerHTML = "<ul class=\"ul-btn\">Vous n'avez pas commandé des produits</ul>"
	if (prestations.codePromo) {
		document.getElementById("promo-code").innerHTML = prestations.codePromo
	}else{
		document.getElementById("promo-code").innerHTML = "<ul class=\"ul-btn\">Vous n'avez pas inseré un code promo</ul>"
	}
	if (typeof(totalPrice)!= "number") {
		document.getElementById("price-modal-cart").innerHTML = 0+"€"
	}else{
		document.getElementById("price-modal-cart").innerHTML = totalPrice+"€"
	}
	document.getElementById("number-cart-ok").innerHTML = number

}

}

function showCart(){
	numberOrder()
	let cart = document.getElementById("cart-inner-ok")
	if (cart.classList[0] == "hidden"){
		cart.classList.remove("hidden")	
	}else{
		// cart.classList.add("hidden")	
	}
}
