main();

function main(){
	let countries = document.querySelectorAll('.js-country');

	countries.forEach(country => {
		country.addEventListener('change',showDepartementIfFrance);
		if(country.value == "France" && country.checked == true){
			document.getElementById("js-department-list").classList.remove("hidden")
		}
	});	
}

function showDepartementIfFrance() {
	let departments = document.querySelectorAll('.js-department');
	if(this.checked == true && this.value == "France"){
		document.getElementById("js-department-list").classList.remove("hidden")
	}
	if(this.checked == false && this.value == "France"){
		document.getElementById("js-department-list").classList.remove("hidden")
		document.getElementById("js-department-list").classList.add("hidden")
		departments.forEach(department => {
			department.checked = false
		})
	}
}
