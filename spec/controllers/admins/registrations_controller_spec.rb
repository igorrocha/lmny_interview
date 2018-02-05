require 'rails_helper'

RSpec.describe Admins::RegistrationsController, type: :controller do
  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:admin]
  end

  def valid_attributes
    {
      admin: FactoryBot.attributes_for(:admin)
    }
  end

  def invalid_attributes
    {
      admin: FactoryBot.attributes_for(:admin, email: nil)
    }
  end

  describe "when the admin is not logged in" do
    describe "POST #create" do
      describe "with valid attributes" do
        before(:each) do
          post :create, params: valid_attributes
        end

        it "should redirect" do
          expect(response).to have_http_status(302)
        end

        it "should login the admin" do
          expect(controller.current_admin).to be_a Admin
        end
      end

      describe "with valid attributes" do
        it "should create an admin" do
          expect {
            post :create, params: valid_attributes
          }.to change {
            Admin.count
          }.by(1)
        end
      end

      describe "with invalid attributes" do
        before(:each) do
          post :create, params: invalid_attributes
        end

        it "should return status 200" do
          expect(response).to have_http_status(200)
        end

        it "should render the new session page" do
          expect(response).to render_template("devise/registrations/new")
        end

        it "shouldn't login the admin" do
          expect(controller.current_admin).to be_nil
        end
      end

      describe "with invalid attributes" do
        it "should not create an admin" do
          expect {
            post :create, params: invalid_attributes
          }.not_to change {
            Admin.count
          }
        end
      end
    end
  end

  describe "when the admin is logged in" do
    before(:each) do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
    end

    after(:each) do
      sign_out @admin
    end

    describe "POST #create" do
      before(:each) do
        post :create, params: valid_attributes
      end

      it "should redirect" do
        expect(response).to have_http_status(302)
      end
    end

    describe "POST #create" do
      it "should not create a admin" do
        expect {
          post :create, params: valid_attributes
        }.not_to change {
          Admin.count
        }
      end
    end
  end
end