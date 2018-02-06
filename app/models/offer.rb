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

class Offer < ApplicationRecord

  enum status: {
    disabled: 0,
    enabled: 1,
  }


  validates_presence_of :advertiser_name, :url, :description, :starts_at

  validates_uniqueness_of :advertiser_name, case_sensitive: false

  validate :is_url_valid?

  validates_length_of :description, maximum: 500

  private

    # reference: https://coderwall.com/p/ztig5g/validate-urls-in-rails
    def is_url_valid?
      uri = URI.parse(self.url) rescue false
      errors.add(:url, "should have a valid HTTP or HTTPS format") unless uri.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
    end
end
