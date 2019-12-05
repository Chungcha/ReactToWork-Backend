class User < ApplicationRecord
    has_many :saves, foreign_key: "saver_id", dependent: :destroy
    has_many :jobs, through: :saves, foreign_key: "saver_id"

    has_many :posts, class_name: "Job", foreign_key: "poster_id"

    has_secure_password  
    validates :username, uniqueness: { case_sensitive: false }


    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end 

end
