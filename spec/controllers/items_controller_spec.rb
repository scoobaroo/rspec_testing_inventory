require "rails_helper"

RSpec.describe ItemsController, type: :controller do

  describe "#show" do
    let(:item) { FactoryGirl.create(:item) }

    before do
      get :show, product_id: item.product.id, id: item.id
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

    it "assigns @item" do
      expect(assigns(:item)).to be_instance_of(Item)
    end

    it "renders the :new view" do
      expect(response).to render_template(:new)
    end
  end


  describe "#create" do
    context "on success" do
      let(:product) { FactoryGirl.create(:product) }
      let!(:items_count) { Item.count }

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

      it "adds the new product to the database" do
        expect(Item.count).to eq(items_count + 1)
      end
    end

    context "failed validations" do
      let(:product) { FactoryGirl.create(:product) }
      before do
        # create blank product (fails validations)
        post :create, product_id: product.id, item: {
          size: nil,
          color: nil,
          status: nil
        }
      end

      it "adds a flash error message" do
        expect(flash[:error]).to be_present
      end
      #
      it "redirects to 'new_product_item_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(new_product_item_path product)
      end
    end
  end


  describe "#edit" do
    let(:item) { FactoryGirl.create :item }

    before do
      get :edit, product_id: item.product.id, id: item.id
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
      let(:new_color) { FFaker::Color.name }
      let(:new_size) { ['S', 'M', 'L', 'venti'].sample }
      let(:new_status) { ['sold', 'unsold'].sample }

      before do
        put :update, product_id: item.product.id, id: item.id, item: {
          color: new_color,
          size: new_size,
          status: new_status
        }

        # reload product to get changes from :update
        item.reload
      end

      it "updates the item in the database" do
        expect(item.size).to eq(new_size)
        expect(item.color).to eq(new_color)
        expect(item.status).to eq(new_status)
      end

      it "redirects to 'product_item_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(product_item_path(item.product_id, item.id))
      end
    end

    context "failed validations" do
      before do
        # update with blank product params (fails validations)
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
        expect(response).to redirect_to(edit_product_item_path(item.product.id, item.id))
      end
    end
  end

  describe "#destroy" do
    let!(:item) { FactoryGirl.create(:item) }
    let!(:items_count) { Item.count }

    before do
      delete :destroy, product_id: item.product.id, id: item.id
    end

    it "removes an item from the database" do
      expect(Item.count).to eq(items_count - 1)
    end
    
    it "redirects to 'root_path'" do
      expect(response.status).to be(302)
      expect(response).to redirect_to(root_path)
    end
  end
end
