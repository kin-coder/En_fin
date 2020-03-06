function on() {
  document.getElementById("overlay").style.display = "block";
}

// function off() {
//   document.getElementById("overlay").style.display = "none";
// }

window.onload = on();

/*

// addZoneInPrestations()

// function addZoneInPrestations() {
// 	let addZone = JSON.parse(sessionStorage.getItem("prestations"))
// 	addZone.pays = "<%= @all_params[:country] %>"
// 	<% if @all_params[:department] %>
// 		addZone.departement = "<%= @all_params[:department] %>"
// 	<% else %>
// 		delete addZone.departement
// 	<% end %>
// 	addZone.date = "<%= @all_params[:date] %>"
// 	addZone.heurs = "<%= @all_params[:heure] %>"
// 	sessionStorage.setItem("prestations",JSON.stringify(addZone))
// }


*/