
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
	/*~~~~~~~~~~~~Date Heurs Pays Departement Praticient ~~~~~~~~~~~~~~~~~*/
	document.getElementById("country-choice").addEventListener("change", showDepartementIfFrance);
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
	sessionStorage.setItem("prestations","{}")
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
	// les fonctions concernatant Date Heurs Pays Departement Praticient
function showDepartementIfFrance() {
	var x = this.value
	var input_dptm = document.getElementById("Departement")
	var div_dptm = document.getElementById("list-department")
	if (x == "France") {
		input_dptm.removeAttribute("disabled")
		div_dptm.removeAttribute("class")
	}else{
		input_dptm.setAttribute("disabled","disabled")
		div_dptm.classList.add("hidden")
	}
/*
	// ajouter le pays dans la session
	let prestations = JSON.parse(sessionStorage.getItem("prestations"))
	if (x != "") {
		prestations.pays = x
		delete prestations.departement
		sessionStorage.setItem("prestations",JSON.stringify(prestations))
	}

	prestations.pays = ""
	prestations.departement = ""
	prestations.date = ""
	prestations.heurs = ""
	prestations.praticient = ""
*/
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
function valueToHtmlSpa(id){ /* code html pour l'ajout d'un spa */
	let data = document.getElementById('form-data').dataset
	let dataSpas = JSON.parse(data.spas)
	let dataSpaoptions = JSON.parse(data.spaoptions)

	// spa.duration,spa.exceptional_price,spa.ordinary_price,spa.exceptional_acompte,spa.ordinary_acompte

	let typeSpa = "<div><h4>Durée location</h4>"
	for (var i = 0; i < dataSpas.length ; i++) {
		typeSpa += "<div><input class=\"time-spa-list\" type=\"radio\" id=\""+id+"h"+dataSpas[i][0]+"\" name=\"timeSpa["+id+"][]\" value=\""+ dataSpas[i][0] +"\" data-prices=\"["+dataSpas[i][1]+","+dataSpas[i][2]+"]\" data-acompte=\"["+dataSpas[i][3]+","+dataSpas[i][4]+"]\" data-index=\""+id+"\" data-array=\""+i+"\"><label for=\""+id+"h"+dataSpas[i][0]+"\">"+ dataSpas[i][0] +"h</label></div>"
	}
	typeSpa += "</div><div><h4>options</h4>"
	for (var i = 0; i < dataSpaoptions.length ; i++) {
		typeSpa += "<div><input class=\"option-spa-list\" type=\"checkbox\" name=\"optionSpa["+id+"][]\" value=\""+dataSpaoptions[i][1]+"\" id=\"opt"+dataSpaoptions[i][0]+""+id+"\" data-array=\""+i+"\" data-price=\""+dataSpaoptions[i][2]+"\" data-index=\""+id+"\" disabled ><label for=\"opt"+dataSpaoptions[i][0]+""+id+"\">"+dataSpaoptions[i][1]+"</label></div>"
	}
	typeSpa += "</div><div><h4>Informations sur la location</h4><label for=\"logement"+id+"\">Type de logement</label><select data-index=\""+id+"\" name=\"typeSpa["+id+"][]\" id=\"logement"+id+"\" class=\"selectElement\"><option value=\"Appartement\">Appartement</option><option value=\"Villa - Maison\">Villa - Maison</option></select><label for=\"installation"+id+"\">Type d'installation</label><select data-index=\""+id+"\" name=\"typeSpa["+id+"][]\" id=\"installation"+id+"\" class=\"selectElement\"><option value=\"Intérieur\">Intérieur</option><option value=\"Extérieur\">Extérieur</option></select><label for=\"eau"+id+"\">Système d'eau</label><select data-index=\""+id+"\" name=\"typeSpa["+id+"][]\" id=\"eau"+id+"\" class=\"selectElement\"><option value=\"Cumulus - Ballon d'eau (eau chaude limitée)\">Cumulus - Ballon d\'eau (eau chaude limitée)</option><option value=\"Chaudière (eau chaude continue)\">Chaudière (eau chaude continue)</option></select></div>"
	return typeSpa
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
		htmlSub += "<input type=\"checkbox\" value=\""+ categories[1][i][0] +"\" id=\"sub"+ i +""+ id +"\" class=\"massage-su\" name=\"massageSu["+id+"][]\" data-info=\"["+ [id,i] +"]\"><label class=\"\" for=\"sub"+ i +""+ id +"\"> "+ categories[1][i][0] +" </label>"
		htmlSub += "</div>"
		heurs = categories[1][i][1] // liste des heurs possibles

		htmlTime += "<div class=\"times-massage hidden\" data-info=\"["+ [id,i] +"]\" ><ul>"
		for (var j = 0; j < heurs.length ; j++) {
			htmlTime += "<li><input class=\"input-time-list\" type=\"radio\" value=\""+ heurs[j][0] +"\" id=\"time"+j+i+id+"\" name=\"massageSuPrice["+id+"][]\" data-info=\"["+ [id,i,j] +"]\" data-price=\"["+ [heurs[j][1],heurs[j][2],heurs[j][3],heurs[j][4]] +"]\" data-sub=\""+categories[1][i][0]+"\" data-name=\""+name+"\" ><label class=\"form\" for=\"time"+j+i+id+"\"> "+ heurs[j][0] +" </label></li>"
		}
		htmlTime += "</ul></div>"
	}
	return "<h4>"+name+"</h4><div class=\"1row\"><h5>Massages</h5>"+ htmlSub +"</div><div class=\"2row\"><h5>Durée(min)</h5>"+htmlTime+"</div>"
}

