class ApplicationController < ActionController::Base
	before_action :configure_devise_parameters, if: :devise_controller?

	def configure_devise_parameters
		devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:first_name,:last_name,:adresse,:adresse_complet,:tel,:sexe,:country,:zip_code, :email, :password, :current_password, :password_confirmation)}
		devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:first_name,:last_name,:adresse,:adresse_complet,:tel,:sexe,:country,:zip_code, :email, :password, :current_password, :password_confirmation)}
	end

	# redirection after sign in
	
	def after_sign_in_path_for(resource_or_scope)
		session.fetch 'user_return_to', client_profil_path
	end
end