class WorkNotification < ApplicationRecord
    belongs_to :company
    has_many :candidate_work_notifications
end
