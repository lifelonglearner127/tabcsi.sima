class PushTokenSerializer < ActiveModel::Serializer
  attributes :user_id, :device_type, :token
end