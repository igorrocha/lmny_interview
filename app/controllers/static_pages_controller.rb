class StaticPagesController < ApplicationController
  before_action :set_offers, only: [:home]

  def home
  end

  private

    def set_offers
      @premium_offers = Offer.enabled.where(premium: true)
      @regular_offers = Offer.enabled.where(premium: false)
    end
end
