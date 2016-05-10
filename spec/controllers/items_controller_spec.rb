require "rails_helper"

RSpec.describe ItemsController, type: :controller do

  describe "#show" do
    let(:item) { FactoryGirl.create(:item) }

    before do
      get :show, product_id: item.product.id, id: item.id
    end

    it "assigns @product" do
      expect(assigns(:product)).to eq(item.product)
    end

    it "assigns @item" do
      expect(assigns(:item)).to eq(item)
    end

    it "renders the :show view" do
      expect(response).to render_template(:show)
    end
  end

  describe "#new" do
    let(:product) { FactoryGirl.create(:product) }

    before do
      get :new, product_id: product.id
    end

    it "assigns @product" do
      expect(assigns(:product)).to eq(product)
    end

    it "assigns @item" do
      expect(assigns(:item)).to be_instance_of(Item)
    end

    it "renders the :new view" do
      expect(response).to render_template(:new)
    end
  end


  describe "#create" do
    let(:product) { FactoryGirl.create(:product) }

    context "success" do
      let!(:items_count) { product.items.count }

      before do
        item_hash = {
            size: "XL",
            color: "heather",
            status: "sold"
        }
        post :create, product_id: product.id, item: item_hash
      end

      it "redirects to 'product_item_path'" do
        expect(response.status).to be(302)
        expect(response.location).to match(/\/products\/#{product.id}\/items\/\d+/)
      end

      it "adds the new item to the product" do
        expect(product.items.count).to eq(items_count + 1)
      end

    end

    context "failed validations" do
      before do
        # create item without status (fails validations)
        item_hash = {
          size: nil,
          color: nil,
          status: nil
        }
        post :create, product_id: product.id, item: item_hash
      end

      it "redirects to 'new_product_item_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(new_product_item_path(product))
      end

      it "adds a flash error message" do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "#edit" do
    let(:item) { FactoryGirl.create :item }

    before do
      get :edit, product_id: item.product.id, id: item.id
    end

    it "assigns @product" do
      expect(assigns(:product)).to eq(item.product)
    end

    it "assigns @item" do
      expect(assigns(:item)).to eq(item)
    end

    it "renders the :edit view" do
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    let(:item) { FactoryGirl.create(:item) }

    context "success" do
      let(:new_item_hash) do
        {
          size: 'M',
          color: 'burgundy',
          status: 'sold'
        }
      end

      before do
        put :update, product_id: item.product.id, id: item.id, item: new_item_hash
        # reload product to get changes from :update
        item.reload
      end

      it "updates the item in the database" do
        expect(item.size).to eq(new_item_hash[:size])
        expect(item.color).to eq(new_item_hash[:color])
        expect(item.status).to eq(new_item_hash[:status])
      end

      it "redirects to 'product_item_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(product_item_path(item.product, item))
      end
    end

    context "failed validations" do
      before do
        # update with blank item status param (fails validations)
        put :update, product_id: item.product.id, id: item.id, item: {
          size: nil,
          color: nil,
          status: nil
        }
      end

      it "adds an error message to flash" do
        expect(flash[:error]).to be_present
      end

      it "redirects to 'edit_product_item_path'" do
        expect(response).to redirect_to(edit_product_item_path(item.product, item))
      end
    end
  end

  describe "#destroy" do
    let!(:item) { FactoryGirl.create(:item) }
    let!(:items_count) { item.product.items.count }

    before do
      delete :destroy, product_id: item.product.id, id: item.id
    end

    it "removes an item from the database" do
      expect(item.product.items.count).to eq(items_count - 1)
    end

    it "redirects to 'product_path'" do
      expect(response.status).to be(302)
      expect(response).to redirect_to(product_path(item.product))
    end
  end
end
