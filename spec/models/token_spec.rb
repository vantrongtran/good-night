require "rails_helper"

RSpec.describe Token, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :user }
  end

  describe "validations" do
    subject { create :token }

    it { is_expected.to validate_uniqueness_of(:token).case_insensitive }
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :expires_at }
  end

  describe "#expired?" do
    subject { token.expired? }

    context "with return true if token expired" do
      let(:token) { create :token, expires_at: Time.zone.now }

      it { is_expected.to be_truthy }
    end

    context "with return false if token expired" do
      let(:token) { create :token, expires_at: 1.minute.from_now }

      it { is_expected.to be_falsey }
    end
  end

  describe "#self.generate!" do
    subject(:token) { described_class.generate! user }

    context "with return new token of valid user" do
      let(:user) { create :user }

      it { token.user.should eq user }
      it { token.expired?.should be_falsey }
      it { token.token.should be_truthy }
    end
  end
end
