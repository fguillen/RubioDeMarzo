class Front::CategoriesController < Front::FrontController
  def show
    @category = Category.find(params[:id])
  end
end
