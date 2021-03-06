class Api::V1::DailySleepingTimesController < ApplicationController
  permited_params only: %i[create update], params: %i[date bed_time wake_up_time]

  def index
    pagy, daily_sleeping_times = pagy(sleeping_times,
                                      items: Settings.pagination.sleeping_time_items)
    res daily_sleeping_times, meta: pagination_dict(pagy)
  end

  def create
    res current_user.daily_sleeping_times.create!(permited_params), status: :created
  end

  def update
    record = current_user.daily_sleeping_times.find(params[:id])
    record.update! permited_params
    res record
  end

  def destroy
    record = current_user.daily_sleeping_times.find(params[:id])
    record.destroy!
  end

  private

  def sleeping_times
    user = current_user.following_users.find(params[:user_id]) if params[:user_id]
    user ? user.daily_sleeping_times.last_week : current_user.daily_sleeping_times
  end
end
