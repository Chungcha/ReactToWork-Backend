class Job < ApplicationRecord
    has_many :saves
    has_many :users, through: :saves
end
