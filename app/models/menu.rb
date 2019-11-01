class Menu < ApplicationRecord
  belongs_to :user
  scope :recent, -> { order(schedule: :desc) }
end
