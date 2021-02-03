require "rails_helper"

RSpec.describe Token, type: :model do
  describe "associations" do
    it { should belong_to :user }
  end

  describe "validations" do
    subject { create :token }

    it { should validate_uniqueness_of(:token).case_insensitive }
    it { should validate_presence_of :expires_at }
  end

  describe "#expired?" do
    subject { token.expired? }

    context "with token expired" do
      let(:token) { create :token, expires_at: Time.zone.now }

      it { should be_truthy }
    end

    context "with token not expires" do
      let(:token) { create :token, expires_at: 1.minute.from_now }

      it { should be_falsey }
    end
  end

  describe "#self.generate!" do
    subject(:token) { described_class.generate! user }

    context "with valid user" do
      let(:user) { create :user }

      it { token.user.should eq user }
      it { token.expired?.should be_falsey }
      it { token.token.should be_truthy }
    end
  end

  describe "#self.find_token!" do
    subject(:method) { described_class.find_token! token_string }

    context "with valid token string" do
      let(:token) { create :token }
      let(:token_string) { token.token }

      it { should eq token }
    end

    context "with wrong token string" do
      let(:token_string) { "xxx" }

      it { should eq nil }
    end

    context "with expired token  string" do
      let(:token) { create :token, expires_at: Time.zone.now }
      let(:token_string) { token.token }

      it { expect { method }.to raise_error Api::Error::TokenExpired }
    end
  end
end
