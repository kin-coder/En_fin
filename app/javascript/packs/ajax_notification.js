function requeteAjax(){
	var idNumber = document.getElementById("notification_list").dataset.notification
	var xhr = new XMLHttpRequest();
	var ulContainer = document.getElementById("ul_notification_list")
	var newNotification = document.getElementById("number-hide")
	xhr.onreadystatechange = function() {
		if(this.readyState == 4 && this.status == 200) {
			data = this.response
			if (data.length > 0) {
				console.log(data)
				for (var i = data.length - 1; i >= 0; i--) {
					var nodeLi = '<li><a data-view="'+data[i].notif.view+'" rel="nofollow" data-method="patch" href="/admin/notification/'+data[i].notif.id+'">'+ data[i].notif.message +'</a><li>'
					ulContainer.innerHTML = nodeLi + ulContainer.innerHTML
				}
				newNotification.innerHTML = parseInt(newNotification.innerHTML)+data.length
				document.getElementById("notification_list").dataset.notification = data[data.length-1].notif.id+1
			}else{
				console.log("tsy misy")
			}
		}
	};
	xhr.open("GET", "/all/"+idNumber+"/notifications.json", true)
	xhr.responseType = "json"
	xhr.send();
}
setInterval(requeteAjax, 10000);
