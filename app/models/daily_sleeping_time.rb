class DailySleepingTime < ApplicationRecord
  before_validation :calculate_sleeping_time, on: %i[create update], if: :wake_up_time

  belongs_to :user

  validates :date, presence: true, uniqueness: { scope: :user_id }
  validates :date, range: { min: (Date.today - 7.days), max: Date.today }
  validates :bed_time, presence: true

  validate :validate_bed_time
  validate :validate_wake_up_time

  scope :last_week, -> { where("date >= ?", Date.today - 7.days).order(sleeping_time: :desc) }

  private

  def calculate_sleeping_time
    self.sleeping_time = wake_up_time.to_i - bed_time.to_i
  end

  def validate_bed_time
    errors.add(:bed_time, "invalid") unless bed_time.between?(date, date + 1)
  end

  def validate_wake_up_time
    errors.add(:wake_up_time, "invalid") unless wake_up_time.between?(
      bed_time + Settings.sleeping_time.min, bed_time + Settings.sleeping_time.max
    )
  end
end