/* #################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################### */
/* #################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################### */
/* #################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################### */

function showTimesOnClickMassageSu(){
	// data-info=\"["+ [id,i] +"]\"
	let myData = JSON.parse(this.dataset.info)[0]

	document.getElementById("list-order-"+myData).classList.add("hidden")

	let timeListAll = document.getElementsByClassName("times-massage")
	let timeList = []
	let inputList = []

	// Enregistrement dans la session
	let sessionMassage = JSON.parse(sessionStorage.getItem("massages"))
	
	// sessionMassage.push({id:id,cat:categories[0],sub:"",time:"",price:""})

	for (var i = sessionMassage.length - 1; i >= 0; i--) {
		if(sessionMassage[i].id == myData){
			sessionMassage[i].sub = JSON.parse(this.dataset.info)[1]
			sessionMassage[i].time = ""
		}
	}

	sessionStorage.setItem("massages",JSON.stringify(sessionMassage))

	// Modification dans le DOM

	// Selection les heurs et les checkbox a cocher disponible
	for (var i = 0; i < timeListAll.length ; i++) {
		if (JSON.parse(timeListAll[i].dataset.info)[0] == myData) {
			timeList = timeListAll[i].parentElement.getElementsByTagName("div")
			inputList = timeListAll[i].parentElement.getElementsByTagName("input")
			break
		}
	}
	// remetre a zero les choix precedent sur les heurs dispo
	for (var i = inputList.length - 1; i >= 0; i--) {
		inputList[i].checked = false
	}
	// decocher les autre type de massage selectionné recedent!
	let listCheck = document.getElementsByClassName("massage-su")
	for (var i = listCheck.length - 1; i >= 0; i--) {
		if (JSON.parse(listCheck[i].dataset.info)[0] == myData && listCheck[i] != this) {
			listCheck[i].checked = false
		}
	}
	if (this.checked) {
		for (var i = 0; i < timeList.length ; i++) {
			if (timeList[i].dataset.info == this.dataset.info){
				timeList[i].className = "times-massage"
			}else{
				timeList[i].className = "times-massage hidden"
			}
		}
	}else{
		for (var i = 0; i < timeList.length ; i++) {
			if (timeList[i].dataset.info == this.dataset.info){
				timeList[i].className = "times-massage hidden"
			}
		}
	}

/* ########################################################################################################################################################################## */
/* ########################################################################################################################################################################## */
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

	div.innerHTML = valueToHtmlSpa(id)

	document.getElementById('spa-input').appendChild(div)

	// Ajout des sous element dans la session et dans le panier
	let timeSpa = document.querySelectorAll(".time-spa-list")
	timeSpa.forEach(tSpa => {
		tSpa.addEventListener('change',addRmvTimSpaInOrder);
	});

	let optionSpa = document.querySelectorAll(".option-spa-list")
	optionSpa.forEach(oSpa => {
		oSpa.addEventListener('change',addRmvOptionSpaInOrder);
	});

	// Ajout dans le panier
	addSpaInOrder(id)
	// nombre de spa - 0 +
	numberSpaSelected()
	// Grand prix total
	bigTotalPrice()
}
// evenement on click
function removeSpaList(){
	let dataForm = JSON.parse(document.getElementById('form-data').dataset.spas)
	let dataOption = JSON.parse(document.getElementById('form-data').dataset.spaoptions)
	// Enregistrement dans la session
	let sessionSpa = JSON.parse(sessionStorage.getItem("spa"))
	sessionSpa.pop()
	sessionStorage.setItem("spa",JSON.stringify(sessionSpa))
	// Modification dans le DOM
	let list = document.getElementsByClassName("spa-list-prestations")
	if (list.length > 0) {
		list[list.length-1].remove()
		// supprimer l'element dans le panier
		rmvSpaInOrder()
		// recalculer le prix total
		priceTotalForAllSpa(dataOption,dataForm)
	}
	numberSpaSelected()
	// Grand prix total
	bigTotalPrice()
}
////////////////////////////////////////////////////////
// fonction principale commande SPA
function addSpaInOrder(id){
	let divOrder = document.getElementById("spa-order")
	let div = document.createElement("div")
	div.classList = "spa-order hidden"
	div.setAttribute("id","spa-list-"+id)
	div.innerHTML = "<p>Pour <span id=\"spa-time-"+id+"\"></span> h <span id=\"spa-price-"+id+"\"></span></p><ul></ul>"
	divOrder.appendChild(div)
}

