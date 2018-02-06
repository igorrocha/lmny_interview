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
    sequence(:advertiser_name) { Faker::Company.name }
    sequence(:url) { Faker::Internet.url }
    sequence(:description) { Faker::Company.catch_phrase }
    starts_at { Time.zone.now }
    ends_at nil
    premium { ['true', 'false'].sample }
  end
end
