main();

function main(){
	let session_massages = sessionStorage.getItem("massages")
	if ( session_massages == null) {
		sessionStorage.setItem("massages","[]");
	}else{
		actualiseValueMassage(JSON.parse(session_massages));
	}
	let session_spas = sessionStorage.getItem("spas")
	if ( session_spas == null) {
		sessionStorage.setItem("spas","[]");
	}else{
		//actualiseValueSpa(JSON.parse(session_spas));
	}
}

/* ------------------------------------------------------------------------------------ */
/*--------------------------------- PRESTATION SPA  -----------------------------------*/
/* ------------------------------------------------------------------------------------ */


$("#remove-spa").click(function(){
	$(".prestation-group-spa").last().remove();

});

$("#add-spa").click(function(){
	let number = $(".prestation-group-spa").length
	let $prestationSpa = $($("#for_location_spa").html());

/*-------------------------------- MODIFIER DOM ----------------------------------*/
	$prestationSpa.find(".label-time-spa,.label-ambiance-spa").each(function(index,element){
		let label = $(element).attr("for")
		$(element).attr("for",label+number)
	});
	$prestationSpa.find(".input-time-spa").each(function(index,element){
		let id = $(element).attr("id")
		$(element).attr("id",id+number)
		$(element).attr("name","spas["+number+"][time][]")
	});
	$prestationSpa.find(".input-ambiance-spa").each(function(index,element){
		let id = $(element).attr("id")
		$(element).attr("id",id+number)
		$(element).attr("name","spas["+number+"][ambiance][]")
	});
	$prestationSpa.find('.label-type-spa').each(function(index,element){
		let label = $(element).attr("for")
		$(element).attr("for",label+number)
	});
	$prestationSpa.find(".select-type-spa").each(function(index,element){
		let id = $(element).attr("id");
		$(element).attr("name","spas["+number+"][type][]");
		$(element).attr("id",id+number);
	});
/*-------------------------------- MODIFIER DOM ----------------------------------*/
	//event manokana ,.select-type-spa
	
	$prestationSpa.find(".input-time-spa,.input-ambiance-spa").click(function(){
		showListTimeAndAmbianceInBascket($(this));
	});

	$("#select-list-spa").append($prestationSpa);
});














/* ------------------------------------------------------------------------------------ */
/* ------------------------------ PRESTATION MASSAGE  --------------------------------- */
/* ------------------------------------------------------------------------------------ */

$(".remove-massage").click(function() {
	let $parentsGroup = $(".prestation-group[data-category='"+$(this).data().category+"']").last();
	let arrayIndex = groupMassagePosition($parentsGroup);
	let session_massages = JSON.parse(sessionStorage.getItem("massages"));
	session_massages.splice(arrayIndex,1)
	sessionStorage.setItem("massages",JSON.stringify(session_massages));
	$parentsGroup.remove();
	// rafraichir la liste des massages
	refreachListCommande();
	numberOfPrestationMassage($(this).data().category);
});

$(".add-massage").click(function() {
	$prestationGroups = $($("#"+$(this).data().category).html())
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
			session_massages.splice(i,1)
		}
	}
	sessionStorage.setItem("massages",JSON.stringify(session_massages));
	var number_man = 0
	var number_woman = 0
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
	let parentsGroup = $(input).parents(".prestation-group")
	let arrayIndex = groupMassagePosition(parentsGroup)
	let session_massages = JSON.parse(sessionStorage.getItem("massages"));
	let subcategoriesList = []
	parentsGroup.find("input:checked").each(function(index,element){
		subcategoriesList.push($(element).data().subcategory);
	});
	session_massages[arrayIndex].prestations = subcategoriesList;
	sessionStorage.setItem("massages",JSON.stringify(session_massages));
	// rafraichir la liste des massage selectionné
	refreachListCommande(arrayIndex);
}

function refreachListCommande(arrayIndex = "") {
	let innerHTML = ""
	let totalAcompte = 0.0
	let totalPrice = 0.0
	$('.prestation-group').each(function(index,element){
		$inputList= $(element).find("input:checked")
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
		    		price += $(elm).data().price[0]+$(elm).data().price[1]
					totalPrice += $(elm).data().price[0]
		    		totalAcompte += $(elm).data().price[1]
		    	}else{ // is exeptional false
		    		price += $(elm).data().price[2]+$(elm).data().price[3]
		    		totalPrice += $(elm).data().price[2]
		    		totalAcompte += $(elm).data().price[3]
		    	}
		    });
		    ul += '</ul>';
		    innerHTML += '<div class="showOnClick" data-list="basket-group-'+ index +'">'+'<a>'+ $(element).data().title+'</a>'+' <span>'+ price + '€</span>'+ '</div>'+ ul;
	    }
	});

	$("#totalPricePrestation").html(totalPrice)
	$("#totalAcomptePrestation").html(totalAcompte)

	$(".presta-list").html(innerHTML);
	// on click affiche ou cacher les liste des massages
	$(".showOnClick").click(function() {
		let $this = $("#"+$(this).data().list)
		if ($this.hasClass("hidden")){
			$this.removeClass("hidden")
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
				$(element).prop("checked",true)
			}
		}
	});
	$prestationGroups.find("label").each(function(index, element){
		let valueAttribute = $(element).attr("for");
		$(element).attr("for",valueAttribute+name+longeur);
	});
	return $prestationGroups;
}
