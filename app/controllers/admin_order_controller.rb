class AdminOrderController < Application2Controller
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  def index
    @orders = Order.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

end


