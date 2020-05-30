class ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
  	ClientMailer.welcome_client(resource).deliver_now
    new_client_session_path
  end
end
