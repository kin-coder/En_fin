class ApplicationController < ActionController::Base
	before_action :configure_devise_parameters, if: :devise_controller?

	def configure_devise_parameters
		devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:first_name,:last_name,:adresse,:adresse_complet,:town,:tel,:sexe,:country,:zip_code, :email, :password, :current_password, :password_confirmation)}
		devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:first_name,:last_name,:adresse,:adresse_complet,:town,:tel,:sexe,:country,:zip_code, :email, :password, :current_password, :password_confirmation)}
	end

	def after_sign_in_path_for(resource_or_scope)
		stored_location_for(resource) || client_profil_path
	end
end
