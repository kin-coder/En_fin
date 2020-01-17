if(sessionStorage.getItem("prestations") == null){
	initSession()
}else{
	addDomIndex()
}

function addDomIndex(){	
	let sessionPrestation = JSON.parse(sessionStorage.getItem("prestations"))
	let divForm = document.getElementById("form")
	console.log(divForm)
	/*
	for (var j = 0 ; j < sessionPrestation.length ; j++) {

		let index = sessionPrestation[j]divForm.id //l'index
		let categories = sessionPrestation[j].category //le category
		let prestations = sessionPrestation[j].prestation //les sous-category
		// ["Femme", 4]
		let div = document.createElement("div")
		div.classList.add("group-form-"+categories[0])

		let list = ""
		// [15, "Dos", 20.21]
		for (var i = 0 ; i < prestations.length ; i++) {
			list += "<li><span class=\"prix\">"+ prestations[i][2] +" € </span><input type=\"checkbox\" value=\""+ prestations[i][0] +"\" id=\"toggle-label-"+ prestations[i][0] +""+ index +"\" data-remote=\"true\" data-title=\""+ prestations[i][1] +"\" data-category=\""+categories[0]+"\" data-price=\""+ prestations[i][2] +"\" data-url=\"/subcategory\" data-params=\"category="+categories[1]+"&amp;subcategory="+ prestations[i][0] +"&amp;index="+ index +"\" data-method=\"put\" class=\"form-input\" name=\"prestations[i]["+ index +"][]\" data-index=\""+ index +"\"><div class=\"toggle\"><label class=\"form-label\" for=\"toggle-label-"+ prestations[i][0] +""+ index +"\">"+ prestations[i][1] +"</label></div></li>"
		}
		div.innerHTML = "<h5 class=\"prestation-category\">Femme</h5><ul><input type=\"hidden\" name=\"category[]\" value=\""+categories[1]+"\">"+ list + "</ul>"

		console.log(div)
		console.log(list)
	}
	*/
}

function initSession(){
	sessionStorage.setItem("prestations","[]")
	sessionStorage.setItem("input",0)
}


/*
"group-form-Femme"
<div class="group-form-Femme">
	<h5 class="prestation-category">Femme</h5>
	<ul>
		<input type="hidden" name="category[]" value="4">
		<li>
			<span class="prix">27.62 € </span>
			<input type="checkbox" value="14" id="toggle-label-141" data-remote="true" data-title="Découverte" data-category="Femme" data-price="27.62" data-url="/subcategory" data-params="category=4&amp;subcategory=14&amp;index=1" data-method="put" class="form-input" name="prestations[i][1][]" data-index="1">
			<div class="toggle">
				<label class="form-label" for="toggle-label-141">Découverte</label>
			</div>
		</li>

<div id="card">
	<h2>Panier</h2>
	<div class="card-Femme">
		<div>Femme <span id="price-1">47.25</span> €</div>
		<ul id="list-card-Femme-1">
			<li id="posibilities-Dos-1">Dos</li>
			<li id="posibilities-Assis-1">Assis</li>
		</ul>
	</div>
</div>
<div>
	Total <span id="priceTotale">47.25</span> €
</div>

*/