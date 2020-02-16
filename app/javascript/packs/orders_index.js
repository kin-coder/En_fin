function scriptPrincipal(){
/*==========================================================================*/
	/*~~~~~~~~~~~~~~~~~~~~~~~~~SPA~~~~~~~~~~~~~~~~~~~~~~~~~*/
	let removeSpa = document.getElementById("remove-spa")
	let addSpa = document.getElementById("add-spa")
	removeSpa.addEventListener('click',removeSpaList)
	addSpa.addEventListener('click',addSpaList)
/*==========================================================================*/
	/*~~~~~~~~~~~~~~~~~~~~~~~Massage~~~~~~~~~~~~~~~~~~~~~~~*/

	let buttonRmvs = document.querySelectorAll('.remove-massage');
	buttonRmvs.forEach(buttonRmv => {
		buttonRmv.addEventListener('click',removeCategoryMassage);
	});

	let buttonAdds = document.querySelectorAll('.add-massage');
	buttonAdds.forEach(buttonAdd => {
		buttonAdd.addEventListener('click',addCategoryMassage);
	});
/*==========================================================================*/
	/*~~~~~~~~~~~~~~~~~~~~~~~Cadeau~~~~~~~~~~~~~~~~~~~~~~~*/

	let rmvCadeau = document.querySelectorAll(".cadeau-rmv")
	rmvCadeau.forEach(rmv => {
		rmv.addEventListener('click',removeCadeau);
	});

	let addCadeau = document.querySelectorAll(".cadeau-add")
	addCadeau.forEach(add => {
		add.addEventListener('click',aDDCadeau);
	});

/*==========================================================================*/
	/*~~~~~~~~~~~~~~~~~~~~~~~~Autre~~~~~~~~~~~~~~~~~~~~~~~~*/
	let prestations = sessionStorage.getItem("prestations")
	if( 1 /*prestations == undefined || prestations == 0*/ ){
		initSession()
	}else{
		addDomIndex()
	}
}

scriptPrincipal()
/*==========================================================================*/

function initSession(){
	sessionStorage.setItem("prestations","[]")
	sessionStorage.setItem("spa","[]")
	sessionStorage.setItem("massages","[]")
	sessionStorage.setItem("cadeau","[]")
	sessionStorage.setItem("inc","0")
}
// remettre les elements si un l'user a actualisé
function addDomIndex(){
	// body...
}
/*==========================================================================*/
	// les fonctions primaire utilisé dans SPA et massage
function incrementeInc(){ /*incremente la valeur inc pour les params*/
	let inc = JSON.parse(sessionStorage.getItem("inc"))
	inc++
	sessionStorage.setItem("inc",JSON.stringify(inc))
	return inc
}

/*==========================================================================*/
	// les fonctions primaire SPA
function valueToHtmlSpa(id,div){ /* code html pour l'ajout d'un spa */
	let data = document.getElementById('form-data').dataset
	let dataSpas = JSON.parse(data.spas)
	let dataSpaoptions = JSON.parse(data.spaoptions)

	// spa.duration,spa.exceptional_price,spa.ordinary_price,spa.exceptional_acompte,spa.ordinary_acompte

	let typeSpa = "<div><h4>Durée location</h4>"
	for (var i = 0; i < dataSpas.length ; i++) {
		typeSpa += "<div><input type=\"radio\" id=\""+id+"h"+dataSpas[i][0]+"\" name=\"timeSpa["+id+"][]\" value=\""+ dataSpas[i][0] +"\" data-prices=\"["+dataSpas[i][1]+","+dataSpas[i][2]+"]\" data-acompte=\"["+dataSpas[i][3]+","+dataSpas[i][4]+"]\" data-index=\""+id+"\"><label for=\""+id+"h"+dataSpas[i][0]+"\">"+ dataSpas[i][0] +"h</label></div>"
	}
	typeSpa += "</div><div><h4>options</h4>"
	for (var i = 0; i < dataSpaoptions.length ; i++) {
		typeSpa += "<div><input type=\"checkbox\" name=\"optionSpa["+id+"][]\" value=\""+dataSpaoptions[i][0]+"\" id=\"opt"+dataSpaoptions[i][0]+""+id+"\" data-price=\""+dataSpaoptions[i][2]+"\" data-index=\""+id+"\"><label for=\"opt"+dataSpaoptions[i][0]+""+id+"\">"+dataSpaoptions[i][1]+"</label></div>"
	}
	
	typeSpa += "</div><div><h4>Informations sur la location</h4><label for=\"logement"+id+"\">Type de logement</label><select data-index=\""+id+"\" name=\"typeSpa["+id+"][]\" id=\"logement"+id+"\" class=\"selectElement\"><option value=\"Appartement\">Appartement</option><option value=\"Villa - Maison\">Villa - Maison</option></select><label for=\"installation"+id+"\">Type d'installation</label><select data-index=\""+id+"\" name=\"typeSpa["+id+"][]\" id=\"installation"+id+"\" class=\"selectElement\"><option value=\"Intérieur\">Intérieur</option><option value=\"Extérieur\">Extérieur</option></select><label for=\"eau"+id+"\">Système d'eau</label><select data-index=\""+id+"\" name=\"typeSpa["+id+"][]\" id=\"eau"+id+"\" class=\"selectElement\"><option value=\"Cumulus - Ballon d'eau (eau chaude limitée)\">Cumulus - Ballon d\'eau (eau chaude limitée)</option><option value=\"Chaudière (eau chaude continue)\">Chaudière (eau chaude continue)</option></select></div>"

	div.innerHTML = typeSpa

	// &quot;&quot;&quot;&quot;
}