function rmvSpaInOrder(){
	let a = document.getElementsByClassName("spa-order")
	a[a.length-1].remove()
	if(a.length == 0){
		document.getElementById("spa-order").classList.add('hidden');
	}
}

function addRmvTimSpaInOrder(){ //checkbox na option spa
	let dataForm = JSON.parse(document.getElementById('form-data').dataset.spas)
	let dataOption = JSON.parse(document.getElementById('form-data').dataset.spaoptions)
	let index = this.dataset.index
	let sessionSpa = JSON.parse(sessionStorage.getItem("spa"))
	// Activer les checkbox pour les options spa
	let inputList = document.querySelectorAll(".option-spa-list[data-index=\'"+index+"\']")
	for (var i = inputList.length - 1; i >= 0; i--) {
		inputList[i].removeAttribute("disabled")
	}
	for (var i = sessionSpa.length - 1; i >= 0; i--) {
		if (sessionSpa[i].id == index) {
			sessionSpa[i].time = this.dataset.array
			break
		}
	}
	sessionStorage.setItem("spa",JSON.stringify(sessionSpa))
	document.getElementById("spa-order").classList.remove('hidden');
	document.getElementById("spa-list-"+index).classList.remove('hidden');
	document.getElementById("spa-time-"+index).innerHTML = this.value

	// calcul prix pour un spa selectionné
	let pricesSpa = JSON.parse(this.dataset.prices)[1]
	let acompteSpa = JSON.parse(this.dataset.acompte)[1]
	priceTotalForOneSpa(index,dataOption,dataForm)
	// total prix pours les spas selectionné
	priceTotalForAllSpa(dataOption,dataForm)
}

