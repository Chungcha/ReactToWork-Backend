class Save < ApplicationRecord
    belongs_to :job
    belongs_to :saver, class_name: 'User', foreign_key: "saver_id"
    

end
