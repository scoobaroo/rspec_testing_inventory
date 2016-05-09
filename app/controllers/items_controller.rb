class ItemsController < ApplicationController
  def show
    @item = Item.find_by(id: params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    if item.save
      redirect_to product_item_path(params[:product_id], item)
    else
      flash[:error] = item.errors.full_messages.join(" ")
      redirect_to new_product_item_path(params[:product_id])
    end
  end

  def edit
    @item = Item.find_by(id: params[:id])
  end

  def update
    item = Item.find_by(id: params[:id])
    if item.update(item_params)
      redirect_to product_item_path(item.product_id, item.id)
    else
      flash[:error] = item.errors.full_messages.join(" ")
      redirect_to edit_product_item_path(item.product_id, item.id)
    end

  end

  def destroy
    Item.destroy(params[:id])
    redirect_to root_path
  end

  private
    def item_params
      params.require(:item).permit(:color, :size, :status)
    end
end
