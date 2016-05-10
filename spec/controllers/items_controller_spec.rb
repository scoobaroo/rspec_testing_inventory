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
end
