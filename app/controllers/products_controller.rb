class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    new_product = Product.new product_params
    if new_product.save
      redirect_to product_path(new_product)
    else
      flash[:error] = new_product.errors.full_messages.join(" ")
      redirect_to new_product_path
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
    product = Product.find_by(id: params[:id])
    if product.update(product_params)
      redirect_to product_path(product)
    else
      flash[:error] = product.errors.full_messages.join(" ")
      redirect_to edit_product_path(product)
    end

  end

  def destroy
    Product.destroy(params[:id])
    redirect_to root_path
  end

  private

    def product_params
      params.require(:product).permit(:name, :description, :category, :sku, :wholesale, :retail)
    end

end
