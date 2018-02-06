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
  # let(:offer) { FactoryBot.build(:offer) }

  # include_examples 'paranoia'


  # RESPOND TO
   [:url, :description, :starts_at, :ends_at, :premium, :status, :deleted_at].each do |attr|
    it "should respond to #{attr}" do
      expect(subject).to respond_to attr
    end
  end
end
