class PrestatairesController < Application2Controller
  before_action :set_prestataire, only: [:show, :edit, :update, :destroy]

  def index
    @prestataires = Prestataire.all
  end

  def show
    @services = @prestataire.services
    @departments = @prestataire.departments
  end

  def new
    @prestataire = Prestataire.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
  private
    def set_prestataire
      @prestataire = Prestataire.find(params[:id])
    end

    def prestataire_params
      params.require(:article).permit(:fname, :lname, :bdate, :email)
    end
end
