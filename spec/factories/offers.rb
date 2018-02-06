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

FactoryBot.define do
  factory :offer do
    sequence(:advertiser_name) { Faker::Company.name }
    sequence(:url) { Faker::Internet.url }
    sequence(:description) { Faker::Company.catch_phrase }
    starts_at { Time.zone.now }
    ends_at { Time.zone.now + 1.month }
    premium { ['true', 'false'].sample }

    factory :active_offer do
      starts_at { Time.zone.now }
      ends_at { Time.zone.now + 1.month }
    end

    factory :expired_offer do
      starts_at { Time.zone.now - 2.months }
      ends_at { Time.zone.now - 1.month }
    end

    factory :endless_offer do
      starts_at { Time.zone.now }
      ends_at nil
    end
  end
end