function numberSpaSelected(){
	let list = document.getElementsByClassName("spa-list-prestations")
	document.getElementById("number-spa").innerHTML = list.length
}

/*==========================================================================*/
	// les fonctions primaire MASSAGE
function numberMassageSelected(name) {
	let list = document.getElementsByClassName("massage-list-"+name)
	document.getElementById("number-"+name).innerHTML = list.length
}

function valueToHtmlMassage(name,id){
	let data = document.getElementById('form-data').dataset
	let dataMassages = JSON.parse(data.massages)
	let categories = []
	if ( name == "Homme") {
		categories = dataMassages[0]
	}else{
		categories = dataMassages[1]
	}
	let heurs = []
	let htmlSub = ""
	let htmlTime = ""
	for (var i = 0; i < categories[1].length ; i++) {
		htmlSub += "<div class=\"\">"
		htmlSub += "<input type=\"radio\" value=\""+ categories[1][i][0] +"\" id=\"sub"+ i +""+ id +"\" class=\"massage-su\" name=\"massageSu["+id+"][]\" data-info=\"["+ [id,i] +"]\"><label class=\"\" for=\"sub"+ i +""+ id +"\"> "+ categories[1][i][0] +" </label>"
		htmlSub += "</div>"
		heurs = categories[1][i][1] // liste des heurs possibles

		htmlTime += "<div class=\"times-massage hidden\" data-info=\"["+ [id,i] +"]\" ><ul>"
		for (var j = 0; j < heurs.length ; j++) {
			htmlTime += "<li><input type=\"radio\" value=\""+ heurs[j][0] +"\" id=\"time"+j+i+id+"\" name=\"massageSuPrice["+id+"][]\" data-info=\"["+ [id,i] +"]\" data-price=\"["+[heurs[j][1],heurs[j][2],heurs[j][3],heurs[j][4]]+"]\"><label class=\"form\" for=\"time"+j+i+id+"\"> "+ heurs[j][0] +" </label></li>"
		}
		htmlTime += "</ul></div>"
	}
	return "<h4>"+name+"</h4><div class=\"1row\"><h5>Massages</h5>"+ htmlSub +"</div><div class=\"2row\"><h5>Durée(min)</h5>"+htmlTime+"</div>"
}

function showTimesOnClickMassageSu(){
	let timeList = document.getElementsByClassName("times-massage")

	for (var i = 0; i < timeList.length ; i++) {
		if (timeList[i].dataset.info == this.dataset.info){
			timeList[i].className = "times-massage"
		}else{
			timeList[i].className = "times-massage hidden"
		}
	}
}


/*==========================================================================*/
// fonction principale SPA
// evenement on click
function addSpaList(){
	let id = incrementeInc() // Augmente de 1 la session
	
	// Enregistrement dans la session
	let sessionSpa = JSON.parse(sessionStorage.getItem("spa"))
	sessionSpa.push({id:id,time:"",option:[],info:[]})
	sessionStorage.setItem("spa",JSON.stringify(sessionSpa))
	
	// Modification dans le DOM

	let div = document.createElement('div')
	div.classList.add('spa-list-prestations')

	valueToHtmlSpa(id,div)

	document.getElementById('spa-input').appendChild(div)
	// nombre de spa - 0 +
	numberSpaSelected()
}


