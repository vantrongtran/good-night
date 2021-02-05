require "rails_helper"

RSpec.describe "Api::V1::Follows", type: :request do
  let!(:user) { create :user }
  let!(:token) { create :token, user: user }

  describe "GET api/v1/follows" do
    context "with empty following list" do
      it "response following list" do
        get v1_follows_path, headers: auth_header(token.token)

        expect_http_status :ok
        expect_body_contains :followings
        response_body["followings"].should eq []
      end
    end

    context "with following list" do
      let!(:following1) { create :following, user: user }
      let!(:following2) { create :following, user: user }

      it "response following list" do
        get v1_follows_path, headers: auth_header(token.token)

        expect_http_status :ok
        expect_body_contains :followings
        response_body["followings"].pluck("id").should eq [following1.id, following2.id]
      end
    end
  end

  describe "POST api/v1/follows" do
    before { post v1_follows_path, params: params, headers: auth_header(token.token) }

    context "with valid following_user_id" do
      let(:user2) { create :user }
      let(:params) { { following_user_id: user2.id }.to_json }

      it "response created record with created status" do
        expect_http_status :created
        expect_body_contains :following
        response_body["following"]["following_user"]["id"].should eq user2.id
      end
    end

    context "with invalid following_user_id" do
      let(:user2) { create :user }
      let(:params) { { following_user_id: 6969 }.to_json }

      it "response error with bad request status" do
        expect_http_status :bad_request
        expect_body_contains :error
        expect_error_message "Validation failed: following user must exist, following user can't be blank" # rubocop:disable Layout/LineLength
      end
    end

    context "with existed following_user_id" do
      let(:following) { create :following, user: user }
      let(:params) { { following_user_id: following.following_user_id }.to_json }

      it "response error with bad request status" do
        expect_http_status :bad_request
        expect_body_contains :error
        expect_error_message "Validation failed: user has already been taken"
      end
    end
  end

  describe "DELETE api/v1/follows/:id" do
    before { delete v1_follow_path(id), headers: auth_header(token.token) }

    context "with valid id" do
      let(:following) { create :following, user: user }
      let(:id) { following.id }

      it "response no content status" do
        expect_http_status :no_content
      end
    end

    context "with invalid id" do
      let(:id) { 6969 }

      it "response error with bad request status" do
        expect_http_status :bad_request
      end
    end
  end
end
