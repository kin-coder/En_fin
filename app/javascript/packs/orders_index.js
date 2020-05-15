$(".remove-massage").click(function() {
	$(".prestation-group[data-category='"+$(this).data().category+"']").last().remove();
	numberOfPrestationMassage($(this).data().category);
});

$(".add-massage").click(function() {
	$prestationGroups = $($("#"+$(this).data().category).html())
	let category = $(this).data().category;
	let longeur = $(".prestation-group[data-category='"+category+"']").length;
/*---------------------GERER LES ID ET LES ATTRIBUTS DES INPUT --------------------*/
	if (category === "for_massage_man") {
		$prestationGroups.find("input").each(function(index, element){
			let valueAttribute = $(element).attr("id")
			$(element).attr("id",valueAttribute+"man"+longeur)
		});
		$prestationGroups.find("label").each(function(index, element){
			let valueAttribute = $(element).attr("for")
			$(element).attr("for",valueAttribute+"man"+longeur)
		});
	}
	if (category === "for_massage_woman") {
		$prestationGroups.find("input").each(function(index, element){
			let valueAttribute = $(element).attr("id")
			$(element).attr("id",valueAttribute+"woman"+longeur)
		});
		$prestationGroups.find("label").each(function(index, element){
			let valueAttribute = $(element).attr("for")
			$(element).attr("for",valueAttribute+"woman"+longeur)
		});
	}
/*---------------------GERER LES ID ET LES ATTRIBUTS DES INPUT --------------------*/
	$("#select-list-massage").append($prestationGroups);
	numberOfPrestationMassage(category);
});

function numberOfPrestationMassage(category) {
	list_length = $(".prestation-group[data-category='"+category+"']").length;
	if (category === "for_massage_man") {
		$("#number_man").text(list_length);
	}
	if (category === "for_massage_woman") {
		$("#number_woman").text(list_length);
	}
	return list_length;
}


/*



function initSession(){
	sessionStorage.setItem("prestations","{}")
	sessionStorage.setItem("spa","[]")
	sessionStorage.setItem("massages","[]")
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


*/

