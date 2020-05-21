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

  def update_all
    Notification.all.update(is_view:true)
    redirect_back(fallback_location: root_path)
  end
end
