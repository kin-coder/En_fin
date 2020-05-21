main();
function main(){
	let session_massages = sessionStorage.getItem("massages");
	if ( session_massages == null) {
		sessionStorage.setItem("massages","[]");
	}else{
		actualiseValueMassage(JSON.parse(session_massages));
	}
	let session_spas = sessionStorage.getItem("spas");
	if ( session_spas == null) {
		sessionStorage.setItem("spas","[]");
	}else{
		actualiseValueSpa(JSON.parse(session_spas));
	}
	let zone = sessionStorage.getItem("zone");
	if (zone != null) {
		zone = JSON.parse(zone);
		$("#heure-spa").val(zone.time_spa);
		$("#heure-massage").val(zone.time_massage);
		$(".praticien-list").each(function(index,element){
			if ($(element).val() == zone.pratitien) {
				$(element).prop("checked",true);
				return false;
			}
		});
	}
}
/* ------------------------------------------------------------------------------------ */
/*--------------------------------- PRESTATION SPA  -----------------------------------*/
/* ------------------------------------------------------------------------------------ */
$("#remove-spa").click(function(){
	$(".prestation-group-spa").last().remove();
	$("#number-spa").html($(".prestation-group-spa").length);
	refreachListCommandeSpa();
});

$("#add-spa").click(function(){
	let number = $(".prestation-group-spa").length;
	let $prestationSpa = $($("#for_location_spa").html());
	$prestationSpa = addGroupLocationSpaInDom(number,$prestationSpa);
	$prestationSpa.find(".input-time-spa,.option-spa-list").click(function(){
		showListTimeAndAmbianceInBascket($(this));
	});
	$prestationSpa.find("select").click(function(){
		if($prestationSpa.find(".input-time-spa:checked").length > 0){
			refreachListCommandeSpa();
		}
	});
	$("#select-list-spa").append($prestationSpa);
	$("#number-spa").html($(".prestation-group-spa").length);
});

function showListTimeAndAmbianceInBascket($input){
	let $parentsGroup = $input.parents(".prestation-group-spa");
	if ($input.data().category === "ambiance"){
		if($input.prop("checked")){
			$parentsGroup.find(".option-spa-list").prop("checked",false);
			$input.prop("checked",true);
		}else{
			$parentsGroup.find(".option-spa-list").prop("checked",false);
		}
	}else{
		if($input.prop("checked")){
			$parentsGroup.find(".input-time-spa").prop("checked",false)	;
			$input.prop("checked",true);
			$parentsGroup.find(".option-spa-list").prop("disabled",false);
		}else{
			$parentsGroup.find(".input-time-spa").prop("checked",false);
			$parentsGroup.find(".option-spa-list").prop("checked",false)	;
			$parentsGroup.find(".option-spa-list").prop("disabled",true);
		}
	}
	refreachListCommandeSpa();
}

function refreachListCommandeSpa(){
	let innerHTML = "";
	let totalPrice = 0.0;
	let totalAcompte = 0.0;
	let session_spas = [];
	$(".prestation-group-spa").each(function(index,element){
		let $timeList = $(element).find(".input-time-spa:checked");
		let a = {};
		if($timeList.length > 0){
			a.time = $timeList.val();
			let price = 0.0;
			let $ambianceList = $(element).find(".option-spa-list:checked");
			let ambianceHtml = '';
			if ($ambianceList.length > 0) {
				price += parseFloat($ambianceList.data().price);
				totalPrice += parseFloat($ambianceList.data().price);
				ambianceHtml = "<li>ambiance: "+ $ambianceList.val() +"</li>";
				a.ambiance = $ambianceList.val();
			}
			// [exceptional_price,exceptional_acompte,ordinary_price,ordinary_acompte]
	    	if(true){ // is exeptiona true
	    		price += $timeList.data().price[0]+$timeList.data().price[1];
				totalPrice += $timeList.data().price[0];
	    		totalAcompte += $timeList.data().price[1];
	    	}else{ // is exeptional false
	    		price += $timeList.data().price[2]+$timeList.data().price[3];
	    		totalPrice += $timeList.data().price[2];
	    		totalAcompte += $timeList.data().price[3];
	    	}
			innerHTML += "<div>Spa <span>"+price+"€</span></div>"+
					"<ul><li>pour: "+$timeList.val()+"h</li>"+ambianceHtml+"</ul>";
			let type = [];
			$(element).find("select").each(function(kndex,glement){
				type.push($(glement).val());
			});
			a.type = type;
			session_spas.push(a);
		}
	});
	sessionStorage.setItem("spas",JSON.stringify(session_spas));
	$(".presta-spa-list")[0].dataset.price = "["+totalPrice+","+totalAcompte+"]";
	if (innerHTML.length > 0){
		$(".presta-spa-list").html(innerHTML);
		$("#totalPriceSpa").removeClass("hidden");
		$("#totalPriceSpa").html("LOCATION SPA : <span>"+(totalPrice+totalAcompte)+"</span>€");
	}else{
		$("#totalPriceSpa").addClass("hidden");
		$(".presta-spa-list").html(innerHTML);
	}
	let massagePrice = JSON.parse($(".presta-list")[0].dataset.price);
	if (massagePrice.length === 2) {
		totalPrice += massagePrice[0];
		totalAcompte += massagePrice[1];
	}
	$("#totalPricePrestation").html(totalPrice);
	$("#totalAcomptePrestation").html(totalAcompte);
	hideMessageShow(totalPrice);
}

