function initSession(){
	sessionStorage.setItem("prestation","[]")
	sessionStorage.setItem("service","")
}

if(sessionStorage.getItem("prestation") == null || sessionStorage.getItem("service") == null){
	initSession();
}else{

}

/*
let prestations = [
	{"category":["man",0],"prestations":[["google",3],"map"]},
	{"category":["woman",1],"prestations":[["yahoo",3],"hotmail"]}
];


sessionStorage.getItem("prenom")



console.log(delete prestations[0].category);  // renvoie true

<!--
element.removeAttribute(nomAttribut);
-->

variable_json = {name:"koto"}
/* Avadika ho string le objet * /
dd = JSON.stringify(variable_json)
/* Averina ho JSON indray * /
JSON.parse(dd)


[{"category":"man","prestations":["beard_trim","beard_shave"]},{"category":"woman","prestations":["woman_shampoo","woman_haircare"]}]

[
	{
	"name" :"Total Accepted",
	"data" :[12,22,12,13,0,0,59]
	},
	{
	"name" :"To Accept",
	"data" :[0,0,0,4,60,92,156]
	}, 
	{
	"name" :"Point comitted",
	"data" :[12,34,46,63,123,215]
	}
]

*/