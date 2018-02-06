require 'rails_helper'

RSpec.describe "offers/index", type: :view do
  before(:each) do
    assign(:offers, [
      Offer.create!(
        :advertiser_name => "Advertiser Name",
        :url => "Url",
        :description => "Description",
        :starts_at => "Starts At",
        :ends_at => "Ends At",
        :premium => "Premium"
      ),
      Offer.create!(
        :advertiser_name => "Advertiser Name",
        :url => "Url",
        :description => "Description",
        :starts_at => "Starts At",
        :ends_at => "Ends At",
        :premium => "Premium"
      )
    ])
  end

  it "renders a list of offers" do
    render
    assert_select "tr>td", :text => "Advertiser Name".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Starts At".to_s, :count => 2
    assert_select "tr>td", :text => "Ends At".to_s, :count => 2
    assert_select "tr>td", :text => "Premium".to_s, :count => 2
  end
end