function addGroupLocationSpaInDom(number,$prestationSpa,time="",ambiance="",types=[]) {
	$prestationSpa.find(".label-spa,.label-option-spa").each(function(index,element){
		let label = $(element).attr("for");
		$(element).attr("for",label+number);
	});
	$prestationSpa.find(".input-time-spa").each(function(index,element){
		let id = $(element).attr("id");
		$(element).attr("id",id+number);
		$(element).attr("name","spas["+number+"][time][]");
		if($(element).val() === time){
			$(element).prop("checked",true);
		}
	});
	$prestationSpa.find(".option-spa-list").each(function(index,element){
		let id = $(element).attr("id");
		$(element).attr("id",id+number);
		$(element).attr("name","spas["+number+"][ambiance][]");
		if($(element).val() === ambiance){
			$(element).prop("checked",true);
		}
		if (ambiance.length  > 0) {
			$(element).prop("disabled",false);
		}
	});
	$prestationSpa.find('.label-info-spa').each(function(index,element){
		let label = $(element).attr("for");
		$(element).attr("for",label+number);
	});
	$prestationSpa.find(".selectElement").each(function(index,element){
		let id = $(element).attr("id");
		$(element).attr("name","spas["+number+"][type][]");
		$(element).attr("id",id+number);
		if (types.length  > 0) {
			$(element).val(types[index]);
		}
	});
	return $prestationSpa;
}

function actualiseValueSpa(session_spas){
	for( var i=0; i < session_spas.length; i++){
		let $prestationSpa = $($("#for_location_spa").html());
		$prestationSpa = addGroupLocationSpaInDom(i,$prestationSpa,session_spas[i].time,session_spas[i].ambiance,session_spas[i].type);
		$("#select-list-spa").append($prestationSpa);
	}
	$("#number-spa").html($(".prestation-group-spa").length);
	$("#select-list-spa").find(".input-time-spa,.option-spa-list").click(function(){
		showListTimeAndAmbianceInBascket($(this));
	});
	$("#select-list-spa").find("select").click(function(){
		if($prestationSpa.find(".input-time-spa:checked").length > 0){
			refreachListCommandeSpa();
		}
	});
	refreachListCommandeSpa();
}

/* ------------------------------------------------------------------------------------ */
/* ------------------------------ PRESTATION MASSAGE  --------------------------------- */
/* ------------------------------------------------------------------------------------ */

$(".remove-massage").click(function() {
	let $parentsGroup = $(".prestation-group[data-category='"+$(this).data().category+"']").last();
	let arrayIndex = groupMassagePosition($parentsGroup);
	let session_massages = JSON.parse(sessionStorage.getItem("massages"));
	session_massages.splice(arrayIndex,1);
	sessionStorage.setItem("massages",JSON.stringify(session_massages));
	$parentsGroup.remove();
	refreachListCommande();
	numberOfPrestationMassage($(this).data().category);
});

