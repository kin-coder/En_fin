class PrestatairesController < Application2Controller
  before_action :authenticate_admin!
  before_action :set_prestataire, only: [:show, :edit, :update, :destroy]

  def index
    @prestataires = Prestataire.all
  end

  def show
    @services = @prestataire.services
    @countries = @prestataire.countries
    @departments = @prestataire.departments
  end

  def new
    @services = Service.all
    @countries = Country.all
    @departments = Department.all
    @prestataire = Prestataire.new
  end

  def create
    @prestataire = Prestataire.new(prestataire_params)
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
        redirect_to show_prestataires_path(@prestataire.id), notice: 'Le prestataire a été créé avec succès.'
      else
        render :new
      end
    end
  end

  def edit
    @services = Service.all
    @countries = Country.all
    @departments = Department.all
  end

  def update
    @prestataire.update(prestataire_params)   
    if params[:service]==nil || params[:prestataire][:country_ids]==nil
      #|| params[:prestataire][:department_ids]==nil
      redirect_back(fallback_location: root_path)
    else
      testValue = params[:prestataire][:country_ids].include?(Country.find_by(name:"France").id.to_s) && (params[:prestataire][:department_ids] == nil)
      if testValue
        redirect_back(fallback_location: root_path)
        return
      end
      @prestataire.country_ids = params[:prestataire][:country_ids]
      @prestataire.department_ids = params[:prestataire][:department_ids]
      @prestataire.service_ids = params[:service][:service_ids]
      if @prestataire.save
        redirect_to show_prestataires_path(@prestataire.id), notice: 'Le prestataire a été modifié avec succès.'
      else
        render :edit
      end
    end
  end

  def destroy
    @prestataire.destroy
    redirect_to index_prestataires_path, notice: 'Le prestataire a été supprimer avec succès.'
  end

  private
    def set_prestataire
      @prestataire = Prestataire.find(params[:id])
    end

    def prestataire_params
      params.require(:prestataire).permit(:email,:sexe,:first_name,:last_name,:date_of_birth,:raison_sociale,:siren,:tel,:adresse,:zip_code,:ville,:pays)
    end
end
