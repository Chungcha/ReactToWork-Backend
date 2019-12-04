class UserSerializer < ActiveModel::Serializer
  attributes :username, :email, :zipCode, :bio, :admin
end
