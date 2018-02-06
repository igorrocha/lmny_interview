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
  pending "add some examples to (or delete) #{__FILE__}"
end
