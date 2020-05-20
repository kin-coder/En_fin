json.array! @notifications do |notification|
  json.notif do
  	json.id notification.id
	  json.message notification.messages
	  json.view notification.is_view
	  json.date notification.created_at
  end
end


#<a rel="nofollow" data-method="patch" href="/admin/notification/4">La commande n°2 a bien été traitée</a>