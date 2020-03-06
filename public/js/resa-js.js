initialize()



function on(){
  document.getElementById("overlay").style.display = "block";
}

function initialize(){
	let prestations = JSON.parse(sessionStorage.getItem("prestations"))
	if (prestations.country != undefined) {
		if (prestations.country != "") {
			let valueCountry = document.getElementById('zode-and-date-selected')
			let nameDepart = ""
			if (prestations.department) {
				nameDepart = "Departement : "+prestations.department
			}
			valueCountry.innerHTML = "<div>Pays : "+prestations.country+" "+nameDepart+" Date de livraison : "+prestations.date+" <button class=\"btn btn-primary\" id=\"openZoneChoice\">Midfier votre zone et la date</button></div>"
			document.getElementById("openZoneChoice").addEventListener('click',openZone);
		}else{
			window.onload = on();
		}
	}else{
		window.onload = on();
	}
}
function openZone(){
	document.getElementById("errorInZone").classList.add("hidden")
	document.getElementById("overlay").style.display = "block"
}
