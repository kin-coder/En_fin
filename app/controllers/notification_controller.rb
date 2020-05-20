class NotificationController < ApplicationController
  def index  	
  	inf_id = params[:id].to_i
  	sup_id = Notification.lastIndex
  	@notifications = Notification.where(id:[inf_id..sup_id])
  end

  def update
  	@notification = Notification.find(params[:id])
  	@notification.update(is_view:true)
  	redirect_to admin_order_show_path(@notification.order_id)
  end
end


=begin
dota=
{"id":current_order.id,"text":"La commande n°#{current_order.id} a bien été traitée"}

Notification.create(notif_type:1,data:dota.to_json)

=end