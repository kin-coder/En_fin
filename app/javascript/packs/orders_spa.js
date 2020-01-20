runJS()
function runJS(){
	const service_name = document.getElementById("form").dataset.service
	if(sessionStorage.getItem("service") != service_name ){
		initSession()
	}else{
		addDomIndex()
	}
}
// initialiser la session
function initSession(){
	sessionStorage.setItem("products","[]")
	sessionStorage.setItem("prestations","[]")
	sessionStorage.setItem("input",0)
	let form = document.getElementById("form")
	sessionStorage.setItem("service",form.dataset.service)
}
// Remetre les valeur dans le DOM après l'actualisation ou autre
function addDomIndex(){
	let sessionPrestation = JSON.parse(sessionStorage.getItem("prestations"))
	for (var i = 0 ; i < sessionPrestation.length ; i++) {
		let longeurs = sessionPrestation[i].id
		let subcategory = sessionPrestation[i].list
		addlistSubInDom(subcategory,longeurs)
	}

	let sessionProduits = JSON.parse(sessionStorage.getItem("products"))
	for (var i = 0 ; i < sessionProduits.length ; i++) {
		addProduitInDom(sessionProduits[i].list)
	}
}

/* Ajouts et suppresion d'element dans la liste prestations */
const prestations = document.querySelectorAll('.posibilities-presation');
prestations.forEach(prestation => {
	prestation.addEventListener('click',addChoiceSubCategory);
});

function addChoiceSubCategory(){
	let posibilities = JSON.parse(document.getElementById("form").dataset.zones)
	for (var i = 0 ; i < posibilities.length ; i++) {
		if(posibilities[i][1] == this.dataset.hourse){
			var subcategory = posibilities[i]
		}
	}
	if (this.dataset.action == "new") {
		// Mise a jour session
		let longeurs = JSON.parse(sessionStorage.getItem("input")) + 1
		sessionStorage.setItem("input",longeurs)
		let sessionPrestation = JSON.parse(sessionStorage.getItem("prestations"))
		sessionPrestation.push({ "id":longeurs,"list":subcategory})
		sessionStorage.setItem("prestations",JSON.stringify(sessionPrestation))
		// Ajout dans la list des choix possible
		addlistSubInDom(subcategory,longeurs)
	}
	if (this.dataset.action == "delete") {
		// Mise a jour session
		let sessionPrestation = JSON.parse(sessionStorage.getItem("prestations"))
		for (var i = sessionPrestation.length - 1; i >= 0; i--) {
			if (sessionPrestation[i].list[0] == subcategory[0]){
				sessionPrestation.splice(i,1)
				break
			}
		}
		sessionStorage.setItem("prestations",JSON.stringify(sessionPrestation))
		// Supprimer l'element dans la liste
		let nombres = document.getElementsByClassName("group-form-"+subcategory[1]+"h")
		if(nombres.length > 0){
			nombres[nombres.length - 1].remove()
			totalPrice()
		}
		// Mise a jour du panier
		if(nombres.length == 0){
			let panier = document.getElementById("group-panier-"+subcategory[1]+"h")
			panier.className = "hidden"
		}else{
			document.getElementById("number-panier-"+subcategory[1]+"h").innerHTML = nombres.length
			document.getElementById("price-panier-"+subcategory[1]+"h").innerHTML = nombres.length * subcategory[2]
		}
		document.getElementById("puts-number-"+subcategory[1]+"h").innerHTML = nombres.length
	}
}

