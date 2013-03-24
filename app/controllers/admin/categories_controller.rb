class Admin::CategoriesController < Admin::AdminController
  before_filter :require_admin_user
  before_filter :load_category, :only => [:edit, :update, :destroy]

  def index
    @categories = Category.by_position.in_section(params[:section])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to edit_admin_category_path(@category), :notice => "Successfully created Category."
    else
      flash.now[:alert] = "Some error trying to create category."
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(params[:category])
      redirect_to edit_admin_category_path(@category), :notice  => "Successfully updated Category."
    else
      flash.now[:alert] = "Some error trying to update Category."
      render :action => 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path(:section => @category.section), :notice => "Successfully destroyed Category."
  end

  def reorder
    params[:ids].each_with_index do |id, index|
      Category.update_all(["position=?", index], ["id=?", id])
    end
    render :json => { "status" => "ok" }
  end

  private

  def load_category
    @category = Category.find(params[:id])
  end
end
