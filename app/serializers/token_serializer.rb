class TokenSerializer < ActiveModel::Serializer
  attributes :token, :expires_at
end
