class AdminsController < Application2Controller
    before_action :authenticate_admin!
    
    # page d'accueil du page admin
    def index
    	@admin = current_admin
        @service = Service.all
    end

    def admin_page
        
    end
    
    def prestataire
    	
    end
end
