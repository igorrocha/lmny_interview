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
    advertisers = [
      "Walmart",
      "Kohls",
      "Ebay",
      "Amazon",
      "Sephora",
      "BestBuy",
      "Groupon",
      "Macys",
      "WholeFoods",
      "Jewel-Osco",
      "Starbucks",
      "IKEA",
      "Dominicks",
      "Teleflora",
      "Nike",
      "Adidas",
      "Verizon",
      "Sprint",
      "Comcast",
      "Vimeo",
      "Orbitz",
      "Hertz",
      "FitBit",
      "Apple",
      "Microsoft",
      "GAP",
      "Zipcar",
      "PokerGo"
    ]

    sequence(:advertiser_name) { |n| "#{advertisers.sample + n.to_s}" }
    sequence(:url) { "https://#{self.advertiser_name.downcase}.com" }
    sequence(:description) { "Up To #{rand(10.0..15.0).round(1)}\% Cashback!" }
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
