require "rails_helper"

RSpec.describe "Api::V1::DailySleepingTimes", type: :request do
  let!(:user) { create :user }
  let!(:token) { create :token, user: user }

  describe "GET api/v1/daily_sleeping_times" do
    context "with have daily sleeping time data" do
      let!(:item) { create :daily_sleeping_time, user: user }
      let!(:item2) do
        create :daily_sleeping_time, user: user, date: Date.yesterday,
                                     bed_time: DateTime.now - 1.day
      end

      it "response daily sleeping list with ok status" do
        get v1_daily_sleeping_times_path, headers: auth_header(token.token)

        expect_http_status :ok
        expect_body_contains :daily_sleeping_times
        response_body["daily_sleeping_times"].pluck("id").should eq [item.id, item2.id]
      end
    end

    context "with empty daily sleeping time data" do
      it "response empty list with ok status" do
        get v1_daily_sleeping_times_path, headers: auth_header(token.token)

        expect_http_status :ok
        expect_body_contains :daily_sleeping_times
        response_body["daily_sleeping_times"].should eq []
      end
    end

    context "with user_id params of following user" do
      let!(:following) { create :following, user: user }
      let(:params) { { user_id: following.following_user_id } }

      context "with empty data sleeping list" do
        it "response empty array with ok status" do
          get v1_daily_sleeping_times_path, params: params, headers: auth_header(token.token)

          expect_http_status :ok
          expect_body_contains :daily_sleeping_times
          response_body["daily_sleeping_times"].should eq []
        end
      end

      context "with data sleeping list in last week" do
        let!(:item) { create :daily_sleeping_time, user: following.following_user }

        it "response daily sleeping list with ok status" do
          get v1_daily_sleeping_times_path, params: params, headers: auth_header(token.token)

          expect_http_status :ok
          expect_body_contains :daily_sleeping_times
          response_body["daily_sleeping_times"].pluck("id").should eq [item.id]
        end
      end

      context "with both valid and old data more than week" do
        let!(:item) { create :daily_sleeping_time, user: following.following_user }
        let!(:old_item) do
          item = build :daily_sleeping_time, date: Date.today - 10
          item.save(validate: false)
          item.user = following.following_user
          item
        end

        it "response only daily sleeping list in last week with ok status" do
          get v1_daily_sleeping_times_path, params: params, headers: auth_header(token.token)

          expect_http_status :ok
          expect_body_contains :daily_sleeping_times
          response_body["daily_sleeping_times"].pluck("id").should eq [item.id]
        end
      end

      context "with only old data more than week" do
        let!(:old_item) do
          item = build :daily_sleeping_time, date: Date.today - 10
          item.save(validate: false)
          item.user = following.following_user
          item
        end

        it "response only daily sleeping list in last week with ok status" do
          get v1_daily_sleeping_times_path, params: params, headers: auth_header(token.token)

          expect_http_status :ok
          expect_body_contains :daily_sleeping_times
          response_body["daily_sleeping_times"].should eq []
        end
      end
    end
  end

  describe "POST api/v1/daily_sleeping_times" do
    before { post v1_daily_sleeping_times_path, params: params, headers: auth_header(token.token) }

    context "with valid params" do
      let(:params) do
        build(:daily_sleeping_time, date: (Date.today - 1), bed_time: (DateTime.now - 20.hours),
                                    user: nil).to_json
      end

      it "response emply data with ok status" do
        expect_http_status :created
      end
    end

    context "with existed date" do
      let!(:record) do
        create :daily_sleeping_time, date: (Date.today - 6), bed_time: (DateTime.now - 6.days),
                                     user: user
      end
      let(:params) { record.to_json }

      it "response error with bad status" do
        expect_http_status :bad_request
        response_body["error"]["message"].should eq "Validation failed: date has already been taken"
      end
    end
  end

  describe "PUT api/v1/daily_sleeping_time/:id" do
    before do
      put v1_daily_sleeping_time_path(id), params: params, headers: auth_header(token.token)
    end

    context "with vaild data" do
      let!(:item) { create :daily_sleeping_time, user: user }
      let(:id) { item.id }
      let(:params) { item.to_json }

      it "response emply data with ok status" do
        expect_http_status :ok
        expect_body_contains :daily_sleeping_time
      end
    end

    context "with invaild id" do
      let(:id) { 6969 }
      let(:params) { build(:daily_sleeping_time).to_json }

      it "response emply data with ok status" do
        expect_http_status :bad_request
        expect_body_contains :error
      end
    end
  end

  describe "DELETE api/v1/daily_sleeping_time/:id" do
    before { delete v1_daily_sleeping_time_path(id), headers: auth_header(token.token) }

    let!(:item) { create :daily_sleeping_time, user: user }
    let!(:item2) { create :daily_sleeping_time }

    context "with vaild data" do
      let(:id) { item.id }

      it "response empty data with no content status" do
        expect_http_status :no_content
      end
    end

    context "with invaild id" do
      let(:id) { 6969 }

      it "response error with bad request status" do
        expect_http_status :bad_request
        expect_body_contains :error
      end
    end

    context "with record id of other users" do
      let(:id) { item2.id }

      it "response error with bad request status" do
        expect_http_status :bad_request
        expect_body_contains :error
      end
    end
  end
end