function addRmvOptionSpaInOrder(){ //checkbox na option spa
	let dataForm = JSON.parse(document.getElementById('form-data').dataset.spas)
	let dataOption = JSON.parse(document.getElementById('form-data').dataset.spaoptions)
	let index = this.dataset.index
	let id = JSON.parse(this.dataset.array)
	// Ajout ou supression d'element dans la session
	let sessionSpa = JSON.parse(sessionStorage.getItem("spa"))
	let listOptions = []
	if(this.checked){
		for (var i = sessionSpa.length - 1; i >= 0; i--) {
			if (sessionSpa[i].id == index) {
				sessionSpa[i].option.push(id)
				listOptions = sessionSpa[i].option
				break
			}
		}
	}else{
		for (var i = sessionSpa.length - 1; i >= 0; i--) {
			if (sessionSpa[i].id == index) {
				sessionSpa[i].option.splice( sessionSpa[i].option.indexOf(id), 1 )
				listOptions = sessionSpa[i].option
				break
			}
		}
	}
	sessionStorage.setItem("spa",JSON.stringify(sessionSpa))
	// Ajout des element dans le dom
	let ulList = (document.getElementById("spa-list-"+index).getElementsByTagName("ul"))
	let liList = ""
	// [1, "Décoration romantique", 20] agencement dans la dataOption
	for (var i = 0; i < listOptions.length; i++) {
		liList += "<li>"+dataOption[listOptions[i]][1]+"</li>"
	}
	ulList[0].innerHTML = liList
	// modifier la petite some
	priceTotalForOneSpa(index,dataOption,dataForm)
	// modifier la somme total
	priceTotalForAllSpa(dataOption,dataForm)
	/*
	<div class="spa-order hidden" id="spa-list-12">
		<p>Pour <span id="spa-time-12"></span>h </p>
		<ul></ul>
	</div>
	*/
}

function priceTotalForOneSpa(index,dataOption,dataForm){
	let spaPrice = document.getElementById("spa-price-"+index)
	//[{"id":1,"time":"2","option":[1,0],"info":[]}]
	let price = [0,0]
	let sessionSpa = JSON.parse(sessionStorage.getItem("spa"))
	for (var i = sessionSpa.length - 1; i >= 0; i--) {
		if (sessionSpa[i].id == index) {
			price[0] += dataForm[sessionSpa[i].time][2] // prix
			price[1] += dataForm[sessionSpa[i].time][4] // acompte
			let spa = sessionSpa[i].option
			for (var j = spa.length - 1; j >= 0; j--) {
				price[1] += dataOption[spa[j]][2]
			}
			spaPrice.innerHTML = "prix: "+price[0]+"€ acompte: "+price[1]+"€"
			break
		}
	}
}

function priceTotalForAllSpa(dataOption,dataForm){
	let spanPriceTotal = document.getElementById("spa-price-total")
	let prixSomme = [0,0]
	let sessionSpa = JSON.parse(sessionStorage.getItem("spa"))
	let tmp = ""
	for (var i = sessionSpa.length - 1; i >= 0; i--) {
		// somme heurs des spa
		if (sessionSpa[i].time != "") {
			prixSomme[0] += dataForm[sessionSpa[i].time][2] // prix
			prixSomme[1] += dataForm[sessionSpa[i].time][4] // acompte
			// some prix pour les options déco
			tmp = sessionSpa[i].option
			for (var j = tmp.length - 1; j >= 0; j--) {
				prixSomme[1] += dataOption[tmp[j]][2]
			}
		}
	}
	spanPriceTotal.innerHTML = "prix: "+prixSomme[0]+"€ acompte: "+prixSomme[1]+"€"
	spanPriceTotal.dataset.price = "["+[prixSomme[0],prixSomme[1]]+"]"
	// Grand prix total
	bigTotalPrice()
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
	sessionSpa.push({id:id,cat:categories[0],sub:"",time:""})
	sessionStorage.setItem("massages",JSON.stringify(sessionSpa))
	// Modification dans le DOM
	let div = document.createElement('div')
	div.classList.add('massage-list-'+this.dataset.cat)
	div.innerHTML = valueToHtmlMassage(this.dataset.cat,id)

	document.getElementById("massage-order").innerHTML += "<div id=\"list-order-"+id+"\" class=\"hidden\"><div><h4>"+ this.dataset.cat +"</h4></div><div><h5></h5><div><ul></ul></div></div></div>"

	document.getElementById('massage-input').appendChild(div)
	// nombre de massage pour homme et femme
	numberMassageSelected(this.dataset.cat)
	// evement pour afficher les horaires disponible pour un massages
	let checkRadio = document.querySelectorAll('.massage-su');
	checkRadio.forEach(checkR => {
		checkR.addEventListener('change',showTimesOnClickMassageSu);
	});
	// evenement pour ajouter un element si une Time est cocher
	let checkRadioList = document.querySelectorAll('.input-time-list');
	checkRadioList.forEach(checkR => {
		checkR.addEventListener('change',addMassageInOrder);
	});
	// Grand prix total
	bigTotalPrice()
}
/* ########################################################################################################################################################################## */
/* ########################################################################################################################################################################## */

