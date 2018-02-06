require 'rails_helper'

RSpec.describe "offers/show", type: :view do
  before(:each) do
    @offer = assign(:offer, Offer.create!(
      :advertiser_name => "Advertiser Name",
      :url => "Url",
      :description => "Description",
      :starts_at => "Starts At",
      :ends_at => "Ends At",
      :premium => "Premium"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Advertiser Name/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Starts At/)
    expect(rendered).to match(/Ends At/)
    expect(rendered).to match(/Premium/)
  end
end