$(".add-massage").click(function() {
	$prestationGroups = $($("#"+$(this).data().category).html());
	let category = $(this).data().category;
	let longeur = $(".prestation-group[data-category='"+category+"']").length;
	let session_massages = JSON.parse(sessionStorage.getItem("massages"));
/*--------------------- GERER LES ID ET LES ATTRIBUTS DES INPUT --------------------*/
	if (category === "for_massage_man") {
		session_massages.push({"category":"massage_man","prestations":[]});
		$prestationGroups = changeInputIdAndLabelFor($prestationGroups,"man",longeur);
	}else{
		session_massages.push({"category":"massage_woman","prestations":[]});
		$prestationGroups = changeInputIdAndLabelFor($prestationGroups,"woman",longeur);
	}
/* ---------------- Clique sur un input ------------------- */
	$prestationGroups.find(".subcategory_massage_input").click(function(){
	    showListSubcategoriesInBascket(this);
	})
/*---------------------GERER LES ID ET LES ATTRIBUTS DES INPUT --------------------*/
	sessionStorage.setItem("massages",JSON.stringify(session_massages));
	$("#select-list-massage").append($prestationGroups);
	numberOfPrestationMassage(category);
});

/*-----------------------------ACTUALISE DOM MASSAGE ----------------------------- */
function actualiseValueMassage(session_massages){
	for (var i = session_massages.length - 1; i >= 0; i--) {
		if (session_massages[i].prestations.length == 0){
			session_massages.splice(i,1);
		}
	}
	sessionStorage.setItem("massages",JSON.stringify(session_massages));
	var number_man = 0;
	var number_woman = 0;
	session_massages.forEach(function(massage){
		$prestationGroups = $($("#for_"+massage.category).html());
		if (massage.category === "massage_man") {
			$prestationGroups = changeInputIdAndLabelFor($prestationGroups,"man",number_man,massage.prestations);
			number_man += 1;
		}else{
			$prestationGroups = changeInputIdAndLabelFor($prestationGroups,"woman",number_woman,massage.prestations);
			number_woman += 1;
		}
		$("#select-list-massage").append($prestationGroups);
	});
	// afficher les liste des massage selectionné
	refreachListCommande();
	$(".subcategory_massage_input").click(function(){
	    showListSubcategoriesInBascket(this);
	})
	numberOfPrestationMassage("for_massage_man");
	numberOfPrestationMassage("for_massage_woman");
}
/*------------------ Autre fonction primaire --------------*/
// Clique sur un input execute cette fonction
function showListSubcategoriesInBascket(input) {
	let parentsGroup = $(input).parents(".prestation-group");
	let arrayIndex = groupMassagePosition(parentsGroup);
	let session_massages = JSON.parse(sessionStorage.getItem("massages"));
	let subcategoriesList = [];
	parentsGroup.find("input:checked").each(function(index,element){
		subcategoriesList.push($(element).data().subcategory);
	});
	session_massages[arrayIndex].prestations = subcategoriesList;
	sessionStorage.setItem("massages",JSON.stringify(session_massages));
	// rafraichir la liste des massage selectionné
	refreachListCommande(arrayIndex);
}