function addMassageInOrder(){
	let dataForm = JSON.parse(document.getElementById('form-data').dataset.spas)
	let dataOption = JSON.parse(document.getElementById('form-data').dataset.spaoptions)
	let dataMassages = JSON.parse(document.getElementById('form-data').dataset.massages)
																											 /*  [id,i,j]  */
	// <input class="input-time-list" type="radio" value="60" id="time164" name="massageSuPrice[4][]" data-info="[4,6,1]" data-name="Homme">
	let myData = JSON.parse(this.dataset.info)
	// Modifier la session
	let sessionMassage = JSON.parse(sessionStorage.getItem("massages"))
	for (var i = sessionMassage.length - 1; i >= 0; i--) {
		if(sessionMassage[i].id == myData[0]){
			sessionMassage[i].time = myData[2]
		}
	}
	sessionStorage.setItem("massages",JSON.stringify(sessionMassage))
	// Calculer le prix et ajouter dans le dom
	// priceTotalForOneMassage(this.dataset.name,myData,this.dataset.sub)
	
	priceTotalForOneMassage(dataMassages,myData)
	priceTotalForAllMassage(dataMassages)
}

function priceTotalForOneMassage(dataMassages,myData){
	let sub =""
	let time =""
	let cat =""
	// 0: {id: 1, cat: "Homme", sub: 6, time: 1}
	// 1: {id: 2, cat: "Femme", sub: 1, time: 0}
	let sessionMassage = JSON.parse(sessionStorage.getItem("massages"))
	for (var i = sessionMassage.length - 1; i >= 0; i--) {
		if (sessionMassage[i].id == myData[0]) {
			sub = sessionMassage[i].sub
			time = sessionMassage[i].time
			cat = sessionMassage[i].cat
			break
		}
	}
	let categories = []
	if ( cat == "Homme") {
		categories = dataMassages[0]
	}else{
		categories = dataMassages[1]
	}
	let divMassage = document.getElementById("list-order-"+myData[0])
	document.getElementById("massage-order").classList.remove('hidden')
	divMassage.classList.remove('hidden')
	divMassage.getElementsByTagName("h5")[0].innerHTML = categories[1][sub][0]
	//  [30, 70, 30, 50, 20]
	divMassage.getElementsByTagName("ul")[0].innerHTML = "<li>prix: "+categories[1][sub][1][time][3]+"€</li><li>acompte: "+categories[1][sub][1][time][4]+"€</li>"
}

function priceTotalForAllMassage(dataMassages){
	let sessionMassage = JSON.parse(sessionStorage.getItem("massages"))
	let price = 0
	let acompte = 0
	for (var i = sessionMassage.length - 1; i >= 0; i--) {
		if (typeof(sessionMassage[i].sub) == "number" && typeof(sessionMassage[i].time) == "number") {
			let categories = []
			if ( sessionMassage[i].cat == "Homme") {
				categories = dataMassages[0]
			}else{
				categories = dataMassages[1]
			}
			price += categories[1][sessionMassage[i].sub][1][sessionMassage[i].time][3]
			acompte += categories[1][sessionMassage[i].sub][1][sessionMassage[i].time][4]
		}
	}
	document.getElementById("massage-price-total").innerHTML = "prix: "+price+"€ acompte: "+acompte+"€"
	document.getElementById("massage-price-total").dataset.price = "["+[price,acompte]+"]"
	if (price == 0 && acompte == 0) {
		document.getElementById("massage-order").classList.add('hidden')
	}
	// Grand prix total
	bigTotalPrice()
}

