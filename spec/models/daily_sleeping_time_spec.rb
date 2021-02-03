require "rails_helper"

RSpec.describe DailySleepingTime, type: :model do
  describe "associations" do
    subject { create :daily_sleeping_time }

    it { should belong_to :user }
  end

  describe "validations" do
    subject(:record) { create :daily_sleeping_time, date: Date.today }

    before do
      allow(record).to receive(:validate_bed_time).and_return(true)
      allow(record).to receive(:validate_wake_up_time).and_return(true)
    end

    it { should validate_presence_of :date }
    it { should validate_uniqueness_of(:date).scoped_to(:user_id) }
    it { should validate_presence_of :bed_time }
  end

  describe "scope last_week" do
    subject { described_class.last_week }

    context "with empty data" do
      it { should eq [] }
    end

    context "without valid data" do
      let!(:old_item) do
        item = build :daily_sleeping_time, date: Date.today - 10
        item.save(validate: false)
        item
      end

      it { should eq [] }
    end

    context "with all valid data" do
      let!(:item1) { create :daily_sleeping_time, date: Date.today }
      let!(:item2) { create :daily_sleeping_time, date: Date.today }

      it { should eq [item1, item2] }
    end

    context "with have valid/invalid data" do
      let!(:item1) { create :daily_sleeping_time, date: Date.today }
      let!(:item2) { create :daily_sleeping_time, date: Date.today }
      let!(:old_item) do
        item = build :daily_sleeping_time, date: Date.today - 10
        item.save(validate: false)
        item
      end

      it { should eq [item1, item2] }
    end
  end
end
