class AdminsController < Application2Controller
    before_action :authenticate_admin!
    
    # page d'accueil du page admin
    def index
    	@admin = current_admin
        @services = Service.all
        @candidates = Candidate.all
        @clients = Client.all
        @countries = Country.all
        @departments = Department.all
        @prestataires = Prestataire.all
        @orders = Order.all
        # @OrderMassage = OrderMassage.all
        # @OrderProduct = OrderProduct.all
        # @OrderService = OrderService.all
        # @OrderSpa = OrderSpa.all
    end

    # gestion candidature
    def showEditCandidat
        @candidate = Candidate.find(params[:id].to_i)
        @prestataire = Prestataire.new
    end
    def createCandidateToPrestataire
        
    end
    def cancelCandidat
        
    end

    # page mandaraka

    def admin_page
        
    end
    
    def prestataire
    	
    end
end
