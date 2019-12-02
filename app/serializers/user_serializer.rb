class UserSerializer < ActiveModel::Serializer
  attributes :username, :email, :city, :bio, :admin
end
