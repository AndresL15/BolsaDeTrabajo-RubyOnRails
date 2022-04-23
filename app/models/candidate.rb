class Candidate < ApplicationRecord
    has_many :candidate_work_notifications, dependent: :destroy
end
