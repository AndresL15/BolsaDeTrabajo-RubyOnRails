class CandidateWorkNotification < ApplicationRecord
  belongs_to :candidate
  belongs_to :work_notification
end
