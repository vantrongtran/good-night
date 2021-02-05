require "rails_helper"

RSpec.describe Following, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:following_user).class_name("User") }
  end

  describe "validations" do
    subject { create :following }

    it { should validate_presence_of :user }
    it { should validate_uniqueness_of(:user).scoped_to(:following_user_id) }
    it { should validate_presence_of :following_user }
  end
end
