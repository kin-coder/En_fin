class NotificationController < ApplicationController
  def index
  	@notifications = Notification.all
  end

  def update
  	@notification = Notification.find(params[:id])
  	@notification.update(is_view:true)
  	redirect_to admin_order_show_path(@notification.order_id)
  end
end