/* ########################################################################################################################################################## */
/* ########################################################################################################################################################################## */

function removeCategoryMassage(){
	let dataMassages = JSON.parse(document.getElementById('form-data').dataset.massages)
	// Enregistrement dans la session
	let sessionMassage = JSON.parse(sessionStorage.getItem("massages"))
	for (var i = sessionMassage.length - 1; i >= 0; i--) {
		if(sessionMassage[i].cat == this.dataset.cat){
			document.getElementById("list-order-"+sessionMassage[i].id).remove()
			sessionMassage.splice(i,1)
			break
		}
	}
	sessionStorage.setItem("massages",JSON.stringify(sessionMassage))
	priceTotalForAllMassage(dataMassages)
	// Modification dans le DOM
	let list = document.getElementsByClassName('massage-list-'+this.dataset.cat)
	if (list.length > 0) {
		list[list.length-1].remove()
	}
	// nombre de massage pour homme et femme
	numberMassageSelected(this.dataset.cat)
	// Grand prix total
	bigTotalPrice()
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
	// calcul du prix
	priceForAllCadeau()
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
	// calcul du prix
	priceForAllCadeau()
}

function priceForAllCadeau(){
	let addCadeau = document.querySelectorAll(".cadeau-add")
	infoCadeau = []
	addCadeau.forEach(listCadeau => {
		infoCadeau.push([JSON.parse(listCadeau.dataset.id),listCadeau.dataset.name,JSON.parse(listCadeau.dataset.price)])
	});
	let cadeau = JSON.parse(sessionStorage.getItem("cadeau"))
	let orderCadeau = document.getElementById("cadeau-order")
	let totalPrice = 0
	let elementDom = "<ul>"
	for (var i = 0; i < cadeau.length; i++) {
		for (var j = infoCadeau.length - 1; j >= 0; j--) {
			if (cadeau[i][0] == infoCadeau[j][0]){
				totalPrice += cadeau[i][1]*infoCadeau[j][2] /* isany * prix */ /* infoCadeau[i][1] anarany*/
				elementDom += "<li>"+ infoCadeau[i][1] +" nb: "+ cadeau[i][1] +" prix: "+ cadeau[i][1]*infoCadeau[j][2] +"€</li>"
				break
			}
		}
	}
	if (totalPrice == 0) {
		orderCadeau.classList.remove("hidden")
		orderCadeau.classList.add("hidden")
		document.getElementById("cadeau-price-total").innerHTML = ""
	}else{
		orderCadeau.classList.remove("hidden")
		document.getElementById("cadeau-price-total").innerHTML = totalPrice
		orderCadeau.getElementsByTagName("div")[0].innerHTML = elementDom+"</ul>"
	}
	// Grand prix total
	bigTotalPrice()
}

function bigTotalPrice(){

	let spa = document.getElementById("spa-price-total").dataset.price

	let massage = document.getElementById("massage-price-total").dataset.price

	let cadeau = document.getElementById("cadeau-price-total").innerHTML

	if ((spa == "" || spa == "[0,0]") && (massage == "" || massage == "[0,0]")) {
		document.getElementById("empty-order").classList.remove("hidden")
	}else{
		document.getElementById("empty-order").classList.add("hidden")
	}

	if (spa != "") {
		spa = JSON.parse(spa)
	}else{
		spa = [0,0]
	}
	if (massage != "") {
		massage = JSON.parse(massage)
	}else{
		massage = [0,0]
	}
	document.getElementById("total-price").innerHTML = spa[0]+massage[0] 
	document.getElementById("total-acompte").innerHTML =  spa[1]+massage[1]+parseFloat(cadeau)
}



/*
========================================================================================================
Doc mety ho ilaina


https://www.youtube.com/watch?v=pPK_C7DKyJo

*/