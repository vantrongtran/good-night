class DailySleepingTimeSerializer < ActiveModel::Serializer
  attributes :id, :date, :bed_time, :wake_up_time, :sleeping_time

  def sleeping_time
    s_time = object.sleeping_time
    return s_time unless s_time

    Time.at(s_time).utc.strftime("%H:%M:%S")
  end
end