function addlistSubInDom(subcategory,longeurs){
	let div_principale = document.getElementById("list-prestation")
	let div = document.createElement("div")
	div.classList.add("group-form-"+subcategory[1]+"h")
	div.innerHTML = "<hr><h4 id=\"add\">Location Spa pour "+ subcategory[1] +"H à "+ subcategory[2] +" €</h4><div class=\"allCategoriSpa\"><input type=\"hidden\" name=\"subcategory[]\" value=\""+ subcategory[0] +"\"><div class=\"addCategoriSpa\"><i class=\"fa fa-hand-o-right\" aria-hidden=\"true\" id=\"fa\"></i><label for=\"logement"+ longeurs +"\">Type de logement</label><select name=\"prestations["+ longeurs +"][]\" id=\"logement"+ longeurs +"\" class=\"selectElement\"><option value=\"0\">Appartement</option><option value=\"1\">Villa - Maison</option></select></div><div class=\"addCategoriSpa\"><i class=\"fa fa-hand-o-right\" aria-hidden=\"true\" id=\"fa\"></i><label for=\"installation"+ longeurs +"\">Type d\'installation</label><select name=\"prestations["+ longeurs +"][]\" id=\"installation"+ longeurs +"\" class=\"selectElement\"><option value=\"0\">Intérieur</option><option value=\"1\">Extérieur</option></select></div><div class=\"addCategoriSpa\"><i class=\"fa fa-hand-o-right\" aria-hidden=\"true\" id=\"fa\"></i><label for=\"eau"+ longeurs +"\">Système d'eau</label><select name=\"prestations["+ longeurs +"][]\" id=\"eau"+ longeurs +"\" class=\"selectElement\"><option value=\"0\">Cumulus - Ballon d'eau (eau chaude limitée)</option><option value=\"1\">Chaudière (eau chaude continue)</option></select></div></div>"
	div_principale.appendChild(div)
	// Ajout dans le panier
	let panier = document.getElementById("group-panier-"+subcategory[1]+"h")
	panier.className = ""
	let nombres = document.getElementsByClassName("group-form-"+subcategory[1]+"h").length		
	document.getElementById("number-panier-"+subcategory[1]+"h").innerHTML = nombres
	document.getElementById("price-panier-"+subcategory[1]+"h").innerHTML = nombres * subcategory[2]
	// Sur le bouttons
	document.getElementById("puts-number-"+subcategory[1]+"h").innerHTML = nombres
	document.getElementById("info-spa").className ="hidden"
	totalPrice()
}
// Pour calculer la prix total
function totalPrice(){
	let sessionPrestation = JSON.parse(sessionStorage.getItem("prestations"))
	let prixTotal = 0
	for (var i = 0 ; i < sessionPrestation.length ; i++) {
		let subcategory = sessionPrestation[i].list
		prixTotal += subcategory[2]
	}

	let sessionProduits = JSON.parse(sessionStorage.getItem("products"))
	for (var i = 0 ; i < sessionProduits.length ; i++) {
		prixTotal += sessionProduits[i].list[2]
	}

	if (prixTotal == 0){
		document.getElementById("info-spa").className =""
	}
	document.getElementById("priceTotale").innerHTML = prixTotal.toFixed(2)
}

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Ajouts et suppresion d'element dans la liste des produits */
const products = document.querySelectorAll('.btn-produits');
products.forEach(product => {
	product.addEventListener('click',addProduitOnSubmit);
});

function addProduitOnSubmit(){
	let currentProduit = JSON.parse(this.dataset.zones)
	// Ajout
	if (this.dataset.action == "new") {
		let sessionPrestation = JSON.parse(sessionStorage.getItem("products"))
		sessionPrestation.push({ "list":currentProduit})
		sessionStorage.setItem("products",JSON.stringify(sessionPrestation))
		addProduitInDom(currentProduit)
	}
	// Suppression
	if (this.dataset.action == "delete") {
		let sessionPrestation = JSON.parse(sessionStorage.getItem("products"))
		for (var i = sessionPrestation.length - 1; i >= 0; i--) {
			if (sessionPrestation[i].list[0] == currentProduit[0]){
				sessionPrestation.splice(i,1)
				break
			}
		}
		sessionStorage.setItem("products",JSON.stringify(sessionPrestation))
		// Suppresion in panier et formulaire
		let nombres = document.getElementsByClassName("hidden-"+currentProduit[0])
		if (nombres.length > 0) {
			nombres[nombres.length - 1 ].remove()
			document.getElementById("produits-number-"+currentProduit[0]).innerHTML = nombres.length
			let addp = document.getElementById("name-"+currentProduit[0])
			if (nombres.length == 0) {
				addp.remove()
			}else{
				addp.innerHTML = listInputProduit(currentProduit,nombres)
			}
		}
		// Prix total
		totalPrice()
	}

}

function addProduitInDom(currentProduit){
	totalPrice()
	// Ajout dans le formulaire
	let divp = document.getElementById("all-produits")
	let input = document.createElement("input")
	input.classList.add("hidden-"+currentProduit[0])
	input.setAttribute("value",currentProduit[0])
	input.setAttribute("name","products[]")
	input.setAttribute("type","hidden")
	divp.appendChild(input)
	// Ajout dans le panier
	let panier = document.getElementById("list-produits")
	let nombres = document.getElementsByClassName("hidden-"+currentProduit[0])
	document.getElementById("produits-number-"+currentProduit[0]).innerHTML = nombres.length
	if( nombres.length > 1 ){
		let addp = document.getElementById("name-"+currentProduit[0])
		addp.innerHTML = listInputProduit(currentProduit,nombres)
	}else{
		let addp = document.createElement("div")
		addp.setAttribute("id","name-"+currentProduit[0])
		addp.innerHTML = listInputProduit(currentProduit,nombres)
		panier.appendChild(addp)
	}
}


function listInputProduit(currentProduit,nombres){
	return "<li>"+ currentProduit[1] +"</li><li>nombre : "+nombres.length+" Prix: "+ (nombres.length*currentProduit[2]).toFixed(2) +"</li>"
}
/*

<input type="hidden" name="products[]" value="2" class="hidden-2">
<input type="hidden" name="products[]" value="1" class="hidden-1">
<input type="hidden" name="products[]" value="2" class="hidden-2">
*/