initialize();
function initialize(){
	let zone = JSON.parse(sessionStorage.getItem("zone"));
	if (zone != null && zone.country != undefined) {
		if (zone.country != "") {
			let $valueCountry = $('#zode-and-date-selected');
			let nameDepart = "";
			if (zone.department) {
				nameDepart = "<i><strong class=\"label-selected\">Departement : </strong></i>"+zone.department;
			}
			$valueCountry.html("<div class=\"pays-selected\"><i><strong class=\"label-selected\">Pays : </strong></i>"+zone.country+" &nbsp;&nbsp; <br>"+nameDepart+" <br><i><strong  class=\"label-selected\">Date de livraison : </strong></i>"+zone.date+" <br><button class=\"btn btn-primary btn-pays\" id=\"openZoneChoice\">Modifier</button></div>");			
			$("#openZoneChoice").click(function(){
				$("#errorInZone").addClass("hidden");
				$("#overlay").css("display","block");
			});
			if (zone.services.includes("Massage")){
				$("#massage-fafana").removeClass("hidden");
			}else{
				$("#massage-fafana").addClass("hidden");
			}
			if (zone.services.includes("Location spa")){
				$("#loc-spa-fafana").removeClass("hidden");
			}else{
				$("#loc-spa-fafana").addClass("hidden");
			}
			$("#inpdepartment").val(zone.department);
			$("#inpdate").val(zone.date);
			$("#inppays").val(zone.country);
			$("#inpcode").val(zone.code[0]);
		}else{
			window.onload = choseZoneAndDate();
		}
	}else{
		window.onload = choseZoneAndDate();
	}
}
function choseZoneAndDate(){
  document.getElementById("overlay").style.display = "block";
}
