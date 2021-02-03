require "rails_helper"

RSpec.describe "Api::V1::DailySleepingTimes", type: :request do
  let!(:user) { create :user }
  let!(:token) { create :token, user: user }
  let!(:item) { create :daily_sleeping_time, user: user }
  let!(:item2) { create :daily_sleeping_time }

  describe "GET api/v1/daily_sleeping_times" do
    before { get v1_daily_sleeping_times_path, headers: auth_header(token.token) }

    context "with vaild data" do
      it "response emply data with ok status" do
        expect_http_status :ok
        expect_body_contains :daily_sleeping_times
        expect_body_contains :meta
        response_body["daily_sleeping_times"][0]["id"].should eq item.id
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
      let(:params) { build(:daily_sleeping_time, user: nil).to_json }

      it "response error with bad status" do
        expect_http_status :bad_request
        response_body["error"]["message"].should eq "Validation failed: date has already been taken"
      end
    end
  end

  describe "PUT api/v1/daily_sleeping_time/:id" do
    before do
      put "/v1/daily_sleeping_times/#{id}", params: params, headers: auth_header(token.token)
    end

    context "with vaild data" do
      let(:id) { item.id }
      let(:params) { item.to_json }

      it "response emply data with ok status" do
        expect_http_status :ok
        expect_body_contains :daily_sleeping_time
      end
    end

    context "with invaild id" do
      let(:id) { item2.id }
      let(:params) { item.to_json }

      it "response emply data with ok status" do
        expect_http_status :bad_request
        expect_body_contains :error
      end
    end
  end

  describe "DELETE api/v1/daily_sleeping_time/:id" do
    before { delete "/v1/daily_sleeping_times/#{id}", headers: auth_header(token.token) }

    context "with vaild data" do
      let(:id) { item.id }

      it "response emply data with ok status" do
        expect_http_status :no_content
      end
    end

    context "with invaild id" do
      let(:id) { item2.id }

      it "response emply data with ok status" do
        expect_http_status :bad_request
        expect_body_contains :error
      end
    end
  end
end
