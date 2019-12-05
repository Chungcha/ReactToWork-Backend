class Job < ApplicationRecord
    has_many :saves
    has_many :users, through: :saves

    accepts_nested_attributes_for :saves
end