function refreachListCommande(arrayIndex = "") {
	let innerHTML = "";
	let totalAcompte = 0.0;
	let totalPrice = 0.0;
	$('.prestation-group').each(function(index,element){
		$inputList= $(element).find("input:checked");
		if ($inputList.length > 0) {
			price = 0.0;
			if (arrayIndex === index) {
				ul = '<ul id="basket-group-'+ index +'" class="massage_basket">';
			}else{
				ul = '<ul id="basket-group-'+ index +'" class="massage_basket hidden">';
			}
		    $inputList.each(function(i,elm){
				ul += '<li>'+ $(elm).data().title +'</li>';
				// [exceptional_price,exceptional_acompte,ordinary_price,ordinary_acompte]
		    	if(true){ // is exeptiona true
		    		price += $(elm).data().price[0]+$(elm).data().price[1];
					totalPrice += $(elm).data().price[0];
		    		totalAcompte += $(elm).data().price[1];
		    	}else{ // is exeptional false
		    		price += $(elm).data().price[2]+$(elm).data().price[3];
		    		totalPrice += $(elm).data().price[2];
		    		totalAcompte += $(elm).data().price[3];
		    	}
		    });
		    ul += '</ul>';
		    innerHTML += '<div class="showOnClick" data-list="basket-group-'+ index +'">'+'<h3 class="subTitlePanierMsg"><a>'+ $(element).data().title+'</a>'+' <span>'+ price + '€</span></h3>'+ '</div>'+ ul;
	    }
	});
	$(".presta-list")[0].dataset.price = "["+totalPrice+","+totalAcompte+"]";
	let spaPrice = JSON.parse($(".presta-spa-list")[0].dataset.price);
	if (spaPrice.length === 2) {
		totalPrice += spaPrice[0];
		totalAcompte += spaPrice[1];
	}
	$("#totalPricePrestation").html(totalPrice);
	$("#totalAcomptePrestation").html(totalAcompte);
	hideMessageShow(totalPrice);
	$(".presta-list").html(innerHTML);
	// on click affiche ou cacher les liste des massages
	$(".showOnClick").click(function() {
		let $this = $("#"+$(this).data().list);
		if ($this.hasClass("hidden")){
			$this.removeClass("hidden");
		}else{
			$this.addClass("hidden");
		}
	});
}
// nombre de massage selectionné
function numberOfPrestationMassage(category) {
	list_length = $(".prestation-group[data-category='"+category+"']").length;
	if (category === "for_massage_man") {
		$("#number_man").text(list_length);
	}else{
		$("#number_woman").text(list_length);
	}
	return list_length;
}
// position du div
function groupMassagePosition(searchDiv){
	let arrayIndex = "";
	$('.prestation-group').each(function(index,element){
	    if(element == searchDiv[0]){
	    	arrayIndex = index;
			return false;
	   	}
	})
	return arrayIndex;
}

// changer le valeur de labe et for , input : id
function changeInputIdAndLabelFor($prestationGroups,name,longeur,dataInput=[]){
	$prestationGroups.find("input").each(function(index, element){
		let valueAttribute = $(element).attr("id");
		$(element).attr("id",valueAttribute+name+longeur);
		$(element).attr("name",name+"["+longeur+"][]");
		if (dataInput.length > 0) {
			if(dataInput.indexOf($(element).data().subcategory) !== -1){
				$(element).prop("checked",true);
			}
		}
	});
	$prestationGroups.find("label").each(function(index, element){
		let valueAttribute = $(element).attr("for");
		$(element).attr("for",valueAttribute+name+longeur);
	});
	return $prestationGroups;
}
function hideMessageShow(value){
	if (value > 0) {
		$("#warnning-message").addClass("hidden");
	}else{
		$("#warnning-message").removeClass("hidden");
	}
}

/*~~~~~~~~~~~~ gerer le modalt pour le choix du pays et date ~~~~~~~~~~~~~~~~~*/
$("#country-choice").click(function(){
	var input_dptm = $("#Departement");
	var div_dptm = $("#list-department");
	if (this.value == "France") {
		input_dptm.prop("disabled",false);
		div_dptm.removeClass("hidden");
	}else{
		input_dptm.prop("disabled",true);
		div_dptm.addClass("hidden");
	}
});

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Submit formulaire ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
$("#nex-submi-tag").click(function(){
	if(true){
		$("#form-data").submit()
	}else{
		// document.getElementById("loc-spa-fafana").classList.add("active")
		// document.getElementsByClassName("accordion-body js-accordion-body").style.display="block"
	}
});


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ heurs pratitien ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

// mprix augmente: $("#inpdate")

$("#heure-spa").click(function(){
	let zone = JSON.parse(sessionStorage.getItem("zone"))
	zone.time_spa = $(this).val()
	sessionStorage.setItem("zone",JSON.stringify(zone));
});
$("#heure-massage").click(function(){
	let zone = JSON.parse(sessionStorage.getItem("zone"))
	zone.time_massage = $(this).val()
	sessionStorage.setItem("zone",JSON.stringify(zone));
});
$(".praticien-list").click(function(){
	let zone = JSON.parse(sessionStorage.getItem("zone"))
	zone.pratitien = $(this).val()
	sessionStorage.setItem("zone",JSON.stringify(zone));
});
