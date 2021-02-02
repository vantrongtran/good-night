require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:tokens).dependent(:destroy) }
  end

  describe "validations" do
    subject { create :user }

    it { is_expected.to have_secure_password }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_presence_of :username }
    it { is_expected.to validate_presence_of :password_digest }
  end
end
