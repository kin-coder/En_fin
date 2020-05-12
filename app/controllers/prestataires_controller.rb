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
    flash[:list_message_errors] = @prestataire.errors.full_messages
    if params[:service] == nil || params[:prestataire][:country_ids] == nil
      if params[:service] == nil
        flash[:list_message_errors].push("Services doit être rempli(e)")
      end
      if params[:prestataire][:country_ids] == nil
        flash[:list_message_errors].push("Le(s) zone(s) où vous pouvez faire vos prestations doit être rempli(e)")
      end
      redirect_back(fallback_location: root_path)
      return
    else
      testValue = params[:prestataire][:country_ids].include?(Country.find_by(name:"France").id.to_s) && (params[:prestataire][:department_ids] == nil)
      if testValue
        flash[:list_message_errors].push("Si vous choisisser France veuillez cocher au moins une de ces départements")
        redirect_back(fallback_location: root_path)
        return
      end
      @prestataire.service_ids = params[:service][:service_ids]
      @prestataire.country_ids = params[:prestataire][:country_ids]
      @prestataire.department_ids = params[:prestataire][:department_ids]

      if @prestataire.save
        flash[:admin_notice] = 'Le prestataire a été créé avec succès.'
        redirect_to show_prestataires_path(@prestataire.id)
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
    flash[:list_message_errors] = @prestataire.errors.full_messages
    if params[:service]==nil || params[:prestataire][:country_ids]==nil
      if params[:service] == nil
        flash[:list_message_errors].push("Services doit être rempli(e)")
      end
      if params[:prestataire][:country_ids] == nil
        flash[:list_message_errors].push("Le(s) zone(s) où vous pouvez faire vos prestations doit être rempli(e)")
      end
      redirect_back(fallback_location: root_path)
      return
    else
      testValue = params[:prestataire][:country_ids].include?(Country.find_by(name:"France").id.to_s) && (params[:prestataire][:department_ids] == nil)
      if testValue
        flash[:list_message_errors].push("Si vous choisisser France veuillez cocher au moins une de ces départements")
        redirect_back(fallback_location: root_path)
        return
      end
      @prestataire.country_ids = params[:prestataire][:country_ids]
      @prestataire.department_ids = params[:prestataire][:department_ids]
      @prestataire.service_ids = params[:service][:service_ids]
      if @prestataire.save
        flash[:admin_notice] = 'Le prestataire a été modifié avec succès.'
        redirect_to show_prestataires_path(@prestataire.id)
      else
        render :edit
      end
    end
  end

  def destroy
    o_services = OrderService.all.where(prestataire_id:@prestataire.id)
    if o_services.empty?
      @prestataire.destroy
      flash[:admin_notice] = 'Le prestataire a été supprimer avec succès.'
      redirect_to index_prestataires_path
    else
      flash[:admin_notice] = 'Impossible de supprimer ce prestataire car il est attribué a une commande.'
      redirect_to index_prestataires_path
    end
  end

  private
    def set_prestataire
      @prestataire = Prestataire.find(params[:id])
    end

    def prestataire_params
      params.require(:prestataire).permit(:email,:sexe,:first_name,:last_name,:date_of_birth,:raison_sociale,:siren,:tel,:adresse,:adresse_complet,:zip_code,:ville,:pays)
    end
end
