runJS()
function runJS(){
	const service_name = document.getElementById("form").dataset.service
	if(sessionStorage.getItem("prestations") == [] || sessionStorage.getItem("service") != service_name ){
		initSession()
	}else{
		addDomIndex()
	}
}

function initSession(){
	sessionStorage.setItem("prestations","[]")
	sessionStorage.setItem("input",0)
	let form = document.getElementById("form")
	sessionStorage.setItem("service",form.dataset.service)
}

function addDomIndex(){	
	let sessionPrestation = JSON.parse(sessionStorage.getItem("prestations"))
	let form = document.getElementById("form")
	let categoryAndSubCategory = JSON.parse(form.dataset.zones)
	let addListPrestations = document.getElementById("list-prestation")
	let addListPanier = document.getElementById("card")

	let totalMaxPrice = 0
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
			listLi += "<li><span class=\"prix\">"+ categoryAdd[h][2] +" €</span><input type=\"checkbox\" value=\""+ categoryAdd[h][0] +"\" "+ isChecked +" id=\"toggle-label-"+ categoryAdd[h][0] +""+ index +"\" data-remote=\"true\" data-title=\""+ categoryAdd[h][1] +"\" data-category=\""+ categories[0] +"\" data-price=\""+ categoryAdd[h][2] +"\" data-url=\"/subcategory\" data-params=\"category="+ categories[1] +"&amp;subcategory="+ categoryAdd[h][0] +"&amp;index="+ index +"\" data-method=\"put\" class=\"form-input\" name=\"prestations["+ index +"][]\" data-index=\""+ index +"\"><div class=\"toggle\"><label class=\"form-label\" for=\"toggle-label-"+ categoryAdd[h][0] +""+ index +"\">"+ categoryAdd[h][1] +"</label></div></li>"
		}
		let divAdd = document.createElement("div")
		divAdd.classList.add("group-form-"+ categories[0])
		divAdd.innerHTML = "<h5 class=\"prestation-category\">"+ categories[0] +"</h5><input type=\"hidden\" name=\"category[]\" value=\""+ categories[1] +"\"><ul>"+ listLi +"</ul>"
		addListPrestations.appendChild(divAdd)
		// Ajoutes tous les sous category dans le panier
		let listLiCard = ""
		let totalCardPrice = 0
		for (var g = 0 ; g < prestations.length ; g++) {
			listLiCard += "<li id=\"posibilities-"+ prestations[g][1] +"-"+ index +"\">"+ prestations[g][1] +"</li>"
			totalCardPrice += prestations[g][2]
		}
		//calcule du prix total
		totalMaxPrice += totalCardPrice
		// Ajout dans la liste des panniers
		let divPanier = document.createElement("div")
		divPanier.classList.add("card-"+ categories[0])
		divPanier.innerHTML = "<div>"+ categories[0] +" <span id=\"price-"+ index +"\">"+ totalCardPrice.toFixed(2) +"</span> €</div><ul id=\"list-card-"+ categories[0] +"-"+ index +"\">"+ listLiCard +"</ul>"
		addListPanier.appendChild(divPanier)
	} // fin pour la boucle sessionPrestation
	document.getElementById("priceTotale").innerHTML = totalMaxPrice.toFixed(2)

	// Nombre de category
	for (var l = 0 ; l < sessionPrestation.length ; l++) {
		document.getElementById("puts-number-"+sessionPrestation[l].category[0]).innerHTML = document.getElementsByClassName("group-form-"+sessionPrestation[l].category[0]).length
	}
}
