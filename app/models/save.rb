class Save < ApplicationRecord
    belongs_to :job
    belongs_to :user, optional: true

end
