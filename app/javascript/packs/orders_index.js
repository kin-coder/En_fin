$(".remove-massage").click(function() {
	$(".prestation-group[data-category='"+$(this).data().category+"']").last().remove();
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
		$prestationGroups.find("input").each(function(index, element){
			let valueAttribute = $(element).attr("id");
			$(element).attr("id",valueAttribute+"man"+longeur);
		});
		$prestationGroups.find("label").each(function(index, element){
			let valueAttribute = $(element).attr("for");
			$(element).attr("for",valueAttribute+"man"+longeur);
		});
	}else{
		session_massages.push({"category":"massage_woman","prestations":[]});
		$prestationGroups.find("input").each(function(index, element){
			let valueAttribute = $(element).attr("id");
			$(element).attr("id",valueAttribute+"woman"+longeur);
		});
		$prestationGroups.find("label").each(function(index, element){
			let valueAttribute = $(element).attr("for");
			$(element).attr("for",valueAttribute+"woman"+longeur);
		});
	}
/* ---------------- Clique sur un input ------------------- */
	$prestationGroups.find(".subcategory_massage_input").click(function(){
	    showListSubcategoriesInBascket(this);
	})
/*---------------------GERER LES ID ET LES ATTRIBUTS DES INPUT --------------------*/
	sessionStorage.setItem("massages",JSON.stringify(session_massages));
	$("#select-list-massage").append($prestationGroups);


	session_massages.length

$(".presta-list")

basket-group-1


	numberOfPrestationMassage(category);
});




































/*------------------ Autre fonction primaire --------------*/
// afficher les donné cocher dans la liste
function showListSubcategoriesInBascket(input) {
	let parentsGroup = $(input).parents(".prestation-group")
	let arrayIndex = ""
	$('.prestation-group').each(function(index,element){
	    if(element == parentsGroup[0]){
	    	arrayIndex = index
			return false
	   	}
	})
	parentsGroup.find("input:checked")
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


/*


function initSession(){
	sessionStorage.setItem("prestations","[]")
	sessionStorage.setItem("spa","[]")
	
	sessionStorage.setItem("cadeau","[]")
	sessionStorage.setItem("inc","0")
}


sessionStorage.setItem("prestations",JSON.stringify(prestations))
let prestations = JSON.parse(sessionStorage.getItem("prestations"))

[
{
"category":"man",
"prestations":["man_shampoo","man_haircut"]
},

{
"category":"woman",
"prestations":["woman_shampoo","woman_color"]
}

]


[
{"category":"man","prestations":[]}
{"category":"man","prestations":["man_haircut","man_color"]}
{"category":"man","prestations":["man_shampoo"]}
]


*/

