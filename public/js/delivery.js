function checkedDefaultValue(){
	let pays = JSON.parse(sessionStorage.getItem('zone')).country
	document.querySelectorAll('input[name="countryL"]').forEach(country => {
		if (pays == country.value) {
			country.checked = true
		}
	});
	document.querySelectorAll('input[name="countryF"]').forEach(country => {
		if (pays == country.value) {
			country.checked = true
		}
	});
}
checkedDefaultValue()