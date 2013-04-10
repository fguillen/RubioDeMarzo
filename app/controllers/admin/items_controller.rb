class Admin::ItemsController < Admin::AdminController
  before_filter :require_admin_user
  before_filter :load_item, :only => [:edit, :update, :destroy]

  def index
    @items = Item.by_position
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])

    @item.log_book_historian = current_admin_user
    if @item.save
      redirect_to edit_admin_item_path(@item), :notice => "Successfully created Item."
    else
      flash.now[:alert] = "Some error trying to create item."
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @item.update_attributes(params[:item])
      redirect_to edit_admin_item_path(@item), :notice  => "Successfully updated Item."
    else
      flash.now[:alert] = "Some error trying to update Item."
      render :action => 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to :admin_items, :notice => "Successfully destroyed Item."
  end

  def reorder
    params[:ids].each_with_index do |id, index|
      Item.update_all(["position=?", index], ["id=?", id])
    end
    render :json => { "status" => "ok" }
  end

  private

  def load_item
    @item = Item.find(params[:id])
    @item.log_book_historian = current_admin_user
  end
end
