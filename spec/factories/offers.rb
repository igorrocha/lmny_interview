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

FactoryBot.define do
  factory :offer do
    advertiser_name "MyString"
    url "MyString"
    description "MyText"
    starts_at "2018-02-06 01:28:31"
    ends_at "2018-02-06 01:28:31"
    premium false
    status 1
    deleted_at "2018-02-06 01:28:31"
  end
end
