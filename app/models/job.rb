class Job < ApplicationRecord
    has_many :saves, dependent: :destroy
    has_many :savers, class_name: "User", through: :saves

    belongs_to :poster, class_name: "User"


    accepts_nested_attributes_for :saves
end
