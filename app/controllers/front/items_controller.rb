class Front::ItemsController < Front::FrontController
  def index
    @items = Item.by_position
  end

  def show
    @item = Item.find(params[:id])
  end
end
