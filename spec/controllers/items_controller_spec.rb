require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe "#show" do
    let(:item) { Item.create({size:'s', color:'blue', status:'unsold'}) }

    before(:each) do
      get :show, id: item.id
    end

    it "renders the :show view" do
      expect(response).to render_template(:show)
    end

    it "assigns @item" do
      expect(assigns(:item)).to eq(item)
    end
  end

  describe "#create" do
    context "success" do
      let(:item_hash) { { size: "XL", color: "heather", status: "sold" } }
      let!(:items_count) { Item.count }

      before(:each) do
        post :create, item: item_hash
      end

      it "redirects to 'item_path'" do
        expect(response.status).to be(302)
        expect(response.location).to match(/\/items\/\d+/)
      end

      it "adds an item to the database" do
        expect(Item.count).to eq(items_count + 1)
      end
    end

    context "failed validations" do
      # set up item data without a status to cause validation failure
      let(:item_hash) { { size: "S", color: "sage", status: nil } }
      before do
        post :create, item: item_hash
      end
      it "redirects to 'new_item_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(new_item_path)
      end

      it "adds a flash error message" do
        expect(flash[:error]).to be_present
      end
    end
  end
end
