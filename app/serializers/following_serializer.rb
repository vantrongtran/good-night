class FollowingSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :following_user
end
