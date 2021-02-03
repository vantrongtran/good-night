class CreateDailySleepingTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_sleeping_times do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.date :date, null: false
      t.datetime :bed_time, null: false
      t.datetime :wake_up_time
      t.integer :sleeping_time

      t.timestamps
    end
  end
end
