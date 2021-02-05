class Api::V1::FollowsController < ApplicationController
  permited_params only: %i[create], params: %i[following_user_id]

  def index
    pagy, following_users = pagy(current_user.followings.includes(:following_user),
                                 items: Settings.pagination.following_items)
    res following_users, meta: pagination_dict(pagy)
  end

  def create
    res current_user.followings.create!(permited_params), status: :created
  end

  def destroy
    following = current_user.followings.find params[:id]
    following.destroy!
  end
end
