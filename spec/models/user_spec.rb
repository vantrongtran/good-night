require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:tokens).dependent(:destroy) }
    it { should have_many(:followings).dependent(:destroy) }
    it { should have_many(:following_users).through(:followings).source(:following_user) }
    it { should have_many(:followers).with_foreign_key("following_user_id").class_name("Following").dependent(:destroy) } # rubocop:disable Layout/LineLength
    it { should have_many(:follower_users).through(:followers).source(:user) }
  end

  describe "validations" do
    subject { create :user }

    it { should have_secure_password }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_presence_of :username }
    it { should validate_presence_of :password_digest }
  end

  describe "#self.authenticate!" do
    subject(:user) { described_class.authenticate!(username: username, password: password) }

    let!(:correct_user) { create :user }

    context "with correct username/password" do
      let(:username) { correct_user.username }
      let(:password) { correct_user.password }

      it { should eq correct_user }
    end

    context "with incorec username" do
      let(:username) { "#{correct_user.username}x" }
      let(:password) { correct_user.password }

      it { expect { user }.to raise_error Api::Error::WrongUsernamePassword }
    end

    context "with incorec password" do
      let(:username) { correct_user.username }
      let(:password) { "#{correct_user.password}x" }

      it { expect { user }.to raise_error Api::Error::WrongUsernamePassword }
    end
  end
end
