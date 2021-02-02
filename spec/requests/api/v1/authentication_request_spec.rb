require "rails_helper"
RSpec.describe "Api::V1::Authentications", type: :request do
  let!(:user) { create :user }

  describe "POST api/v1/sessions" do
    before { post v1_login_path, params: params }

    context "with correct username/password" do
      let(:params) { { username: user.username, password: user.password } }

      it "reponse new token" do
        expect_http_status :created
        expect_body_contains :token, :token, :expires_at
      end
    end

    context "with incorrect username/password" do
      let(:params) { { username: "#{user.username}x", password: user.password } }

      it "response wrong email password error" do
        expect_http_status :unauthorized
        expect_error_message "Wrong username password"
      end
    end

    context "with incorrect password" do
      let(:params) { { username: user.username, password: "#{user.password}x" } }

      it "response wrong email password error" do
        expect_http_status :unauthorized
        expect_error_message "Wrong username password"
      end
    end

    context "with empty request body" do
      let(:params) { {} }

      it "response wrong email password error" do
        expect_http_status :unauthorized
        expect_error_message "Wrong username password"
      end
    end
  end
end
