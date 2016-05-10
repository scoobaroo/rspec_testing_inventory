class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
  end

  def create
    new_item = Item.new item_params
    if new_item.save
      flash[:notice] = "Successfully created item."
      redirect_to item_path(new_item)
    else
      flash[:error] = new_item.errors.full_messages.join(", ")
      redirect_to new_item_path
    end
  end

  private

    def item_params
      params.require(:item).permit(:color, :size, :status)
    end

end
