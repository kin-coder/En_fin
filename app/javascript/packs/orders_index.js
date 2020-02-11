function scriptPrincipal(){
	// let data = document.getElementById('form-data').dataset
	// let dataMassages = JSON.parse(data.massages)

	let removeSpa = document.getElementsByClassName("remove-spa")[0]
	let addSpa = document.getElementsByClassName("add-spa")[0]

	removeSpa.addEventListener('click',removeSpaList)
	addSpa.addEventListener('click',addSpaList)

	let prestations = sessionStorage.getItem("prestations")
	if( prestations == undefined || prestations ){
		initSession()
	}else{
		addDomIndex()
	}
}

scriptPrincipal()

function initSession(){
	sessionStorage.setItem("prestations","[]")
	sessionStorage.setItem("spa","[]")
	sessionStorage.setItem("massages","[]")
	sessionStorage.setItem("input",0)
}
// remettre les elements si un l'user a actualisé
function addDomIndex(){
	// body...
}

// evenement on click
function addSpaList(){
	let data = document.getElementById('form-data').dataset
	let dataSpas = JSON.parse(data.spas)
	// spa.duration,spa.exceptional_price,spa.ordinary_price,spa.exceptional_acompte,spa.ordinary_acompte
	let dataSpaoptions = JSON.parse(data.spaoptions)
	

	let div = document.createElement('div')
	div.classList.add('spa-list-prestations')




	document.getElementById('spa-input').appendChild(div)
}
// evenement on click
function removeSpaList(){
	alert("Mete le mamafa")
}


// JSON.stringify()

