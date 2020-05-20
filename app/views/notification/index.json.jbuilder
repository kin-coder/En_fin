json.array! @notifications do |notification|
  json.notif do
  	json.id notification.id
	  json.message notification.messages
	  json.view notification.is_view
  end
end
