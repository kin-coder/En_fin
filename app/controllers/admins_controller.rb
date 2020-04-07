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

    def allcandidate
        @candidates = Candidate.all
    end

    # gestion candidature
    def showEditCandidat
        @services = Service.all
        @countries = Country.all
        @departments = Department.all
        @candidate = Candidate.find(params[:id].to_i)

        @allServices = []
        @candidate.services.split("|").each do |service|
            @allServices.push(Service.find_by(name:service).id)
        end

        @allCountries = []
        @candidate.countries.split("|").each do |country|
            @allCountries.push(Country.find_by(name:country).id)
        end

        @allDepartment = []
        if @candidate.departments
            @candidate.departments.split("|").each do |department|
                @allDepartment.push(Department.find_by(name:department).id)
            end
        end
    end

    def createCandidateToPrestataire
        @prestataire = Prestataire.new
        candidate = params[:candidate]
        @prestataire.email = candidate[:email]
        @prestataire.sexe = candidate[:sexe]
        @prestataire.first_name = candidate[:first_name]
        @prestataire.last_name = candidate[:last_name]
        @prestataire.date_of_birth = candidate[:date_of_birth]
        @prestataire.raison_sociale = candidate[:raison_sociale]
        @prestataire.siren = candidate[:siren]
        @prestataire.tel = candidate[:telephone]
        @prestataire.adresse = candidate[:adresse]
        @prestataire.zip_code = candidate[:zip_code]
        @prestataire.ville = candidate[:ville]
        @prestataire.pays = candidate[:country]

        if params[:service] == nil || params[:prestataire][:country_ids] == nil
          redirect_back(fallback_location: root_path)
        else
          testValue = params[:prestataire][:country_ids].include?(Country.find_by(name:"France").id.to_s) && (params[:prestataire][:department_ids] == nil)
          if testValue
            redirect_back(fallback_location: root_path)
            return
          end
          @prestataire.service_ids = params[:service][:service_ids]
          @prestataire.country_ids = params[:prestataire][:country_ids]
          @prestataire.department_ids = params[:prestataire][:department_ids]
          
          if @prestataire.save
            Candidate.find(params[:id].to_i).destroy
            redirect_to show_prestataires_path(@prestataire.id), notice: 'Le prestataire a été créé avec succès.'
          else
            render :showEditCandidat
          end
        end
    end

    def cancelCandidat
        Candidate.find(params[:id].to_i).destroy
        redirect_to allcandidate_path, notice: 'Le (la) candidate a été supprimer avec succès.'
    end

    # page mandaraka

    def admin_page
        
    end
    
    def prestataire
    	
    end
end
