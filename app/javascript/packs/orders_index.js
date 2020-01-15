function initSession(){
	sessionStorage.setItem("prestations","[]")
	sessionStorage.setItem("input",0)
}

function addDomIndex(){
	
}

if(sessionStorage.getItem("prestations") == null){
	initSession()
}else{
	addDomIndex()
}
