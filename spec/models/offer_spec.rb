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
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  forced_status   :boolean
#

require 'rails_helper'

RSpec.describe Offer, type: :model do
  subject { FactoryBot.build_stubbed(:offer) }

  # RESPOND TO
   [:advertiser_name, :url, :description, :starts_at, :ends_at, :premium, :status].each do |attr|
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

  # STATUS
  describe "when there's an expired offer" do
    before(:each) do
      @expired_offer = FactoryBot.create(:expired_offer)
    end

    it "should maintain its disabled status upon saving with a forced enabled status" do
      expect {
        @expired_offer.update_attributes(status: 'enabled', forced_status: true)
        }.not_to change {
          @expired_offer.status
        }
    end
  end

  describe "when there's an active offer" do
    before(:each) do
      @active_offer = FactoryBot.create(:active_offer)
    end

    context "and today is past its expiration date" do
      before(:each) do
        Timecop.travel(@active_offer.ends_at + 1.day)
        Timecop.freeze(Time.zone.now)
      end

      [true, false].each do |forced|
        before(:each) do
          @active_offer.update_attributes(forced_status: forced)
        end

        context "and its status #{forced ? 'is' : 'isn\'t'} forced" do
          it "should become disabled" do
            expect(@active_offer.status).to eq('disabled')
          end
        end
      end
    end
  end

  describe "when there's an active offer with a forced disabled status" do
    before(:each) do
      @active_offer = FactoryBot.create(:active_offer)
      @active_offer.update_attributes(status: 'disabled', forced_status: true)
    end

    describe "and its expiration date is not due" do
      before(:each) do
        Timecop.travel(@active_offer.ends_at - 1.day)
        Timecop.freeze(Time.zone.now)
      end

      after(:each) do
        Timecop.return
      end

      it "should not update its status to enabled upon saving" do
        expect {
            @active_offer.save
          }.not_to change {
            @active_offer.status
          }
      end

      it "should update its status to enabled upon saving with a forced enabled status" do
        expect {
          @active_offer.update_attributes(status: 'enabled', forced_status: true)
          }.to change {
            @active_offer.status
          }.to('enabled')
      end
    end
  end

  describe "when there's an endless offer with a forced disabled status" do
    before(:each) do
      @endless_offer = FactoryBot.create(:endless_offer)
      @endless_offer.update_attributes(status: 'disabled', forced_status: true)
    end

    it "should not update its status to enabled upon saving" do
      expect {
          @endless_offer.save
        }.not_to change {
          @endless_offer.status
        }
    end
  end
end
