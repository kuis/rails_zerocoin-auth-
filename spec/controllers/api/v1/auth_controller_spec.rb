require "rails_helper"

describe Api::V1::AuthController, type: :controller do
  render_views

  describe "DELETE #destroy" do
    context "with valid attributes" do
      it "destroys access token" do
        user = FactoryGirl.create(:user)
        api_key = FactoryGirl.create(:api_key, user: user)
        @request.headers["HTTP_AUTHORIZATION"] = api_key.access_token

        expect { delete :destroy, format: :json }
          .to change(ApiKey, :count).by(-1)
      end
    end

    context "with invalid attributes" do
      it "renders error" do
        expect { delete :destroy, format: :json }
          .to change(ApiKey, :count).by(0)
      end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:user) { FactoryGirl.create(:user) }
      let(:valid_request) {
        post :create,
          format: :json,
          user: {
            email: user.email,
            password: user.password
          }
      }

      it "finds or creates an api_key" do
        valid_request
        expect(user.reload.api_key).to_not be_nil
      end
    end

    context "with invalid attributes" do
      let(:invalid_request) {
        post :create,
          format: :json,
          user: {
            email: "bademail",
            password: "123"
          }
      }

      it "does not create an api_key" do
        expect { invalid_request }.to change(ApiKey, :count).by(0)
      end
    end
  end
end
