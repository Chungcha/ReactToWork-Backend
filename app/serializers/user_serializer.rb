class UserSerializer < ActiveModel::Serializer
  attributes :username, :email, :zipCode, :bio, :admin, :saves, :jobs
end