/*
runJS()
function runJS(){
	const service_name = document.getElementById("form").dataset.service
	if(sessionStorage.getItem("service") != service_name ){
		initSession()
	}else{
		addDomIndex()
	}
}

function initSession(){
	let form = document.getElementById("form")
	sessionStorage.setItem("service",form.dataset.service)
	sessionStorage.setItem("products","[]")
	sessionStorage.setItem("prestations","[]")
	sessionStorage.setItem("input",0)
}

function addDomIndex(){	
	let sessionPrestation = JSON.parse(sessionStorage.getItem("prestations"))
	let form = document.getElementById("form")
	let categoryAndSubCategory = JSON.parse(form.dataset.zones)
	let addListPrestations = document.getElementById("list-prestation")
	let addListPanier = document.getElementById("card")

	let sessionProduits = JSON.parse(sessionStorage.getItem("products"))
	for (var i = 0 ; i < sessionProduits.length ; i++) {
		addProduitInDom(sessionProduits[i].list)
	}

	for (var j = 0 ; j < sessionPrestation.length ; j++) {
		let index = sessionPrestation[j].id //l'index
		let categories = sessionPrestation[j].category //le category = ["Femme", 4]
		let prestations = sessionPrestation[j].prestation //les sous-category
		// Quelle category est dans la prestations
		for (var i = 0 ; i < categoryAndSubCategory.length ; i++) {
			if (categories[1] == categoryAndSubCategory[i][0][1]){
				var categoryAdd = categoryAndSubCategory[i]
				break
			}
		}
		// Ajoutes tous les sous category a selectionné dans la li
		let listLi = ""
		for (var h = 1 ; h < categoryAdd.length ; h++) {
			let isChecked = ""
			// verifier si la sous category est déja dans la session
			for (var a = 0 ; a < prestations.length ; a++) {
				if(categoryAdd[h][0] == prestations[a][0]){
					isChecked = "checked"
				}
			}
			listLi += "<li><span class=\"prix\">"+ categoryAdd[h][2] +" €</span><input type=\"checkbox\" value=\""+ categoryAdd[h][0] +"\" "+ isChecked +" id=\"toggle-label-"+ categoryAdd[h][0] +""+ index +"\" data-remote=\"true\" data-title=\""+ categoryAdd[h][1] +"\" data-category=\""+ categories[0] +"\" data-price=\""+ categoryAdd[h][2] +"\" data-url=\"/subcategory\" data-params=\"category="+ categories[1] +"&amp;subcategory="+ categoryAdd[h][0] +"&amp;index="+ index +"\" data-method=\"put\" class=\"form-input\" name=\"prestations["+ index +"][]\" data-index=\""+ index +"\"><label class=\"form-label\" for=\"toggle-label-"+ categoryAdd[h][0] +""+ index +"\"><span class=\"text-label\">"+ categoryAdd[h][1] +"</span></label></li>"
		}
		let divAdd = document.createElement("div")
		divAdd.classList.add("group-form-"+ categories[0])
		divAdd.innerHTML = "<h5 class=\"prestation-category\">"+ categories[0] +"</h5><input type=\"hidden\" name=\"category[]\" value=\""+ categories[1] +"\"><ul class=\"prestations\">"+ listLi +"</ul>"
		addListPrestations.appendChild(divAdd)
		// Ajoutes tous les sous category dans le panier
		let listLiCard = ""
		let totalCardPrice = 0
		for (var g = 0 ; g < prestations.length ; g++) {
			listLiCard += "<li class=\"listMassage\" id=\"posibilities-"+ prestations[g][1] +"-"+ index +"\">"+ prestations[g][1] +"</li>"
			totalCardPrice += prestations[g][2]
		}

		// Ajout dans la liste des panniers
		let divPanier = document.createElement("div")
		divPanier.classList.add("card-"+ categories[0])
		divPanier.innerHTML = "<div><h5><i class=\"fa fa-hand-o-right\" aria-hidden=\"true\" id=\"fa\"></i>"+ categories[0] +": <span id=\"price-"+ index +"\">"+ totalCardPrice.toFixed(2) +"</span> €</h5></div><ul class=\"panierContentMassage\" id=\"list-card-"+ categories[0] +"-"+ index +"\">"+ listLiCard +"</ul>"
		addListPanier.appendChild(divPanier)
	} // fin pour la boucle sessionPrestation
	totalPrice()

	// Nombre de category
	for (var l = 0 ; l < sessionPrestation.length ; l++) {
		document.getElementById("puts-number-"+sessionPrestation[l].category[0]).innerHTML = document.getElementsByClassName("group-form-"+sessionPrestation[l].category[0]).length
	}
}

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Ajouts et suppresion d'element dans la liste des produits 

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
		if (sessionPrestation == 0) {
			document.getElementById("info-produit").className = "hidden"
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
		document.getElementById("info-produit").className = ""
	}
}


function listInputProduit(currentProduit,nombres){
	return "<li>"+ currentProduit[1] +"</li><li>nombre : "+nombres.length+" Prix: "+ (nombres.length*currentProduit[2]).toFixed(2) +"€</li>"
}

function totalPrice(){
	let sessionPrestation = JSON.parse(sessionStorage.getItem("prestations"))

	let prixTotal = 0
	for (var i = 0 ; i < sessionPrestation.length ; i++) {
		let prestations = sessionPrestation[i].prestation
		for (var g = 0 ; g < prestations.length ; g++) {
			prixTotal += prestations[g][2]
		}
	}

	let sessionProduits = JSON.parse(sessionStorage.getItem("products"))
	for (var i = 0 ; i < sessionProduits.length ; i++) {
		prixTotal += sessionProduits[i].list[2]
	}
	document.getElementById("priceTotale").innerHTML = prixTotal.toFixed(2)
}

console.log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
document.getElementById("submi-tag")
console.log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")


==========================================================================================

<h4>Durée location</h4>

<div>
  <input type="radio" id="h24" name="timeSpa[1][]" value="24">
  <label for="h24">24h</label>
</div>

<div>
  <input type="radio" id="h48" name="timeSpa[1][]" value="48">
  <label for="h48">48h</label>
</div>

<div>
  <input type="radio" id="h72" name="timeSpa[1][]" value="72">
  <label for="h72">72h</label>
</div>



<h4>options</h4>
<input type="checkbox" name="optionSpa[1][]" value="Bike" id="vehicle1">
<label for="vehicle1"> Table de massage</label><br>
<input type="checkbox" name="optionSpa[1][]" value="Car" id="vehicle2">
<label for="vehicle2"> Decoration</label><br>
<input type="checkbox" name="optionSpa[1][]" value="Boat" id="vehicle3">
<label for="vehicle3"> Plateau</label><br><br>

<h4>Informations sur la location</h4>
<label for="logement1">Type de logement</label>
<select name="prestations[1][]" id="logement1" class="selectElement">
	<option value="Appartement">Appartement</option>
	<option value="Villa - Maison">Villa - Maison</option>
</select>

<label for="installation1">Type d'installation</label>
<select name="prestations[1][]" id="installation1" class="selectElement">
	<option value="Intérieur">Intérieur</option>
	<option value="Extérieur">Extérieur</option>
</select>

<label for="eau1">Système d'eau</label>
<select name="prestations[1][]" id="eau1" class="selectElement">
	<option value="Cumulus - Ballon d'eau (eau chaude limitée)">Cumulus - Ballon d'eau (eau chaude limitée)</option>
	<option value="Chaudière (eau chaude continue)">Chaudière (eau chaude continue)</option>
</select>

==========================================================================================

*/