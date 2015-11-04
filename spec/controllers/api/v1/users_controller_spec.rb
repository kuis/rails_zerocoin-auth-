require "rails_helper"

describe Api::V1::UsersController, type: :controller do
  render_views

  let(:user) { FactoryGirl.create(:user) }
  let(:api_key) { auth_with_user(user) }
  let(:validate_user) do
    request.env["HTTP_AUTHORIZATION"] = api_key.access_token
  end

  describe "GET #show" do
    context "with valid attributes" do
      it "renders show" do
        validate_user
        get :show, format: :json, id: user.id
        expect(response).to render_template(:show)
      end
    end

    context "with invalid attributes" do
      it "renders error" do
        validate_user
        get :show, format: :json, id: 9000
        expect(response).to render_template(nil)
      end
    end

    context "with invalid access" do
      it "renders unauthorized" do
        get :show, format: :json, id: user.id
        expect(response).to render_template(:unauthorized)
      end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do

      let(:user) { FactoryGirl.attributes_for(:user) }
      let(:valid_request) {
        post :create,
          format: :json,
          user: {
            email: user[:email],
            password: user[:password]
          }
      }

      it "creates a user" do
        expect { valid_request }
          .to change(User, :count).by(1)
      end

      it "creates an api_key" do
        expect { valid_request }
          .to change(ApiKey, :count).by(1)
      end
    end

    context "with invalid attributes" do
      let(:invalid_request) {
        post :create,
          format: :json,
          user: {
            email: "bademail",
            password: "123",
            
          }
      }

      it "does not creates a user" do
        expect { invalid_request }.to change(User, :count).by(0)
      end

      it "does not create an api_key" do
        expect { invalid_request }.to change(ApiKey, :count).by(0)
      end
    end
  end
end
