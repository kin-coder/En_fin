class ApplicationController < ActionController::Base
	before_action :configure_devise_parameters, if: :devise_controller?

    def configure_devise_parameters
        devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:first_name, :last_name, :adresse,:sexe, :tel, :email, :password, :password_confirmation)}
        devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:first_name, :last_name, :sexe, :adresse, :tel, :email, :password, :password_confirmation)}
    end
end
