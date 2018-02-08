class StaticPagesController < ApplicationController
  before_action :set_offers, only: [:home]

  def home
  end

  private

    def set_offers
      # update to check if any expired, before rendering
      Offer.find_each do |offer|
        offer.update_status
      end
      @premium_offers = Offer.enabled.where(premium: true)
      @regular_offers = Offer.enabled.where(premium: false)
    end
end
