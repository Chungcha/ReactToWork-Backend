class User < ApplicationRecord
    has_many :saves
    has_many :jobs, through: :saves

    has_many :posts, as: :poster

    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }


    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end 

end
