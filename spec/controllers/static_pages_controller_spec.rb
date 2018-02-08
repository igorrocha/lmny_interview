require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #home" do
    before(:each) do
      get :home
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    context "when there are some active and some expired offers" do
      before(:each) do
        @active_premium_offers = FactoryBot.create_list(:active_offer, 5, premium: true)
        @active_regular_offers = FactoryBot.create_list(:active_offer, 5, premium: false)
        @expired_offers = FactoryBot.create_list(:expired_offer, 5)
      end

      after(:all) do
        Offer.destroy_all
      end

      it "sets the correct premium offers collection" do
        expect(assigns(:premium_offers)).to match_array(@active_premium_offers)
      end

      it "sets the correct regular offers collection" do
        expect(assigns(:regular_offers)).to match_array(@active_regular_offers)
      end
    end
  end
end
