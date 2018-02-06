# == Schema Information
#
# Table name: offers
#
#  id              :integer          not null, primary key
#  advertiser_name :string
#  url             :string
#  description     :text
#  starts_at       :datetime
#  ends_at         :datetime
#  premium         :boolean
#  status          :integer
#  deleted_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Offer, type: :model do
  subject { FactoryBot.build_stubbed(:offer) }

  # include_examples 'paranoia'


  # RESPOND TO
   [:advertiser_name, :url, :description, :starts_at, :ends_at, :premium, :status, :deleted_at].each do |attr|
    it "should respond to #{attr}" do
      expect(subject).to respond_to attr
    end
  end

  # PRESENCE
  [:advertiser_name, :url, :description, :starts_at].each do |attr|
    it "should validate the presence of #{attr}" do
      expect(subject).to validate_presence_of attr
    end
  end

  # UNIQUENESS
  [:advertiser_name].each do |attr|
    before(:each) do
      @offer = FactoryBot.build(:offer)
    end

    it "should validate uniqueness of #{attr}" do
      expect(@offer).to validate_uniqueness_of(attr).case_insensitive
    end
  end

  # URL FORMAT
  describe "when there's an offer" do
    before(:each) do
      @offer = FactoryBot.build(:offer)
    end

    context "with an invalid url" do
      before(:each) do
        @offer.url = "lemoneyonthewebdotcom"
        @offer.valid?
      end

      it "should not be valid" do
        expect(@offer).not_to be_valid
      end

      it "should have an error regarding its url" do
        expect(@offer.errors.keys).to include(:url)
      end
    end
  end

  # TEXT LENGTH
  { description: 500 }.each do |attr,max_chars|
    it "should validate that #{attr} can't be more than #{max_chars} characters in length" do
      expect(subject).to validate_length_of(attr).is_at_most(max_chars)
    end
  end
end
