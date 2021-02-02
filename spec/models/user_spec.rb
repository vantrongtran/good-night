require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:tokens).dependent(:destroy) }
  end

  describe "validations" do
    subject { create :user }

    it { should have_secure_password }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_presence_of :username }
    it { should validate_presence_of :password_digest }
  end

  describe "#self.authenticate!" do
    subject { described_class.authenticate!(username: username, password: password) }

    let!(:correct_user) { create :user }

    context "with correct username/password" do
      let(:username) { correct_user.username }
      let(:password) { correct_user.password }

      it { should eq correct_user }
    end
  end
end
