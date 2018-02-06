# == Schema Information
#
# Table name: admins
#
#  id                 :integer          not null, primary key
#  email              :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :inet
#  last_sign_in_ip    :inet
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  deleted_at         :datetime
#

require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject { FactoryBot.build_stubbed(:admin) }

  # include_examples 'paranoia'


  # RESPOND TO
   [:email, :encrypted_password, :deleted_at, :password, :password_confirmation].each do |attr|
    it "should respond to #{attr}" do
      expect(subject).to respond_to attr
    end
  end
end
