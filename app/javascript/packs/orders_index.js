function initSession(){
	sessionStorage.setItem("prestation","[]")
	sessionStorage.setItem("service","")
}

if(sessionStorage.getItem("prestation") == null || sessionStorage.getItem("service") == null){
	initSession();
}else{

}