// evenement on click
function removeSpaList(){
	// Enregistrement dans la session
	let sessionSpa = JSON.parse(sessionStorage.getItem("spa"))
	sessionSpa.pop()
	sessionStorage.setItem("spa",JSON.stringify(sessionSpa))
	// Modification dans le DOM
	let list = document.getElementsByClassName("spa-list-prestations")
	if (list.length > 0) {
		list[list.length-1].remove()	
	}
	numberSpaSelected()
}

/*==========================================================================*/
	// fonction principale MASSAGE
function addCategoryMassage(){
	let id = incrementeInc()
	let data = document.getElementById('form-data').dataset
	let dataMassages = JSON.parse(data.massages)
	let categories = []
	if ( this.dataset.cat == "Homme") {
		categories = dataMassages[0]
	}else{
		categories = dataMassages[1]
	}
	
	// Enregistrement dans la session
	let sessionSpa = JSON.parse(sessionStorage.getItem("massages"))
	sessionSpa.push({id:id,cat:categories[0],list:[],time:"",price:""})
	sessionStorage.setItem("massages",JSON.stringify(sessionSpa))
	// Modification dans le DOM

	let div = document.createElement('div')
	div.classList.add('massage-list-'+this.dataset.cat)

	div.innerHTML = valueToHtmlMassage(this.dataset.cat,id)
	
	document.getElementById('massage-input').appendChild(div)
	// nombre de massage pour homme et femme
	numberMassageSelected(this.dataset.cat)
	// evement pour afficher les horaires disponible pour un massages
	let checkRadio = document.querySelectorAll('.massage-su');
	checkRadio.forEach(checkR => {
		checkR.addEventListener('change',showTimesOnClickMassageSu);
	});
}

function removeCategoryMassage(){
	// Enregistrement dans la session
	let sessionMassage = JSON.parse(sessionStorage.getItem("massages"))
	for (var i = sessionMassage.length - 1; i >= 0; i--) {
		if(sessionMassage[i].cat == this.dataset.cat){
			sessionMassage.splice(i,1)
			break
		}
	}
	sessionStorage.setItem("massages",JSON.stringify(sessionMassage))
	// Modification dans le DOM
	let list = document.getElementsByClassName('massage-list-'+this.dataset.cat)
	if (list.length > 0) {
		list[list.length-1].remove()
	}
	// nombre de massage pour homme et femme
	numberMassageSelected(this.dataset.cat)

}
/*==========================================================================*/
	// fonction principale CADEAU
function removeCadeau(){
	let id = JSON.parse(this.dataset.id)
	let cadeau = JSON.parse(sessionStorage.getItem("cadeau"))
	for (var i = cadeau.length - 1; i >= 0; i--) {
		if(cadeau[i][0] == id){
			cadeau[i][1]--
			document.getElementById(id+"-nbr").innerHTML = cadeau[i][1]
			if(cadeau[i][1] == 0){
				cadeau.splice(i,1)
			}
			break
		}
	}
	sessionStorage.setItem("cadeau",JSON.stringify(cadeau))
	document.getElementById("cadeau-id").value = JSON.stringify(cadeau)
}


function aDDCadeau(){
	let id = JSON.parse(this.dataset.id)
	let cadeau = JSON.parse(sessionStorage.getItem("cadeau"))
	let test = true
	for (var i = cadeau.length - 1; i >= 0; i--) {
		if(cadeau[i][0] == id){
			test = false
			cadeau[i][1]++
			document.getElementById(id+"-nbr").innerHTML = cadeau[i][1]
			break
		}
	}
	if (test) {
		cadeau.push([id,1])
		document.getElementById(id+"-nbr").innerHTML = 1
	}
	sessionStorage.setItem("cadeau",JSON.stringify(cadeau))
	document.getElementById("cadeau-id").value = JSON.stringify(cadeau)
}


// JSON.stringify()

/*


<input type="text" value="" name="cadeau" id="cadeau-input">









var rad = document.myForm.myRadios;
var prev = null;
for (var i = 0; i < rad.length; i++) {
    rad[i].addEventListener('change', function() {
        (prev) ? console.log(prev.value): null;
        if (this !== prev) {
            prev = this;
        }
        console.log(this.value)
    });
}
<form name="myForm">
  <input type="radio" name="myRadios"  value="1" />
  <input type="radio" name="myRadios"  value="2" />
</form>










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

*/
