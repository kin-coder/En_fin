$(".remove-massage").click(function() {
	$(".prestation-group[data-category='"+$(this).data().category+"']").last().remove();
	numberOfPrestationMassage($(this).data().category);
});

$(".add-massage").click(function() {
	$gona = $("#"+$(this).data().category).html()
	$("#select-list-massage").append($gona);
	console.log($gona)
	numberOfPrestationMassage($(this).data().category);
});

function numberOfPrestationMassage(category) {
	list_length = $(".prestation-group[data-category='"+category+"']").length;
	if (category === "for_massage_man") {
		$("#number_man").text(list_length);
	}
	if (category === "for_massage_woman") {
		$("#number_woman").text(list_length);
	}
}