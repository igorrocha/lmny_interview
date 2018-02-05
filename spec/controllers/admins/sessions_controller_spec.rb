require 'rails_helper'

RSpec.describe Admins::SessionsController, type: :controller do
  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:admin]
    @password = 'abc123'
    @admin = FactoryBot.create(:admin, password: @password, password_confirmation: @password)
  end

  def valid_attributes
    {
      admin: {
        email: @admin.email,
        password: @password
      }
    }
  end

  def invalid_attributes
    {
      admin: {
        email: @admin.email,
        password: "123"
      }
    }
  end

  describe "when the admin is not logged in" do
    describe "GET #new" do
      before(:each) do
        get :new
      end

      it "returns status 200" do
        expect(response).to have_http_status(200)
      end

      it "renders the new view" do
        expect(response).to render_template(:new)
      end
    end

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

      describe "with invalid attributes" do
        before(:each) do
          post :create, params: invalid_attributes
        end

        it "should render the new page" do
          expect(response).to have_http_status(200)
        end

        it "should render the new page" do
          expect(response).to render_template(:new)
        end

        it "should not login the admin" do
          expect(controller.current_admin).to be_nil
        end
      end
    end
  end

  describe "when the admin is logged in" do
    before(:each) do
      sign_in @admin
    end

    after(:each) do
      sign_out @admin
    end

    describe "GET #new" do
      before(:each) do
        get :new
      end

      it "should redirect" do
        expect(response).to have_http_status(302)
      end
    end

    describe "POST #create" do
      before(:each) do
        post :create, params: valid_attributes
      end

      it "should redirect" do
        expect(response).to have_http_status(302)
      end
    end
  end
end