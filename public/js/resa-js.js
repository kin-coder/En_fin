initialize()

function on(){
  document.getElementById("overlay").style.display = "block";
}

function initialize(){
	let zone = JSON.parse(sessionStorage.getItem("zone"))
	if (zone != null && zone.country != undefined) {
		if (zone.country != "") {
			let valueCountry = document.getElementById('zode-and-date-selected')
			let nameDepart = ""
			if (zone.department) {
				nameDepart = "Departement : "+zone.department
			}
			valueCountry.innerHTML = "<div>Pays : "+zone.country+" "+nameDepart+" Date de livraison : "+zone.date+" <button class=\"btn btn-primary\" id=\"openZoneChoice\">Modifier</button></div>"
			document.getElementById("openZoneChoice").addEventListener('click',openZone);
		
			if (zone.services.includes("Massage")){
				document.getElementById("massage-fafana").classList.remove("hidden")
			}else{
				document.getElementById("massage-fafana").classList.add("hidden")
			}

			if (zone.services.includes("Location spa")){
				document.getElementById("loc-spa-fafana").classList.remove("hidden")
			}else{
				document.getElementById("loc-spa-fafana").classList.add("hidden")
			}

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
